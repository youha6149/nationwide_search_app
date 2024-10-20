<template>
  <div class="results">
    <AddressSearch />
    <div class="results-container">
      <h1>検索結果</h1>

      <!-- 検索結果表示 -->
      <div v-if="addresses.length > 0" class="address-list-container">
        <div class="address-list">
          <div
            v-for="address in addresses"
            :key="address.id"
            class="address-card"
          >
            <h3>{{ address.prefecture }} {{ address.city }}</h3>
            <p>
              {{ address.postal_code }} {{ address.town }} {{ address.chome }}
            </p>
            <p>{{ address.business_name }} {{ address.business_address }}</p>
          </div>
        </div>

        <!-- ページネーション -->
        <div class="pagination">
          <button @click="changePage(page - 1)" :disabled="page === 1">
            前へ
          </button>
          <span>ページ {{ page }}</span>
          <button
            @click="changePage(page + 1)"
            :disabled="addresses.length < perPage"
          >
            次へ
          </button>
        </div>
      </div>

      <!-- エラーメッセージ -->
      <div v-if="error" class="error">{{ error }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import AddressSearch from "@/components/AddressSearch.vue";
import { ref, onMounted, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import axios from "axios";
import { Address } from "../types";

export default {
  components: {
    AddressSearch,
  },
  setup() {
    const route = useRoute();

    const searchQuery = ref(route.query.query || "");
    const addresses = ref<Address[]>([]);
    const error = ref("");
    const page = ref(1);
    const perPage = ref(10);

    const searchAddresses = async () => {
      try {
        const response = await axios.get(
          `http://localhost:3000/addresses/search`,
          {
            params: {
              query: searchQuery.value,
              page: page.value,
              per_page: perPage.value,
            },
          }
        );
        addresses.value = response.data as Address[];
        error.value = "";
      } catch (e) {
        console.error(e);
        error.value = "検索に失敗しました。";
        addresses.value = [];
      }
    };

    const changePage = (newPage: number) => {
      if (newPage > 0) {
        page.value = newPage;
        searchAddresses();
      }
    };

    watch(
      () => route.query.query,
      (newQuery) => {
        searchQuery.value = newQuery || "";
        searchAddresses();
      }
    );

    onMounted(() => {
      searchAddresses();
    });

    return {
      searchQuery,
      addresses,
      error,
      page,
      perPage,
      searchAddresses,
      changePage,
    };
  },
};
</script>

<style scoped>
.results-container {
  padding: 20px;
}

.address-list-container {
  width: 80%;
  margin-left: auto;
  margin-right: auto;
}

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

.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.error {
  color: red;
}
</style>
