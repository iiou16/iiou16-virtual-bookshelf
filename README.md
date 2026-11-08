# 📚 Virtual Bookshelf Template

あなたの個人読書ライブラリを美しく展示するWebアプリケーションテンプレートです。

## 🎯 概要

このテンプレートは、iPadのKindleアプリや他の電子書籍リーダーで読書をしている方向けの、個人蔵書管理・展示システムです。読んだ本を見つけやすくし、5星評価システムで本を評価・管理できます。

### 主な機能

- 📖 **2つの表示モード**: 表紙表示・リスト表示
- 📱 **Kindle for Webで読む**: Kindleインポートした本は、表紙か「📖 読む」ボタンを押すと Kindle for Web（read.amazon.co.jp）が別タブで開く。Amazonの商品ページは詳細画面から開ける。手動追加・Google Play Booksの本は今までどおりストアのページを開く
- 📚 **複数本棚管理**: テーマ別本棚の作成・キュレーション
- ⭐ **5星評価システム**: 1-5星による本の評価管理・フィルタリング
- 🎯 **ハイライト表示**: bookIdベースでKindleのマーカー情報を自動読み込み
- 📝 **個人メモ**: 本ごとのレビューとおすすめ文

- 🔍 **検索・フィルター**: タイトル・著者・星評価での絞り込み
- 📊 **読書統計**: 総蔵書数の表示
- 🔗 **Amazon Associates**: アフィリエイトIDを設定すると、Amazonへのリンクにアフィリエイトタグを付ける
- 🌐 **公開・共有**: 本棚ごとの公開設定と静的ページ生成
- 💾 **データエクスポート**: 設定・星評価・メモの永続化
- 📥 **蔵書管理**: Kindleインポート、手動追加、Google Books追加、削除機能
- 🔄 **ハイライトファイル管理**: スクリプトベースでのハイライトインデックス生成
- 🔀 **並び替え機能**: ドラッグ&ドロップによる本の順序変更・保存
- 📗 **複数ストア対応**: Amazon/KindleとGoogle Play Booksの両方に対応

## 🚀 使い始めるには

### 1. このテンプレートを使用してリポジトリを作成

1. GitHub上でこのリポジトリの「Use this template」ボタンをクリック
2. 新しいリポジトリ名を入力（例: `my-bookshelf`）
3. 「Create repository from template」をクリック

### 2. リポジトリをGitHubに公開

1. 作成したリポジトリをPublic（公開）に設定
2. ファイルがすべてアップロードされていることを確認

### 3. GitHub Pagesを有効化

1. 作成したリポジトリで Settings > Pages を開く
2. Source を「Deploy from a branch」に設定
3. Branch を「main」に設定
4. Saveボタンをクリック
5. 数分待つとサイトが公開される（URLが表示されます）

### 4. あなたの本を追加する

#### 初回セットアップ（サンプルデータで確認）

蔵書データ（`data/library.json`）は個人データのためリポジトリに含めていません。初回は空の本棚で起動します。

1. ローカルサーバーを起動（後述）
2. ブラウザでアクセスし、空の本棚が表示されることを確認
3. 動作を試す場合は「📥 Kindleインポート」で `sample/sample_books.json` を読み込む（試したあとは「🗑️ 蔵書をクリア」で消せます）

#### 本格運用：あなたのデータに置き換え

**方法1: Kindleデータのインポート（推奨）**

