import { describe, it, expect } from "vitest";
import { mount } from "@vue/test-utils";
import ResultsList from "@/components/ResultsList.vue";
import { mockAddresses } from "@/mocks/addressesMock";

describe("ResultsList", () => {
  it("renders all addresses from props", () => {
    const wrapper = mount(ResultsList, {
      props: {
        addresses: mockAddresses,
      },
    });

    const addressCards = wrapper.findAll(".address-card");
    expect(addressCards).toHaveLength(mockAddresses.length);

    addressCards.forEach((card) => {
      expect(card.find("h3").exists()).toBe(true);
      expect(card.findAll("p").length).toBeGreaterThan(0);
    });
  });

  it("renders empty when addresses array is empty", () => {
    const wrapper = mount(ResultsList, {
      props: {
        addresses: [],
      },
    });

    const addressCards = wrapper.findAll(".address-card");
    expect(addressCards).toHaveLength(0);
  });

  it("renders correctly when no addresses prop is passed", () => {
    const wrapper = mount(ResultsList);

    const addressCards = wrapper.findAll(".address-card");
    expect(addressCards).toHaveLength(0);
  });

  it("renders each address card with correct content", () => {
    const wrapper = mount(ResultsList, {
      props: {
        addresses: mockAddresses,
      },
    });

    const addressCards = wrapper.findAll(".address-card");
    addressCards.forEach((card, index) => {
      const address = mockAddresses[index];
      expect(card.find("h3").text()).toBe(
        `${address.prefecture} ${address.city}`,
      );
      const paragraphs = card.findAll("p");
      expect(paragraphs[0].text()).toBe(
        `${address.postal_code} ${address.town} ${address.chome}`.trim(),
      );
      expect(paragraphs[1].text()).toBe(
        `${address.business_name} ${address.business_address}`.trim(),
      );
    });
  });
});
