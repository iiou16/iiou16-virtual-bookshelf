#!/bin/bash
# 個人データ（蔵書・ハイライト）をリポジトリ外のフォルダに置き、data/ からシンボリックリンクで参照する。
# Google Drive / Dropbox / OneDrive などの同期フォルダを指定すれば、そのままバックアップになる。
#
# 使い方:
#   scripts/link-data-dir.sh <データフォルダ>
#   BOOKSHELF_DATA_DIR=<データフォルダ> scripts/link-data-dir.sh
#
# 対象:
#   data/library.json       蔵書・評価・メモ（データエクスポートしたファイル）
#   data/KindleHighlights/  ハイライトの Markdown（元データ）
# HighlightsASCII/ と highlights-index.json は generate-highlights-index.sh で再生成できるため対象外。

set -euo pipefail

DATA_DIR="${1:-${BOOKSHELF_DATA_DIR:-}}"
if [ -z "$DATA_DIR" ]; then
    echo "使い方: $0 <データフォルダ>   (または BOOKSHELF_DATA_DIR を設定)" >&2
    exit 1
fi

cd "$(dirname "$0")/.."
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

echo "🎉 完了。ハイライトを使う場合は scripts/generate-highlights-index.sh を実行してください。"
