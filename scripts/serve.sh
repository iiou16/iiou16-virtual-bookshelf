#!/bin/bash
# .env の設定でローカルサーバーを起動する。
# - BOOKSHELF_DATA_DIR があれば、起動前に data/ のリンクをその保存先に合わせる
# - 起動前にハイライトのインデックスを作り直す（KindleHighlights/ に足したファイルが再起動だけで反映される）
# - PORT（既定 8000）と BIND（既定 127.0.0.1）で待ち受ける
# 各値は環境変数で指定すれば .env より優先される（例: PORT=9000 scripts/serve.sh）

set -euo pipefail

cd "$(dirname "$0")/.."
source scripts/_env.sh
load_env .env

PORT="${PORT:-8000}"
BIND="${BIND:-127.0.0.1}"

if [ -n "${BOOKSHELF_DATA_DIR:-}" ]; then
    scripts/link-data-dir.sh "$BOOKSHELF_DATA_DIR"
else
    echo "ℹ️ BOOKSHELF_DATA_DIR が未設定のため、data/ 内のファイルをそのまま使います"
fi

# data/KindleHighlights のリンクが保存先に向いてから読む必要があるため、リンク作成のあとに実行する
scripts/generate-highlights-index.sh

if command -v python3 >/dev/null 2>&1; then
    PYTHON=python3
else
    PYTHON=python
fi

echo "🌐 http://localhost:$PORT で起動します（待ち受け: $BIND）。停止は Ctrl+C"
exec "$PYTHON" -m http.server "$PORT" --bind "$BIND"
