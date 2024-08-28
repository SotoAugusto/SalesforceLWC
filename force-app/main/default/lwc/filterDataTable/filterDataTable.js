/**
 * Created by ausoto on 2024-08-19.
 */

import {api, LightningElement, wire} from 'lwc';
//import apex shortcut
//get records from soql
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import updateAccount from '@salesforce/apex/AccountController.updateAccount';
//import lightning shortcut
//for actions
import { NavigationMixin } from 'lightning/navigation';
//update db
import { refreshApex } from "@salesforce/apex";
//update ui
import { updateRecord } from "lightning/uiRecordApi";
import {ShowToastEvent} from "lightning/platformShowToastEvent";

//array of objects with two properties
// dropdown actions
const ACTIONS = [
        {label: 'View', name: 'view'},
        {label: 'Edit', name: 'edit'},
    ];
//TODO WIP LINES 27-35 HYPERLINK ON DATATABLE
const COLUMNS = [
  {
    label: 'Name',
    fieldName: 'Name',
    type: 'url',
    typeAttributes: {
      label: { fieldName: 'Name' }, // Display the record name as the link text
      url: 'https://insulet-6b-dev-ed.develop.lightning.force.com/lightning/r/Account/{Id}/view' // Replace '{Id}' with the actual record ID
    }
  },
        {label: 'Name', fieldName:'Name', editable:true},
        {label: 'Industry', fieldName:'Industry', editable:true},
        {label: 'AnnualRevenue', fieldName:'AnnualRevenue', editable:true},
        {
            type:'action',
            typeAttributes: {rowActions: ACTIONS},
        },
    ]


export default class FilterDataTable extends NavigationMixin(LightningElement) {
  @api availableAccounts;
  initialRecords;
  columns = COLUMNS;
  //handle inline editing TODO
  draftValues = [];
  error;


  // whereClauses = {
  // // key, value
  //   BillingCity: 'Lawrence',
  //   BillingCountry: 'USA',
  //   BillingPostalCode: '66045',
  //   Phone: '(785) 241-6200'
  // };

  whereClauses = {};

  accountInputFields = [
    {
      dataName: 'billingStreet',
      label: 'Billing Street'
    },
    {
      dataName: 'billingCity',
      label: 'Billing City'
    },
    {
      dataName: 'billingState',
      label: 'Billing State'
    },
    {
      dataName: 'billingPostalCode',
      label: 'Billing Postal Code'
    },
    {
      dataName: 'billingCountry',
      label: 'Billing Country'
    },
    {
      dataName: 'shippingStreet',
      label: 'Shipping Street'
    },
    {
      dataName: 'shippingCity',
      label: 'Shipping City'
    },
    {
      dataName: 'shippingState',
      label: 'Shipping State'
    },
    {
      dataName: 'shippingPostalCode',
      label: 'Shipping Postal Code'
    },
    {
      dataName: 'shippingCountry',
      label: 'Shipping Country'
    },
    {
      dataName: 'phone',
      label: 'Phone'
    },
    {
      dataName: 'fax',
      label: 'Fax'
    },
    {
      dataName: 'accountNumber',
      label: 'Account Number'
    },
    {
      dataName: 'website',
      label: 'Website'
    },
    {
      dataName: 'photoUrl',
      label: 'Photo URL'
    },
    {
      dataName: 'sic',
      label: 'Sic'
    },
    {
      dataName: 'numberOfEmployees',
      label: 'Number of Employees'
    },
    {
      dataName: 'ownership',
      label: 'Ownership'
    }
  ];



  getAccountData(whereClauses){
    getAccounts({whereClauses: this.whereClauses})
        .then(data =>{
          if (data) {
            console.log('🚀 data from imperative getAccounts: ', data);
            this.availableAccounts = data;
            this.initialRecords = data;

          }
    }).catch(error =>{
      console.log(error);
      })
  }// end getAccountData




  // runs on page load, similar to @wire
  connectedCallback() {
    this.getAccountData(this.whereClauses);
  }


// @wire(updateAccount,{recordId: '$recordId'})
// accountsUpdated;

// wire runs on page load
// get all account records from controller, then save them to availableAccounts and initialRecords for display

