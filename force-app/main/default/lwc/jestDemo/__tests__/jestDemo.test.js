import { createElement } from "lwc";
import jestDemoComponent from "c/JestDemo";

const mockAccounts = require("./mockData/accounts.json");

describe("taco tests suite", () => {
  beforeEach(() => {
    const jestDemo = createElement("c-jest-demo", {
      is: jestDemoComponent,
    });
    document.body.appendChild(jestDemo);
  }); //end beforeach

  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  }); //end aftereach

  test("check iterator values", () => {
    const jestDemo = document.querySelector("c-jest-demo");
    const tacoParagraphs = jestDemo.shadowRoot.querySelectorAll(".tacoInfo");
    const tacoArray = Array.from(tacoParagraphs);
    //from the array, pull out the text content
    const tacoTextContentArray = tacoArray.map((p) => p.textContent);
    expect(tacoTextContentArray.length).toBe(3);
    expect(tacoTextContentArray).toEqual([
      "Chalupa",
      "Soft Shell",
      "Hard Shell",
    ]);
  });

  test("onclick new paragraph shown", () => {
    const jestDemo = document.querySelector("c-jest-demo");
    const newParagraph = jestDemo.shadowRoot.querySelector(".newParagraph");
    expect(newParagraph).toBeNull();
    const button = jestDemo.shadowRoot.querySelector(".renderButton");
    //   wait for event
    //simulate event, click
    button.dispatchEvent(new CustomEvent("click"));
    //   promise
    return Promise.resolve().then(() => {
      const newParagraph = jestDemo.shadowRoot.querySelector(".newParagraph");
      expect(newParagraph.textContent).toBe("Wow I love Tacos");
    });
  });

  test("paragraph bind variable", () => {
    const jestDemo = document.querySelector("c-jest-demo");
    const paragraphText = jestDemo.shadowRoot.querySelector(".tacoStuff");
    expect(paragraphText.textContent).toBe("Tacos are exciting");
  });
}); //end describe
