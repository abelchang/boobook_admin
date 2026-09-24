# BooBook Admin — Flutter App 架構與功能分析文件

> 產出日期：2026-09-24
>
> 用途：作為後續開發、維護、接手此專案時的參考文件。
> 內容涵蓋：專案總覽、技術棧、架構設計、目錄結構、各功能模組說明、資料庫設計、環境設定、程式碼生成流程、測試方式與目前狀態。

---

## 1. 專案總覽

| 項目 | 內容 |
| --- | --- |
| 專案名稱 | `boobook_admin`（應用標題：**BooBook Admin**） |
| 類型 | Flutter 跨平台 App（android / ios / web / windows / macos / linux 平台目錄皆已建立） |
| 定位 | **民宿（BnB）訂房管理系統的後台管理端** |
| 對應後端 | 遠端 REST API，預設網域 `https://boobook.company/api/v1`（可依環境切換） |
| 資料庫 | MySQL（`database_schema.sql` 提供完整 schema，非 SQLite） |
| 主要語言 | Dart（`sdk: '>=3.2.3 <4.0.0'`） |
| 狀態 | **開發中／骨架已完成、部分功能實作中**（多處仍留有 `TODO`） |

### 目前可用的主要功能（已實作）

1. **登入**：手機號碼＋密碼登入（`flutter_login` 套件），登入後將 Token 存到本地 Hive。
2. **主畫面**：自適應 NavigationBar（`flutter_adaptive_scaffold`），包含三個分頁：
   - **例假日**（Holiday 管理）— 最完整的功能
   - **BnB**（民宿列表 → 訂單營收統計）
   - **Test**（Activity，連接 Bored API 的練習頁）
3. **例假日管理**：
   - 依年份列出假日、新增／編輯／刪除假日
   - 標示「假日」與「時間電價假日（tep）」兩種屬性
   - 可從 **新北市開放資料 API** 匯入政府例假日資料並批次寫入後端
4. **民宿列表**：顯示民宿名稱與訂單數，點擊進入該民宿的訂單統計頁。
5. **訂單營收統計**：以民宿為單位，顯示「今年（按月）」與「歷年（按年）」的營收加總（NT$）。

---

## 2. 技術棧（Tech Stack）

### 主要依賴（`pubspec.yaml` dependencies）

| 套件 | 版本 | 用途 |
| --- | --- | --- |
| `flutter_riverpod` | ^2.4.9 | 狀態管理（Riverpod 2.x） |
| `riverpod_annotation` | ^2.3.3 | riverpod_generator 的註解來源 |
| `go_router` | ^5.0.5 | 路由管理（`MaterialApp.router`） |
| `dio` | ^5.4.0 | HTTP client（網路層核心） |
| `hive_flutter` | ^1.1.0 | 本地 Key-Value 儲存（存 token 等） |
| `flutter_login` | ^5.0.0 | 登入畫面 UI（含動畫、密碼找回） |
| `flutter_easyloading` | ^3.0.5 | 全域 loading / toast 提示 |
| `flutter_adaptive_scaffold` | ^0.1.7+2 | 自適應導覽列／版面 |
| `freezed_annotation` | ^2.4.1 | 不可變 model 產生 |
| `json_annotation` | ^4.8.1 | JSON 序列化 |
| `intl` | ^0.20.2 | i18n 與日期／金額格式化 |
| `flutter_localizations` | SDK | 內建多語系支援 |
| `logger` | ^2.0.1 | 除錯日誌 |

### 開發依賴（dev dependencies）

| 套件 | 用途 |
| --- | --- |
| `build_runner` | 執行 code generation |
| `freezed` | 產生 model 的 freezed 檔 |
| `json_serializable` | 產生 JSON 序列化檔 |
| `riverpod_generator` | 由 `@riverpod` 產生 providers |
| `riverpod_lint` + `custom_lint` | Riverpod 靜態檢查 |
| `flutter_launcher_icons` | 產生各平台 App 圖示 |
| `flutter_lints` | 官方 lint 規則 |

### 本地化設定

- `flutter_intl`：main_locale 為 `zh_TW`，`generate: true`。
- 語系檔位於 `lib/l10n/`：
  - `intl_zh_TW.arb`（主語系）
  - `intl_en.arb`
- 產生的程式碼在 `lib/generated/l10n.dart` 與 `lib/generated/intl/`。
- 目前僅 3 個翻譯鍵：`network_error_no`、`network_error2`、`auth_out_date`（皆為網路／認證錯誤訊息）。

---

## 3. 整體架構（Architecture）

### 3.1 分層設計

採用 **Feature-first（功能優先）** 目錄結構，每個功能模組內部再分層：

```
View（畫面 / UI）
   │  watch providers
   ▼
Providers（Riverpod 狀態層，AsyncNotifier / FutureProvider）
   │  read repository
   ▼
Repository（抽象介面 + 實作）
   │  呼叫 Network
   ▼
Network（Dio 封裝，HTTP 層）
   │
   ▼
後端 API
```

- **Model**：以 `freezed` + `json_serializable` 定義不可變資料模型，附 `fromJson / toJson`。
- **Repository 模式**：每個功能有一個 `abstract class Repository`，並提供：
  - `xxx_repository_impl.dart` — 真正的 API 實作（另註冊 `xxxRepositoryProvider`）
  - `xxx_repository_fake.dart` — 假資料（目前多為註解掉的空殼）
