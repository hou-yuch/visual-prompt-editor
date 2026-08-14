# DEVELOPMENT HISTORY

本文件以資深工程師角度整理本專案從起點、需求收斂、錯誤修正、Web 化、部署到 GitHub 的完整開發過程。內容以目前專案中可追溯的實作為準；部分使用者列出的「公開報名頁、管理頁、報名資料」等需求並非本專案目前功能，已在對應章節標示為未實作或未來擴充方向。

## 1. 專案起點與需求收斂

專案起點是 `666S.bat`，原本定位為 PowerShell WinForms 圖片生成提示詞編輯器。

初始需求：

- 修正 PowerShell parser error。
- 保留原始 `666S.bat`。
- 建立新版提示詞編輯器。
- 將圖片提示詞欄位標準化。
- 後續擴充為圖片、影片、聲音、分鏡整合工具。

需求逐步收斂為：

- 圖片生成提示詞編輯器。
- 影片生成提示詞編輯器。
- 影片分鏡／參考圖結構。
- 聲音設定。
- Web 版部署。
- GitHub Pages 發布。

重要決策：

- 原始 `666S.bat` 保留，不直接覆蓋。
- 新版用新檔名區分，例如 `666S_13.bat`、`ImagePromptEditor_hi.bat`、`Image_Video_PromptEditor.bat`、`Image_Video_PromptEditor1.bat`。
- 程式逐步從 WinForms 版擴充到 Web 版。

## 2. 早期錯誤修正

最初的 PowerShell 問題：

- 第 39 行 `try {` 缺少結束結構。
- 第 632 行 `Try` 遺漏 `Catch` 或 `Finally`。
- 根因是 `Build-MetaPrompt` 函式未正確關閉。

修正策略：

- 補齊 `Build-MetaPrompt` 的回傳邏輯。
- 補上結束大括號。
- 使用 PowerShell Parser 做靜態解析。

驗證結果：

```text
PowerShell Parser: OK
```

## 3. 固定欄位、場景欄位與驗證規則

圖片提示詞固定為 13 項：

1. 主體
2. 場景
3. 動作
4. 構圖
5. 鏡頭
6. 光線
7. 材質
8. 色彩
9. 風格
10. 用途
11. 比例
12. 品質要求
13. 排除條件

影片提示詞擴充為：

- 主體
- 場景
- 動作
- 劇情／事件
- 鏡頭運動
- 構圖
- 光線
- 材質／質感
- 色彩
- 風格
- 影片用途
- 比例
- 時長
- 節奏
- 分鏡／參考圖
- 品質要求
- 排除條件

驗證規則：

- PowerShell 檔案以 Parser 靜態解析確認語法。
- Web 版以 Node `--check` 檢查 `app.js` 語法。
- 下拉選項逐步改成支援空白值，避免工具替使用者強制選擇。
- 技術規格保留「預設」選項。
- 專業品質審查初始值改為空白，避免輸出過度堆疊。

## 4. 編輯器、公開報名頁、管理頁的開發階段

### 編輯器

本專案已實作的核心是「提示詞編輯器」：

- WinForms 圖片編輯器
- WinForms 圖片＋影片整合編輯器
- Web 圖片＋影片整合編輯器
- 影片分鏡結構
- 聲音設定

### 公開報名頁

目前未實作。

若未來要擴充為活動報名系統，公開報名頁應負責：

- 顯示活動資訊
- 顯示可報名名額
- 收集報名欄位
- 驗證重複報名
- 產生報名編號

### 管理頁

目前未實作。

若未來擴充，管理頁應負責：

- 活動建立與發布
- 報名資料查詢
- 報名修改／取消
- 匯出資料
- 固定管理員權限控管

## 5. Firebase 架構與資料模型

目前實作：

- Firebase Hosting 靜態部署。
- 無 Firebase Auth。
- 無 Firestore。
- 無 Cloud Functions。
- 無 Storage。

既有 Firebase 相關資料夾：

```text
ImagePromptEditor_FirebaseWeb/
  firebase.json
  .firebaserc
  public/
```

目前資料模型：

- 無後端資料模型。
- Web 版資料存在於前端 JavaScript 常數。
- 使用者輸出不會寫入雲端。

若未來擴充為報名系統，建議資料模型：

```text
events/{eventId}
drafts/{draftId}
publishedSnapshots/{snapshotId}
registrations/{registrationId}
admins/{uid}
```

## 6. 草稿、發布快照及報名資料的差異

目前未實作草稿、發布快照與報名資料。

若未來擴充，建議定義如下：

- 草稿：管理員尚未公開的編輯狀態。
- 發布快照：使用者看到的正式活動版本。
- 報名資料：使用者針對某個發布快照提交的資料。

設計重點：

- 報名資料應綁定發布快照，而不是直接綁草稿。
- 草稿修改不應回頭影響已報名資料。
- 發布快照可追溯當時公開內容。

## 7. 多活動管理、公開姓名、報名編號修改／取消

目前未實作。

若未來擴充：

- 多活動管理應以 `eventId` 作為主要隔離鍵。
- 公開姓名應讓使用者明確同意。
- 報名編號應由系統產生，不建議人工輸入。
- 修改／取消報名要保留紀錄，避免資料不可追溯。
- 若有名額限制，取消報名需回補名額。

## 8. LINE 免費分享方案

目前未實作。

若未來要支援免費分享，建議先採用純前端分享連結：

- 使用 LINE Share URL。
- 不建 LINE Bot。
- 不使用 Messaging API。
- 不需要 Cloud Functions。

可行方向：

```text
https://social-plugins.line.me/lineit/share?url={encodedUrl}
```

優點：

- 免費。
- 不需要後端。
- 適合 GitHub Pages 或 Firebase Hosting 靜態網站。

