# 圖片／影片提示詞編輯器

本專案是一套用於 AI 圖片與 AI 影片生成的提示詞編輯器，目標是讓使用者透過選項快速組合可用 Prompt，降低從零手寫提示詞的成本。

## 專案用途

- 產生圖片生成提示詞。
- 產生影片生成提示詞。
- 支援文生圖、圖生圖、修改／置換圖片、圖生文、提示詞優化。
- 支援文生影片、圖生影片、修改／置換影片、影片分鏡提示詞、影片轉文字、提示詞優化。
- 透過固定欄位整理主體、場景、動作、構圖、鏡頭、光線、材質、色彩、風格、用途、比例、品質要求與排除條件。
- 影片版額外支援技術規格、品質審查、聲音設定、分鏡／參考圖結構。

## 主要成果

- Windows WinForms 版：
  - `Image_Video_PromptEditor.bat`
  - `Image_Video_PromptEditor.ps1`
  - `Image_Video_PromptEditor1.bat`
  - `Image_Video_PromptEditor1.ps1`
- Web 版：
  - `ImagePromptEditor_FirebaseWeb/`
  - `docs/`
- Firebase Hosting 版曾發布於：
  - `https://visual-prompt-editor.web.app`
- GitHub Pages 發布資料夾：
  - `docs/`
- GitHub Pages 預期網址：
  - `https://hou-yuch.github.io/visual-prompt-editor/`

## Web 版結構

```text
ImagePromptEditor_FirebaseWeb/
  public/
    index.html
    app.js
    styles.css
  firebase.json
  README.md

docs/
  index.html
  app.js
  styles.css
  .nojekyll
```

`ImagePromptEditor_FirebaseWeb/public/` 是 Firebase Hosting 用版本。  
`docs/` 是 GitHub Pages 用版本。

## 核心功能

- 下拉選單快速選擇提示詞欄位。
- 所有下拉選項支援空白欄，避免強制預設值。
- 依模式自動加入「開頭標示」，讓 AI 知道目前任務類型。
- Negative Prompt 用於告訴模型不要生成什麼。
- Web 版支援複製、另存 TXT、清除。
- 影片分鏡支援依參考圖數量自動產生畫面、鏡頭、動作、聲音。

## 影片分鏡

影片版支援：

```text
15. 分鏡 / 參考圖
```

可選：

- 無分鏡，單一連續鏡頭
- 1圖：單鏡頭延伸
- 2圖：起點／終點
- 3圖：開場／發展／收尾
- 4圖：開場／發展／高潮／收尾
- 5圖：開場／建立／發展／高潮／收尾
- 6圖：開場／建立／發展／轉折／高潮／收尾

輸出會自動產生：

```text
畫面：
鏡頭：
動作：
聲音：
```

## Firebase 與 GitHub Pages

本專案目前主要是靜態前端工具，不需要後端資料庫即可運作。

- Firebase Hosting：適合作為正式版、長期網址或後續串接 Firebase 服務。
- GitHub Pages：適合作為公開原始碼專案的展示頁。

目前若以 GitHub Pages 為主，可維護 `docs/` 內容並透過 GitHub Pages 發布。

## 不屬於目前實作範圍

以下項目不是本專案目前已完成的功能，但可作為未來擴充方向：

- 公開報名頁
- 管理頁
- Firebase Firestore 報名資料模型
- 草稿、發布快照、報名資料
- 多活動管理
- 公開姓名
- 報名編號修改／取消
- 手機登入
- 固定管理員
- 名額競態控制
- LINE 分享流程

## 開發與維護

常用 Git 流程：

```powershell
git status
git add .
git commit -m "更新內容"
git push
```

GitHub Pages 更新流程：

```powershell
git add docs
git commit -m "更新 GitHub Pages 網頁"
git push
```

## 下一階段建議

- 統一 Web 版與 WinForms 版的欄位資料來源。
- 將圖片、影片、聲音、分鏡選項抽成 JSON 設定檔。
- Web 版加入版本號與 changelog。
- 若未來需要帳號、草稿、發布、活動報名等功能，再正式導入 Firebase Auth、Firestore 與安全規則。
- 若要避免 Cloud Functions Blaze 成本，優先使用純前端、Firestore 規則與 GitHub Pages/Firebase Hosting。