- **Providers**：`@riverpod` 註解 + `riverpod_generator` 自動產生 provider（`.g.dart`），避免手寫 boilerplate。state 層的 AsyncNotifier 內含 UI 操作邏輯（如 `store`、`destroy`、`login`）。
- **View / Widget 分離**：`view/` 放畫面（頁面級），`widget/` 放可重用元件。

### 3.2 依賴注入

- 沒有額外 DI 框架，統一用 **Riverpod Provider 作為 DI 容器**（如 `userRepositoryProvider`、`holidayRepositoryProvider`）。
- 全域單例：`Network.instance`（Dio 網路層）、`AppStorage()`（Hive 儲存層）。

### 3.3 狀態管理流程（以 Holiday 為例）

1. `HolidayView` `watch` `holidaysProvider`（AsyncNotifier）。
2. `Holidays.build()` 讀 `yearProvider`（目前年份）→ 經 `holidayRepositoryProvider` → `getHolidays(year)`。
3. UI 操作（新增／刪除）直接呼叫 `holidaysProvider.notifier` 的方法（`store` / `desroy`），成功後**直接更新本地 state**，不需重新向後端拉取。
4. 切換年份會透過 `yearProvider` 改 state → `build()` 自動重新執行。

---

## 4. 目錄結構

```
lib/
├── main.dart                          # App 進入點：初始化 Hive → runApp(ProviderScope)
├── app/
│   ├── app.dart                       # App root widget（MaterialApp.router + EasyLoading）
│   ├── core/                          # 跨功能共用
│   │   ├── constants.dart/
│   │   │   └── app_config.dart        # AppConfig / ApiConstants / Constants / ResCode
│   │   ├── local_storage/
│   │   │   └── app_storage.dart       # Hive 封裝（token 存取、清除）
│   │   ├── network_utils/
│   │   │   └── api.dart               # Network 單例（Dio 封裝、錯誤/認證處理）
│   │   ├── router/
│   │   │   └── router.dart            # go_router 設定（目前只有 /main）
│   │   ├── theme/
│   │   │   └── app_theme.dart         # light/dark theme（目前為空）
│   │   ├── utils/
│   │   │   └── date_utils.dart        # DateTime 擴充（格式化、星期幾、TimeOfDay）
│   │   └── widget/
│   │       └── tiny_widget.dart       # C() 間距小工具
│   └── features/                      # 功能模組
│       ├── main/                      # 主畫面（Dashboard 分頁容器）
│       ├── user/                      # 使用者／登入
│       ├── holiday/                   # 例假日管理（最完整）
│       ├── bnb/                       # 民宿列表
│       ├── orders/                    # 訂單營收統計
│       └── activity/                  # 練習頁（Bored API）
├── generated/                         # flutter_intl 產生的 l10n 程式碼
└── l10n/                              # .arb 語系檔

database_schema.sql                    # MySQL 完整 Schema（15 張表）
run.sh                                 # 環境化啟動腳本（--dart-define）
gen.sh                                 # build_runner 程式碼生成腳本
mason_gen.sh                           # mason 產生新功能模組
mason.yaml                             # mason bricks（riverpod_project / riverpod_module）
.env.example / .env.dev / .env.prod   # 各環境 API_URL / DEBUG
test/
├── widget_test.dart                   # 預設 counter smoke test（與 App 不合，會失敗）
└── api_verification_test.dart         # 對後端 live API 的驗證測試
```

### 每個功能模組的標準結構

```
features/<name>/
├── view/          # 頁面級 widget（如 holiday_view.dart）
├── widget/        # 可重用元件（如 holiday_card.dart）
├── model/         # freezed model + .freezed.dart + .g.dart
├── repository/    # repository 抽象 + impl + fake
└── providers/     # @riverpod 狀態層 + .g.dart
```

---

## 5. 核心層（Core）詳解

### 5.1 `main.dart` — 啟動流程

```dart
WidgetsFlutterBinding.ensureInitialized();
await AppStorage().initAppStorage();   // 初始化 Hive，開 'appInfo' box
runApp(const ProviderScope(child: App()));
```

### 5.2 `app.dart` — App Root

- `ConsumerWidget`，由 `routerProvider` 取得 `GoRouter`，使用 `MaterialApp.router`。
- `builder: EasyLoading.init()` 掛載全域 loading。
- 設定 `S.delegate` 與 Global 語系 delegates，支援中／英。
- 使用 `appThemeProvider`（目前 `ThemeData()` 空白，尚未客製）。

### 5.3 `app_storage.dart`（Local Storage）

- 單例；`Hive` 開 `appInfo` box。
- API：`getToken()` / `putToken()` / `clearAllData()`。

### 5.4 `api.dart`（Network — 最核心）

`Network` 是單例（`Network.instance`），用 Dio 封裝：

- Base URL：`String.fromEnvironment(AppConfig.apiUrl, defaultValue: 'https://boobook.company/api/v1')`，也就是由 **`--dart-define=API_URL=...`** 決定。
- 封裝方法：
  - `getData` / `getUnData`（免 token）/ `getChangeTokenData`
  - `postData` / `postUnData` / `postFormData`
  - `putData` / `putFormData`
  - `deleData`
  - `authData`（免 token POST）
- 自動夾帶 headers：`Authorization: Bearer <token>`、`timeZoneOffset`（秒）、`X-Origin`、CORS headers、`content-Type: application/json`、`Accept`。
- 錯誤處理 `errorHandle`：
  - timeout → 顯示 `network_error2` toast
  - unknown → 顯示 `network_error_no` toast
  - **401（`ResCode.authFalse`）→ 移除 token、`AppStorage().clearAllData()`**
