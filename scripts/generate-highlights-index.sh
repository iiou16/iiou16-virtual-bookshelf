#!/bin/bash

# ハイライトインデックス生成スクリプト
# 途中で失敗したら止める。serve.sh から呼ばれたとき、インデックスと
# HighlightsASCII の中身が食い違ったままサーバーが起動しないようにするため。
set -euo pipefail

echo "🔄 ハイライトインデックス生成開始..."

cd "$(dirname "$0")/.."
OUTPUT_FILE="data/highlights-index.json"
ASCII_DIR="data/HighlightsASCII"

# ASCII用ディレクトリを作り直し
echo "🗂️ ASCII用ディレクトリを準備中..."
if [ -d "$ASCII_DIR" ]; then
    rm -rf "$ASCII_DIR"
fi
mkdir -p "$ASCII_DIR"

echo "{" > "$OUTPUT_FILE"
first=true

for file in data/KindleHighlights/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        # YAMLフロントマターからASINを抽出
        # Windows で書かれたファイルは改行が CRLF のため、\r も取り除く（残ると JSON が壊れる）
        asin=$(head -20 "$file" | sed -n 's/^asin: *//p' | tr -d " \"'\r")

        # ASINが見つからない場合はメタデータから抽出を試行
        # grep は一致しないと 1、読み取りエラーなどでは 2 を返す。一致しないのは ASIN が無いだけなので 1 だけを許す
        # grep | head -1 だと pipefail の下で grep が SIGPIPE で失敗することがあるため、grep -m1 で 1 件に絞る
        if [ -z "$asin" ]; then
            asin=$({ grep -m1 -E "ASIN: *[A-Z0-9]{10}" "$file" || [ $? -eq 1 ]; } | sed 's/.*ASIN: *//' | tr -d " \r")
        fi

        # ASIN はファイル名と JSON のキーにそのまま使うため、英大文字と数字の 10 桁以外は使わない
        if [ -n "$asin" ] && ! [[ "$asin" =~ ^[A-Z0-9]{10}$ ]]; then
            echo "⚠️ ASINの形式が正しくないため飛ばします（$asin）: $filename"
            continue
        fi

        if [ -n "$asin" ]; then
            # ASCIIファイル名を作成
            ascii_filename="${asin}.txt"
            
            # ASCIIディレクトリにファイルをコピー
            cp "$file" "$ASCII_DIR/$ascii_filename"
            
            # インデックスに追加
            if [ "$first" = false ]; then
                echo "," >> "$OUTPUT_FILE"
            fi
            echo -n "  \"$asin\": \"$ascii_filename\"" >> "$OUTPUT_FILE"
            first=false
            echo "✅ $asin → $ascii_filename (コピー完了)"
        else
            echo "⚠️ ASINが見つかりません: $filename"
        fi
    fi
done

echo "" >> "$OUTPUT_FILE"
echo "}" >> "$OUTPUT_FILE"

echo "🎉 完了: $OUTPUT_FILE を生成しました"
echo "📁 ASCII用ハイライトファイルを $ASCII_DIR に作成しました"