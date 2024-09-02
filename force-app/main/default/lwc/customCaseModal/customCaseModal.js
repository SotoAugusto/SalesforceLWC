/**
 * Created by ausoto on 2024-09-02.
 */

import { api } from "lwc";
import LightningModal from "lightning/modal";

export default class CustomCaseModal extends LightningModal {
  @api caseId;
  handleClose() {
    this.close("closed");
  }
}