- `showMessage`：當後端回應 `code == 9110001`（`ResCode.showMessage`）時顯示訊息 toast。
- `refreshToken()`：呼叫 `/auth/refresh_token`（目前 token 更新邏輯部分被註解）。

> 注意：`ApiConstants` 內大量 key 是從其他專案（療管家）複製過來，許多與本專案無關（如 `classes`、`courses`、`kids`），使用時需特別留意。

### 5.5 `app_config.dart`（常數）

- `AppConfig.apiUrl = "API_URL"`、`debug = "DEBUG"`（從 dart-define 讀取）。
- `AppConfig.projectName = "療管家"`（註：這是複製殘留的舊專案名稱，與 BooBook 無關）。
- `ResCode`：`showMessage = 9110001`、`success = 0`、`authFalse = 401`。後端成功判斷以 `result["success"] == true` 為準。
- `Constants`（其他專案殘留，未使用於本專案功能）。

### 5.6 `router.dart`

- `routerProvider`：`GoRouter`，目前只有一條路由 `/main`（`MainView`）。
- **其餘畫面（holiday / bnb / orders / login）都是用 `Navigator.push(MaterialPageRoute(...))` 直接推入，未走 go_router** —— 這是目前架構上一個不一致處。

### 5.7 `date_utils.dart`

`DateTime?` 擴充方法：

- `dateFormat`（`yyyy-MM-dd`）、`onlyDateFormat`（`MM-dd`）、`timeFormat`（`HH:mm`）、`weekdayFormat`（zh_TW 星期幾）
- `getDate`（取日期部分）、`timeOfDay`、`setTimeOfDay(time)`

---

## 6. 功能模組詳解

### 6.1 main（主畫面容器）

- **`view/main_view.dart`**：watch `appUserProvider`。
  - `data` → `Dashborad`
  - `loading` → 轉圈
  - `error` → `LoginView`
- **`view/dashboard.dart`**：`AdaptiveScaffold` + NavigationBar，三個分頁：
  1. 例假日（`HolidayView`）
  2. BnB（`BnbsView`）
  3. Test（`ActivityView`）
- `model/main_model.dart`、`providers/main_providers.dart`：**空殼**（TODO）。

### 6.2 user（登入）

- **`model/user.dart`**：`User` freezed model，欄位：`id, name, email, emailVerifiedAt, period, createdAt, updatedAt, permission, phone, ftoken, code`。
- **`providers/user_providers.dart`**：`@riverpod class AppUser extends _$AppUser`：
  - `build()` → `getUserInfo()`（一進 App 就驗證 token 是否有效）
  - `login(phone, password)` → repository.login → 成功設 `state = AsyncValue.data(user)`；失敗回傳錯誤字串
- **`repository/user_repository.dart`**：`getUserInfo()` / `login(phone, password)`
  - **`user_repository_impl.dart`**：
    - `getUserInfo()` → `GET /getUserInfo`，success 時取 `result['user']`
    - `login()` → `POST /login`（body: `{phone, password}`），成功時 `AppStorage().putToken(result["token"])`
- **`view/login_view.dart`**：`flutter_login` 畫面（`LoginUserType.phone`）。
  - 注意：目前有一組硬編碼假用戶 `users = {'dribbble@gmail.com': '12345', ...}` 只用在 `onRecoverPassword`。
  - 登入動畫完成後直接 `pushReplacement` 到 `Dashborad`（沒有真正串接登入成功/失敗狀態，`appUser.login` 的回傳值未被檢查）。
- `user_view.dart`、`user_widget.dart`：空殼。

### 6.3 holiday（例假日管理 — 最完整）

- **`model/holiday.dart`**：`Holiday` freezed model：
  - `id, createdAt, updatedAt, date, name, isHoliday, holidayCategory, description, tep`
  - `isHoliday` / `tep` 使用 `boolFromInt` / `boolToInt` 處理資料庫 0/1 與布林的轉換
- **`providers/year_provider.dart`**：`@riverpod class Year`，預設目前年份，提供 `increment()` / `decrement()`。
- **`providers/holiday_providers.dart`**：`@riverpod class Holidays`：
  - `build()`：watch `yearProvider` → `getHolidays(year)` → 依日期排序
  - `store(day)`：新增或更新（依 id 是否存在），**成功後直接更新本地列表**
  - `desroy(id)`：刪除並更新本地列表（注意方法名拼成 `desroy`，非 `destroy`）
- **`repository/holiday_repository.dart`**：`getHolidays(year)` / `store(day)` / `storeList(list)` / `destroy(id)`
  - **impl**（`holiday_repository_impl.dart`）：
    - `POST /getholidays`（body: `{thisYear}`）
    - `POST /storeHoliday`（body: `{holiday}`）
    - `POST /holidays/storeList`（body: `{holidayList}`，批次匯入）
    - `DELETE /holidays/destroy/$id`
