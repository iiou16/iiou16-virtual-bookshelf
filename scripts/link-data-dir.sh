#!/bin/bash
# 個人データ（蔵書・ハイライト）をリポジトリ外のフォルダに置き、data/ からシンボリックリンクで参照する。
# Google Drive / Dropbox / OneDrive などの同期フォルダを指定すれば、そのままバックアップになる。
#
# 使い方:
#   scripts/link-data-dir.sh                      # .env の BOOKSHELF_DATA_DIR を使う
#   scripts/link-data-dir.sh <データフォルダ>
#   BOOKSHELF_DATA_DIR=<データフォルダ> scripts/link-data-dir.sh
# 保存先の優先順位: 引数 → 環境変数 BOOKSHELF_DATA_DIR → .env の BOOKSHELF_DATA_DIR
#
# 対象:
#   data/library.json       蔵書・評価・メモ（データエクスポートしたファイル）
#   data/KindleHighlights/  ハイライトの Markdown（元データ）
# HighlightsASCII/ と highlights-index.json は generate-highlights-index.sh で再生成できるため対象外。

set -euo pipefail

cd "$(dirname "$0")/.."
source scripts/_env.sh
load_env .env

DATA_DIR="${1:-${BOOKSHELF_DATA_DIR:-}}"
if [ -z "$DATA_DIR" ]; then
    echo "保存先が指定されていません。.env に BOOKSHELF_DATA_DIR を書くか、引数でフォルダを指定してください。" >&2
    echo "  例: cp .env.example .env  を実行して BOOKSHELF_DATA_DIR を編集" >&2
    exit 1
fi

mkdir -p "$DATA_DIR"
DATA_DIR="$(cd "$DATA_DIR" && pwd)"

TARGETS=("library.json" "KindleHighlights")

for name in "${TARGETS[@]}"; do
    local_path="data/$name"
    remote_path="$DATA_DIR/$name"

    # すでに同じ場所へのリンクなら何もしない
    if [ -L "$local_path" ]; then
        if [ "$(readlink "$local_path")" = "$remote_path" ]; then
            echo "✅ $local_path → $remote_path (設定済み)"
            continue
        fi
        echo "🔁 $local_path のリンク先を変更: $(readlink "$local_path") → $remote_path"
        rm "$local_path"
    elif [ -e "$local_path" ]; then
        # ローカルに実ファイルがある場合: リンク先が空なら移動、両方あれば上書きせず中断
        if [ -e "$remote_path" ]; then
            echo "⚠️ $local_path と $remote_path の両方が存在します。どちらかを手動で整理してから再実行してください。" >&2
            exit 1
        fi
        mv "$local_path" "$remote_path"
        echo "📦 $local_path を $remote_path に移動しました"
    fi

    # ディレクトリ型の対象は、リンク先がなければ空で作る（リンク切れを防ぐ）
    if [ "$name" = "KindleHighlights" ] && [ ! -e "$remote_path" ]; then
        mkdir -p "$remote_path"
        echo "📁 $remote_path を作成しました"
    fi

    ln -s "$remote_path" "$local_path"
    echo "🔗 $local_path → $remote_path"
done

echo "🎉 リンクの作成が完了しました（serve.sh を使わずに起動する場合は、先に scripts/generate-highlights-index.sh を実行してください）。"
