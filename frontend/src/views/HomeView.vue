<template>
  <div class="home">
    <AddressSearch />

    <div class="features">
      <div class="card">
        <img src="@/assets/icon_cpu.svg" alt="CPU" />
        <h3>パフォーマンス</h3>
        <p>
          ElasticSearchによる超高速な検索機能、Railsの強力なAPI、Vueの軽量で直感的なUI、そしてMySQLの堅牢なデータ処理を組み合わせ、膨大なデータでも迅速かつ確実に処理。
        </p>
      </div>

      <div class="card">
        <img src="@/assets/icon_key.svg" alt="Key" />
        <h3>セキュリティ</h3>
        <p>
          Railsの強固なセキュリティ機能を標準装備し、CSRFやSQLインジェクションにも対応。安心してお使いいただける堅牢なセキュリティ体制を提供します。
        </p>
      </div>

      <div class="card">
        <img src="@/assets/icon_puzzle.svg" alt="Puzzle" />
        <h3>拡張性</h3>
        <p>
          バックエンドにRails、フロントエンドにVueを採用し、Elasticsearchのスケーラビリティを活かすことで、システムの成長に合わせた柔軟な拡張性を確保。
        </p>
      </div>

      <div class="card">
        <img src="@/assets/icon_tag.svg" alt="Tag" />
        <h3>保守性</h3>
        <p>
          TDDやRSpec、TypeScript、Dockerを導入し、高品質なコードを維持しつつ、開発環境の再現性を高め、保守性に優れたシステムを提供。
        </p>
      </div>
    </div>
    <div class="pdf-viewer">
      <div class="iframe-container">
        <iframe
          src="https://docs.google.com/presentation/d/e/2PACX-1vSaWxsLKSEcHv-eb4UgT_QUDcfvmg5SPD3Pp4uituLe9EYO2WXrg6JIum1HkYonIFV1mgGjKF4TLXVT/embed?start=false&loop=false&delayms=3000"
          frameborder="0"
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

export default defineComponent({
  name: "HomeView",
  components: {
    AddressSearch,
  },
});
</script>

<style scoped>
.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin: 30px;
  place-content: center;
  place-items: center;
}

.card {
  flex-direction: column;
  align-items: center;
  border-radius: 8px;
  padding: 10px;
  max-width: 300px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  height: 100%;
}

.card img {
  width: 100%;
  max-width: 60px;
  height: auto;
}

.card h3 {
  text-align: center;
  font-size: 18px;
}

.card p {
  margin-top: 10px;
  font-size: 14px;
  text-align: center;
}

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