- **`view/holiday_view.dart`**：watch `holidaysProvider`，render `HolidayList`。
- **`widget/holiday_list.dart`**：SliverAppBar（年份切換＋「政府Api」按鈕）＋ FAB（新增）＋ SliverList。
- **`widget/holiday_card.dart`**：顯示日期、名稱、描述、假日／時間電價假日旗標；可編輯模式有刪除（含確認對話框）與編輯按鈕。
- **`widget/edit_day_dialog.dart`**：新增／編輯對話框，可選日期、輸入名稱／描述、勾選假日與 tep。
- **`view/holiday_gov.dart`**：**政府資料匯入頁**：
  - 直接以 `Dio().get` 呼叫新北市開放資料 API（`data.ntpc.gov.tw` 的國定假日 dataset）
  - 解析後依年份過濾顯示，點「import」呼叫 `holidayRepositoryProvider.storeList(...)` 批次寫入後端

### 6.4 bnb（民宿列表）

- **`model/bnb.dart`**：`Bnb` freezed model：`id, createdAt/UpdatedAt, bnbName, deposit, depositPeriod, orderSample, activity, userId, cancelSample, delaySample, delay, checkSample, code, countryId, cityId, ordersCount`。
- **`providers/bnb_providers.dart`**：`@riverpod class Bnbs` → `getAllBnbs()`。
- **`repository/bnb_repository.dart`**：`getAllBnbs()` → impl 呼叫 `GET /getAllBnbs`，取 `result['bnbs']`。
- **`view/bnb_view.dart`**：watch `bnbsProvider` → `BnbList`。
- **`widget/bnb_list.dart`**：標題「所有民宿」＋ SliverList。
- **`widget/bnb_card.dart`**：顯示 `bnbName` 與 `訂單數：ordersCount`；點擊卡片 `Navigator.push` 到 `OrdersView`。

### 6.5 orders（訂單營收統計）

- **`model/order.dart`**：`Order` freezed model：`id, createdAt/UpdatedAt, checkin, checkout, customerId, roomId, orderStatusId, orderPlaceId, bnbId, price, depositPay, memo`。
- **`providers/orders_providers.dart`**：`@riverpod class Orders`（**帶參數** family-style）→ `build(int bnbId)` → `getAllOrders(bnbId)`。
- **`repository/orders_repository.dart`**：`getAllOrders(bnbId)` → impl 呼叫 `GET /getAllOrdersByBnb/$bnbId`，取 `result['orders']`。
- **`view/orders_view.dart`**：watch `ordersProvider(bnb.id ?? 0)`，AppBar 顯示民宿名。
- **`widget/orders_widget.dart`**：
  - 計算 **今年各月營收**（依 `checkin` 年份 == 今年 → 依月份加總 `price`）
  - 計算 **歷年營收**（依年份加總）
  - 以 `NumberFormat.currency(symbol: 'NT\$')` 顯示金額
  - 版面分「今年」與「歷年」兩個區塊

### 6.6 activity（練習頁）

- 直接呼叫 **Bored API**（`https://boredapi.com/api/activity`）取得隨機活動（`key, activity, type, participants, price`）。
- `activity_providers.dart` 為 `@riverpod Future<Activity>` 風格（provider function 而非 class）。
- `ActivityView` 示範了 Riverpod 的 pattern matching 寫法（`switch (activity)` + `valueOrNull`）與 pull-to-refresh。
- Repository／widget 為空殼，屬於**測試/範例性質的模組**。

---

## 7. 資料庫設計（`database_schema.sql`）

MySQL 5.7+／8.0+／MariaDB 相容，共 **15 張表**：

| # | 表名 | 說明 |
| --- | --- | --- |
| 1 | `users` | 使用者，`permission` ENUM：helper / level1 / level2 / level3 / admin；含 `ftoken`（FCM）、`code` |
| 2 | `countries` | 國家字典表 |
| 3 | `cities` | 城市表（FK → countries） |
| 4 | `bnbs` | 民宿：`bnb_name`、訂金成數 `deposit`(預設50)、`deposit_period`(保留天數)、`activity`(營運中)、`delay`(延期月數)、`code`、各類訊息範本（order/cancel/delay/check sample） |
| 5 | `rooms` | 房型：`default_price` / `normal_price`(平日) / `holiday_price`(假日) |
| 6 | `customers` | 房客：姓名、電話、身分證、地址、生日、`blacklist` 黑名單 |
| 7 | `order_places` | 訂單來源管道（Booking / Agoda / 官網…），含 `commission` 抽成 |
| 8 | `order_statuses` | 訂單狀態字典（內建 7 筆：新訂單、已付訂金、已付全額、已入住、已退房、已取消、已延期） |
| 9 | `orders` | 訂單主表：checkin/checkout、price、deposit_pay、photo_path、memo、delay_perid；關聯 bnb/customer/room/status/place |
| 10 | `deposits` | 訂金查帳核銷表：`account`(末五碼)、`deposit_pay`、`check`、`code` |
| 11 | `order_notifies` | 訂單推播通知紀錄（type: 訂金/入住前提醒/取消） |
| 12 | `holidays` | 國定假日：`date`(unique)、`name`、`is_holiday`、`holiday_category`、`description` |
| 13 | `memodays` | 民宿自訂備忘提醒日 |
| 14 | `solars` | 二十四節氣表 |
| 15 | `icodes` | 會員註冊邀請碼／授權序號（type 對應方案、status 0/1/2） |
| 16 | `app_versions` | App 版本控制與強制更新 |

> 對照：`holidays.is_holiday`、`holidays.tep`（時間電價假日）目前存在於 App model，但 **schema 並無 `tep` 欄位**，與 `.g.dart` 的 fromJson 對照需再確認後端是否已在 API 層補上。

---

## 8. 環境設定與執行

