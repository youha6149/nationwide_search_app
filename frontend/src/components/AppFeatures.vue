<template>
  <div class="features">
    <div class="card" v-for="(feature, index) in features" :key="index">
      <img :src="feature.image" :alt="feature.alt" />
      <h3>{{ feature.title }}</h3>
      <p>{{ feature.description }}</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import { features } from "@/constants/featuresData";
import type { FeatureCard } from "@/constants/featuresData";

export default defineComponent({
  setup() {
    const featuresList = ref<FeatureCard[]>(features);
    return {
      features: featuresList,
    };
  },
});
</script>

<style scoped>
.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin: 30px;
  place-content: center;
  place-items: center;
}

.card {
  flex-direction: column;
  align-items: center;
  border-radius: 8px;
  padding: 10px;
  max-width: 300px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  height: 100%;
}

.card img {
  width: 100%;
  max-width: 60px;
  height: auto;
}

.card h3 {
  text-align: center;
  font-size: 18px;
}

.card p {
  margin-top: 10px;
  font-size: 14px;
  text-align: center;
}

@media (max-width: 1200px) {
  .features {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 480px) {
  .features {
    grid-template-columns: 1fr;
  }
}
</style>
