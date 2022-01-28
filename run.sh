echo "$0: Running"
sleep 7
sudo -E /sbin/entrypoint.sh &
sleep 3
cd ~/shared/
lxterminal --command "echo 'Terminate this xterm to kill container' ; /bin/bash"
pkill tini
