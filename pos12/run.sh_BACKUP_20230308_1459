RELEASE=geopos-touch-1.9.4.jar 
GEOPOSTOUCH_OPTS=-Xmx1024M
LOG=output.log
export GEOPOS_HOME=/home/geocom/geopos/current

export DISPLAY=:0
export JAVA_HOME_8=/home/geocom/geopostouch/jdk1.8.0_211
export RELEASE

rm -r /root/.cache/GEOPos\ Touch    

chmod  -R 755 *
chown geocom:users -R /home/geocom/geopos/
chown geocom:users -R /home/geocom/geopostouch/


$JAVA_HOME_8/bin/java ${GEOPOSTOUCH_OPTS} -jar ${RELEASE} > $LOG 2>&1 &
sleep 10
cd nwjs/nwjs-sdk-v0.69.1-linux-x64
./nw &

sleep 10
nw=$(tail -n1 /home/geocom/geopostouch/current/output.log | cut -d '.' -f4)
if [ $nw = "geopos-touch" ] ; then
	./nw &
fi
