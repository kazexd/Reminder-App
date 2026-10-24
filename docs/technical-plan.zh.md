# 技術方案

## 技術棧

- Electron 負責 Windows 桌面執行環境及系統整合。
- React 及 TypeScript 負責介面；electron-vite 及 Vite 負責開發及建置。
- SQLite 用於本機持久儲存提示及設定，於下一個功能階段整合。
- electron-builder 配合 NSIS 製作 Windows 安裝程式。自訂安裝頁提供自動啟動選項，預設啟用。
- Vitest 測試邏輯，Playwright 驗證 Electron 啟動，之後擴展至功能操作流程測試。

## 職責分工

主程序負責提示排程、儲存、通知、系統匣及自動啟動設定。React 負責顯示介面。沙箱內的 preload 橋接透過 IPC 提供明確操作，啟用 context isolation 並停用 renderer 的 Node.js。主程序亦必須驗證輸入。

排程器會在啟動及喚醒後重新檢查到期提示。安裝程式及 App 設定必須控制同一個 Windows 自動啟動項目。自動啟動使用背景模式參數。無需伺服器、帳戶或 Windows Service。

## 目前骨架

專案包含桌面視窗、React 佔位畫面、受限的 preload 橋接、提示輸入驗證及單元測試。目前關閉視窗會退出 App。持久儲存、排程、鈴聲、通知、系統匣、自動啟動設定及安裝程式仍屬規劃功能，尚未實作。

## 開發方式

使用 Node.js 22.16 或鎖定依賴所支援的較新版本。執行 `npm ci`，再執行 `npm run dev`。交付前執行 `npm test`、`npm run test:docs` 及 `npm run test:desktop`。桌面測試亦會執行型別檢查及正式建置。建置結果位於 `out/`；目前不會產生安裝程式。

## 下一步

1. 實作 SQLite 儲存及新增、編輯、刪除提示。
2. 加入排程、通知、鈴聲、完成、稍後提醒及錯過提示處理。
3. 加入系統匣及自動啟動設定，再製作 NSIS 安裝程式及 Windows 操作流程測試。

## 參考資料

- [Electron context isolation](https://www.electronjs.org/docs/latest/tutorial/context-isolation)
- [Electron 程序模型](https://www.electronjs.org/docs/latest/tutorial/process-model)
- [electron-builder NSIS](https://www.electron.build/docs/nsis/)
