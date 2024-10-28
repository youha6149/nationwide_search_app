import { shallowMount } from "@vue/test-utils";
import HomeView from "@/views/HomeView.vue";
import AddressSearch from "@/components/AddressSearch.vue";
import AppFeatures from "@/components/AppFeatures.vue";
import PdfViewer from "@/components/PdfViewer.vue";

describe("HomeView.vue", () => {
    let wrapper: any;

    beforeEach(() => {
        wrapper = shallowMount(HomeView);
    });

    it("renders the component", () => {
        expect(wrapper.exists()).toBe(true);
    });

    it("contains AddressSearch component", () => {
        const addressSearch = wrapper.findComponent(AddressSearch);
        expect(addressSearch.exists()).toBe(true);
    });

    it("contains AppFeatures component", () => {
        const appFeatures = wrapper.findComponent(AppFeatures);
        expect(appFeatures.exists()).toBe(true);
    });

    it("contains PdfViewer component", () => {
        const pdfViewer = wrapper.findComponent(PdfViewer);
        expect(pdfViewer.exists()).toBe(true);
    });
});
