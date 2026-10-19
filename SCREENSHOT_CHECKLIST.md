# ISP 操作圖與擷取核對

## 已提供的操作圖

以下14張操作圖來自使用者提供的實際畫面。
公開副本僅遮蔽本機檔案／報告路徑，保留 MCU、模式、metadata、按鈕、狀態與完成訊息。
圖片中的版本、COM、size 與耗時是範例，不是固定操作參數。

| 操作圖 | 對應內容 |
| --- | --- |
| [tool_connect_COM.jpg](images/tool_operation/tool_connect_COM.jpg) | Probe Host 成功；同時說明 Misc 載入 CAN BIN 的目的地拒絕 |
| [tool_CAN_update1_load_image.jpg](images/tool_operation/tool_CAN_update1_load_image.jpg) | Device BIN 離線解析 |
| [tool_CAN_update2_discover_target.jpg](images/tool_operation/tool_CAN_update2_discover_target.jpg) | Discover 回報 App 模式 |
| [tool_CAN_update3_enter_boot.jpg](images/tool_operation/tool_CAN_update3_enter_boot.jpg) | ENTER 後確認 Boot Ready |
| [tool_CAN_update4_start_update.jpg](images/tool_operation/tool_CAN_update4_start_update.jpg) | 更新確認視窗與範圍 |
| [tool_CAN_update5_during_update.jpg](images/tool_operation/tool_CAN_update5_during_update.jpg) | CAN 更新階段與進度 |
| [tool_CAN_update6_after_update.jpg](images/tool_operation/tool_CAN_update6_after_update.jpg) | App 已確認、CAN 已停止、COM 保留 |
| [tool_Bridge_update1_load_image.jpg](images/tool_operation/tool_Bridge_update1_load_image.jpg) | Misc Host BIN 與 UART 契約 |
| [tool_Bridge_update2_enter_boot.jpg](images/tool_operation/tool_Bridge_update2_enter_boot.jpg) | ENTER Host Boot 的明確確認 |
| [tool_Bridge_update3_enter_boot.jpg](images/tool_operation/tool_Bridge_update3_enter_boot.jpg) | 同 COM 重連確認 Host Boot |
| [tool_Bridge_update4_start_update.jpg](images/tool_operation/tool_Bridge_update4_start_update.jpg) | Host App 更新確認 |
| [tool_Bridge_update5_after_update.jpg](images/tool_operation/tool_Bridge_update5_after_update.jpg) | 寫入完成、仍需 RUN |
| [tool_Bridge_update6_run_valid.jpg](images/tool_operation/tool_Bridge_update6_run_valid.jpg) | 明確執行 RUN |
| [tool_Bridge_update7_update_finish.jpg](images/tool_operation/tool_Bridge_update7_update_finish.jpg) | RUN 後重連並確認 Host App |

說明原稿為 Tool 的 SHARED_CONSOLE_BRIDGE_GUIDE。
sync_tool_operation_media.ps1 同步三段 TOOL_*_MEDIA 與公開圖；-CheckOnly 核對文字及 SHA-256。
網站入口為 #tool-connect-example、#device-update-example、#bridge-update-example。
原圖保留於 Tool 本機的 tmp/private_screenshots，不用原圖取代公開副本。

既有 [PCAN benchmark](img/benchmark_pcan.jpg) 與 [MCU TRACE](img/benchmark_mcu_log.jpg)
屬於 Custom Transfer 通訊範例，與 App 更新操作圖分開使用。

## Custom Transfer：F24 MCU CAN device

四張操作圖集中於 [Custom Transfer 範例](https://released.github.io/slide_isp_tool_for_RL78/#f24-custom-transfer-example)，與 App 更新操作圖分開使用。

| 公開圖 | 可觀察內容 |
| --- | --- |
| [CAN_custom_transfer_1.png](images/custom_transfer/CAN_custom_transfer_1.png) | Tool 選擇 Custom Transfer、device 尚未探索 |
| [CAN_custom_transfer_mcu_log_1.png](images/custom_transfer/CAN_custom_transfer_mcu_log_1.png) | DEVICE_INFO sequence 1..7、target／part prefix／CRC |
| [CAN_custom_transfer_2.png](images/custom_transfer/CAN_custom_transfer_2.png) | Live F24 device 身分、Transfer Test 成功及 host／device counters |
| [CAN_custom_transfer_mcu_log_2.png](images/custom_transfer/CAN_custom_transfer_mcu_log_2.png) | PING／ECHO／PATTERN／GET_STATS sequence 8..22 |

原稿為 MULTIBUS_TOOL_GUIDE 的 CUSTOM_TRANSFER_MEDIA；sync_custom_transfer_media.ps1 同步公開副本。
原圖保留於 Tool 的忽略區域，不隨公開圖片上傳；畫面中的 F13 BIN 是未參與此測試的 OFFLINE 資料。
這組紀錄僅涵蓋正常通訊；CAN 波形、故障注入、恢復及 Flash 更新分別驗證。

## 另外擷取／驗證的情境

16 張操作圖包含 F13 更新步驟，以及 F24 device 的 PASS 報告與更新後 App counter。
正常 CAN App 更新已確認；下列專項情境另外記錄設定、BIN、log／trace 與結果。

| 情境 | 應核對內容 | 狀態 |
| --- | --- | --- |
| 最小視窗／DPI／TAB | 1366×768、100%／125%、無裁切及殘影、footer 完整 | 尚需專項畫面 |
| Auto scroll down | 預設與 INI、暫停後 viewport／選取文字、恢復跟隨 | 尚需互動畫面 |
| ENTER inactivity | 原 App 有效、START 前約30秒閒置返回 App；重新 Discover／Enter | 尚需實板連續紀錄 |
| 錯映像／CRC／政策 | 錯誤原因及 START 前拒絕；只修改測試副本 | 尚需專項畫面 |
| 分段 metadata／CAN raw frames | 完整暫存與驗證、COMMIT／ACK、分析儀 frame／counter | 尚需 trace |
| 連線／供電中斷 | 取消、拔線、重新探索、斷電後 Boot／App 狀態 | 尚需授權的實板測試 |
| Host 高速 UART | 115200／460800／921600、重連、Misc 回115200、錯誤與溢位計數 | 尚需完整測試組 |
| I2C 探索 | 指定 port／address、回報來源、唯讀／BLOCKED 邊界 | 尚需專項畫面 |

一般截圖不觸發未授權的 erase／write；進度100%與App健康／功能驗證分別記錄。

## F24 MCU CAN device：更新完成與執行紀錄

| 公開圖 | 可觀察內容 |
| --- | --- |
| [firmware_update_report.png](images/tool_operation/firmware_update_report.png) | CAN device update PASS、CRC、App 啟動確認、Host COM 保留 |
| [MCU_F24_Device_app_log.png](images/tool_operation/MCU_F24_Device_app_log.png) | boot-validated、CAN update completed、V1 counter 從 0 遞增 |

完整說明集中於 [F24 device 更新結果](https://released.github.io/slide_isp_tool_for_RL78/#f24-device-update-example)。
兩張原圖無本機路徑；公開 PNG 保留全部解碼像素並移除圖片 metadata，原始 JPEG 保存在忽略的私有目錄。
