import { shallowMount, flushPromises } from "@vue/test-utils";
import ResultsView from "@/views/ResultsView.vue";
import axios from "axios";
import MockAdapter from "axios-mock-adapter";
import { mockAddresses } from "@/mocks/addressesMock";

jest.mock("vue-router", () => ({
    useRoute: jest.fn(() => ({
        query: {
            query: "test"
        }
    }))
}));

describe("ResultsView.vue", () => {
    let mock: MockAdapter;

    beforeEach(() => {
        mock = new MockAdapter(axios);
        mock.onGet(`${process.env.VUE_APP_API_BASE_URL}/addresses/search`).reply(200, mockAddresses);
    });

    afterEach(() => {
        mock.reset();
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
        });
    };

    it("displays search results when addresses are available", async () => {
        const wrapper = mountComponent();
        await flushPromises();
        expect(wrapper.vm.addresses.length).toBeGreaterThan(0);
    });

    it("displays an error message when API call fails", async () => {
        mock.onGet(`${process.env.VUE_APP_API_BASE_URL}/addresses/search`).reply(500);
        const wrapper = mountComponent();
        await flushPromises();
        expect(wrapper.find(".error").text()).toBe("検索に失敗しました。");
    });

    it("updates page correctly when pagination changes", async () => {
        const wrapper = mountComponent();
        wrapper.vm.changePage(2);
        await flushPromises();
        expect(wrapper.vm.page).toBe(2);
    });
});
