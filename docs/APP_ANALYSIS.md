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
2. **主畫面**：自適應 NavigationBar（`flutter_adaptive_scaffold`），三個分頁：
   - **BnB**（民宿列表 → 訂單營收統計）
   - **假日**（例假日管理）— 最完整的功能
   - **節氣**（二十四節氣，可自動產生整年）
3. **例假日管理**：
   - 依年份列出假日、新增／編輯／刪除假日
   - 標示「假日」與「時間電價假日（tep）」兩種屬性
   - 可從 **新北市開放資料 API** 匯入政府例假日資料並批次寫入後端
4. **民宿列表**：顯示民宿名稱、訂單數與**有效營收**（後端依「預訂/付訂/付清」狀態加總，排除取消/延期/候補），點擊卡片進入該民宿的訂單統計頁。
5. **訂單營收統計**：以民宿為單位，顯示「今年（按月）」與「歷年（按年）」的營收加總（NT$）；**營收只計有效狀態，訂單數仍計入全部狀態**。今年月份可再點擊進入**當月訂單明細頁**。

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
3. UI 操作（新增／刪除）直接呼叫 `holidaysProvider.notifier` 的方法（`store` / `destroy`，回傳 `bool`），成功後**直接更新本地 state**，不需重新向後端拉取；失敗保留列表、由 UI（EasyLoading）提示。
4. 切換年份會透過 `yearProvider` 改 state → `build()` 自動重新執行。
5. 政府資料匯入完成後呼叫 `holidaysProvider.notifier.refresh()`（`ref.invalidateSelf()`）重新抓取。

---

## 4. 目錄結構

