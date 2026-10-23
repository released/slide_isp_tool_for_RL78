[知識庫首頁](https://released.github.io/) · [RL78 ISP Tool 與 MCU bridge 操作](index.html)

<a id="article_top"></a>

# MCU device 工程入口

Boot／App、Metadata、IRQ 與移植的主題連結。

## Device firmware 與工程說明

<a id="f13-boot-flow"></a>

<!-- F13_BOOT_DECISION_BEGIN -->
<a id="f13-boot-decision"></a>

## F13 (MCU CAN device)：Boot 啟動與更新狀態

Boot 啟動檢查、ENTER marker、30 秒 inactivity 與更新完成後的啟動路徑集中於 Bootloader 頁。
[閱讀完整章節](https://released.github.io/slide_boot_loader_for_RL78/#f13-boot-decision)
<!-- F13_BOOT_DECISION_END -->

<!-- F24_DEVICE_BEGIN -->
<a id="f24-can-device"></a>

## F24 (MCU CAN device)：工程配置

F24 CAN device 提供 Transfer、Boot 與 App 工程。板端時鐘、Flash 配置與 RFD 說明集中於 Bootloader 頁。
[閱讀完整章節](https://released.github.io/slide_boot_loader_for_RL78/#f24-can-device)
<!-- F24_DEVICE_END -->

<!-- DEVICE_WORKSHOP_BEGIN -->
<a id="device-metadata-vector-workshop"></a>

## Device App：Metadata 與 IRQ 設定

F13 與 F24 CAN device 使用兩份 C header 管理映像資訊與中斷對應，並共同作為後續 MCU 的工程基準。完整範例、產生命令及驗證步驟集中於 Bootloader 頁；不同 BIN 大小的等待時間見 [App 更新耗時參考](https://released.github.io/slide_boot_loader_for_RL78/#device-update-timing)。
[閱讀完整章節](https://released.github.io/slide_boot_loader_for_RL78/#device-metadata-vector-workshop)
<!-- DEVICE_WORKSHOP_END -->

<!-- FD_DEVICE_BEGIN -->
<a id="can-fd-device-engineering"></a>

## MCU CAN FD device 工程設定

CAN FD Boot/App設定來源、timing、metadata、建置與產物集中於Device指南。
[閱讀完整章節](https://released.github.io/slide_boot_loader_for_RL78/#can-fd-device-engineering)
<!-- FD_DEVICE_END -->

<!-- SERIAL_DEVICE_GUIDE_BEGIN -->
<a id="serial-device-engineering"></a>

## MCU 串列 ISP 工程配置

F13／F24／G16／G22 UART、I2C與Xmodem的獨立工程、C header、Flash／IRQ、metadata與封包契約集中於Bootloader頁。
[閱讀完整章節](https://released.github.io/slide_boot_loader_for_RL78/#serial-device-engineering)
<!-- SERIAL_DEVICE_GUIDE_END -->

---

[上一主題：MCU host 韌體與自身更新](host-firmware.html) · [指南入口](index.html)
