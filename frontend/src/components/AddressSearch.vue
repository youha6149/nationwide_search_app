<template>
    <div class="address-search">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="検索値を入力してください"
      />
      <button @click="searchAddresses">検索</button>

      <div v-if="addresses.length > 0">
        <ul>
          <li v-for="address in addresses" :key="address.id">
            {{ address.prefecture }} - {{ address.city }} - {{ address.postal_code }}
          </li>
        </ul>
        <div class="pagination">
          <button @click="changePage(page - 1)" :disabled="page === 1">前へ</button>
          <span>ページ {{ page }}</span>
          <button @click="changePage(page + 1)" :disabled="addresses.length < perPage">次へ</button>
        </div>
      </div>

      <div v-if="error" class="error">{{ error }}</div>
    </div>
  </template>

  <script lang="ts">
  import { ref } from 'vue';
  import axios from 'axios';

  export default {
    setup() {
      const searchQuery = ref('');
      const addresses = ref([]);
      const error = ref('');
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
          addresses.value = response.data;
          error.value = '';
        } catch (e) {
          error.value = '検索に失敗しました。';
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
    max-width: 600px;
    margin: 0 auto;
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
