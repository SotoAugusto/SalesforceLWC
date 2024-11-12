import { LightningElement, wire, track } from "lwc";
import getAccountOppStats from "@salesforce/apex/OpportunityController.getAccountOppStats";

export default class AccountOpportunityData extends LightningElement {
  @track items = [];

  @wire(getAccountOppStats)
  wiredAccountOppStats({ error, data }) {
    if (data) {
      this.items = this.formatData(data);
    } else if (error) {
      console.error("Error fetching account opportunity data:", error);
    }
  }

  formatData(data) {
    return data.map((account) => {
      return {
        label: account.accountName,
        name: account.accountId,
        metatext: `Annual Revenue: ${account.annualRevenueSum},
         Total Opportunities: ${account.totalOpportunities},
          totalOpportunityAmount: ${account.totalOpportunityAmount},
           MaxOpportunityAmount: ${account.maxOpportunityAmount},
            AvgRevenuePerOpportunity: ${account.avgRevenuePerOpportunity}`,
        expanded: false,
        items: account.opportunities.map((opportunity) => {
          return {
            label: opportunity.Name,
            name: opportunity.Id,
            metatext: `Amount: ${opportunity.Amount}`,
            expanded: true,
            items: [],
          };
        }),
      };
    });
  }
}
