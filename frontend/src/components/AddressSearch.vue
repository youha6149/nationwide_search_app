<template>
  <div class="search-view-container">
    <div class="search-section">
      <h1>Find the best location for your project</h1>
      <div class="search-bar">
        <input
          v-model="searchQuery"
          type="text"
          placeholder="地名を入力してください"
          class="search-input"
        />
        <button @click="goToResults" class="search-button">検索</button>
      </div>
    </div>
    <div class="image-section">
      <img src="@/assets/search_results.png" alt="Description" />
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";

export default {
  setup() {
    const searchQuery = ref("");
    const router = useRouter();

    const goToResults = () => {
      if (searchQuery.value.trim()) {
        router.push({ name: "Results", query: { query: searchQuery.value } });
      } else {
        alert("検索クエリを入力してください");
      }
    };

    return {
      searchQuery,
      goToResults,
    };
  },
};
</script>

<style scoped>
.search-view-container {
  width: 100%;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  background-image: linear-gradient(
    90deg,
    rgba(196, 182, 197, 1),
    rgba(35, 117, 163, 1)
  );
  border-top: 1px solid #ddd;
  padding: 20px;
}

.search-section {
  flex: 1;
  margin-right: 50px;
}

.search-bar {
  display: flex;
  margin-top: 20px;
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

.image-section {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
}

.image-section img {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
}

@media (max-width: 768px) {
  .search-view-container {
    flex-direction: column;
    align-items: center;
  }

  .search-section {
    margin-right: 0;
    margin-bottom: 20px;
    width: 100%;
  }

  .image-section {
    width: 100%;
  }

  .image-section img {
    max-width: 90%;
  }
}
</style>
