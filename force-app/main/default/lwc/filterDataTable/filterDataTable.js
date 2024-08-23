/**
 * Created by ausoto on 2024-08-19.
 */

import { LightningElement, wire } from 'lwc';
//import apex shortcut
//get records from soql
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
//import lightning shortcut
//for actions
import { NavigationMixin } from 'lightning/navigation';
//update db
import { refreshApex } from "@salesforce/apex";
//update ui
import { updateRecord } from "lightning/uiRecordApi";

//array of objects with two properties
// dropdown actions
const actions = [
        {label: 'View', name: 'view'},
        {label: 'Edit', name: 'edit'},
    ];

const columns = [
        {label: 'Name', fieldName:'Name', editable:true},
        {label: 'Industry', fieldName:'Industry', editable:true},
        {label: 'AnnualRevenue', fieldName:'AnnualRevenue', editable:true},
        {
            type:'action',
            typeAttributes: {rowActions: actions},
        },
    ]


export default class FilterDataTable extends NavigationMixin(LightningElement) {
  availableAccounts;
  initialRecords;
  columns = columns;
  //handle inline editing TODO
  draftValues = [];

  //submit button filters
    //test

  fields = ['BillingCity', 'BillingCountry', 'BillingPostalCode', 'Phone'];
  whereClauses = {
    BillingCity: 'Lawrence',
    BillingCountry: 'USA',
    BillingPostalCode: '66045',
    Phone: '(785) 241-6200'
  };

  // fields = [];
  // whereClauses = {};

  results = [];


  inputsArray = [
      {
        label: 'Billing Address',
        dataName: 'billingAddress'
      },
    {
      label: 'Billing Postal Code',
      dataName: 'billingPostalCode'
    },
    {
      label: 'Billing Country',
      dataName: 'billingCountry'
    },
    {
    label: 'Created Date',
    dataName: 'createdDate'
    },
  ];



//todo test without @wire
  // get accounts from controller, then save them to availableAccounts and initialRecords
@wire
(getAccounts, { fields: '$fields', whereClauses: '$whereClauses' })
//propertyOrFunction—A private property or function that receives the stream of data from the wire service.
//If a property is decorated with @wire, the results are returned to the property’s data property or error property.
//If a function is decorated with @wire, the results are returned in an object with a data property or an error property.

//Note
//The data property and the error property are hardcoded values in the API. You must use these values.
// in this case, im using a function wiredAccount
wiredAccount({error,data}){
  if (data) {
    console.log('🚀 data from @wire getAccounts: ', data);
    this.availableAccounts = data;
    this.initialRecords = data;

  } else if(error){
    this.error = error;
    this.availableAccounts = undefined;
  }
}

handleRowAction (event){
  const actionName = event.detail.action.name;
  const row = event.detail.row;
  row.Id = undefined;

  switch (actionName){
    case 'view':
      this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes:{
          recordId:row.Id,
          objectApiName: 'Account',
          actionName: 'view'
        }
      });
      break;
    case 'edit':
      this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes:{
          recordId:row.Id,
          objectApiName: 'Account',
          actionName: 'edit'
        }
      });
      break;
    default:
  }//end switch
}//end handleRowAction

handleSearch(event) {
  const searchKey = event.target.value.toLowerCase();
  console.log('searchKey is ' + searchKey);

  if (searchKey) {
    this.availableAccounts = this.initialRecords;
    //        console.log('Account records are '+ JSON.stringify(this.availableAccounts));

    if (this.availableAccounts) {
      const recordsMap = new Map();
      //            filter results on each keystroke and save them to a Map
      //go through the list and for each record, then, for each field and check if it matches with searchkey
      // if matches, save the record to the map
      this.availableAccounts.forEach(record => {
        if (Object.values(record).some(value => String(value).toLowerCase().includes(searchKey))) {
          recordsMap.set(record.Id, record);
          console.log(recordsMap);
//          refreshApex(this.wiredAccount);
        }
      });
      //convert the Map values back to an array
      this.availableAccounts = Array.from(recordsMap.values());
    }//end if
  } else {
    this.availableAccounts = this.initialRecords;
  }
}

handleExtraFields(event) {
//    todo, how to access data-name value???
  const field = event.target.dataset.name;
  const value = event.target.value;

  console.log('test:',field);
  if (value) {
    this.fields.push(field);
    this.whereClauses[field] = value;
  }
}

handleSubmit() {
  getAccounts({ fields: this.fields, whereClauses: this.whereClauses })
    .then(result => {
      if (result) {
          this.results = result;
          console.log('Query Results:', this.results);
      }
//    todo once it's working, save results to availableAccounts
  })
    .catch(error => {
    console.error('Error:', error);
  });
}//end handleSubmit


}//end filterDataTable



  //old search

  //handleSearch(event){
  //        const searchKey = event.target.value.toLowerCase();
  //          console.log('searchKey is ' + searchKey);
  //        if(searchKey){
  //                this.availableAccounts = this.initialRecords;
  //                console.log('Account records are '+ JSON.stringify(this.availableAccounts));
  //
  ////! TODO refactor to use a map instead nested for
  //                if(this.availableAccounts){
  //                        let records = [];
  //                        for (let record of this.availableAccounts){
  //                                console.log('record is' + JSON.stringify(record));
  //                                let valuesArray = Object.values(record);
  //                                console.log('valuesArray is ' + JSON.stringify(valuesArray));
  //
  //                                for(let value of valuesArray){
  //                                        console.log('value is ' + value);
  //                                        let strValue = String (value);
  //                                        if(strValue){
  //                                                if(strValue.toLowerCase().includes(searchKey)){
  //                                                        records.push(record);
  //                                                        break;
  //                                                    }
  //                                            }
  //                                    }//end for value
  //                            }//end for record
  //                    this.availableAccounts = records;
  //                    }
  //            } else{
  //                    this.availableAccounts = this.initialRecords;
  //                }
  //    }