### 8.1 環境檔

| 檔案 | API_URL | DEBUG | 用途 |
| --- | --- | --- | --- |
| `.env.dev` | `https://boobook.company/api/v1` | true | 開發環境 |
| `.env.prod` | `https://boobook.company/api/v1` | false | 正式環境 |
| `.env.example` | `https://boobook.company/api/v1` | true | 範本 |

> `.env.*` 檔案在 repo 內（`.gitignore` 未排除），內容以 `KEY=VALUE` 一行一個。
> 目前 API 只有單一來源（`https://boobook.company/api/v1`），dev / prod 僅以 DEBUG 區分。

### 8.2 啟動腳本 `run.sh`

```
./run.sh dev          # 用 .env.dev 一般執行
./run.sh dev web      # 用 .env.dev 開 Chrome
./run.sh prod abel    # 用 .env.prod 安裝到 Abel 的手機（release）
./run.sh prod release # 用 .env.prod release 執行
```

原理：以 `--dart-define-from-file=.env.${env}` 把整個 .env 檔帶入 `flutter run`（Dart 側用 `String.fromEnvironment` 讀取）。

### 8.3 程式碼生成 `gen.sh`

```bash
flutter clean
flutter pub run build_runner build --delete-conflicting-outputs
```

產生：`*.freezed.dart`、`*.g.dart`（json_serializable）、`*_providers.g.dart`（riverpod_generator）。

### 8.4 產生新功能模組（Mason）

- `mason.yaml` 使用 `riverpod_project`、`riverpod_module` 兩個 brick。
- `mason_gen.sh`：`mason make riverpod_module`
- 依 brick 模板在 `lib/app/features/` 下自動建立 model / view / widget / repository / providers 五件套骨架。

---

## 9. 程式碼生成模式（Codegen 慣例）

對每個新功能模組的慣例：

1. **Model**：`@freezed` + `part 'xxx.freezed.dart'; part 'xxx.g.dart';`，欄位用 `@JsonKey(name: "...")` 對應後端欄位名。
2. **Providers**：`@riverpod class Xxx extends _$Xxx`，`part 'xxx_providers.g.dart';`。由 generator 產出 `xxxProvider`（如 `appUserProvider`、`holidaysProvider`、`ordersProvider`）。
3. **Repository**：宣告 `abstract class`，`Impl` 內用 `Network.instance.xxx`，並在檔案底部註冊 `final xxxRepositoryProvider = Provider<XxxRepository>(...)`。
4. 產生的 provider 都是 `AutoDispose`（見 `user_providers.g.dart` 中的 `AutoDisposeAsyncNotifierProvider`）。

---

## 10. 測試（Test）

### 10.1 `test/widget_test.dart`（預設範本）

- 內容是 Flutter 預設 counter app 的 smoke test，**與目前 App 內容不符**（App 沒有 counter），執行會失敗。建議改寫或刪除。

### 10.2 `test/api_verification_test.dart`（後端實測）

- 直接對 **live 後端** 做驗證：
  1. `getHolidays(2023)` 取得假日資料
  2. 登入測試帳號 `0933787349 / 1234`
  3. 帶 token 取得使用者資訊
  4. `getAllBnbs()`
  5. `getAllOrders(8)`
  6. 建立→刪除測試假日（`store` + `destroy`）
  7. 第二個測試帳號 `0919506368 / 12345678` 登入
- 會 mock `path_provider` channel 並在 temp dir 初始化 Hive，允許自簽憑證（`RealHttpOverrides`）。
- 需要連到真實環境／開發後端才能跑過。

---

## 11. 目前狀態與待辦事項

### 已完成的架構性工作

- ✅ Feature-first 目錄結構 + 五件套骨架（mason 模板）
- ✅ Riverpod（generator）狀態管理整合
- ✅ Network 層（Dio）＋ Hive 儲存
- ✅ Holiday CRUD 完整串接後端
- ✅ BnB 列表 → 訂單營收統計
- ✅ 政府假日 API 匯入
- ✅ 環境切換腳本（run.sh / .env.*）
- ✅ 登入流程（flutter_login + token 存取）

### 未完成／薄弱點（接手時建議優先處理）

| 項目 | 說明 |
| --- | --- |
| 登入導向未檢查結果 | `LoginView` 的 `onSubmitAnimationCompleted` 直接跳 `Dashborad`，未判斷 `appUser.login` 是否成功 |
| 路由不一致 | 只有 `/main` 走 go_router；其餘全部 `Navigator.push`。建議統一改用 go_router |
| Theme 未客製 | `AppTheme` 的 `lightTheme` / `darkTheme` 都是空 `ThemeData()` |
| `main_providers.dart`、`main_model.dart` | 空檔案 |
| activity 模組 | 僅為練習頁（Bored API），與業務無關，可移除或改為正式功能 |
| 多處 TODO | `user_view.dart`、`user_widget.dart`、`plugin / repository` 空殼 |
| 舊專案殘留 | `AppConfig.projectName = "療管家"`、`ApiConstants` 大量無關 key（classes/kids/courses…） |
| 拼字錯誤 | `Holidays.desroy`（應為 destroy） |
| `tep` 欄位 | App model 有、SQL schema 無，需確認後端對應 |
| widget_test | 為範本 counter test，會失敗 |
| `postUnData` | 缺少 `showMessage` / `checkAuth` 處理（與其他方法不一致） |
| 註解掉的程式碼 | `api.dart` 中 `_checkSSl`、`updateLogginUserToken`、登出導向等已被註解 |

