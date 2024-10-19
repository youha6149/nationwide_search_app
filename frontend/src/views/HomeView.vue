<template>
  <div class="home">
    <AddressSearch />
    <!-- 以下にこのWebアプリの特徴などを書く -->
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
// import HelloWorld from "@/components/HelloWorld.vue"; // @ is an alias to /src
import AddressSearch from "@/components/AddressSearch.vue";

export default defineComponent({
  name: "HomeView",
  components: {
    AddressSearch,
  },
});
</script>
