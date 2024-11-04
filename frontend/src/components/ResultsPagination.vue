<template>
  <div class="pagination">
    <button @click="changePage(page - 1)" :disabled="page === 1">前へ</button>
    <span>ページ {{ page }}</span>
    <button @click="changePage(page + 1)" :disabled="isNextDisabled">
      次へ
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({
  name: "ResultsPagination",
  props: {
    page: {
      type: Number,
      required: true,
    },
    perPage: {
      type: Number,
      required: true,
    },
    addressesCount: {
      type: Number,
      required: true,
    },
  },
  computed: {
    isNextDisabled(): boolean {
      return this.addressesCount < this.perPage;
    },
  },
  methods: {
    changePage(newPage: number) {
      this.$emit("updatePage", newPage);
    },
  },
});
</script>

<style scoped>
.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}
</style>