1. [Kindle Bookshelf Exporter](https://chromewebstore.google.com/detail/kindle-bookshelf-exporter/olimpmeljimffgjonlpmiaebaonnegdp)をChromeにインストール
2. Kindle Cloud Readerで蔵書データをJSONファイルとしてエクスポート
3. ブラウザで「📥 Kindleインポート」ボタンをクリックしてインポート

**方法2: 手動で本を追加（Amazon/Kindle）**

1. 「➕ 手動追加」ボタンをクリック
2. 「Amazon/Kindle」タブを選択
3. ASIN、タイトル、著者を入力
4. 購入日と読書状況を設定

**方法3: Google Play Booksの本を追加**

1. 「➕ 手動追加」ボタンをクリック
2. 「Google Play Books」タブを選択
3. ボリュームIDを入力（Google BooksのURLの`?id=`以降の文字列、例: `-DFzEAAAQBAJ`）
4. 「自動取得」ボタンで書籍情報を取得、または手動でタイトル・著者を入力

**方法4: データファイルを直接編集**

1. `data/library.json` を編集（後述のデータフォーマット参照）

### 5. カスタマイズ

#### デフォルト設定 (data/config.json)

アプリケーションのデフォルト設定を`data/config.json`で指定できます。サイドバーの「⚙️ 設定エクスポート」ボタンで現在の設定をエクスポートすることもできます。

| 設定項目 | 説明 | 値 |
| --------- | ------ | ----- |
| `affiliateId` | Amazon AssociatesのアフィリエイトID | 文字列（例: `"your-id-22"`）。空文字`""`ならアフィリエイトタグを付けない（既定） |
| `defaultView` | デフォルトの表示モード | `"covers"`: 表紙表示、`"list"`: リスト表示 |
| `coverSize` | 表紙サイズ | `"small"`: 小、`"medium"`: 中、`"large"`: 大 |
| `booksPerPage` | 1ページあたりの表示数 | `25`, `50`, `100`, `200`, `"all"` |
| `enableSeriesGrouping` | シリーズグループ化 | `true`: 有効、`false`: 無効 |
| `showImagesInOverview` | 概要での画像表示 | `true`: 表示、`false`: 非表示 |
| `sortOrder` | 並び順 | `"custom"`: カスタム順、`"acquiredTime"`: 購入日、`"title"`: タイトル、`"authors"`: 著者 |
| `sortDirection` | 並び方向 | `"asc"`: 昇順、`"desc"`: 降順 |

**設定例:**

```json
{
  "affiliateId": "your-affiliate-id",
  "defaultView": "covers",
  "coverSize": "medium",
  "booksPerPage": 50,
  "enableSeriesGrouping": true,
  "showImagesInOverview": true,
  "sortOrder": "acquiredTime",
  "sortDirection": "desc"
}
```

#### 基本設定

- **アフィリエイトID**: `data/config.json`の`affiliateId`を変更（使わない場合は`""`のままにする。キーごと消すと、ブラウザに保存済みの以前のIDが使われ続ける）
- **本棚の作成**: デフォルトの本棚を編集、新しい本棚を追加
- **カラーテーマ**: CSS変数でカスタマイズ

#### ハイライト機能（オプション）

[Obsidian Kindle Plugin](https://github.com/hadynz/obsidian-kindle-plugin)の出力先を個人データの保存先（`.env`の`BOOKSHELF_DATA_DIR`）の`KindleHighlights`フォルダにすると、同期したハイライトがそのまま本棚に表示されます。

1. Obsidianで、`BOOKSHELF_DATA_DIR`のフォルダを保管庫（vault）として開く（例: WSLで`/mnt/c/Users/<ユーザー名>/My Drive/virtual-bookshelf`を指定しているなら、Windows側の`C:\Users\<ユーザー名>\My Drive\virtual-bookshelf`を開く）
2. Obsidian Kindle Pluginをインストールし、設定の「Highlights folder」に`KindleHighlights`を選ぶ（フォルダがなければ`./scripts/serve.sh`を一度起動すると作られます）
3. プラグインで、同期方法に「Amazon Cloud」を選んでKindleのハイライトを同期する。「Upload "My Clippings" file」で取り込んだハイライトにはASINが付かないため、本棚には表示されません
4. `./scripts/serve.sh`を起動し直す（起動のたびに`scripts/generate-highlights-index.sh`が実行され、ハイライトのインデックスが作り直されます）

- 本との対応付けにはハイライトファイル内のASIN（フロントマターの`asin:`、または本文の`ASIN: B0XXXXXXXX`の行）を使います。ASINが見つからないファイルは起動時に`⚠️ ASINが見つかりません`と表示され、本棚には表示されません
- `BOOKSHELF_DATA_DIR`を使わない場合は、プラグインの出力ファイルを`data/KindleHighlights/`に置いてください

## 📁 プロジェクト構造

```
virtual-bookshelf/
├── index.html              # メインページ
├── css/
│   └── bookshelf.css      # スタイルシート
├── js/
│   ├── bookshelf.js       # メイン機能
│   ├── book-manager.js    # 蔵書CRUD管理（Amazon/Google Books対応）
│   ├── highlights.js      # ハイライト表示
│   ├── series-manager.js  # 漫画シリーズ検出・グループ化
│   └── static-bookshelf-generator.js # 静的ページ生成
├── templates/
│   └── bookshelf-template.html # 静的ページテンプレート
├── static/                 # 静的ページファイル（手動配置・Git管理外）
│   └── bookshelf_*.html   # 生成された静的本棚ページ
├── data/
│   ├── library.json    # メイン蔵書データ（Git管理外）
│   ├── config.json     # ユーザー設定
│   ├── highlights-index.json # ハイライトファイルのASINマッピング（Git管理外・再生成可）
│   ├── KindleHighlights/  # ハイライトMarkdownファイル（元ファイル・Git管理外）
│   └── HighlightsASCII/   # ASCIIファイル名のハイライト（Web表示用・Git管理外・再生成可）
├── scripts/
│   ├── generate-highlights-index.sh # ハイライトインデックス生成スクリプト
│   ├── serve.sh           # .env の設定でローカルサーバーを起動
│   ├── link-data-dir.sh   # 個人データを外部フォルダに置くためのリンク作成スクリプト
│   └── _env.sh            # .env 読み込みの共通処理
├── sample/
│   └── sample_books.json  # サンプル蔵書データ（参考用）
├── .env.example           # ローカル設定の見本（コピーして .env を作る）
└── .gitignore             # Git除外設定
```

## 🛠️ ローカル開発

```bash
# 初回のみ: ローカル設定ファイルを作成して編集（.env は Git 管理外）
cp .env.example .env

# HTTPサーバーを起動（CORS制約回避のため）
./scripts/serve.sh
```

ブラウザで `http://localhost:8000` を開く（ポートは `.env` の `PORT` で変更可）

`scripts/serve.sh`は`.env`を読み、次のことを行います。

| `.env` の項目 | 既定値 | 内容 |
| --- | --- | --- |
| `BOOKSHELF_DATA_DIR` | なし | 個人データの保存先。設定すると起動前に`data/`のリンクをこの保存先に合わせる（後述「同期フォルダにバックアップする」） |
| `PORT` | `8000` | 待ち受けるポート |
| `BIND` | `127.0.0.1` | 待ち受けアドレス。`127.0.0.1`ならこのPCからのみ接続できる |

各項目は環境変数でも指定でき、環境変数が`.env`より優先されます（例: `PORT=9000 ./scripts/serve.sh`）。

`scripts/serve.sh`を使わずに起動する場合:

```bash
python -m http.server 8000 --bind 127.0.0.1
# または（データをシンボリックリンクで置く場合は --symlinks が必要）
npx serve . --symlinks
# または
php -S localhost:8000
```

起動のたびにハイライトのインデックス（`data/highlights-index.json`と`data/HighlightsASCII/`）も作り直します。`scripts/serve.sh`を使わずに起動する場合は、先に次を実行してください。

```bash
./scripts/generate-highlights-index.sh
```

## 💾 データフォーマット

### 蔵書データ (data/library.json)

「💾 データエクスポート」で書き出されるファイルの形式です。`books`のキーが書籍の識別子（bookId）で、Amazon/Kindleの場合はASIN、Google Booksの場合はボリュームIDです。

```json
{
  "exportDate": "2025-11-16T16:03:19.724Z",
  "books": {
    "B0XXXXXXXXX": {
      "title": "Kindle書籍タイトル",
      "authors": "著者名",
      "acquiredTime": 1756899555435,
      "readStatus": "READ",
      "productImage": "https://m.media-amazon.com/images/I/...",
      "source": "kindle_import",
      "addedDate": 1756899555435,
      "memo": "素晴らしい本でした！詳細は[こちら](https://example.com)をご覧ください",
      "rating": 5
    },
    "-DFzEAAAQBAJ": {
      "title": "Google Books書籍タイトル",
      "authors": "著者名",
      "acquiredTime": 1756899555435,
      "readStatus": "UNKNOWN",
      "productImage": "https://books.google.com/...",
      "source": "google_books",
      "addedDate": 1756899555435,
      "memo": "",
      "rating": 0
    }
  },
  "bookshelves": [
    {
      "id": "bookshelf_1756899555435",
      "name": "技術書",
      "emoji": "💻",
      "description": "プログラミング・技術関連の本",
      "isPublic": true,
      "books": ["B0XXXXXXXXX", "-DFzEAAAQBAJ"],
      "createdAt": "2025-11-16T16:03:19.724Z"
    }
  ],
  "settings": {
    "defaultView": "covers",
    "showHighlights": true,
    "currentBookshelf": "all",
    "theme": "light",
    "booksPerPage": 100,
    "showImagesInOverview": true,
    "enableSeriesGrouping": true,
    "coverSize": "medium",
    "sortOrder": "custom",
    "sortDirection": "desc"
  },
  "bookOrder": {
    "all": ["B0XXXXXXXXX", "-DFzEAAAQBAJ"],
    "bookshelf_1756899555435": ["B0XXXXXXXXX"]
  },
  "stats": {
    "totalBooks": 2,
    "notesCount": 1
  },
  "version": "2.0"
}
```

- `books`の各本
  - `readStatus`: `"READ"`（読了）または`"UNKNOWN"`（未読・不明）
  - `memo`: 個人メモ（Markdown可）。未入力なら`""`
  - `rating`: 星評価`1`〜`5`。未評価なら`0`
  - `updatedAsin`: 詳細画面の編集で「変更後商品コード」を入れた本だけに付く
- `bookshelves`の各本棚
  - `lastUpdated`: 本棚を編集したことがある場合だけ付く
  - `staticPageInfo`: 共有ページを生成したことがある場合だけ付く（`filename`、`lastGenerated`、`url`）
- `settings`: 画面で変更した表示設定。`affiliateId`は書き出されない（`data/config.json`で管理する）
- `stats`: 書き出した時点の冊数（`totalBooks`）とメモ・評価のある本の数（`notesCount`）

### sourceの値

| source | 説明 | bookIdの形式 | リンク先 |
| -------- | ------ | ------------- | ---------- |
| `kindle_import` | Kindleからインポート | ASIN（例: `B00XXXXX`） | Amazon |
| `manual_add` | 手動追加（Amazon） | ASIN | Amazon |
| `google_books` | Google Books追加 | ボリュームID（例: `-DFzEAAAQBAJ`） | Google Books |

## 🎨 使い方

### 基本操作

1. **表示切り替え**: ヘッダーのボタンで表紙・リスト表示を切り替え
2. **本棚選択**: ドロップダウンで表示する本棚を選択
3. **検索**: 検索ボックスでタイトル・著者を検索
4. **フィルター**: サイドバーで読書状況や星評価で絞り込み
5. **詳細表示**: 本をクリックして詳細モーダルを表示
6. **星評価**: モーダル内で1-5星の評価を設定・変更・リセット

### 本棚管理

1. **本棚の作成**: 新しいテーマの本棚を作成
2. **本の追加**: 詳細モーダルで本を複数の本棚に追加
3. **公開設定**: 本棚ごとに公開・非公開を設定
4. **並び替え**: ドラッグハンドル（⋮⋮）で本の順序を変更
5. **静的ページ生成**: 公開本棚のSNS共有用静的HTMLページ作成

### 静的ページ生成・SNS共有

1. **公開設定**: 本棚編集時に「📤 この本棚を公開する」をチェック
2. **静的ページ生成**: 本棚管理で「📤 共有ページ」ボタンをクリック
3. **HTMLファイルダウンロード**: `{本棚ID}.html`（例: `bookshelf_1756899555435.html`）が自動ダウンロード
4. **ファイル配置**: ダウンロードしたファイルを`static/`フォルダに配置
5. **SNS共有**: Twitter/Facebook/LINEで直接共有、またはURLコピー
6. **アクセス方法**:
   - 本棚セレクターで公開本棚選択→「🌐 静的ページ」ボタン
   - 本棚一覧カードの「🌐 静的ページ」ボタン

#### 静的ページファイルの配置方法

```bash
# 1. ダウンロードされたHTMLファイルを確認
ls ~/Downloads/bookshelf_*.html

# 2. staticフォルダを作成（まだない場合）
mkdir -p static

# 3. HTMLファイルを配置
cp ~/Downloads/bookshelf_*.html static/

# 4. Gitにコミット・プッシュ
#    static/ は既定で .gitignore に入っているため、公開する場合は .gitignore から static/ の行を外す
git add static/
git commit -m "Add static bookshelf pages"
git push origin main
```

**注意**: GitHubページにファイルをプッシュ後、URLが有効になります（例: `https://yourusername.github.io/your-repo/static/bookshelf_1756899555435.html`）

生成時に表示される公開URLは、いま本棚を開いているURLをもとに作られます。ローカルで生成した場合は`http://localhost:8000/static/...`になるため、共有するときは`http://localhost:8000/`の部分をGitHub PagesのURLに置き換えてください。

### 星評価システム

1. **評価設定**: 詳細モーダルで本に1-5星の評価を設定
2. **評価リセット**: 「評価をリセット」ボタンで未評価に戻す
3. **フィルタリング**: チェックボックスで特定の星評価の本のみ表示
4. **複数選択**: 星2,3,4や星4,5など複数の評価を組み合わせ表示

### データの永続化とバックアップ

ブラウザで付けた評価・メモ・本棚は、まずブラウザのローカルストレージに保存されます。ファイルとして残すには次の手順を行います。

1. 「💾 データエクスポート」でlibrary.jsonをダウンロード
2. ダウンロードしたファイルを`data/library.json`として保存

ローカルストレージが空のとき（別のブラウザ、データ消去後など）は`data/library.json`から読み込まれるため、このファイルがバックアップ兼復元元になります。

#### 個人データはGitで管理しない

購入した本の一覧は個人データのため、`data/library.json`・`data/KindleHighlights/`などは既定で`.gitignore`に入っています。公開リポジトリにpushしても蔵書データは含まれません。

#### 同期フォルダ（Google Drive / Dropbox / OneDrive など）にバックアップする

個人データの実体を任意のフォルダに置き、`data/`からシンボリックリンクで参照できます。同期フォルダを指定すれば、保存した時点でバックアップされます。保存先は`.env`に書くため、リポジトリには含まれません。

1. `.env`の`BOOKSHELF_DATA_DIR`に保存先を書く（空白を含むパスもそのまま書けます）

   ```bash
   # 例: WSL から Windows の Google Drive フォルダを指定
   BOOKSHELF_DATA_DIR=/mnt/c/Users/<ユーザー名>/My Drive/virtual-bookshelf
   ```

2. `./scripts/serve.sh`で起動する（起動のたびに`data/`のリンクが`.env`の保存先に合わせられます）

保存先を変えるときは、`.env`を書き換えて`./scripts/serve.sh`を起動し直します（元の保存先のファイルは移動されないため、必要なら手動でコピーしてください）。

リンクだけを作り直したい場合は`./scripts/link-data-dir.sh`を実行します。保存先は「引数 → 環境変数`BOOKSHELF_DATA_DIR` → `.env`」の順で決まります。

- 対象は`data/library.json`と`data/KindleHighlights/`です（`HighlightsASCII/`と`highlights-index.json`は`generate-highlights-index.sh`で再生成できるため対象外）
- `data/`に実ファイルがあり、指定先に同名のものがなければ指定先へ移動します。両方にある場合は上書きせずに中断します
- 以後は「💾 データエクスポート」したファイルを、指定したフォルダの`library.json`に上書き保存します

## 📱 対応環境

- **ブラウザ**: Chrome, Firefox, Safari, Edge (最新版)
- **デバイス**: デスクトップ、タブレット、スマートフォン
- **要件**: JavaScript有効、LocalStorage利用可能

## 🔒 プライバシー

- 個人データはブラウザのローカルストレージに保存
- 蔵書データ（`data/library.json`など）は既定でGit管理外（公開リポジトリにも含まれない）
- 公開設定しない限り個人メモは非公開
- サーバーサイド処理なし（完全クライアントサイド）

## 🤝 カスタマイズのヒント

### スタイルのカスタマイズ

- `css/bookshelf.css`でカラーテーマや表示サイズを調整
- CSS変数`--book-width`, `--book-height`で本のサイズ調整

### 機能の追加

- 新機能は適切なクラス（VirtualBookshelf/BookManager等）に追加
- スタイリングは`css/bookshelf.css`に追加

### Amazon Associatesの設定

- `data/config.json`の`affiliateId`を変更
- アフィリエイトプログラムの利用規約を確認

## 📄 ライセンス

MIT License

---

## 💡 参考リソース

### 必須ツール

- [Kindle Bookshelf Exporter](https://chromewebstore.google.com/detail/kindle-bookshelf-exporter/olimpmeljimffgjonlpmiaebaonnegdp) - Kindleデータエクスポート用Chrome拡張機能
- [Obsidian Kindle Plugin](https://github.com/hadynz/obsidian-kindle-plugin) - Kindleハイライト抽出用Obsidianプラグイン

### 関連リソース

- [元のVirtual Bookshelf](https://github.com/karaage0703/virtual-bookshelf)
- [GitHub Pages Documentation](https://pages.github.com/)
- [Amazon Associates Program](https://affiliate.amazon.com/)

🎉 **Happy Reading!** あなただけの素敵な本棚を作成してください！
