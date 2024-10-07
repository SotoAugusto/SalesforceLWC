import { LightningElement, wire, track } from "lwc";
import getAccountOppStats from "@salesforce/apex/OpportunityController.getAccountOppStats";

export default class OpportunityAggregate extends LightningElement {
  // COLUMNS = [
  //   { label: "Account Id", fieldName: "Id" },
  //   { label: "Account Name", fieldName: "Name" },
  //   {
  //     label: "Annual Revenue Sum",
  //     fieldName: "AnnualRevenueSum",
  //     type: "currency",
  //   },
  //   {
  //     label: "Total Opportunities",
  //     fieldName: "TotalOpportunities",
  //     type: "number",
  //   },
  //   {
  //     label: "Total Opportunity Amount",
  //     fieldName: "TotalOpportunityAmount",
  //     type: "currency",
  //   },
  //   {
  //     label: "Max Opportunity Amount",
  //     fieldName: "MaxOpportunityAmount",
  //     type: "currency",
  //   },
  //   {
  //     label: "Avg Revenue Per Opportunity",
  //     fieldName: "AvgRevenuePerOpportunity",
  //     type: "currency",
  //   },
  // ];
  @track accountOpportunityData;
  @wire(getAccountOppStats)
  opportunitiesList({ error, data }) {
    if (data) {
      console.log("✅ data from @wire accountOpportunityData: ", data);
      this.accountOpportunityData = data;
    } else if (error) {
      console.log("❌ error from @wire accountOpportunityData: ", error);
    }
  } //end wire
} //end component
