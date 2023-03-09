
ps -aux | grep nwjs | grep -o '    [0-9][0-9][0-9][0-9] ' | while read -r line; do

echo "Terminando hilo de nwjs: $line"
kill -9 $line

done

ps -aux | grep nwjs | grep -o '    [0-9][0-9][0-9][0-9][0-9] ' | while read -r line; do

echo "Terminando hilo de nwjs: $line"
kill -9 $line

done



ps -aux | grep geopostouch- | grep -o '    [0-9][0-9][0-9][0-9] '  | while read -r line; do
 echo "Terminando el hilo de backend... $line"
 kill -9 $line
done

ps -aux | grep geopostouch- | grep -o '    [0-9][0-9][0-9][0-9][0-9] '  | while read -r line; do
 echo "Terminando el hilo de backend... $line"
 kill -9 $line
done

echo "Iniciando Frontend"
sh run.sh

