<template>
  <div class="address-search">
    <div class="search-bar">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="地名を入力してください"
        class="search-input"
      />
      <button @click="searchAddresses" class="search-button">検索</button>
    </div>

    <div v-if="addresses.length > 0">
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

    <div v-if="error" class="error">{{ error }}</div>
  </div>
</template>

<script lang="ts">
import { ref } from "vue";
import axios from "axios";
import { Address } from "../types";

export default {
  setup() {
    const searchQuery = ref("");
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
.address-search {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-bar {
  display: flex;
  justify-content: center;
  margin: 80px 0 20px 0;
}

.search-input {
  flex: 1;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 5px 0 0 5px;
}

.search-button {
  padding: 10px 20px;
  font-size: 16px;
  border: 1px solid #ddd;
  background-color: #007bff;
  color: white;
  cursor: pointer;
  border-radius: 0 5px 5px 0;
}

.address-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
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
