import { shallowMount, VueWrapper } from "@vue/test-utils";
import { describe, it, expect, beforeEach, afterEach, vi, Mock } from "vitest";
import AddressSearch from "@/components/AddressSearch.vue";
import { ComponentPublicInstance } from "vue";

interface AddressSearchProps extends ComponentPublicInstance {
  searchQuery: string;
  goToResults: () => void;
}

const mockPush = vi.fn();
vi.mock("vue-router", () => ({
  useRouter: () => ({
    push: mockPush,
  }),
}));

describe("AddressSearch.vue", () => {
  let wrapper: VueWrapper & { vm: AddressSearchProps };
  let mockAlert: Mock<(message?: any) => void>;

  beforeEach(() => {
    mockAlert = vi.spyOn(window, "alert").mockImplementation(() => {}) as Mock<
      (message?: any) => void
    >;
    mockPush.mockClear();
    mockAlert.mockClear();

    wrapper = shallowMount(AddressSearch) as VueWrapper & {
      vm: AddressSearchProps;
    };
  });

  afterEach(() => {
    mockPush.mockReset();
    mockAlert.mockReset();
  });

  describe("Component Rendering", () => {
    it("renders the component correctly", () => {
      expect(wrapper.find(".search-view-container").exists()).toBe(true);
      expect(wrapper.find("h1").text()).toBe(
        "Find the best location for your project",
      );
      expect(wrapper.find(".search-input").exists()).toBe(true);
      expect(wrapper.find(".search-button").exists()).toBe(true);
      expect(wrapper.find("img").exists()).toBe(true);
    });

    it("renders the correct placeholder text", () => {
      const input = wrapper.find(".search-input");
      expect(input.attributes("placeholder")).toBe("地名を入力してください");
    });

    it("renders the search button with correct text", () => {
      const button = wrapper.find(".search-button");
      expect(button.text()).toBe("検索");
    });

    it("renders the image with correct source and alt text", () => {
      const img = wrapper.find("img");
      expect(img.attributes("src")).toContain("search_results.png");
      expect(img.attributes("alt")).toBe("Description");
    });
  });

  describe("Search Functionality", () => {
    it("updates searchQuery when input value changes", async () => {
      const input = wrapper.find(".search-input");
      await input.setValue("Tokyo");
      expect(wrapper.vm.searchQuery).toBe("Tokyo");
    });

    it("navigates to results page with correct query when search button is clicked with valid input", async () => {
      const input = wrapper.find(".search-input");
      const button = wrapper.find(".search-button");

      await input.setValue("Tokyo");
      await button.trigger("click");

      expect(mockPush).toHaveBeenCalledWith({
        name: "Results",
        query: { query: "Tokyo" },
      });
    });

    it("shows alert when search button is clicked with empty input", async () => {
      const button = wrapper.find(".search-button");
      await button.trigger("click");

      expect(mockAlert).toHaveBeenCalledWith("検索クエリを入力してください");
      expect(mockPush).not.toHaveBeenCalled();
    });

    it("shows alert when search button is clicked with only whitespace input", async () => {
      const input = wrapper.find(".search-input");
      const button = wrapper.find(".search-button");

      await input.setValue("   ");
      await button.trigger("click");

      expect(mockAlert).toHaveBeenCalledWith("検索クエリを入力してください");
      expect(mockPush).not.toHaveBeenCalled();
    });
  });

  describe("Component Structure", () => {
    it("contains required sections", () => {
      expect(wrapper.find(".search-section").exists()).toBe(true);
      expect(wrapper.find(".image-section").exists()).toBe(true);
      expect(wrapper.find(".search-bar").exists()).toBe(true);
    });

    it("has correct flex layout structure", () => {
      const container = wrapper.find(".search-view-container");
      const searchSection = wrapper.find(".search-section");
      const imageSection = wrapper.find(".image-section");

      expect(container.exists()).toBe(true);
      expect(searchSection.exists()).toBe(true);
      expect(imageSection.exists()).toBe(true);
    });

    it("has correct search input and button structure", () => {
      const searchBar = wrapper.find(".search-bar");
      const input = searchBar.find(".search-input");
      const button = searchBar.find(".search-button");

      expect(input.exists()).toBe(true);
      expect(button.exists()).toBe(true);
    });
  });
});
