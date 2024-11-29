import { describe, it, expect, beforeEach } from "vitest";
import { VueWrapper, mount } from "@vue/test-utils";
import AppFeature from "@/components/AppFeatures.vue";
import { ComponentPublicInstance } from "vue";
import { features } from "@/constants/featuresData";
import type { FeatureCard } from "@/constants/featuresData";

interface AppFeatureProps extends ComponentPublicInstance {}

describe("AppFeature", () => {
  let wrapper: VueWrapper & { vm: AppFeatureProps };

  beforeEach(() => {
    wrapper = mount(AppFeature) as VueWrapper & { vm: AppFeatureProps };
  });
  // memo: ユーザー視点では、機能を表す画像、ヘッド、説明が含まれたカードが4つ表示されているかどうかが重要
  describe("Component Structure", () => {
    it("renders all feature cards", () => {
      const cards = wrapper.findAll(".card");
      expect(cards).toHaveLength((features as FeatureCard[]).length);
    });

    it("has correct structure for each card", () => {
      const cards = wrapper.findAll(".card");

      cards.forEach((card) => {
        expect(card.find("img").exists()).toBe(true);
        expect(card.find("h3").exists()).toBe(true);
        expect(card.find("p").exists()).toBe(true);
      });
    });
  });
});