```
lib/
├── main.dart                          # App 進入點：初始化 Hive → runApp(ProviderScope)
├── app/
│   ├── app.dart                       # App root widget（MaterialApp.router + EasyLoading）
│   ├── core/                          # 跨功能共用
│   │   ├── constants.dart/
│   │   │   └── app_config.dart        # AppConfig / ApiConstants / ResCode
│   │   ├── local_storage/
│   │   │   └── app_storage.dart       # Hive 封裝（token 存取、清除）
│   │   ├── network_utils/
│   │   │   └── api.dart               # Network 單例（Dio 封裝、錯誤/認證處理）
│   │   ├── router/
│   │   │   └── router.dart            # go_router 設定（目前只有 /main）
│   │   ├── theme/
│   │   │   └── app_theme.dart         # light/dark theme（目前為空）
│   │   ├── utils/
│   │   │   ├── date_utils.dart        # DateTime 擴充（格式化、星期幾、TimeOfDay）
│   │   │   └── money_utils.dart       # 金額格式化（千分位／萬縮寫）
│   │   └── widget/
│   │       ├── tiny_widget.dart       # C() 間距小工具
│   │       └── money_text.dart        # MoneyText 金額元件（縮寫＋點擊 tooltip 完整金額）
│   └── features/                      # 功能模組
│       ├── main/                      # 主畫面（Dashboard 分頁容器）
│       ├── user/                      # 使用者／登入
│       ├── holiday/                   # 例假日管理（最完整）
│       ├── bnb/                       # 民宿列表
│       ├── orders/                    # 訂單營收統計
├── generated/                         # flutter_intl 產生的 l10n 程式碼
└── l10n/                              # .arb 語系檔

database_schema.sql                    # MySQL 完整 Schema（16 張表）
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

### 5.5 `app_config.dart`（常數）

- `AppConfig`：僅 `apiUrl = "API_URL"`、`debug = "DEBUG"`（從 dart-define 讀取）。
- `ApiConstants`：僅保留實際被 `api.dart` 引用的 key（`token`/`success`/`message`/`code`/`data`）；已刪除其他專案殘留的 `classes`/`courses`/`kids` 等無關 key 與 `Constants`/`ClassRes` 整組常數。
- `ResCode`：`showMessage = 9110001`、`success = 0`、`authFalse = 401`。後端成功判斷以 `result["success"] == true` 為準。

### 5.6 `router.dart`

- `routerProvider`：`GoRouter`，目前只有一條路由 `/main`（`MainView`）。
- **其餘畫面（holiday / bnb / orders / login）都是用 `Navigator.push(MaterialPageRoute(...))` 直接推入，未走 go_router** —— 這是目前架構上一個不一致處。

### 5.7 `date_utils.dart`

`DateTime?` 擴充方法：

- `dateFormat`（`yyyy-MM-dd`）、`onlyDateFormat`（`MM-dd`）、`timeFormat`（`HH:mm`）、`weekdayFormat`（zh_TW 星期幾）
- `getDate`（取日期部分）、`timeOfDay`、`setTimeOfDay(time)`

### 5.8 `money_utils.dart`

金額格式化統一入口（純函式）：

- `formatNTMoney(int)`：顯示用金額。NT$1 萬（10^4）以上由 intl `compactCurrency(locale: 'zh_TW')` 縮寫（`58000 → NT$5.8萬`、`58 萬 → NT$58萬`）；未滿 1 萬用 `NumberFormat.currency` 千分位（`5000 → NT$5,000`、`999 → NT$999`）。分支是刻意的——intl compact 建構子直接 `turnOffGrouping()`，未壓縮路徑不插千分位且無開啟 API，千分位只能靠一般 currency 格式補上。
- `formatNTMoneyFull(int)`：一律千分位完整金額（`58000 → NT$58,000`、`1234567 → NT$1,234,567`），供 tooltip／明細頁用。

### 5.9 `money_text.dart`

- `MoneyText(value, {style, textAlign, maxLines, overflow, softWrap})`：金額顯示元件。渲染 `formatNTMoney` 縮寫，**點一下以 tooltip 彈出 `formatNTMoneyFull` 完整金額**；未滿 1 萬（縮寫＝完整）時直接顯示、不包 tooltip。全 App 金錢顯示統一改用它，未來改格式只動此檔＋`money_utils.dart`。
- 使用處：`bnb_card.dart`（有效營收 chip）、`orders_widget.dart`（月份/年份卡營收）、`month_orders_view.dart`（統計卡總營收/訂金已收、每日營收、房費、訂金 chip；明細 sheet 用 `formatNTMoneyFull` 顯示完整金額）。

---

## 6. 功能模組詳解

### 6.1 main（主畫面容器）

- **`view/main_view.dart`**：watch `appUserProvider`。
  - `data` → `Dashborad`
  - `loading` → 轉圈
  - `error` → `LoginView`
- **`view/dashboard.dart`**：`AdaptiveScaffold` + NavigationBar，三個分頁：
  1. BnB（`BnbsView`，`Icons.reorder`）
  2. 假日（`HolidayView`，`Icons.edit_calendar`）
  3. 節氣（`SolarView`，`Icons.wb_sunny`）
  - AppBar 標題動態顯示當前分頁名稱
  - 原「3. Test（`ActivityView`）」分頁已移除
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
  - `store(day)`：新增或更新（依 id 是否存在），成功後**直接更新本地列表**，回傳 `bool`
  - `destroy(id)`：刪除並更新本地列表，回傳 `bool`（方法名已由 `desroy` 修正為 `destroy`）
  - `refresh()`：`ref.invalidateSelf()` 重新抓取（政府資料匯入後呼叫，主列表立即反映新資料）
- **`repository/holiday_repository.dart`**：`getHolidays(year)` / `store(day)` / `storeList(list)` / `destroy(id)`
  - **impl**（`holiday_repository_impl.dart`）：
    - `POST /getholidays`（body: `{thisYear}`）
    - `POST /storeHoliday`（body: `{holiday}`）
    - `POST /holidays/storeList`（body: `{holidayList}`，批次匯入）——**依日期 upsert**：同日期重複匯入不會產生重複 row；已存在的 row 保留人工 `tep`（政府匯入不設 tep，與自動補全一致）；新 row 初始 `tep=0`
    - `DELETE /holidays/destroy/$id`
- **`view/holiday_view.dart`**：watch `holidaysProvider`，render `HolidayList`。
- **`widget/holiday_list.dart`**：SliverAppBar（年份切換＋「政府Api」按鈕）＋ FAB（新增）＋ SliverList。
- **`widget/holiday_card.dart`**：顯示日期（**含星期，如 `2026-09-24 星期四`**）、名稱、描述、假日／時間電價假日旗標；可編輯模式有刪除（含確認對話框）與編輯按鈕。
- **`widget/edit_day_dialog.dart`**：新增／編輯對話框，可選日期（選完下方即時顯示星期）、輸入名稱／描述、勾選假日與 tep。
- **`view/holiday_gov.dart`**：**政府資料匯入頁**（已 Riverpod 化）：
  - 透過 `govHolidaysProvider` 抓取新北市開放資料 API（`data.ntpc.gov.tw` 的國定假日 dataset），解析函式 `parseGovHolidayList`／`govDateToIso` 可獨立單元測試（含補班日/加放假日補名規則）
  - 載入失敗顯示錯誤＋重試按鈕；依年度過濾顯示，點「import」先跳出確認（筆數／年度），確認後批次寫入後端，成功後 `refresh()` 主列表並自動跳回
  - 瀏覽年份為本頁 local state，與主列表的 `yearProvider` 各自獨立
- **後端自動補全（新）**：`boobook_backend/functions/src/services/holidayService.ts` + `utils/govHolidays.ts`（解析規則與 admin `parseGovHolidayList` 完全一致）：
  - `ensureHolidaysForYear(year)`：今年 ±1 年內（政府資料只出到「次年」，6/30 前公告、最遲 8/31）；**閾值 8 判定「未完整」**（政府完整年 16~28 筆、部分資料來源 1~3 筆）→ 該年才補全
  - **只補缺漏日期**（日期 diff：既有集 vs 政府該年清單，只插入缺的）——不更新／不刪除既有資料、**不碰 `tep`**，admin 的人工編輯與自訂假日全部保留；也因此「`count==0` 才補」的洞（任何單筆資料都會讓該年永遠卡死、補不齊其他假日）已修掉
  - **解析含補班日與加放假日**：政府 dataset 的 null-name 行依 category 補名保留——`補行上班日`（isHoliday=否，名稱「補行上班日」，與舊系統 DB 慣例一致，消費端顯示「這天要補班」且不標紅）、`補假`/`調整放假日`（isHoliday=是，名稱用 category，消費端正確標紅＋假日計價）；一般週末（`星期六、星期日`）仍略過（消費端依 weekday 上色）。parse 後共 **210 筆**（137 具名＋19 補班日＋54 加放假日）
  - 抓到的 dataset（原始 1199 筆、含 2018–2027）以 **12h TTL** 記憶體快取；年度 cooldown **6h**（「年未公布／抓取失敗」不重複重試）；一次抓取會**補齊窗口內所有未完整年**
  - hook：`/getholidays`（未登入，`snap.empty` 時補）、`orders.ts` 消費端月曆（月查詢前補，失敗不影響主流程）、`index.ts` 每日報時
  - 已知限制：政府**修正**已公告年份（如 2025 下半年新增 3 個國定假日）不會自動同步——既有 row 不覆寫的刻意取捨，修正靠 admin 現有「政府Api」匯入頁手動重匯（`>8 筆` 的完整年自動補全也完全不介入）
- **週期顯示**：`core/utils/date_utils.dart` 新增純 Dart 的 `weekdayLabel` getter（「星期四」，不依賴 intl locale 初始化，`weekdayFormat` 目前無人使用），假日卡片與編輯對話框都顯示星期。

### 6.3.1 solar（節氣維護 — 新增，含自動產生）

原系統後端（Firestore `solars`）只有**讀取**（`orders.ts` 月曆、`index.ts` 每日報時），沒有維護 API、admin 也無介面。本次補上：

- **後端**（`boobook_backend/functions/src/routes/solars.ts`，掛載於 `app.ts`；產生邏輯抽在 `services/solarService.ts`）：
  - `POST /getsolars`（body: `{thisYear}`，不需登入，與 `/getholidays` 對齊）→ 依年份列出節氣；**Lazy 自癒**：該年完全無資料時自動產生後再回傳
  - `POST /solars/generateYear`（需登入，body: `{thisYear}`）→ **自動產生／重產該年 24 節氣**（清掉該年舊資料、整批覆寫）
  - `POST /storeSolar`（需登入，body: `{solar}`）→ 新增／更新（保留為手動維護後門；id 不存在時用 `getNextId('solars')` 自增）
  - `DELETE /solars/destroy/:id`（需登入）
  - 寫入／讀出皆把 `date` 以 `normalizeDate` 正規化為純 `yyyy-MM-dd`
  - `holidays.ts` 的 `normalizeDate` 抽出為共用 `utils/date.ts`（兩路由共用一份）
  - 欄位 `{id, date, name, description}` 與 `boobook_flutter` / `tep_flutter` 讀取的 Solar model 相容（consumers 不變）
- **消費端月曆路徑（`orders.ts`）**：`/showOrdersByMonth` 的 holidays / solars 改用**當月範圍查詢**（`where('date', '>=', 月初).where('date', '<=', 月底 + '\uf8ff')`），不再整 collection 讀取＋記憶體 filter——每次請求只讀當月 2~10 筆；solars 查詢前先 `ensureSolarTermsForYear(year)`（lazy 自癒，防該年從沒產生過），產生失敗以 `.catch(() => null)` 吞掉不影響月曆主流程。`/showOrdersByMonth` 有 auth，防護與 `/getsolars` 共用同一份（±3 年範圍 + 30 分鐘記憶體去重）
- **移除 holiday/solar 的整 collection cache**（`dataCache.ts` 的 `getCachedHolidays` / `getCachedSolars` / `invalidateHolidaysCache`）：原本是每小時整讀一次，且 `invalidateHolidaysCache` 根本沒人呼叫——admin 編輯政府匯入的假日後，消費端最久會看到 1 小時舊資料；改當月查詢後**寫入即時可見**，也省掉每小時的整 collection 讀取。`getCachedOrderStatuses`（小字典）維持快取，`getCachedCities/Countries` 供 bnb 路由使用不變
- **`index.ts` 每日報時**也在取今日節氣前 `ensureSolarTermsForYear(今年)`
- **自動產生的演算法**（`utils/solarTerms.ts`，用 `lunar-javascript` 套件）：
  - **date（日期）** 由 lunar 逐日掃描 `Solar.fromYmd(y,m,d).getLunar().getJieQi()` 決定，每年恰得 24 個節氣日；套件預設為中國／台北時區，與消費端 `DateTime.parse` 相容
  - **name / description 一律取自靜態表 `SOLAR_TERM_META`**（24 筆固定文字，唯一來源）。來源為資料庫 `solars` 表的傳統版描述（2021–2024 年內容相同），僅修正錯別字；lunar 回傳的簡體名（惊蛰/谷雨/处暑/小满/芒种 五個）只做「同位置比對驗證」，不符即拋錯（loud fail，防演算法漂移）
  - 靜態表修正清單（相對資料庫原文）：春分「畫夜→晝夜」、夏至「晝長夜短／白天最短→最長」、雨水「溶化→融化」、小雪「遽降→驟降」——記錄在 `solarTerms.ts` 註解內
  - 整批產生用 `utils/counter.ts` 新增的 `getNextIds(collection, count)` 一次 transaction 領 24 個連續 id
  - 產生的文件帶 `generated_at`（ISO 字串）記錄產生日（consumers 忽略未知欄位，安全）
- **admin `features/solar/`**（全新 module，仿 holiday 結構）：
  - `model/solar.dart`：freezed（`id? / date / name / description? / generatedAt?`），`generatedAt` 對應後端 `generated_at`（自動產生的文件才有）
  - `providers/solar_year_provider.dart`：`@riverpod class SolarYear`，預設目前年份（與 holiday 的 `yearProvider` 各自獨立）
  - `providers/solar_providers.dart`：`@riverpod class Solars` → `build()` watch `solarYearProvider`、依日期排序；`store` / `destroy` 成功後同步本地列表、回傳 `bool`；`generateYear(year)` 整批產生後直接以回傳結果取代列表（失敗不 clobber）
  - `repository/solar_repository_impl.dart`：`Network` 可注入（測試用 fake）
  - `view/solar_view.dart` + `widget/solar_list.dart` + `widget/solar_card.dart` + `widget/edit_solar_dialog.dart`
  - `widget/solar_list.dart` 的 AppBar 有「產生該年節氣」按鈕（`Icons.autorenew`，先確認再產生，成功 EasyLoading 提示）；列表頂部顯示**資料狀態列**：自動產生的最後時間（`自動產生於 yyyy-MM-dd HH:mm`）或人工資料提示
  - 卡片日期顯示星期、description 直接顯示，仍可手動新增／編輯／刪除（後門）
  - **錯誤狀態加重試**：`SolarView.error` 顯示「載入失敗」＋重試按鈕（`ref.invalidate`）；`HolidayView` 同步對齊（原本只有一行字）
- **dashboard**：`Dashborad` 新增「節氣」Tab（`SolarView`，`Icons.wb_sunny`），並將分頁重排為 **BnB → 假日 → 節氣**（原 Test 分頁移除）。

### 6.4 bnb（民宿列表）

- **`model/bnb.dart`**：`Bnb` freezed model：`id, createdAt/UpdatedAt, bnbName, deposit, depositPeriod, orderSample, activity, userId, cancelSample, delaySample, delay, checkSample, code, countryId, cityId, ordersCount, revenueEffective`（`revenue_effective` → 後端依有效狀態算好的每民宿總營收，欄位 optional，後端 deploy 前為 null）。
- **`providers/bnb_providers.dart`**：`@riverpod class Bnbs` → `getAllBnbs()`。
- **`repository/bnb_repository.dart`**：`getAllBnbs()` → impl 呼叫 `GET /getAllBnbs`，取 `result['bnbs']`（後端同時回 `orders_count` 與 `revenue_effective`）。
- **`view/bnb_view.dart`**：watch `bnbsProvider` → `BnbList`。
- **`widget/bnb_list.dart`**：SliverAppBar（「所有民宿」＋「N 間」計數徽章＋重新整理按鈕）＋ `RefreshIndicator` 下拉刷新（`ref.invalidate(bnbsProvider)`）；空狀態顯示商店 icon＋「尚無民宿」。
- **`widget/bnb_card.dart`**：漸層頭像（民宿名首字，依 id 固定取色）＋名稱＋chips（`N 筆訂單`／`有效營收 NT$5.8萬`——僅 `revenueEffective != null` 時顯示，金額用 `MoneyText`，點一下見完整金額）＋「成立於 yyyy/MM」（有 `createdAt` 時）＋ chevron；整張卡片 `InkWell` 點擊 `Navigator.push` 到 `OrdersView`。

### 6.5 orders（訂單營收統計）

- **`model/order.dart`**：`Order` freezed model：`id, createdAt/UpdatedAt, checkin, checkout, customerId, roomId, orderStatusId, orderPlaceId, bnbId, price, depositPay, memo`——**扁平、不含關聯資料**（房型/通路/客戶採 lazy 動態載入）。
- **`model/order_relations.dart`**：`OrderRoom`（`id/roomName`）、`OrderPlace`（`id/orderPlace`）、`OrderCustomer`（`id/customerName/phone`）三個小 freezed model＋`OrderReferences` 容器（`rooms`＋`places`）——訂單關聯資料的顯示用欄位。
- **`model/order_status.dart`**：`enum OrderStatus`（`id`/`label`/`countsAsRevenue`）——訂單狀態的**領域單一事實來源**：`預訂(1)/付訂(2)/付清(3)` 計入營收；`取消(4)/延期(5-7)/候補(8)` 排除。`countsAsRevenue` 是營收判斷的唯一切入點，顏色對應表（`Map<OrderStatus, Color>`）放 view 層。
- **`providers/orders_providers.dart`**：`@riverpod class Orders`（**帶參數** family-style）→ `build(int bnbId)` → `getAllOrders(bnbId)`；另兩個 **lazy provider**：`BnbOrderReferences`（`build(bnbId)`，進月份頁才觸發，整批載房型＋通路段）與 `CustomerInfo`（`build(customerId)`，點開明細 sheet 才觸發，1 read）。
- **`repository/orders_repository.dart`**：`getAllOrders(bnbId)` → impl 呼叫 `GET /getAllOrdersByBnb/$bnbId`（**裸訂單，不做關聯載入**——控制 Firestore 讀取成本：摘要列表只付訂單本身的讀取量）；`getOrderReferences(bnbId)` → `GET /getOrderReferences/$bnbId`；`getCustomer(customerId)` → `GET /getCustomer/$customerId`。
- **`repository/orders_repository_impl.dart`**：singleton 實作（`OrdersRepositoryImpl.instance`），內建**前端無 TTL 快取**：兩個 `_BoundedFifoCache`（上限 1000、先進先出），`getOrderReferences` 以 `bnbId` 為 key 快取整組房型＋通路段、`getCustomer` 以 `customerId` 為 key 快取單筆客戶——同份內容在 App 生命週期內只向後端要一次。**訂單與快取機制無關**：`getAllOrders` 每次都重抓（會變動的營收資料要新鮮）。快取放 repo 層的原因：Riverpod 3 預設 provider 是 `autoDispose`——監聽畫面關閉（sheet／月份頁／訂單頁 pop）即 dispose、重開會重建並重打後端；repo 是唯一 choke point 且是 singleton，才能真正跨畫面命中（來回重開同一筆明細 = 0 read）。
- **`view/orders_view.dart`**：watch `ordersProvider(bnb.id ?? 0)`，AppBar 顯示民宿名。
- **`widget/orders_widget.dart`**（民宿摘要列表）：
  - 摘要卡：月份／年份徽章（今年藍、歷年藍灰）＋「N 筆訂單」＋營收金額（`MoneyText`，NT$5.8萬 樣式，點一下完整金額）；整張卡 `InkWell` 可點
  - **今年月份卡再點擊進入 `view/month_orders_view.dart` 的當月明細頁**（年份卡不可點）
  - 區段標題「今年 N 個月」／「歷年 N 年」＋空狀態；日期不重複顯示（有徽章即可）
  - **營收只計 `countsAsRevenue == true` 的有效狀態，訂單數仍計入全部狀態**（取消/候補照樣列出）
- **`view/month_orders_view.dart`**（當月訂單明細頁，從摘要的今年月份卡進入）：統計卡（訂單數／總營收／訂金已收／總晚數）＋依入住日期分組（每日標頭含當日營收）＋彩色狀態徽章訂單卡（取消單淡化）＋**進頁時 watch `bnbOrderReferencesProvider(bnbId)` 整批載入房型＋通路段**（兩者小而近靜態，一次涵蓋整月所有卡片；載入完成前卡片先顯示 `房型 #id`／`來源 #id`，完成後自動換成名稱）＋點卡開 bottom sheet 顯示完整明細（**客戶姓名＋電話**由 `customerInfoProvider` 在 sheet 開啟時才 lazy 載入，失敗/查無退回 `#id`；房型、來源以名稱顯示；訂單編號可複製）＋空狀態。**客戶資訊只在點入明細後才讀取與顯示**——摘要與月份列表完全不付客戶的讀取成本。