限制：

- 無法主動推播。
- 無法追蹤使用者是否真的分享。

## 9. Cloud Functions 因 Blaze 要求而撤回的過程

目前專案未使用 Cloud Functions。

架構上曾討論 Firebase 作為正式版長期部署，但因目前需求可由靜態網站完成，因此沒有導入 Cloud Functions。

工程判斷：

- Cloud Functions 會讓專案從純前端變成有後端維運成本。
- Firebase Cloud Functions 通常需要 Blaze 方案。
- 目前工具不需要伺服器端執行邏輯。
- 因此保留 Firebase Hosting／GitHub Pages 靜態部署即可。

結論：

- Cloud Functions 暫不導入。
- 需要帳號、名額競態、報名交易時再評估。

## 10. 日期重疊、欄位取消、參加人數、圖片網址等錯誤修正

本專案目前不是活動報名系統，因此以下項目未出現在目前實作：

- 日期重疊
- 欄位取消
- 參加人數
- 圖片網址

若未來擴充為活動報名系統，建議驗證規則：

- 日期不可結束早於開始。
- 多活動日期重疊是否允許需明確定義。
- 欄位取消不得破壞既有報名資料。
- 參加人數必須是正整數。
- 圖片網址需檢查格式與來源。
- 若使用外部圖片網址，需考慮 CORS、失效與授權。

## 11. Firebase 管理帳號與手機登入處理

目前未實作 Firebase Auth。

若未來需要管理頁，建議：

- 使用 Firebase Authentication。
- 管理員白名單寫在 Firestore 或環境設定中。
- 手機登入可用 Google 登入或 Email link。
- 不建議只靠前端隱藏管理頁。

固定管理員限制：

- 靜態網站無法安全保護管理權限。
- 真正管理權限必須由 Firebase Auth 與 Firestore Security Rules 控制。

## 12. 部署與正式環境驗證程序

### Firebase Hosting

已建立 Firebase Hosting 用 Web 版：

```text
ImagePromptEditor_FirebaseWeb/
```

曾發布：

```text
https://visual-prompt-editor.web.app
```

驗證程序：

- 檢查 `firebase.json`。
- 檢查 `public/index.html`。
- 檢查 `public/app.js`。
- 發布後使用版本參數避免快取。

### GitHub Pages

已建立：

```text
docs/
```

部署流程：

```powershell
git add docs
git commit -m "新增 docs 網頁發布檔"
git push
```

GitHub Pages 設定：

```text
Settings → Pages → Deploy from a branch → main → /docs → Save
```

預期網址：

```text
https://hou-yuch.github.io/visual-prompt-editor/
```

正式環境驗證：

- 首頁是否能載入。
- 圖片模式是否可產生提示詞。
- 影片模式是否可產生提示詞。
- 分鏡選項是否輸出分鏡段落。
- 複製與另存 TXT 是否正常。
- 手機版是否可操作。

## 13. 個資、安全、名額競態及固定管理員等現有限制

目前專案為靜態工具，限制如下：

- 不儲存個資。
- 不提供使用者登入。
- 不提供管理員權限。
- 不提供報名名額控管。
- 不處理名額競態。
- 不提供伺服器端資料驗證。
- 不支援多人協作資料同步。

安全現況：

- 因為沒有後端資料庫，個資風險低。
- 因為沒有帳號系統，不存在管理員權限保護。
- 若未來加入報名資料，必須重新設計安全架構。

## 14. 資深工程師角度的下一階段建議

建議優先順序：

1. 統一 WinForms 與 Web 版選項資料來源。
2. 將選項抽成 JSON，例如 `prompt-options.json`。
3. 建立版本管理規則，避免 BAT、PS1、Web 三套內容不同步。
4. Web 版加入匯入／匯出設定。
5. Web 版加入本機儲存草稿，但先不要上雲端。
6. 若未來要帳號與管理頁，再導入 Firebase Auth。
7. 若未來要報名功能，再導入 Firestore 與 Security Rules。
8. Cloud Functions 只在真的需要交易、通知、伺服器驗證時導入。
9. GitHub Pages 與 Firebase Hosting 擇一作為正式入口，另一個作為備援。
10. 每次正式發布前做 smoke test。

技術債：

- WinForms 版與 Web 版邏輯重複。
- BAT 與 PS1 需同步維護。
- 部分輸出仍偏文字堆疊，未來可加入模板系統。
- 目前無自動化測試。

## 15. 維護與交接檢查清單

### 檔案檢查

- `Image_Video_PromptEditor.bat`
- `Image_Video_PromptEditor.ps1`
- `Image_Video_PromptEditor1.bat`
- `Image_Video_PromptEditor1.ps1`
- `ImagePromptEditor_FirebaseWeb/public/app.js`
- `docs/app.js`
- `README.md`
- `DEVELOPMENT-HISTORY.md`

### 發布前檢查

- PowerShell Parser 是否 OK。
- Web `app.js` 語法是否 OK。
- 圖片模式可產生提示詞。
- 影片模式可產生提示詞。
- 分鏡模式可產生分鏡結構。
- 聲音設定可輸出。
- 清除、複製、另存 TXT 可用。
- Git 狀態乾淨。

### Git 流程

```powershell
git status
git add .
git commit -m "更新內容"
git push
```

### GitHub Pages 更新

```powershell
git add docs
git commit -m "更新 GitHub Pages 網頁"
git push
```

### 交接重點

- 本專案目前主體是 AI 圖片／影片提示詞編輯器。
- 報名系統相關內容目前不是已實作功能。
- Firebase 目前僅作為 Hosting 思路，沒有後端資料庫。
- GitHub Pages 使用 `docs/` 發布。
- 若未來導入帳號、報名、管理頁，需重新設計資料模型、安全規則與部署流程。
