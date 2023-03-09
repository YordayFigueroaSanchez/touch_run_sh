RELEASE=geopos-touch-1.9.3.jar 
GEOPOSTOUCH_OPTS=-Xmx1024M
LOG=output.log
LOG_EXTRA=runShTouch.log
NUMBER_PROCESS_MORE_THAT=8
export GEOPOS_HOME=/home/geocom/geopos/current
export GEOPOS_TOUCH=/home/geocom/geopostouch/current

export DISPLAY=:0
export JAVA_HOME_8=/home/geocom/geopostouch/jdk1.8.0_211
export RELEASE

echo $(date -u) "iniciando las tareas del run.sh     ######################################" >> $GEOPOS_TOUCH/$LOG_EXTRA
echo $(date -u) "removiendo directorio de cache" >> $GEOPOS_TOUCH/$LOG_EXTRA
rm -r /root/.cache/GEOPos\ Touch    

echo $(date -u) "modificando permisos" >> $GEOPOS_TOUCH/$LOG_EXTRA
chmod  -R 755 *
chown geocom:users -R /home/geocom/geopos/
chown geocom:users -R /home/geocom/geopostouch/

echo $(date -u) "iniciando geopostouch $RELEASE" >> $GEOPOS_TOUCH/$LOG_EXTRA
$JAVA_HOME_8/bin/java ${GEOPOSTOUCH_OPTS} -jar ${RELEASE} > $LOG 2>&1 &

echo $(date -u) "seteando ruta del navegador" >> $GEOPOS_TOUCH/$LOG_EXTRA
cd nwjs/nwjs-sdk-v0.69.1-linux-x64

echo $(date -u) "estrategia para iniciar el navegador" >> $GEOPOS_TOUCH/$LOG_EXTRA
x=1
continue=100
while [ $x -le 10 ] & [ $continue -le 200 ]; 
do
  echo $(date -u) "Intento $x" >> $GEOPOS_TOUCH/$LOG_EXTRA
  x=$(( $x + 1 ))
  sleep 5
  status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:8992/api/pos/echo)
  echo $(date -u) "response status code $status_code" >> $GEOPOS_TOUCH/$LOG_EXTRA
  if [[ "$status_code" -eq 200 ]] ;then
	echo $(date -u) "iniciando navegador nwjs" >> $GEOPOS_TOUCH/$LOG_EXTRA
	./nw &
	sleep 5
	echo $(date -u) "consultar cantidad de procesos del navegador nwjs" >> $GEOPOS_TOUCH/$LOG_EXTRA
	process_nwjs=$(ps -aux | grep nwjs | wc -l)
	echo $(date -u) "cantidad de procesos $process_nwjs" >> $GEOPOS_TOUCH/$LOG_EXTRA
	if [[ "$process_nwjs" -gt "$NUMBER_PROCESS_MORE_THAT" ]] ;then
		continue=201
		echo $(date -u) "iniciado navegador nwjs" >> $GEOPOS_TOUCH/$LOG_EXTRA
	else
		echo $(date -u) "reintento de inicio de navegador nwjs" >> $GEOPOS_TOUCH/$LOG_EXTRA
	fi
	
  fi
done
echo $(date -u) "finalizadas las tareas del run.sh   ######################################" >> $GEOPOS_TOUCH/$LOG_EXTRA
