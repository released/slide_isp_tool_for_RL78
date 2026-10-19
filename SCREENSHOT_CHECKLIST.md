# ISP 操作截圖拍攝清單

截圖與驗證清單；每次擷取需記錄實際Tool與firmware版本。新版UI實際擷取 NOT RUN：Computer Use native pipe
`os error 2`，retry/reset後仍失敗；不可用mockup冒充實際操作圖。

每圖記錄tool version、host FW/build、device firmware、bus/port/rate、BIN
version/size、log/trace、日期與PASS/FAIL。100%/125% DPI及Debug startup assertion
另行驗證。未經具體授權不為拍图觸發erase/write；CRC錯誤只修改測試副本。

| img/檔名 | 情境與重點 | 狀態 |
|---|---|---|
| 01_disconnected.png | 1366×768全畫面、五張角色卡、N/A、CAN／I2C／Misc；無主視窗捲軸 | 待擷取 |
| 02_valid_can_bin.png | OFFLINE、size、calculated/stored/MATCH；live仍N/A | 待擷取 |
| 03_invalid_crc.png | 測試副本CRC錯誤；紅色INVALID；不能START | 待擷取 |
| 04_host_verified.png | Host board/ID/COM/FW/build；friendly name不是identity | 待板測 |
| 05_self_test_help.png | button/? hover；需active analyzer；counter reset | 待擷取 |
| 06_self_test_trace.png | ID123 DLC8 counter00/01/02、1秒；原trace | 待板測 |
| 07_transfer_target.png | part/target/protocol；boot/app N/A | 待板測 |
| 08_log_summary.png | PC log/summary count/error；無個人路徑 | 待擷取 |
| 09_app_live_info.png | 板上版本vs loaded BIN；Application mode | Device ready後補 |
| 10_boot_live_info.png | Enter後Boot mode/version/build/layout | Device ready後補 |
| 11_update_confirm.png | source/target/start/size方向；不按Yes | Device ready後補 |
| 12_update_progress.png | 已授權更新；progress/elapsed/trace | Device ready後補 |
| 13_updated_app.png | 重新探索/上電、新版/UART marker；非舊cache | Device ready後補 |
| 14_i2c_read_only.png | reported constants、09/100k、redBLOCKED | 待板測 |
| 15_i2c_upgrade.png | 安全erase/write/read-back/recovery | 未開放，待slave修正 |
| 16_shared_console_tabs.png | 五個系統灰白群組、加粗邊框；TAB只在左下；上方20欄metadata及中下更新、右下Log獨立；1366×768、100%／125% DPI、切換無殘影 | 待擷取 |
| log_auto_scroll.png | 預設勾選、INI重開記憶；關閉後追加大量訊息，視窗位置及選取文字不變；再勾選回到底部 | 待實際操作擷取；原生RichEdit測試另記 |
| 17_misc_bridge_info.png | HOST BRIDGE目的地、host boot/app descriptor、BUR1與live layout匹配；舊host封鎖 | 待實板安裝 |
| 18_misc_host_update.png | 明確HOST APP確認、更新後留boot、另按RUN、重連確認版本；附授權及原log | 待實板驗證 |
| 19_metadata_pages.png | READ／STAGE各四段64 bytes、256組合／CRC、BEGIN前取消零擦寫；Host128／frame142 | 待實板trace |
| 20_incompatible_host.png | 舊96-host拒絕訊息；F13 format3／bridge contract1拒絕，不得擦除 | 待擷取，勿實際寫入 |
| 29_can_v5_blocks.png | F24 App1.5.0／bit12、F13 v5／1.5.0、raw720..727／8-byte；summary blocks／ms／B/s、CRC與App啟動 | 使用者182253實板log已通過301區塊／10963ms／END；截圖與新版App啟動證據待補 |
| 30_can_v5_guard.png | 舊bridge缺bit12時按鈕封鎖；v4 BIN拒絕；queue drop警告時log標不完整 | 待擷取／負載測試 |
| benchmark_pcan.jpg | 歷史Transfer，0x710/711 | 已複製；非新版UI |
| benchmark_mcu_log.jpg | 同一benchmark UART TRACE CT | 已複製；非Boot/App更新證據 |

原圖來源`RL78_F13_CAN_Transfer/pcan.jpg`、`log.jpg`，未修改。
沒有個人路徑或序號；COM8只是原terminal選擇。公開發布前重新檢查隱私。

0076新增UPD1 Update Policy與Boot / IRQ ABI顯示；F13 protocol4／format6，
F24 bridge contract3。完整metadata在START／BEGIN前驗證，G16新版boot/app延後。
本輪native pipe重試與reset仍os error2，UI截圖／DPI為NOT RUN；不得使用示意圖。
共用政策由tool docs/COMMON_IMAGE_METADATA.md與sync_common_image_policy.ps1同步。

| 新增截圖 | 重點 | 狀態 |
| --- | --- | --- |
| 21_image_policy.png | CAN-only BIN切I2C／Misc仍保留MCU／版本／CRC32；WRONG ROUTE紅色，更新封鎖 | 待擷取 |
| 22_can_metadata_seal.png | RESET／64次METADATA／SEAL在START前完成；錯政策零擦寫 | 待實板trace |

0077新增Host Baud與tooltip：PC到bridge115200／460800／921600，與未來device
UART的BIN固定baud分開；Misc ENTER按BOOT固定速度重連。native pipe重試與重置
仍os error2，沒有新UI截圖或實體高速通過宣稱。

| 新增截圖 | 重點 | 狀態 |
| --- | --- | --- |
| 23_host_baud.png | Host Baud tooltip、名義／計算速度log、固定device baud說明 | 待擷取 |
| 24_host_baud_recovery.png | 高速後Reset／Close／拔線／Misc ENTER重連；CRC與溢位計數 | 待實板trace |

0078修正共用footer長操作文字換行裁切；GDI字型／邊界測試不是實際更新截圖。

| 新增截圖 | 重點 | 狀態 |
| --- | --- | --- |
| 25_progress_footer.png | Misc的Host bridge app update於0／40／99／100%；百分比完整、bar／elapsed／build不重疊；1366×768、100%／125% DPI | 待擷取，native pipe os error2 |

| 26_app_metadata_reconnect.png | Tool0079啟動無空路徑INI錯誤；App1.4.1 Probe含0x57四頁、關閉／重開後再Probe；舊App以SW1 reset進Boot後Misc復原 | 待實板復測，勿假造截圖 |
| 27_can_update_latency.png | Tool0080同19224B BIN／115200／500K／相同trace設定比對0079的142秒DATA；另測trace off及460800／921600；CRC、overflow/lost/error與App啟動 | 0080 log171150約79s；0082 log182253約10.963s；非相同BIN多次A/B，截圖／高速／新版App證據待補 |
