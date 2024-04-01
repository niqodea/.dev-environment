:: Set static ip for WSL and forward host ports

set host_ip=192.168.99.1
set wsl_ip=192.168.99.2
set broadcast_ip=192.168.99.255
set static_wsl_ipnet_mask=255.255.255.0
set static_wsl_ipnet_mask_length=24

:: Ref: https://superuser.com/a/1715206
netsh interface ip add address "vEthernet (WSL)" %host_ip% %static_wsl_ipnet_mask%
wsl -u root sudo ip addr add %wsl_ip%/%static_wsl_ipnet_mask_length% broadcast %broadcast_ip% dev eth0 label eth0:1

:: Ref: https://github.com/microsoft/WSL/issues/4150#issuecomment-504209723
set ports=443,50000,50001,50002,50003,50004,50005,50006,50007,50008,50009

PowerShell -Command "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort %ports% -Action Allow -Protocol TCP"
PowerShell -Command "New-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort %ports% -Action Allow -Protocol TCP"

for %%p in (%ports%) do (
    netsh interface portproxy add v4tov4 listenport=%%p listenaddress=0.0.0.0 connectport=%%p connectaddress=%wsl_ip%
)
