/**
 * Created by ausoto on 2024-09-02.
 */
import { LightningElement, wire } from "lwc";
import { publish, MessageContext } from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";

export default class Component1 extends LightningElement {
  @wire(MessageContext)
  messageContext;
  // change on submit
  // modify channel to send differents kind of data

  // layout form component
  // layout form edit component

  // LDS on component
  // record id

  sendMessage(event) {
    const payload = {
      value: event.target.value,
    };
    // sender of message
    publish(this.messageContext, MY_MESSAGE_CHANNEL, payload);
  }
}