---

## 12. 常用指令速查（Cheat Sheet）

```bash
# 啟動（依環境）
./run.sh dev        # 用 .env.dev 一般執行
./run.sh prod       # 用 .env.prod 一般執行
./run.sh prod abel  # 安裝到 Abel 手機（release）

# 程式碼生成（freezed / json_serializable / riverpod_generator）
./gen.sh            # flutter clean + build_runner

# 產生新功能模組骨架
mason make riverpod_module

# 產生 App 圖示
flutter pub run flutter_launcher_icons

# 靜態分析
flutter analyze

# 後端 API 驗證測試（需連到開發後端）
flutter test test/api_verification_test.dart
```

---

## 附錄 A：後端 API 端點整理（由 repository 層歸納）

| 方法 | 路徑 | 用途 | 來源 |
| --- | --- | --- | --- |
| POST | `/login` | 登入（body: phone, password），回傳 token + user | user impl |
| GET | `/getUserInfo` | 取目前使用者 | user impl |
| POST | `/getholidays` | 依年份取假日（body: `{thisYear}`） | holiday impl |
| POST | `/storeHoliday` | 新增／更新單筆假日 | holiday impl |
| POST | `/holidays/storeList` | 批次匯入假日（body: `{holidayList}`） | holiday impl |
| DELETE | `/holidays/destroy/{id}` | 刪除假日 | holiday impl |
| GET | `/getAllBnbs` | 取全部民宿 | bnb impl |
| GET | `/getAllOrdersByBnb/{bnbId}` | 取某民宿的所有訂單 | orders impl |
| POST | `/auth/refresh_token` | 刷新 token | api.dart |

---

## 13. 升級紀錄（2026-09-24 完成）

> 目標：讓此舊專案可在最新 Flutter stable 上正常 build。
> 環境：**Flutter 3.47.4 / Dart 3.13.3**（`flutter --version` 驗證）。

### 13.1 升級前的主要障礙

- `flutter build web` 失敗，主因：`flutter_login ^5.0.0` 間接引入的
  `font_awesome_flutter 10.12.0` 會 `extends IconData`，而新版 Flutter 已將
  `IconData` 改為 `final class`，編譯直接報錯。
- Android 端仍為舊模板（Kotlin 1.7.10 / AGP 7.3.0 / Gradle 7.5 / Groovy DSL），
  與新版工具鏈（compileSdk 36 等）不相容，且有舊 Gradle daemon 殘留問題。
- `test/widget_test.dart` 是 Flutter 預設 counter 範本，與本 App 不符，測試必失敗。
- Web `index.html` 使用已棄用的 `_flutter.loader.loadEntrypoint` 與 service worker。

### 13.2 依賴升級（pubspec.yaml）

| 套件 | 升級前 | 升級後 | 原因 |
| --- | --- | --- | --- |
| `flutter_login` | ^5.0.0（5.1.0） | **^7.0.0（7.0.0）** | 關鍵修復：改用 `font_awesome_flutter ^11`（相容 final IconData） |
| `flutter_easyloading` | ^3.0.5 | ^4.0.2 | 新版 API 相容 |
| `flutter_lints` | ^2.0.1 | ^6.0.0 | 與 Flutter 3.47 模板一致 |
| `dio` | ^5.4.0 | ^5.9.0 | 解析至 5.11.1 |
| `logger` | ^2.0.1 | ^2.5.0 | 解析至 2.8.0 |
| `cupertino_icons` | ^1.0.5 | ^1.0.8 | 版本同步 |
| `freezed_annotation` / `json_annotation` / `flutter_riverpod` / `riverpod_annotation` | 見原檔 | ^2.4.4 / ^4.9.0 / ^2.6.1 / ^2.6.1 | minor 升級 |
| `go_router` | ^5.0.5 | ^5.2.4 | 保留 major（v5 即可正常編譯，避免大改動） |
| `flutter_adaptive_scaffold` | ^0.1.7+2 | ^0.1.12 | 已是 pub 上最後一版（套件 discontinued，但正常運作） |
| `environment.sdk` | >=3.2.3 | **>=3.9.0** | flutter_login 7 的最低要求 |

> 注意：**未升級** riverpod 3.x / freezed 4.x / go_router 16+（需大規模遷移程式碼，
> 超出本次「可正常 build」範圍，建議日後另行處理）。

### 13.3 Android 現代化（對齊 Flutter 3.47 模板）

舊檔刪除（Groovy DSL），新增/覆寫為 Kotlin DSL：

| 檔案 | 內容 |
| --- | --- |
| `android/settings.gradle.kts` | AGP **9.1.0**、Kotlin **2.4.0**、flutter-plugin-loader 1.0.0 |
| `android/build.gradle.kts` | 新版 root build（Kotlin DSL） |
| `android/app/build.gradle.kts` | Java 17、namespace/applicationId `com.example.boobook_admin` |
| `android/gradle.properties` | `-Xmx8G`、`android.newDsl=false`、`android.builtInKotlin=false` |
| `android/gradle/wrapper/gradle-wrapper.properties` | Gradle **9.3.1** |
| `android/app/src/debug|profile/AndroidManifest.xml` | 新增（INTERNET 權限，供 debug/hot reload） |
| `android/app/src/main/AndroidManifest.xml` | 新增 `<uses-permission INTERNET>`（release 連 API 需要） |

