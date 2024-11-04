<template>
  <div class="address-list">
    <div v-for="address in addresses" :key="address.id" class="address-card">
      <h3>{{ address.prefecture }} {{ address.city }}</h3>
      <p>{{ address.postal_code }} {{ address.town }} {{ address.chome }}</p>
      <p>{{ address.business_name }} {{ address.business_address }}</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";
import { Address } from "../types";

export default defineComponent({
  name: "ResultsList",
  props: {
    addresses: {
      type: Array as PropType<Address[]>,
      required: true,
    },
  },
});
</script>

<style scoped>
.address-list {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 20px;
  margin-top: 20px;
}

.address-card {
  border: 1px solid #ddd;
  padding: 15px;
  border-radius: 5px;
  background-color: #f9f9f9;
}
</style>
