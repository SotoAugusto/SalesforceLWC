/**
 * Created by ausoto on 2024-09-02.
 */
// https://jetbi.com/blog/communication-between-lightning-web-components-how-many-can-we-use
// Demo on LMS, this is the receiver
import { LightningElement, wire } from "lwc";
import { subscribe, MessageContext } from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";

export default class Component1 extends LightningElement {
  value;
  subscription;

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
}
