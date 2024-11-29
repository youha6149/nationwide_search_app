import { describe, it, expect } from "vitest";
import { mount } from "@vue/test-utils";
import PdfViewer from "@/components/PdfViewer.vue";

describe("PdfViewer", () => {
  it("renders a Google Slides presentation in an iframe", () => {
    const wrapper = mount(PdfViewer);
    const iframe = wrapper.find("iframe");

    expect(iframe.exists()).toBe(true);

    expect(iframe.attributes("src")).toBe(
      "https://docs.google.com/presentation/d/e/2PACX-1vSR9GbLD-22P94Yy7U7VrZmtSCgoFpbLmbwpUstvFzGs21ZEJf3Sbjht2z4CQpmR6oh2GqrZumHaTPE/embed?start=false&loop=false&delayms=3000",
    );
  });
});
