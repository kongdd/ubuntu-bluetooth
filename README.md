# 修复windows、Ubuntu双系统中蓝牙鼠标与键盘

source from: 

```bash
# note 
# ./export-ble-infos.py -s "/media/C/Windows/System32/config/SYSTEM"
./export-ble-infos.py -s "/media/C/WINDOWS/System32/config/SYSTEM" # change your system path

sudo bash -c 'cp -r ./bluetooth /var/lib'
sudo service bluetooth force-reload
```
