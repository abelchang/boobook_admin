# AGENTS.md

BooBook Admin — Flutter 3.47.4 / Dart 3.13.3 管理後台（fvm default 即此版本，`flutter` 與 `fvm flutter` 等效）。詳細架構分析見 `docs/APP_ANALYSIS.md`（升級紀錄 §13.1–13.10）。

## 常用指令

- **啟動 App 一律用 `./run.sh <env> [cmd]`**（不要直接 `flutter run`）：
  - `env` = `dev` | `prod`（對應 `.env.dev` / `.env.prod`，不存在會報錯）
  - `cmd` = `web`（Chrome）| `abel`（真機 release）| `release` | 省略（一般跑）
  - 底層就是 `flutter run --dart-define-from-file=.env.<env>`
- **改過 freezed 模型 / riverpod provider 後一定要重跑 codegen**，`.g.dart` 與 `.freezed.dart` 是**會 commit 的**：
  - `dart run build_runner build --delete-conflicting-outputs`
  - `./gen.sh` 會多做 `flutter clean`（較慢）
- **`flutter analyze` 必須維持 "No issues found!"（0 issue）**——這是之前的明確目標，VS Code 的 issue 數也以此為準。
- 測試：`flutter test`（或單檔）。`test/api_verification_test.dart` 會打**真實後端**（網路不通會失敗），不是單元測試。
- 建置：
  - Android debug：`flutter build apk --debug --dart-define-from-file=.env.dev`
  - iOS 模擬器：`flutter build ios --simulator --dart-define-from-file=.env.dev`

## 環境（只有 dev / prod 兩個）

- 只有 `.env.dev` / `.env.prod`（`API_URL` 兩檔皆為 `https://boobook.company/api/v1`，差異只剩 `DEBUG` 旗標）。
- **不要再新增 `.env.local` / `.env.staging` / `.env.production`**——是刻意移除的。
- `.env.*` 是 tracked 檔案且無機密，可 commit。
- `lib/app/core/network_utils/api.dart` 用 `String.fromEnvironment` 讀 `API_URL` / `DEBUG`（預設即上述 URL）。

## 架構

- 功能模組放 `lib/app/features/<module>/{model,providers,repository,view,widget}`；跨模組共用放 `lib/app/core/`。
- 狀態管理：Riverpod 3 + codegen（`@riverpod` class / function，產生 `.g.dart`）。
- 模型：freezed 4 + json_serializable（`fromJson`/`toJson`）；全部是單一 constructor，無 union。
- 網路：`Network.instance`（Dio singleton）；本地儲存 Hive（`AppStorage`，`main()` 先 init）。
- 路由：go_router，`routerProvider`（手寫 `Provider`）。

## Riverpod 3 / Freezed 4 陷阱（容易踩）

- **`@freezed` class 必須寫 `abstract class X with _$X`**（freezed 3+ 要求；非 abstract 會報 missing implementations）。
- `AsyncValue.valueOrNull` 已改名 `value`（且 error/loading 時回傳 null，不再 throw）。
- Notifier 內 `state = …` 合法，但 **await 之後要先用 `if (!ref.mounted)` 防護再碰 state/ref**（v3 對已 dispose 的 ref 會直接 throw）。
- **`main.dart` 的 `ProviderScope(retry: (c, e) => null)` 是刻意加的，不要拿掉**——v3 預設對一般 Exception 指數退避重試 10 次，會讓未登入的 401 查詢連打 API。
- `riverpod_annotation 4.x` 已 re-export 所需元素，provider 檔不需要重複 import `flutter_riverpod`（會多 `unnecessary_import` lint）。
- provider 檔內的 `// ignore_for_file: avoid_manual_providers_...` 是舊 riverpod_lint 殘留，不產生 issue，保留即可。

## 平台注意

- **iOS 已轉 SPM，沒有 CocoaPods**（無 Podfile/Pods）。不要執行 `pod install` 或重加 Podfile；`ios/Flutter/ephemeral/` 是每次 build 產生的，不 commit。
- Android 是 **Kotlin DSL**（`build.gradle.kts`），不是 Groovy。
- `run.sh` 硬編碼 Abel 真機 UDID `00008130-001A6D5E3EF0001C`（裝置名「Abel Ti」）；換手機時用 `flutter devices` 更新。

## 測試注意

- `test/widget_test.dart`：smoke test，需要 Hive + path_provider mock（照抄現有 `setUpAll` 即可），期望未登入時落入 LoginView。
- 登入測試帳號（真實後端，`api_verification_test.dart` 用）：`0933787349/1234`、`0919506368/12345678`。