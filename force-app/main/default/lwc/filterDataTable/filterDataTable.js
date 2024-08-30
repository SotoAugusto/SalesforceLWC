/**
 * Created by ausoto on 2024-08-19.
 */

import {LightningElement, track, wire} from 'lwc';
//import apex shortcut
//get records from soql
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import updateAccounts from '@salesforce/apex/AccountController.updateAccounts';
//import lightning shortcut
//for actions
import {NavigationMixin} from 'lightning/navigation';
//update db
import {refreshApex} from "@salesforce/apex";
//update ui
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

import {notifyRecordUpdateAvailable, updateRecord} from "lightning/uiRecordApi";
import {ShowToastEvent} from "lightning/platformShowToastEvent";

// dropdown actions
const ACTIONS = [
    {label: 'View', name: 'view'},
    {label: 'Edit', name: 'edit'},
];
// https://techdicer.com/add-hyperlink-column-in-lwc-datatable/
const COLUMNS = [
    {
        label: 'View',
        fieldName: 'accLink',
        type: 'url',
        typeAttributes: {label: 'See record', target: '_blank'}
    },
    {label: 'Name', fieldName: 'Name', editable: true},
    {label: 'Industry', fieldName: 'Industry', editable: true},
    {label: 'AnnualRevenue', fieldName: 'AnnualRevenue', editable: true},
    {
        type: 'action',
        typeAttributes: {rowActions: ACTIONS},
    },
]


export default class FilterDataTable extends NavigationMixin(LightningElement) {
    @track availableAccounts;
    @track initialRecords;
    @track columns = COLUMNS;
    @track draftValues = [];
    @track error;
    @track value = [];
    @track whereClauses = {};

    //todo, see how to reuse values from accountInputFields
    get optionsFilterCheckbox() {
        return [
            {label: 'Billing Street', value: 'billingStreet'},
            {label: 'Billing City', value: 'billingCity'},
            {label: 'Billing State', value: 'billingState'},
            {label: 'Billing Postal Code', value: 'billingPostalCode'},
            {label: 'Billing Country', value: 'billingCountry'},
            {label: 'Billing Street', value: 'shippingStreet'},
        ];

    }

    accountInputFields = [
        {
            dataName: 'billingStreet',
            label: 'Billing Street',
            isVisible: false
        },
        {
            dataName: 'billingCity',
            label: 'Billing City',
            isVisible: false
        },
        {
            dataName: 'billingState',
            label: 'Billing State',
            isVisible: false
        },
        {
            dataName: 'billingPostalCode',
            label: 'Billing Postal Code',
            isVisible: false
        },
        {
            dataName: 'billingCountry',
            label: 'Billing Country',
            isVisible: false
        },
        {
            dataName: 'shippingStreet',
            label: 'Shipping Street',
            isVisible: false
        },
        {
            dataName: 'shippingCity',
            label: 'Shipping City',
            isVisible: false
        },
        {
            dataName: 'shippingState',
            label: 'Shipping State',
            isVisible: false
        },
        {
            dataName: 'shippingPostalCode',
            label: 'Shipping Postal Code',
            isVisible: false
        },
        {
            dataName: 'shippingCountry',
            label: 'Shipping Country',
            isVisible: false
        },
        {
            dataName: 'phone',
            label: 'Phone',
            isVisible: false
        },
        {
            dataName: 'fax',
            label: 'Fax',
            isVisible: false
        },
        {
            dataName: 'accountNumber',
            label: 'Account Number',
            isVisible: false
        },
        {
            dataName: 'website',
            label: 'Website',
            isVisible: false
        },
        {
            dataName: 'photoUrl',
            label: 'Photo URL',
            isVisible: false
        },
        {
            dataName: 'sic',
            label: 'Sic',
            isVisible: false
        },
        {
            dataName: 'numberOfEmployees',
            label: 'Number of Employees',
            isVisible: false
        },
        {
            dataName: 'ownership',
            label: 'Ownership',
            isVisible: false
        }
    ];


//imperative apex method call to get db data
    getAccountData(whereClauses) {
        getAccounts({whereClauses: this.whereClauses})
            .then(data => {
                if (data) {
                    console.log('🚀 data from imperative getAccounts: ', data);
                    data = JSON.parse(JSON.stringify(data));
                    data.forEach(res => {
                      res.accLink = '/' + res.Id;
                    });

                    this.availableAccounts = data;
                    this.initialRecords = data;

                }
            }).catch(error => {
            console.log(error);
        })
    }// end getAccountData


    // runs on page load, similar to @wire
    connectedCallback() {
        console.log('connectedCallback');
        this.getAccountData(this.whereClauses);
    }


// @wire(updateAccount,{recordId: '$recordId'})
// accountsUpdated;
// wire runs on page load
// get all account records from controller, then save them to availableAccounts and initialRecords for display

// @wire(getAccounts, {whereClauses: '$whereClauses' })

    /* propertyOrFunction—A private property or function that receives the stream of data from the wire service.
    If a property is decorated with @wire, the results are returned to the property’s data property or error property.
    If a function is decorated with @wire, the results are returned in an object with a data property or an error property.

    Note
    The data property and the error property are hardcoded values in the API. You must use these values.
     in this case, im using a function wiredAccount */

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


    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'view':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
                        objectApiName: 'Account',
                        actionName: 'view'
                    }
                });
                break;
            case 'edit':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.Id,
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

        console.log('input data-name:', field);
        console.log('input value:', criteria);

        // if the input has a value (criteria), save it in to the map
        if (criteria) {
            this.whereClauses[field] = criteria;
            // console.log(this.whereClauses);
        }
    }

    handleSubmit() {
        try {
            this.getAccountData(this.whereClauses);
        } catch (error) {
            console.error('error:', error);
        }

    }//end handleSubmit

//checkbox
    get selectedValues() {
        return this.value.join(',');

    }

//checkbox
    handleChangeFilterCheckbox(event) {
        const selectedValues = event.detail.value;
        this.value = selectedValues;

        this.accountInputFields.forEach(field => {
            field.isVisible = selectedValues.includes(field.dataName);
        });
    }


    @track isLoading = false;


    handleSave(event) {

        // Show spinner
        this.isLoading = true;
        // get fields to update
        const updatedFields = event.detail.draftValues;
        console.log('updatedFields:', updatedFields);
        // Clear all datatable draft values
        this.draftValues = [];

        updateAccounts({accountsForUpdate: updatedFields}).then(() => {
            return this.getAccountData(this.whereClauses);
        }).catch(error => {
            console.error('error:', error);
        }).finally(() => {
            return this.isLoading = false;
        })
    }//end handleSave


}//end filterDataTable
