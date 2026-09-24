#!/bin/bash

# ============================================================
# boobook_admin run.sh
# 參考 helpnbuy_app/run.sh 改寫（已移除 flavor 相關參數）
#
# 用法: ./run.sh <env> [cmd]
#   env : dev | prod   (對應 .env.dev / .env.prod)
#   cmd : web      → 在 Chrome 執行（支援熱重載）
#         abel     → 安裝並執行到 Abel 的 iPhone（release）
#         release  → release 模式執行
#         (省略)   → 一般模式執行
#
#   example:
#     ./run.sh dev               # 用 .env.dev 一般執行
#     ./run.sh dev web           # 用 .env.dev 開 Chrome
#     ./run.sh prod abel         # 用 .env.prod 裝到 Abel 手機
# ============================================================

# --- 參數檢查 ---
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <env> [cmd]"
  echo "  env: dev | prod"
  echo "  cmd: web | abel | release  (省略 = 一般執行)"
  exit 1
fi

env=$1
cmd=$2

# --- 檢查 .env 檔是否存在（避免打錯 env 名稱） ---
if [ ! -f ".env.$env" ]; then
  echo "錯誤：找不到 .env.$env 檔（可用 env: dev / prod）"
  exit 1
fi

# --- 共用參數（boobook 無 flavor，直接帶 dart-define-from-file 即可） ---
params="--dart-define-from-file=.env.$env"

# --- 設置目標設備參數（專為 Abel 使用） ---
# 實體 iPhone「Abel Ti」；若換手機，請執行 `flutter devices` 查 UDID 更新後方
abel_device="-d 00008130-001A6D5E3EF0001C"

# --- 檢查命令並執行對應操作 ---
if [ "$cmd" = "web" ]; then
  # Web 執行方式
  echo "flutter run $params -d chrome"
  flutter run $params -d chrome
elif [ "$cmd" = "abel" ]; then
  # 安裝到 Abel 的手機（release）
  echo "flutter run $params $abel_device --release"
  flutter run $params $abel_device --release
elif [ "$cmd" = "release" ]; then
  # 發佈模式
  echo "flutter run $params --release"
  flutter run $params --release
elif [ -n "$cmd" ]; then
  # 未知命令：提示但不中斷，改以一般模式執行
  echo "警告：未知的 cmd \"$cmd\"，改以一般模式執行"
  echo "flutter run $params"
  flutter run $params
else
  # 預設模式
  echo "flutter run $params"
  flutter run $params
fi

# ============================================================
# 常用建置參考（手動使用）
#
# Android debug APK
#   flutter build apk --debug --dart-define-from-file=.env.dev
#
# iOS 模擬器（無需真機簽名）
#   flutter build ios --simulator --dart-define-from-file=.env.dev
#   flutter run -d "iPhone 18 Pro" --dart-define-from-file=.env.dev
#
# 檢查目前可用裝置 / 真機 UDID
#   flutter devices
# ============================================================