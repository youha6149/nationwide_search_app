<template>
  <div class="home">
    <AddressSearch />
    <AppFeatures />
    <div class="pdf-viewer">
      <div class="iframe-container">
        <iframe
          src="https://docs.google.com/presentation/d/e/2PACX-1vSR9GbLD-22P94Yy7U7VrZmtSCgoFpbLmbwpUstvFzGs21ZEJf3Sbjht2z4CQpmR6oh2GqrZumHaTPE/embed?start=false&loop=false&delayms=3000"
          frameborder="0"
          width="960"
          height="749"
          allowfullscreen="true"
          mozallowfullscreen="true"
          webkitallowfullscreen="true"
        ></iframe>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import AddressSearch from "@/components/AddressSearch.vue";
import AppFeatures from "@/components/AppFeatures.vue";

export default defineComponent({
  name: "HomeView",
  components: {
    AddressSearch,
    AppFeatures,
  },
});
</script>

<style scoped>
.pdf-viewer {
  width: 100%;
  max-width: 800px;
  margin: 20px auto;
}

.iframe-container {
  position: relative;
  width: 100%;
  padding-top: 56.25%;
}

.iframe-container iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  border: 0;
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