  // @wire(getAccounts, {whereClauses: '$whereClauses' })

//propertyOrFunction—A private property or function that receives the stream of data from the wire service.
//If a property is decorated with @wire, the results are returned to the property’s data property or error property.
//If a function is decorated with @wire, the results are returned in an object with a data property or an error property.

//Note
//The data property and the error property are hardcoded values in the API. You must use these values.
// in this case, im using a function wiredAccount

//   wiredAccount({error,data}){
//   if (data) {
//     console.log('🚀 data from @wire getAccounts: ', data);
//     this.availableAccounts = data;
//     this.initialRecords = data;
//
//   } else if(error){
//     this.error = error;
//     this.availableAccounts = undefined;
//   }
// }

  //todo WIP
handleHyperlink (event){
  const row = event.detail.row;

}

  handleRowAction (event){
    const actionName = event.detail.action.name;
    const row = event.detail.row;

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
    //        console.log('Account records are', JSON.stringify(this.availableAccounts));

    if (this.availableAccounts) {
      const recordsMap = new Map();
      //filter results on each keystroke and save them to a Map
      //go through the list and for each record, then, for each field and check if it matches with searchKey
      //if matches, save the record to the map
      this.availableAccounts.forEach(record => {
        if (Object.values(record).some(value => String(value).toLowerCase().includes(searchKey))) {
          recordsMap.set(record.Id, record);
        }
      });
      //convert the Map values back to an array
      this.availableAccounts = Array.from(recordsMap.values());
      console.log(recordsMap);
    }//end if
  } else {
    this.availableAccounts = this.initialRecords;
  }
}

// listen to the user inputs on the filter fields, save it on the whereClauses map
handleAccountInputFields(event) {
  // save the name of the field
  const field = event.target.dataset.name;
  // save value (criteria) of input
  const criteria = event.target.value;

  console.log('input data-name:',field);
  console.log('input value:',criteria);

  // if the input has a value (criteria), save it in to the map
  if (criteria) {
    this.whereClauses[field] = criteria;
    // console.log(this.whereClauses);
  }
}
  // https://developer.salesforce.com/docs/platform/lwc/guide/apex-call-imperative.html
   handleSubmit() {
    // try {
    //   // send whereClauses map, returns SOQL with the new criteria filtered
    //   this.availableAccounts = await getAccounts({ whereClauses: this.whereClauses });
    //   this.error = undefined;
    //   console.log('🚀 data from imperative getAccounts with submit button: ', this.availableAccounts);
    //   // TODO how can i console log my map?
    //   // console.log(JSON.stringify([this.whereClauses.entries()]));
    //   // console.log([...this.whereClauses.entries()]);
    //   // console.log([...Object.entries(this.whereClauses)]);
    //
    // } catch (error) {
    //   this.error = error;
    //   this.availableAccounts = undefined;
    //
    //   console.log(this.error);
    //
    // }
  try{
    this.getAccountData(this.whereClauses);

  }catch (error) {
    console.error('error:',error);
  }

  }//end handleSubmit

  async handleSave(event) {
    // Convert datatable draft values into record objects
    const records = event.detail.draftValues.slice().map((draftValue) => {
      const fields = Object.assign({}, draftValue);
      return {fields};
    });

    // Clear all datatable draft values
    this.draftValues = [];

    try {
      // Update all records in parallel thanks to the UI API
      const recordUpdatePromises = records.map((record) => updateRecord(record));
      await Promise.all(recordUpdatePromises);

      // Report success with a toast
      this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Account updated",
            variant: "success"
          })
      );
      //todo, implement imperative apex call instead of refreshApex (used with wire)
                                                          console.log('accountsUpdated before',this.accountsUpdated);
                                                           console.log('availableAccounts before',this.availableAccounts);


      // Display fresh data in the datatable
      // await refreshApex(this.availableAccounts);
      // this.availableAccounts = accountsUpdated.data;
                                                            console.log('accountsUpdated after',this.accountsUpdated);
                                                           console.log('availableAccounts after',this.availableAccounts);

    } catch (error) {
      this.dispatchEvent(
          new ShowToastEvent({
            title: "Error updating or reloading contacts",
            message: error.body.message,
            variant: "error"
          })
      );
    }
  }//end handleSave


}//end filterDataTable

