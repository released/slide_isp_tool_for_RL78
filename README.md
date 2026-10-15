# RL78 ISP Tool 操作指南

- 網頁入口：<https://released.github.io/slide_isp_tool_for_RL78/>
- 可編輯內容：`index.md`；網頁載入入口：`index.html`。
- 共用版型：`/notices_can/assets/style.css`、`app.js`、Markdown／Mermaid與側邊目錄。
- 實際截圖與驗證要求：`SCREENSHOT_CHECKLIST.md`；不可用模型圖冒充操作證據。

本頁說明Host／Device識別、共用BIN／metadata／log、CAN更新、I2C探索，
以及Misc透過UART更新Host App。公開導覽與介紹使用功能導向文字，
不綁定Tool／firmware版號、交付階段或單次效能數字。精確版本與SHA-256
由各交付套件說明提供；協定、metadata、IRQ ABI與硬體限制仍須明確保留。

現行CAN範例固定標示 F24 (MCU CAN host)、F13 (MCU CAN device)。後續
F24 (MCU CAN device) 須另列專案與下載，不把型號當成角色或更新權限。

## 共用內容維護

以下區塊由Tool專案的canonical MD同步，不直接修改網頁中的複本：

| 主題 | 原稿與同步腳本 |
| --- | --- |
| Tool→F24→F13 操作／驗證／decode 對照教學 | `docs/CAN_UPDATE_WALKTHROUGH_zh-TW.md` 的 `CAN_WALKTHROUGH` 區塊；`sync_can_update_walkthrough.ps1` 同步本頁 `#can-update-walkthrough` |
| Flash／metadata每byte address／CAN格式與範例程式 | `docs/FLASH_METADATA_CAN_FRAME_GUIDE_zh-TW.md`；`sync_flash_reference.ps1`同步Bootloader頁，本頁連至該入口 |
| 下載與六個操作／流程圖入口 | [Tool原稿](https://github.com/released/simple_renesas_isp_tool/blob/main/docs/MULTIBUS_TOOL_GUIDE_zh-TW.md)的`PUBLIC_RESOURCES`區塊；`sync_public_resources.ps1`同步兩頁，網站從`#downloads`開始 |
| Boot/App移植入口 | `docs/RL78_BOOT_APP_PORTING_GUIDE_zh-TW.md`；`sync_rl78_porting_guide.ps1`同步Bootloader頁，本頁連至`#boot-app-porting` |
| F13 Boot→App／ENTER／逾時 | `docs/F13_BOOT_UPDATE_FLOW_zh-TW.md`；`sync_f13_boot_decision.ps1` |
| F24 App獨立IRQ產表 | `docs/SHARED_CONSOLE_BRIDGE_GUIDE_zh-TW.md`；`sync_f24_app_irq_guide.ps1` |
| 共用metadata／跨介面防呆 | `docs/COMMON_IMAGE_METADATA.md`；`sync_common_image_policy.ps1` |

同步後執行各腳本的`-CheckOnly`。功能變更須一併更新相關MD／PDF、操作步驟、
支援／封鎖範圍與截圖清單；未驗證的UI或實板功能仍需清楚註記，不能因移除
編輯狀態字樣而宣稱所有功能已完成。

同步腳本位於[Tool scripts](https://github.com/released/simple_renesas_isp_tool/tree/main/scripts)。
透過`-WebRoot`或`FIRMWARE_WEB_ROOT`指定包含各網站checkout的父目錄；預設為Tool的父目錄。
下載入口區分首次燒錄Boot與後續App BIN更新，不可互換Host／Device映像。

## 本機預覽與檢查

在包含sibling資料夾的web根目錄啟動read-only HTTP server：

```powershell
python -m http.server 18670 --bind 127.0.0.1
```

開啟`http://127.0.0.1:18670/slide_isp_tool_for_RL78/`。
不可直接使用file://，renderer需要fetch；marked／Mermaid CDN需網路。

`scripts/verify_local.ps1 -PreviewBase <local URL> -ToolRoot <Tool專案目錄>`
檢查本機引用、HTTP routes、產品名稱、ISP入口超連結與通用導覽文字；
刻意不要求網頁列出當前build版號。這些檢查不代替browser外觀、DPI或板測。

截圖與log須先檢查個人路徑、序號及不必要資料；部署另依網站既有流程處理。
