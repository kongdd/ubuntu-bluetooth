## please change to your system path
# /media/kong/6296F81996F7EC03/Windows/System32/config/SYSTEM
# /media/C/Windows/System32/config/SYSTEM
python ./export-ble-infos.py -s "/media/kong/Windows/WINDOWS/System32/config/SYSTEM"
Rscript keyboard_k380.R

sudo cp -r bluetooth /var/lib
sudo service bluetooth force-reload
