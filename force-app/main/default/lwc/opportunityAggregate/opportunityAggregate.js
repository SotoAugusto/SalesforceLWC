import { LightningElement, wire, track } from "lwc";
import getOpportunitiesByAccount from "@salesforce/apex/OpportunityController.getOpportunitiesByAccount";

export default class OpportunityAggregate extends LightningElement {
  COLUMNS = [
    { label: "Account Id", fieldName: "Id" },
    { label: "Account Name", fieldName: "Name" },
    {
      label: "Annual Revenue Sum",
      fieldName: "AnnualRevenueSum",
      type: "currency",
    },
    {
      label: "Total Opportunities",
      fieldName: "TotalOpportunities",
      type: "number",
    },
    {
      label: "Total Opportunity Amount",
      fieldName: "TotalOpportunityAmount",
      type: "currency",
    },
    {
      label: "Max Opportunity Amount",
      fieldName: "MaxOpportunityAmount",
      type: "currency",
    },
    {
      label: "Avg Revenue Per Opportunity",
      fieldName: "AvgRevenuePerOpportunity",
      type: "currency",
    },
  ];
  @track currentOpportunitiesList;
  @wire(getOpportunitiesByAccount)
  opportunitiesList({ error, data }) {
    if (data) {
      console.log("✅ data from @wire opportunitiesList: ", data);
      this.currentOpportunitiesList = data;
      // this.initialRecords = data;
    } else if (error) {
      console.log("❌ error from @wire opportunitiesList: ", error);
      // this.availableAccounts = undefined;
    }
  } //end wire
} //end component
