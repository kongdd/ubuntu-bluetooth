# Bluetooth keyboard and mouse share between dual system (windows + Ubuntu)
> windows、Ubuntu双系统共享蓝牙鼠标与键盘
> Dongdong Kong

## Tests passed

- keyboard, k590
- mouse, k380

## TODO

R语言脚本翻译至Python,摆脱R语言的依赖（Python不熟，暂时完不成）。

## Usage

```bash
# ./export-ble-infos.py -s "/media/C/Windows/System32/config/SYSTEM"
python ./export-ble-infos.py -s "/media/kong/Windows/WINDOWS/System32/config/SYSTEM" # change to your system path
# python ./export-ble-infos.py -s /media/kong/6296F81996F7EC03/Windows/System32/config/SYSTEM
Rscript keyboard_k380.R

sudo cp -r bluetooth /var/lib
sudo service bluetooth force-reload
```

## References
1. Mouse, <https://gist.github.com/Mygod/f390aabf53cf1406fc71166a47236ebf>
2. Keyboard, <https://gist.github.com/madkoding/f3cfd3742546d5c99131fd19ca267fd4>
