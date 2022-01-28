set port=6081
set vnc_port=5901

set db_dir=C:\shared\mysql8
set "curr_dir=%cd%"
REM Asegúrate que esta red ha sido creada con:   docker network create -d bridge mi-ewd
set network=mi-red

set user=hector
set pass=password

set hostname=ubuntu-server

start "" cmd.exe /C docker run --hostname %hostname% -p %port%:80 -p %vnc_port%:5900 -p 33506:3306 -e USER=%user% -e PASSWORD=%pass% -v %db_dir%:/var/lib/mysql -v %curr_dir%:/root/shared --network %network% ubuntu/mysql8
timeout 3
"C:\Program Files\Google\Chrome\Application\Chrome.exe" http://localhost:%port%