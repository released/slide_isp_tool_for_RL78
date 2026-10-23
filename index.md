<!-- GUIDE_OVERVIEW -->
[知識庫首頁](https://released.github.io/)

<a id="article_top"></a>

# RL78 ISP Tool 與 MCU bridge 操作

FirmwareUpgradeTool 透過 MCU bridge 連接 device，依需求選擇下載、操作、更新或通訊驗證。
Device Boot／App 開發見 [Bootloader 指南](../slide_boot_loader_for_RL78/)。

## 主題指南

| 主題 | 內容 |
| --- | --- |
| [下載與韌體產物](downloads.html) | Tool、Host 與 Device 原始碼、安裝檔及更新 BIN。 |
| [Tool 連線與操作](operation.html) | COM／Host 識別、畫面、接線、更新政策與錯誤資訊。 |
| [欄位、更新確認與報告](status-and-reports.html) | BIN／live 資料、狀態訊息、進度、取消及 HTML 更新報告。 |
| [CAN／CAN FD App 更新](can-update.html) | Classical CAN：F13／F24；CAN FD：F24。 |
| [CAN 更新逐層導讀](can-protocol.html) | 對照 Tool、MCU CAN host 與 MCU CAN device 的資料流。 |
| [UART／Xmodem／I2C 操作](serial-isp.html) | 接線、可調通訊設定、App 更新及串列通訊測試。 |
| [Custom Transfer 通訊驗證](custom-transfer.html) | F13／F24 Classical CAN 與 F24 CAN FD 的獨立通訊測試。 |
| [MCU host 韌體與自身更新](host-firmware.html) | Misc／UART 更新 Host App，以及 Host 工程與向量設定。 |
| [MCU device 工程入口](device-guides.html) | Boot／App、Metadata、IRQ 與移植的主題連結。 |

## CAN 範例分類

<!-- ISP_MODE_NAV_BEGIN -->
| 分類 | MCU device 範例 | 操作入口 |
| --- | --- | --- |
| Classical CAN | F13／F24 | [App 更新與確認](can-update.html#f13-device-update) |
| CAN FD | F24 | [App 更新與確認](can-update.html#can-fd-update) |
| Custom Transfer | F13／F24 Classical CAN；F24 CAN FD | [範例分類與通訊測試](custom-transfer.html#custom-transfer) |
<!-- ISP_MODE_NAV_END -->

<!-- RH850_DEVICE_BEGIN -->
<!-- RH850_DEVICE_END -->
