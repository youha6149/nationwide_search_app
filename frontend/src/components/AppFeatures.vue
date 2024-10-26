<template>
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
</template>

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
