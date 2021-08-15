# 修复windows、Ubuntu双系统中蓝牙鼠标与键盘

> Author:    
> https://github.com/Mygod   
> https://gist.github.com/Mygod/f390aabf53cf1406fc71166a47236ebf   

```bash
# ./export-ble-infos.py -s "/media/C/Windows/System32/config/SYSTEM"
./export-ble-infos.py -s "/media/C/WINDOWS/System32/config/SYSTEM" # change to your system path

sudo bash -c 'cp -r ./bluetooth /var/lib'
sudo service bluetooth force-reload
```
