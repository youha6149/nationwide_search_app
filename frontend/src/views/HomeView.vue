<template>
  <div class="home">
    <AddressSearch />
    <AppFeatures />
    <PdfViewer />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import AddressSearch from "@/components/AddressSearch.vue";
import AppFeatures from "@/components/AppFeatures.vue";
import PdfViewer from "@/components/PdfViewer.vue";

export default defineComponent({
  name: "HomeView",
  components: {
    AddressSearch,
    AppFeatures,
    PdfViewer,
  },
});
</script>
