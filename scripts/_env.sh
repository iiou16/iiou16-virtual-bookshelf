#!/bin/bash
# .env を読み込む共通処理（他のスクリプトから source して使う）。
# - .env はシェルとして実行せず、KEY=VALUE の行だけを取り出す
# - すでに環境変数で設定されている値は上書きしない（環境変数が .env より優先）
# - 値を囲む引用符（" または '）は外し、先頭の ~ はホームディレクトリに展開する

load_env() {
    local env_file="$1"
    [ -f "$env_file" ] || return 0

    local line key value
    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%$'\r'}"
        # 空行とコメント行は読み飛ばす
        [[ "$line" =~ ^[[:space:]]*(#|$) ]] && continue
        if [[ "$line" =~ ^[[:space:]]*(export[[:space:]]+)?([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
            key="${BASH_REMATCH[2]}"
            value="${BASH_REMATCH[3]}"
            # 前後の空白を除く
            value="${value#"${value%%[![:space:]]*}"}"
            value="${value%"${value##*[![:space:]]}"}"
            # 囲みの引用符を外す
            if [[ "$value" =~ ^\"(.*)\"$ ]] || [[ "$value" =~ ^\'(.*)\'$ ]]; then
                value="${BASH_REMATCH[1]}"
            fi
            # 先頭の ~ をホームディレクトリに展開
            if [[ "$value" == "~" || "$value" == "~/"* ]]; then
                value="$HOME${value:1}"
            fi
            # 環境変数で設定済みなら上書きしない
            if [ -z "${!key+x}" ]; then
                export "$key=$value"
            fi
        else
            echo "⚠️ $env_file の次の行は KEY=VALUE の形式ではないため無視します: $line" >&2
        fi
    done < "$env_file"
}
