/**
 * Created by ausoto on 2024-09-02.
 */

import { LightningElement, wire } from "lwc";
import { gql, graphql } from "lightning/uiGraphQLApi";
import Id from "@salesforce/user/Id";
import CaseModal from "c/customCaseModal";

export default class CustomCaseList extends LightningElement {
  userId = Id;
  cases;

  @wire(graphql, {
    query: gql`
      query getCases($ownerId: ID, $limit: Int = 5) {
        uiapi {
          query {
            Case(
              where: { OwnerId: { eq: $ownerId } }
              first: $limit
              orderBy: { Priority: { order: ASC } }
            ) {
              edges {
                node {
                  Id
                  Subject {
                    value
                  }
                  Description {
                    value
                  }
                  Priority {
                    value
                  }
                  CreatedDate {
                    value
                  }
                  Status {
                    value
                  }
                }
              }
            }
          }
        }
      }
    `,
    variables: "$params",
  })
  graphqlQueryResult({ data }) {
    if (data) {
      this.cases = data.uiapi.query.Case.edges.map((edge) => edge.node);
    }
  }

  get params() {
    return {
      ownerId: this.userId ? this.userId : "",
    };
  }

  handleViewCase(event) {
    CaseModal.open({
      caseId: event.detail.Id,
    }).then((result) => {
      console.log(result);
    });
  }
}
