# Image Prompt Editor Firebase Web

這是圖片 / 影片提示詞編輯器的 Firebase Hosting 網頁版。

## 檔案結構

- `public/index.html`：主畫面
- `public/styles.css`：版面樣式
- `public/app.js`：提示詞產生邏輯
- `firebase.json`：Firebase Hosting 設定

## 本機預覽

可直接開啟：

```text
public/index.html
```

若已安裝 Firebase CLI，也可使用：

```bash
firebase serve
```

## 部署到 Firebase Hosting

1. 安裝 Firebase CLI。
2. 登入 Firebase。
3. 在本資料夾內設定專案。
4. 部署。

```bash
npm install -g firebase-tools
firebase login
firebase init hosting
firebase deploy
```

若已經有 Firebase 專案，可將 `.firebaserc.example` 複製成 `.firebaserc`，再把 `your-firebase-project-id` 改成你的專案 ID。

## 目前版本

- 純前端靜態網頁。
- 不需要資料庫。
- 支援複製、下載 TXT、清除。
- 支援圖片提示詞與影片提示詞。
- 影片提示詞包含技術規格、品質審查、聲音設定。
