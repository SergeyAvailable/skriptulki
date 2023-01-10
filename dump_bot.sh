#!/usr/bin/env bash
date=$(date +%Y%m%d'-'%H'-'%M'-'%S)
s_stor=3221225472
s_back=$(ls -lv /test | tail -n 1 | awk '{print $5}')
let c_back=$s_stor/$s_back
t_back=$(ls -lv /test | grep "^-" | wc | awk '{print $1}')
if [ $t_back -ge $c_back ]
	then
		let a=($t_back-$c_back)+1
#		echo $a
		cd /test
		ls -lv | grep "^-" | head -n $a | awk '{print $9}' | xargs rm -f
		pg_dump -U postgres -d back_test > /test/back_test-$date
		l_back=$(ls -lv | grep "^-" | tail -n 1 | awk '{print $5}')
		let b=($l_back/1024/1024)
		curl -X POST -d text="Бэкап завершен $date %0AКоличество доступных копий: $c_back %0AРазмер последней копии: $b Mb %0A#backup " 'https://api.telegram.org/bot5892481615:AAH01YAOHd39_LU3HeJsfGU-YF7GC34a4do/sendMessage?chat_id=-1001884359879' &> /dev/null
	else 
		pg_dump -U postgres -d back_test > /test/back_test-$date
fi


#echo "Кол-во текущих копий" $t_back
#echo "Размер хранилища" $s_stor
#echo "Размер бэкапа" $s_back
#echo "Кол-во возможных копий" $c_back
 
