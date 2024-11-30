# ベースイメージとして軽量なNode.jsイメージを使用
FROM node:18-alpine

# 作業ディレクトリを作成
WORKDIR /app

# 依存関係のインストール
COPY package*.json ./
RUN npm install

# ソースコードをコピー
COPY . .

# 開発サーバーのデフォルトポートを公開
EXPOSE 8080

# ホットリロードをサポートする開発サーバーを起動
CMD ["npm", "run", "serve"]
