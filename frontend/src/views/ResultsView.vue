<template>
  <div class="results">
    <AddressSearch />
    <div class="results-container">
      <h1>検索結果</h1>

      <div v-if="addresses.length > 0" class="address-list-container">
        <ResultsList :addresses="addresses" />
        <ResultsPagination
          :page="page"
          :perPage="perPage"
          :addressesCount="addresses.length"
          @updatePage="changePage"
        />
      </div>

      <div v-if="error" class="error">{{ error }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, watch } from "vue";
import AddressSearch from "@/components/AddressSearch.vue";
import ResultsList from "@/components/ResultsList.vue";
import ResultsPagination from "@/components/ResultsPagination.vue";
import { useRoute } from "vue-router";
import axios from "axios";
import MockAdapter from "axios-mock-adapter";
import { Address } from "@/types";
import { mockAddresses } from "@/mocks/addressesMock";

export default defineComponent({
  name: "ResultsView",
  components: {
    AddressSearch,
    ResultsList,
    ResultsPagination,
  },
  setup() {
    const route = useRoute();
    const searchQuery = ref<string>((route.query.query as string) || "");
    const addresses = ref<Address[]>([]);
    const error = ref<string>("");
    const page = ref<number>(1);
    const perPage = ref<number>(10);

    if (process.env.VUE_APP_USE_MOCK === "true") {
      const mock = new MockAdapter(axios);

      mock
        .onGet(`${process.env.VUE_APP_API_BASE_URL}/addresses/search`)
        .reply((config) => {
          const params = config.params;
          const currentPage = parseInt(params.page, 10);
          const itemsPerPage = parseInt(params.per_page, 10);

          const start = (currentPage - 1) * itemsPerPage;
          const end = start + itemsPerPage;
          const paginatedData = mockAddresses.slice(start, end);

          return [200, paginatedData];
        });
    }

    const searchAddresses = async (resetPage = false) => {
      if (resetPage) {
        page.value = 1;
      }

      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_BASE_URL}/addresses/search`,
          {
            params: {
              query: searchQuery.value,
              page: page.value,
              per_page: perPage.value,
            },
          },
        );
        addresses.value = response.data as Address[];
        error.value = "";
      } catch (e) {
        console.error(e);
        error.value = "検索に失敗しました。";
        addresses.value = [];
      }
    };

    const changePage = (newPage: number): void => {
      if (newPage > 0) {
        page.value = newPage;
        searchAddresses();
      }
    };

    watch(
      () => route.query.query,
      (newQuery) => {
        searchQuery.value = (newQuery as string) || "";
        searchAddresses(true);
      },
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
});
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

.error {
  color: red;
}
</style>
