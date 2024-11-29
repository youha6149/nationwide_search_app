import { shallowMount, flushPromises } from "@vue/test-utils";
import { describe, it, expect, beforeEach, afterEach, vi } from "vitest";
import ResultsView from "@/views/ResultsView.vue";
import axios from "axios";
import MockAdapter from "axios-mock-adapter";
import { mockAddresses } from "@/mocks/addressesMock";
import type { ComponentPublicInstance } from "vue";
import type { Address } from "@/types";

interface ResultsViewProps extends ComponentPublicInstance {
  addresses: Address[];
  error: string;
  page: number;
  perPage: number;
  searchQuery: string;
  searchAddresses: (resetPage?: boolean) => Promise<void>;
  changePage: (newPage: number) => void;
}

vi.mock("vue-router", () => ({
  useRoute: vi.fn(() => ({
    query: {
      query: "test",
    },
  })),
}));

describe("ResultsView.vue", () => {
  let mock: MockAdapter;

  beforeEach(() => {
    mock = new MockAdapter(axios);
    mock
      .onGet(`${process.env.VUE_APP_API_BASE_URL}/addresses/search`)
      .reply(200, mockAddresses);
  });

  afterEach(() => {
    mock.reset();
    vi.clearAllMocks();
  });

  const mountComponent = () => {
    return shallowMount(ResultsView, {
      global: {
        stubs: {
          AddressSearch: true,
          ResultsList: true,
          ResultsPagination: true,
        },
      },
    }) as ReturnType<typeof shallowMount> & { vm: ResultsViewProps };
  };

  it("displays search results when addresses are available", async () => {
    const wrapper = mountComponent();
    await flushPromises();
    expect(wrapper.vm.addresses.length).toBeGreaterThan(0);
  });

  it("displays an error message when API call fails", async () => {
    mock
      .onGet(`${process.env.VUE_APP_API_BASE_URL}/addresses/search`)
      .reply(500);
    const wrapper = mountComponent();
    await flushPromises();
    expect(wrapper.find(".error").text()).toBe("検索に失敗しました。");
  });

  it("updates page correctly when pagination changes", async () => {
    const wrapper = mountComponent();
    await wrapper.vm.changePage(2);
    await flushPromises();
    expect(wrapper.vm.page).toBe(2);
  });
});