`MainActivity.kt`、`res/`、mipmap 等維持不變。

### 13.4 iOS / macOS / Web 調整

- **iOS（後續已完整轉 SPM，見 13.8）**：`project.pbxproj` 的 `IPHONEOS_DEPLOYMENT_TARGET`
  **13.0 → 15.0**（對齊模板）。
- **macOS**：`MACOSX_DEPLOYMENT_TARGET` **10.14 → 12.0**；Podfile `platform :osx` 同步；
  並於 `DebugProfile.entitlements` / `Release.entitlements` 補上
  **`com.apple.security.network.client`**（連 API 用，模板預設沒加）。
- **Web**：`web/index.html` 改用新模板的 `flutter_bootstrap.js`
  （移除棄用的 service worker / `loadEntrypoint`），`manifest.json` 與模板一致。

### 13.5 測試修正

- `test/widget_test.dart`：重寫為有效 smoke test（初始化 Hive + mock path_provider，
  並 flush `flutter_login` 的 timer）。
- `test/api_verification_test.dart`：移除未使用的 `api.dart` import。

### 13.6 驗證結果

- ✅ `flutter pub get`：成功（關鍵版號 flutter_login 7.0.0 / font_awesome_flutter 11.0.0）
- ✅ `flutter analyze`：**0 errors**、0 warnings（lib 端）；僅剩 1 個 legacy plugin 棄用
  warning（custom_lint 尚未支援新版 analyzer plugin 機制）與若干 info 級 lint
- ✅ `flutter build web`：成功
- ✅ `flutter build ios --config-only --no-codesign`：成功（pod install 完成，iOS 部署
  目標 15.0；Flutter 已自動更新 Podfile、xcscheme（新增 Prepare Flutter Framework
  PreAction）與 plugin registrant）
- ✅ `flutter test test/widget_test.dart`：通過
- 🏃 `flutter build apk --debug`：進行中（首次需下載 AGP 9.1.0 / Kotlin 2.4.0 依賴，較久）

### 13.7 後續建議

1. **移除舊 Gradle daemon**：`./android/gradlew --stop`（本機可能有 7.5 / 8.9 舊 daemon 殘留）。
2. **升級 riverpod 3 / freezed 4 / go_router 16+**：屬大規模遷移，需逐一驗證 codegen 與 API 變更。
3. **custom_lint / riverpod_lint**：已於 13.9 移除（與新版 analyzer 不相容）。
   日後若想重新啟用，需先將 freezed 升至 3.x（custom_lint ≥0.7.4 依賴
   `freezed_annotation ^3.0.0`），再等 custom_lint 支援新版 plugin 語法後
   改用頂層 `plugins:` 註冊（見 https://dart.dev/tools/analyzer-plugins）。
4. 若要在 Android 上執行 debug build，首次會下載 AGP/Kotlin 依賴，耗時較長屬正常。

### 13.8 iOS SPM（Swift Package Manager）轉移紀錄

> 目的：將 iOS 從 CocoaPods 架構完整移轉到 Swift Package Manager，並驗證可運行。
> 背景：`flutter build ios` 偵測到所有 iOS plugins（url_launcher、shared_preferences）
> 皆為 first-party SPM 相容套件，但因專案使用舊式（non-standard）Podfile，需手動移轉。

**執行步驟**

1. `cd ios && pod deintegrate`：移除 CocoaPods 對 Xcode 專案的所有引用。
2. 刪除 `ios/Podfile`、`ios/Podfile.lock`、`ios/Pods/`。
3. 手動清除殘留：
   - `ios/Flutter/Debug.xcconfig` / `Release.xcconfig` 中的 `#include? "Pods/..."` 行
   - `ios/Runner.xcworkspace/contents.xcworkspacedata` 中的 `Pods/Pods.xcodeproj` FileRef
4. `flutter build ios --config-only --no-codesign`：Flutter 工具自動加入 SPM 整合。

**轉移後的結果（SPM 已生效）**

- `project.pbxproj`：
  - `packageReferences` → `XCLocalSwiftPackageReference "FlutterGeneratedPluginSwiftPackage"`
  - Runner target 的 `packageProductDependencies`、`XCSwiftPackageProductDependency` section
- 產生 `ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift`：
  - `shared_preferences_foundation 2.5.7`
  - `url_launcher_ios 6.4.2`
  - `FlutterFramework`
- `ios/` 已無任何 CocoaPods 殘留（無 Podfile / Pods / pod install）。

**可運行驗證（2026-09-24）**

- ✅ `flutter build ios --simulator`：成功（32s）→ `build/ios/iphonesimulator/Runner.app`
- ✅ iPhone 17 模擬器啟動 → `simctl install` → `simctl launch`（PID 19361）
- ✅ 5 秒後 process 仍存活（`launchctl list`）
- ✅ 系統日誌：Flutter engine 正常啟動，正確呼叫後端 API
  （無 token → 401「Token 已過期或無效，請重新登入」→ 進入登入畫面），無 crash。
- ⚠️ 注意：`flutter build` 會在每次執行時重新產生 `Flutter/ephemeral/Packages/`
  （ephemeral 目錄不該 commit 進 git）。

### 13.9 Analyzer 檢查清理（2026-09-24，目標 0 issues）

> 背景：VS Code 顯示 52 條 issue，但 `flutter analyze` / `dart analyze` 只有 30 條。
> 追查後發現主要差異來自 **custom_lint / riverpod_lint 完全無法載入**。