---

## 7. 資料庫設計（`database_schema.sql`）

MySQL 5.7+／8.0+／MariaDB 相容，共 **16 張表**：

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

> 對照：`holidays` 含 `tep`（時間電價假日，0/1）欄位——舊 MySQL 有、migrate.ts 有遷移；後端寫入路由（`/storeHoliday`、`/holidays/storeList`）已補上持久化 `tep`，且會把 `date` 正規化為純 `yyyy-MM-dd`（避免年份邊界字串比較漏件）。`tep` 由 admin 手動標，政府匯入資料一律 `0`。
> `solars`（二十四節氣）原只有讀取、無維護管道，已補上 `/getsolars`、`/storeSolar`、`/solars/destroy/:id`、`/solars/generateYear` 與 admin 節氣維護 Tab（見 §6.3.1）；節氣可由天文演算法（`lunar-javascript`）自動產生整年，人工維護保留為後門。節氣**無** `tep` 欄位。

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
| 已修正 | `lib/app/features/activity/` 練習頁模組已整目錄移除（dashboard 分頁早在重排時改為 BnB/假日/節氣） |
| 多處 TODO | `user_view.dart`、`user_widget.dart`、`plugin / repository` 空殼 |
| 已修正 | 舊專案殘料已清：`AppConfig.projectName("療管家")`、`ApiConstants` 的 classes/kids/courses 等無關 key 已刪除；`Constants`/`ClassRes` 整組移除；`ResCode` 有引用保留 |
| 已修正 | `Holidays.desroy` 拼字已改為 `destroy` |
| 已修正 | `tep` 欄位：後端 `/storeHoliday`、`/holidays/storeList` 已持久化 `tep`；`date` 正規化為純日期（解 12/31 邊界） |
| 已修正 | `solars`（節氣）原先沒有維護 API 與介面：後端補上 `/getsolars`、`/storeSolar`、`/solars/destroy/:id`；admin 新增節氣維護 Tab（§6.3.1）。節氣可由 `lunar-javascript` 天文演算法自動產生整年（`/solars/generateYear` + `/getsolars` lazy 自癒），人工維護保留為後門 |
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
| POST | `/getsolars` | 依年份取節氣（body: `{thisYear}`，不需登入；該年無資料時自動產生） | solar impl |
| POST | `/solars/generateYear` | 依年份自動產生／覆寫 24 節氣（body: `{thisYear}`，天文演算法） | solar impl |
| POST | `/storeSolar` | 新增／更新單筆節氣（body: `{solar}`） | solar impl |
| DELETE | `/solars/destroy/{id}` | 刪除節氣 | solar impl |
| GET | `/getAllBnbs` | 取全部民宿（附 `orders_count` 與 `revenue_effective`——有效營收只計預訂/付訂/付清） | bnb impl |
| GET | `/getAllOrdersByBnb/{bnbId}` | 取某民宿的所有訂單（裸資料，不做關聯載入） | orders impl |
| GET | `/getOrderReferences/{bnbId}` | 取民宿的房型＋通路段（供月份明細頁整批對照，小量） | orders impl |
| GET | `/getCustomer/{customerId}` | 取單筆客戶（訂單明細開啟時才讀，1 read；查無回 `customer: null`） | customers impl |
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