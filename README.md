# RL78 ISP Tool 操作指南

- 網頁入口：<https://released.github.io/slide_isp_tool_for_RL78/>
- 內容：`index.md`；載入入口：`index.html`。
- 共用版型：`/notices_can/assets/style.css`、`app.js`。
- 截圖資料：`SCREENSHOT_CHECKLIST.md`。

本頁包含 Tool 連線、共用 BIN／metadata／log、Custom Transfer、CAN device App 更新、I2C 探索及 Misc Host App 更新。
公開導覽使用功能名稱；量測版本與雜湊由交付紀錄提供。

## 主題維護

編寫與驗收依據為 [公開文件編寫準則](PUBLIC_CONTENT_GUIDELINES_zh-TW.md)。
共用原稿位於 `/web` 根目錄，適用目前與未來各類 slide；此處為獨立 repository 的同步副本。
規範同步由 `/web/scripts/sync_public_content_guidelines.ps1` 維護，並可使用 `-CheckOnly` 檢查。

原稿位於 [Tool docs](https://github.com/released/simple_renesas_isp_tool/tree/main/docs)。
`scripts/web_guide_sections.json` 定義主題歸屬。
同步後，完整章節只保留在所屬頁面，其他頁面使用跳轉連結。

| 本頁完整章節 | 原稿／同步腳本 |
| --- | --- |
| 下載與操作入口 | MULTIBUS_TOOL_GUIDE 的 PUBLIC_RESOURCES／sync_public_resources.ps1 |
| Tool→MCU CAN host→MCU CAN device 逐層導讀 | CAN_UPDATE_WALKTHROUGH／sync_can_update_walkthrough.ps1 |
| Host App 工程與向量設定 | SHARED_CONSOLE_BRIDGE_GUIDE 的 F24_APP_IRQ／sync_f24_app_irq_guide.ps1 |
| COM／Device App／Host App 操作圖 | SHARED_CONSOLE_BRIDGE_GUIDE 的 TOOL_*_MEDIA／sync_tool_operation_media.ps1 |
| 更新政策與通訊速度 | COMMON_IMAGE_METADATA／sync_common_image_policy.ps1 |
| Custom Transfer 診斷欄位與錯誤統計 | MULTIBUS_TOOL_GUIDE 的 TRANSFER_DIAGNOSTICS／sync_transfer_diagnostics.ps1 |
| F24 device Custom Transfer 操作圖 | MULTIBUS_TOOL_GUIDE 的 CUSTOM_TRANSFER_MEDIA／sync_custom_transfer_media.ps1 |

Device metadata／vector 編輯、各 device 工程、Boot decision、移植及逐 byte 參考集中於
[MCU CAN device 頁](https://released.github.io/slide_boot_loader_for_RL78/)。

修改原稿後執行同步及 `-CheckOnly`，同步相關 PDF。
操作圖原稿位於 Tool 的 `docs/images/tool_operation`；同步腳本同時核對三段說明與16張公開副本的 SHA-256。
F24 device 的更新報告與 UART counter 位於 `#f24-device-update-example`，正常 CAN App 更新流程已完成實板驗證。
頁面只使用遮蔽本機路徑的副本；圖片可點選開啟原尺寸。
Custom Transfer 的四張公開圖位於 Tool `docs/images/custom_transfer`，由專用同步腳本核對文字與圖片 SHA-256。
使用 `-WebRoot` 或 `FIRMWARE_WEB_ROOT` 指定網站 checkout 父目錄。

## 預覽與檢查

以現有 HTTP server 預覽網站；renderer 使用 fetch，不採 file://。
執行 `scripts/verify_local.ps1 -PreviewBase <local URL> -ToolRoot <Tool checkout>`
檢查本機引用、章節連結、HTTP routes 與產品名稱，不綁定 build 版號。
瀏覽器／DPI 外觀及硬體測試分別記錄。

截圖與 log 先檢查個人路徑、序號及不必要資料，再依網站既有流程部署。