**根因：custom_lint 0.7.3 與新版 analyzer 不相容**

- `dart run custom_lint` 編譯失敗：`analyzer_plugin 0.12.0` 與 Dart 3.13 內建的
  `analyzer 7.6.0` API 衝突（`Element` vs `Element2`）。
- 要升 custom_lint ≥0.7.4 又會撞上 `freezed_annotation ^3.0.0` 的依賴，
  而專案模型使用 freezed 2.x（升 freezed 3/4 屬大規模 codegen 遷移）。

**處理方式**

1. 移除 `dev_dependencies` 中的 `custom_lint` 與 `riverpod_lint`
   （僅 dev-time linter；`riverpod_generator` 等 codegen 保留不動）。
2. 刪除 `analysis_options.yaml` 的 `analyzer.plugins: [custom_lint]` 段落
   → 消除了唯一的 `analysis_options_deprecated_plugins` warning。
3. 修正剩餘 29 條 analyzer issue：
   - `lib/app/core/network_utils/api.dart`（17 條 `strict_top_level_inference`）：
     - 移除未使用的 `dart:developer` import（含其 ignore 註解）
     - 所有 API method 補上參數型別：`apiUrl` → `String`、`data` → `Object?`
     - `debugLog(var res)` → `debugLog(Response<dynamic> res)`
   - `lib/app/features/holiday/view/holiday_gov.dart`（2 條）：
     - `stringTobool(string)` → `stringTobool(String string)`
     - `filterHolidays()` → `void filterHolidays()`
   - 10 個 View/Widget 的 `use_super_parameters`：
     `{Key? key} : super(key: key)` → `{super.key}`

**結果**

- ✅ `flutter analyze`：**No issues found!**（0 errors / 0 warnings / 0 infos）
- ✅ `flutter test test/widget_test.dart`：All tests passed
- 說明：provider 檔案中的 `// ignore: avoid_manual_providers_as_generated_provider_dependency`
  註解為 riverpod_lint 殘留，目前不產生任何 issue，故保留（日後重啟 riverpod_lint 仍可用）。

### 13.10 Riverpod 3 + Freezed 4 升級（2026-09-24）

> 目的：依需求將 riverpod 用法升級至最新版本，並處理其帶動的 freezed 升版。

**版本對照**

| 套件 | 升級前 | 升級後 |
|---|---|---|
| `flutter_riverpod` | 2.6.1 | **3.4.3** |
| `riverpod_annotation` | 2.6.1 | **4.0.7** |
| `riverpod_generator` | 2.3.9 | **4.0.9** |
| `freezed`（dev） | 2.4.6 | **4.0.2** |
| `freezed_annotation` | 2.4.4 | **3.1.0** |
| `json_annotation` | 4.9.0 | **4.12.0** |

- 版本配對：`riverpod_annotation/generator 4.x` 對應 `riverpod core 3.x`；
  `riverpod_generator 4.0.9 → riverpod_analyzer_utils 1.0.0-dev.12`
  依賴 `freezed_annotation ^3.0.0`，故 freezed 必須一起升。
- 附帶收穫：`custom_lint_core / custom_lint_visitor` 隨新 codegen 依賴消失，
  不再需要以「保留但不使用」的方式存在。

**Riverpod 2 → 3 的程式碼變更**

1. `activity_view.dart`：`AsyncValue.valueOrNull` 改名為 `AsyncValue.value`
   （3.0 中 `value` 在 error/loading 時回傳 null，不再 throw）。
2. `user_providers.dart` / `holiday_providers.dart`：在 async gap 之後、
   改寫 `state` 之前加入 `if (!ref.mounted) return;` 防護
   （3.0 對已 dispose 的 ref 使用會直接 throw）。
3. `year_provider.dart` 的 `state = state + 1` 在 Notifier 內仍然合法（protected setter），不需改。
4. `activity_providers.dart`：移除多餘的 `flutter_riverpod` import
   （`riverpod_annotation 4.x` 已 re-export 所需元素）。
5. Codegen 行為（由 build_runner 重產，原始檔不必動）：
   - `AutoDispose*` 系列全部消失，改為統一 lifecycle（`isAutoDispose` 旗標）。
   - 自訂 `XxxRef` 型別消失，統一使用 `Ref`。
   - Family Notifier：family 參數透過 `ref.$arg` 傳入，`ordersProvider(bnbId)` 用法不變。

**Freezed 2 → 4 的程式碼變更**

- Freezed 3.0+ breaking change：`@freezed` class 必須是 `abstract` / `sealed`
  或手動實作 `_$X`（新的 `_$X` mixin 只有抽象成員，具體實作在產生的 `_X implements X`）。
- 5 個模型檔（activity / bnb / holiday / order / user）只加一個關鍵字：
  `class X with _$X {` → `abstract class X with _$X {`。
- 模型皆為單一 constructor（無 union / sealed），freezed 4.0 的其他 breaking changes
  （`final` 參數語法移除、analyzer 13/14 要求）都不影響。

**驗證**

- ✅ `flutter pub get`：依賴解析成功
- ✅ `dart run build_runner build`：重產 27 個輸出（riverpod `.g.dart` / `.freezed.dart` / json `.g.dart`）
- ✅ `flutter analyze`：**No issues found!**
- ✅ `flutter test test/widget_test.dart`：All tests passed
- ✅ `flutter build apk --debug`：成功（見背景 build 的 APK 產出）