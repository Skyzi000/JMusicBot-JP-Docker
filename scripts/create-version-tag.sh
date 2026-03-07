#!/usr/bin/env bash

set -euo pipefail

branch="$(git branch --show-current)"
if [[ "$branch" != "main" ]]; then
  echo "このスクリプトは main ブランチで実行してください。現在のブランチ: $branch" >&2
  exit 1
fi

if [[ -n "$(git status --short)" ]]; then
  echo "未コミット変更があります。コミットまたは退避してから再実行してください。" >&2
  git status --short >&2
  exit 1
fi

version="$(grep '^ARG JMUSICBOT_VERSION=' Dockerfile | head -n 1 | cut -d'=' -f2)"
if [[ -z "$version" ]]; then
  echo "Dockerfile から JMUSICBOT_VERSION を取得できませんでした。" >&2
  exit 1
fi

tag="v$version"

if git rev-parse -q --verify "refs/tags/$tag" >/dev/null 2>&1; then
  echo "ローカルタグ $tag は既に存在します。" >&2
  exit 1
fi

if git ls-remote --exit-code --tags origin "refs/tags/$tag" >/dev/null 2>&1; then
  echo "リモートタグ $tag は既に存在します。" >&2
  exit 1
fi

git fetch origin main --quiet

head_commit="$(git rev-parse HEAD)"
origin_main_commit="$(git rev-parse origin/main)"
if [[ "$head_commit" != "$origin_main_commit" ]]; then
  echo "HEAD が origin/main と一致していません。main を push した後で再実行してください。" >&2
  echo "HEAD: $(git rev-parse --short "$head_commit")" >&2
  echo "origin/main: $(git rev-parse --short "$origin_main_commit")" >&2
  exit 1
fi

echo "現在のブランチ: $branch"
echo "作成するタグ: $tag"
echo "対象コミット: $(git rev-parse --short HEAD)"

read -r -p "HEAD にタグ $tag を作成して origin に push しますか? [y/N] " confirm
case "$confirm" in
  y|Y|yes|YES)
    ;;
  *)
    echo "キャンセルしました。"
    exit 0
    ;;
esac

git tag -a "$tag" -m "https://github.com/Cosgy-Dev/JMusicBot-JP/releases/tag/$version"
git push origin "$tag"

echo "タグ $tag を作成して push しました。"
