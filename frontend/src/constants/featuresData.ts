export interface FeatureCard {
  title: string;
  image: string;
  alt: string;
  description: string;
}

import IconCPU from "@/assets/icon_cpu.svg";
import IconKey from "@/assets/icon_key.svg";
import IconPuzzle from "@/assets/icon_puzzle.svg";
import IconTag from "@/assets/icon_tag.svg";

export const features: FeatureCard[] = [
  {
    title: "パフォーマンス",
    image: IconCPU,
    alt: "CPU",
    description:
      "ElasticSearchによる超高速な検索機能、Railsの強力なAPI、Vueの軽量で直感的なUI、そしてMySQLの堅牢なデータ処理を組み合わせ、膨大なデータでも迅速かつ確実に処理。",
  },
  {
    title: "セキュリティ",
    image: IconKey,
    alt: "Key",
    description:
      "Railsの強固なセキュリティ機能を標準装備し、CSRFやSQLインジェクションにも対応。安心してお使いいただける堅牢なセキュリティ体制を提供します。",
  },
  {
    title: "拡張性",
    image: IconPuzzle,
    alt: "Puzzle",
    description:
      "バックエンドにRails、フロントエンドにVueを採用し、Elasticsearchのスケーラビリティを活かすことで、システムの成長に合わせた柔軟な拡張性を確保。",
  },
  {
    title: "保守性",
    image: IconTag,
    alt: "Tag",
    description:
      "TDDやRSpec、TypeScript、Dockerを導入し、高品質なコードを維持しつつ、開発環境の再現性を高め、保守性に優れたシステムを提供。",
  },
];
