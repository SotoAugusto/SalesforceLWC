import { LightningElement, wire } from "lwc";
import getAccounts from "@salesforce/apex/JestDemoController.getAccounts";

export default class JestDemo extends LightningElement {
  @wire(getAccounts)
  accounts;

  connectedCallback() {
    console.log(
      "This is the account JSON = " + JSON.stringify(this.accounts.data),
    );
  }

  tacoStuff = "Tacos are exciting";
  showNewParagraph = false;
  tacoList = [
    { Id: 1, TacoType: "Chalupa" },
    { Id: 2, TacoType: "Soft Shell" },
    { Id: 3, TacoType: "Hard Shell" },
  ];

  renderNewParagraph() {
    this.showNewParagraph = true;
  }
}
