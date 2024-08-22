/**
 * Created by ausoto on 2024-08-18.
 */

import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' }
];

export default class AccountTable extends LightningElement {
    columns = columns;
    @wire(getAccounts) accounts;
}
