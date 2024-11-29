import { describe, it, expect } from "vitest";
import { mount } from "@vue/test-utils";
import ResultsPagination from "@/components/ResultsPagination.vue";

describe("ResultsPagination", () => {
  it("displays current page number", () => {
    const wrapper = mount(ResultsPagination, {
      props: {
        page: 2,
        perPage: 10,
        addressesCount: 30,
      },
    });

    expect(wrapper.find("span").text()).toBe("ページ 2");
  });

  it("emits updatePage event with correct page number when buttons are clicked", async () => {
    const wrapper = mount(ResultsPagination, {
      props: {
        page: 2,
        perPage: 10,
        addressesCount: 30,
      },
    });

    await wrapper.findAll("button")[0].trigger("click");
    expect(wrapper.emitted("updatePage")?.[0]).toEqual([1]);

    await wrapper.findAll("button")[1].trigger("click");
    expect(wrapper.emitted("updatePage")?.[1]).toEqual([3]);
  });

  it("disables previous button on first page", () => {
    const wrapper = mount(ResultsPagination, {
      props: {
        page: 1,
        perPage: 10,
        addressesCount: 30,
      },
    });

    const prevButton = wrapper.findAll("button")[0];
    expect(prevButton.attributes("disabled")).toBeDefined();
  });

  it("disables next button when no more results", () => {
    const wrapper = mount(ResultsPagination, {
      props: {
        page: 1,
        perPage: 10,
        addressesCount: 5,
      },
    });

    const nextButton = wrapper.findAll("button")[1];
    expect(nextButton.attributes("disabled")).toBeDefined();
  });

  it("enables both buttons when on middle page with more results", () => {
    const wrapper = mount(ResultsPagination, {
      props: {
        page: 2,
        perPage: 10,
        addressesCount: 30,
      },
    });

    const [prevButton, nextButton] = wrapper.findAll("button");
    expect(prevButton.attributes("disabled")).toBeUndefined();
    expect(nextButton.attributes("disabled")).toBeUndefined();
  });
});
