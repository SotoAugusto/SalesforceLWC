// component that receives info from filterDataTable via LMS
import { LightningElement, api, wire, track } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import ANNUAL_REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import OWNER_NAME_FIELD from "@salesforce/schema/Account.Owner.Name";
import PHONE_FIELD from "@salesforce/schema/Account.Phone";

import { subscribe, MessageContext } from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";
export default class MyComponent extends LightningElement {
  //LMS
  @track value; //value received through channel, this will be my recordID
  fields = [
    NAME_FIELD,
    INDUSTRY_FIELD,
    ANNUAL_REVENUE_FIELD,
    PHONE_FIELD,
    OWNER_NAME_FIELD,
  ];
  subscription; //subscribe to channel
  @wire(MessageContext)
  messageContext;

  connectedCallback() {
    this.subscribeToMessageChannel();
  }

  // receiver of message
  subscribeToMessageChannel() {
    this.subscription = subscribe(
      this.messageContext,
      MY_MESSAGE_CHANNEL,
      (message) => this.handleMessage(message),
    );
  }

  handleMessage(message) {
    this.value = message.value;
  }

  // LDS

  @api objectApiName = ACCOUNT_OBJECT.objectApiName;
  // https://developer.salesforce.com/docs/component-library/bundle/lightning-record-form/documentation
  @wire(getRecord, {
    recordId: "$value",
    fields: "$fields",
  })
  account;
}
