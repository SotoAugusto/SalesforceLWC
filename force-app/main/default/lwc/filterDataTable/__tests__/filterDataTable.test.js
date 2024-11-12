import { createElement } from "lwc";
import FilterDataTable from "c/filterDataTable";
import getAccounts from "@salesforce/apex/AccountController.getAccounts";
import updateAccounts from "@salesforce/apex/AccountController.updateAccounts";
// import { publish, MessageContext } from "lightning/messageService";
// import { ShowToastEvent } from "lightning/platformShowToastEvent";

// testear filtrado
// testear los datos traidos de apex (hacer mocks)
// testear que se muestre el input correcto al hacer check del checkbox
// testear el toast

// Mock the required modules
jest.mock("@salesforce/apex", () => ({
  getAccounts: jest.fn(),
  updateAccounts: jest.fn(),
}));

jest.mock("lightning/messageService", () => {
  return {
    publish: jest.fn(),
    MessageContext: jest.fn(),
  };
});

jest.mock("lightning/platformShowToastEvent", () => {
  return {
    ShowToastEvent: jest.fn(),
  };
});

// jest.mock("lightning/navigation", () => {
//   return {
//     NavigationMixin: (Base) =>
//       class extends Base {
//         [NavigationMixin.Navigate] = jest.fn();
//       },
//   };
// });

describe("c-filter-data-table", () => {
  afterEach(() => {
    // Clean up after each test
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("should render search input, checkbox group, and datatable", async () => {
    // Arrange
    getAccounts.mockResolvedValue([
      {
        Id: "001",
        Name: "Acme Inc",
        Industry: "Technology",
        AnnualRevenue: 1000000,
      },
    ]);

    const element = createElement("c-filter-data-table", {
      is: FilterDataTable,
    });

    // Act
    document.body.appendChild(element);

    // Wait for the wire to resolve and rerender
    await Promise.resolve();

    // Assert
    const searchInput = element.shadowRoot.querySelector(
      'lightning-input[data-name="searchAccount"]',
    );
    expect(searchInput).not.toBeNull();

    const datatable = element.shadowRoot.querySelector("lightning-datatable");
    expect(datatable).not.toBeNull();

    // Verify that Apex call is made
    expect(getAccounts).toHaveBeenCalled();
  });

  it("should filter accounts based on search input", async () => {
    // Arrange
    getAccounts.mockResolvedValue([
      {
        Id: "001",
        Name: "Acme Inc",
        Industry: "Technology",
        AnnualRevenue: 1000000,
      },
    ]);

    const element = createElement("c-filter-data-table", {
      is: FilterDataTable,
    });

    document.body.appendChild(element);

    // Wait for initial data to load
    await Promise.resolve();

    // Act
    const searchInput = element.shadowRoot.querySelector(
      'lightning-input[data-name="searchAccount"]',
    );
    searchInput.value = "Acme";
    searchInput.dispatchEvent(new CustomEvent("change"));

    // Assert filtered data
    await Promise.resolve();
    expect(element.availableAccounts.length).toBe(1);
  });

  it('should call the sendMessage method on "Send Record ID" button click', async () => {
    // Arrange
    getAccounts.mockResolvedValue([
      {
        Id: "001",
        Name: "Acme Inc",
        Industry: "Technology",
        AnnualRevenue: 1000000,
      },
    ]);

    const element = createElement("c-filter-data-table", {
      is: FilterDataTable,
    });

    document.body.appendChild(element);

    await Promise.resolve();

    // Simulate row action event
    const datatable = element.shadowRoot.querySelector("lightning-datatable");
    datatable.dispatchEvent(
      new CustomEvent("rowaction", {
        detail: { action: { name: "send_id_to_LMS" }, row: { Id: "001" } },
      }),
    );

    // Assert that publish is called
    expect(publish).toHaveBeenCalledWith(
      expect.any(Object),
      expect.any(Object),
      { value: "001" },
    );
  });

  it("should call the handleSave method and show a success toast", async () => {
    // Arrange
    updateAccounts.mockResolvedValue();
    getAccounts.mockResolvedValue([]);

    const element = createElement("c-filter-data-table", {
      is: FilterDataTable,
    });

    document.body.appendChild(element);

    await Promise.resolve();

    const datatable = element.shadowRoot.querySelector("lightning-datatable");

    // Simulate save event
    datatable.dispatchEvent(
      new CustomEvent("save", {
        detail: { draftValues: [{ Id: "001", Name: "Updated Acme Inc" }] },
      }),
    );

    // Wait for promise resolution
    await Promise.resolve();

    // Assert
    expect(updateAccounts).toHaveBeenCalled();
    expect(ShowToastEvent).toHaveBeenCalledWith({
      title: "Success",
      message: "Records updated",
      variant: "success",
    });
  });
});
