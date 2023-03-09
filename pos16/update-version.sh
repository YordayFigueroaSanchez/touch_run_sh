echo "Comenzando proceso de actualizacion de version de GEOPos Touch - FrontEnd a version 1.9.4"
 
cd /home/geocom/geopostouch/

echo "Actualizando links:"

echo "   -> current"
rm -rf current
ln -sf installations/geopostouch-1.9.4/ current

cd current

echo "   -> app_resources"
ln -sf /home/geocom/geopostouch/app_resources app_resources

echo "   -> resources"
ln -sf /home/geocom/geopostouch/resources/ resources

echo "   -> nwjs"
ln -sf /home/geocom/geopostouch/nwjs nwjs

echo "Asignando permisos necesarios."
cd /home/geocom/geopostouch
chmod -R 755 *
chown -R geocom:users *

echo "Actualizacion de version completada con exito."

echo "Have a nice day :)"
