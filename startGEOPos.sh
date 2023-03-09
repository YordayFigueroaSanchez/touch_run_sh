export GEOPOS_HOME=/home/geocom/geopos/current
export CONFIGURATOR=/home/geocom/geoconfigurator/current
export SELFCHECKOUT=/home/geocom/selfcheckout/current
export SCODEVICEMGR=/home/geocom/sco-device-mgr/current
export GEOPOSTOUCH=/home/geocom/geopostouch/current

#Se carga en la propiedad BUSINESS_NAME_WORK_TYPE el valor configurado desde Geoconfigurator con el nombre de como va a trabajar el equipo que utilizara la version.
BUSINESS_NAME_WORK_TYPE=$(grep 'states.team.work.mode' $GEOPOS_HOME/configuration/pos/pos-production.properties | cut -d'=' -f2)

if [[ $BUSINESS_NAME_WORK_TYPE = *"CAJA"* ]] ; then
	#LINEA CAJA TRADICIONAL.
	cd $CONFIGURATOR
	. ./run-configuratorClient.sh $GEOPOS_HOME/docs/VersionGEOPosCaja.xml >>$GEOPOS_HOME/logs/startGEOPosOut.log
	
	/bin/sh /home/autentia/bin/autentia-monitor.sh start
	
	cd $GEOPOS_HOME
	. ./runPosUnify.sh>>$GEOPOS_HOME/logs/startGEOPosOut.log
else
	if [[ $BUSINESS_NAME_WORK_TYPE = *"SCO"* ]] ; then
		#LINEA SELFCHECKOUT (SCO).
		cd $CONFIGURATOR
		. ./run-configuratorClient.sh $GEOPOS_HOME/docs/VersionGEOPosCaja.xml >>$GEOPOS_HOME/logs/startGEOPosOut.log
		. ./run-configuratorClient.sh $SCODEVICEMGR/docs/SelfcheckOut_Manager.xml >>$SCODEVICEMGR/logs/start.log
		. ./run-configuratorClient.sh $SELFCHECKOUT/docs/SelfcheckOut_Selfcheckout.xml >>$SELFCHECKOUT/logs/start.log

		cd $GEOPOS_HOME
		. ./runPosUnifyDebug.sh>>$GEOPOS_HOME/logs/startGEOPosOut.log

		sleep 10

		cd $SCODEVICEMGR
		. ./start.sh>>$SCODEVICEMGR/logs/start.log

		sleep 60

		cd $SELFCHECKOUT
		. ./start.sh>>$SELFCHECKOUT/logs/start.log
	else
		if [[ $BUSINESS_NAME_WORK_TYPE = *"TOUCH"* ]] ; then
			#LINEA CAJA TOUCH.
			cd $CONFIGURATOR                                                   
			. ./run-configuratorClient.sh $GEOPOS_HOME/docs/VersionGEOPosCaja.xml >>$GEOPOS_HOME/logs/startGEOPosOut.log
			. ./run-configuratorClient.sh $GEOPOSTOUCH/docs/VersionGeoposTouch.xml >>$GEOPOSTOUCH/logs/start.log

			cd $GEOPOS_HOME
			. ./runPosUnifyDebug.sh>>$GEOPOS_HOME/logs/startGEOPosOut.log

			sleep 60

			cd $GEOPOSTOUCH
			. ./start.sh>>$GEOPOSTOUCH/logs/start.log	
		else
		    cd $CONFIGURATOR
			. ./run-configuratorClient.sh $GEOPOS_HOME/docs/VersionGEOPosCaja.xml >>$GEOPOS_HOME/logs/startGEOPosOut.log
			
			cd $GEOPOS_HOME
			. ./runPosUnify.sh>>$GEOPOS_HOME/logs/startGEOPosOut.log
		fi
	fi
fi


#Codigo original al 20201209
#cd $CONFIGURATOR
#. ./run-configuratorClient.sh $GEOPOS_HOME/docs/VersionGEOPosCaja.xml >>$GEOPOS_HOME/logs/startGEOPosOut.log

#cd $GEOPOS_HOME
#. ./runPosUnify.sh>>$GEOPOS_HOME/logs/startGEOPosOut.log

