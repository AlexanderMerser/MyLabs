#!/bin/bash
# Программа для рассчета сетей на bash
# Выполнил Фатеев А.М.
#
# Переменная n - итераттор цикла по параметру
# point - счетчик точек, для разделения значений
# l, k - временные переменные для разделения значений
# Следующий цикл разбивает строку, которая передается через параметр, на 4 части: ipd1, ipd2, ipd3, ipd4
n=1;
point=1;
l=1;
while [ "$(echo $1 | cut -c$n)" ]
do
	if [ "$(echo $1 | cut -c$n)" == '.' ]; then
		k=$n;
		ipd0=$(echo $1 | cut -c$l-$((k-1)));
		if [ $point -eq 1 ]; then
			ipd1=$ipd0;
		elif [ $point -eq 2 ]; then
			ipd2=$ipd0;
		elif [ $point -eq 3 ]; then
			ipd3=$ipd0;
		fi
		point=$((point+1));
		l=$((k+1));
	fi
	n=$((n+1));
done
ipd4=$(echo $1 | cut -c$l-$((n-1)));
# Теперь переводим эти части в двоичную систему счисления ipb1, ipb2, ipb3, ipb4 соответственно
ipb1=$(echo 'obase=2;'$ipd1'' | bc);
while [ "$(echo $ipb1 | wc -m)" -le 8 ] 
do
	ipb1=$(echo 0$ipb1);
done
ipb2=$(echo 'obase=2;'$ipd2'' | bc);
while [ "$(echo $ipb2 | wc -m)" -le 8 ] 
do
	ipb2=$(echo 0$ipb2);
done
ipb3=$(echo 'obase=2;'$ipd3'' | bc);
# Следующие циклы необходимы, для сохранения разрядности при выводе на экран
while [ "$(echo $ipb3 | wc -m)" -le 8 ] 
do
	ipb3=$(echo 0$ipb3);
done
ipb4=$(echo 'obase=2;'$ipd4'' | bc);
while [ "$(echo $ipb4 | wc -m)" -le 8 ] 
do
	ipb4=$(echo 0$ipb4);
done
# Производим конкатенацию и выводим IP адресс в двоичной сс
ipbin=$(echo $ipb1.$ipb2.$ipb3. $ipb4);
echo -e "\033[37mAddresss:\t\033[34m$1\t\t\033[33m$ipbin";
#
#
# Аналогично для маски подсети
#
#
n=1;
point=1;
l=1;
while [ "$(echo $2 | cut -c$n)" ]
do
	if [ "$(echo $2 | cut -c$n)" == '.' ]; then
		k=$n;
		masd0=$(echo $2 | cut -c$l-$((k-1)));
		if [ $point -eq 1 ]; then
			masd1=$masd0;
		elif [ $point -eq 2 ]; then
			masd2=$masd0;
		elif [ $point -eq 3 ]; then
			masd3=$masd0;
		fi
		point=$((point+1));
		l=$((k+1));
	fi
	n=$((n+1));
done
masd4=$(echo $2 | cut -c$l-$((n-1)));
# Теперь переводим эти части в двоичную систему счисления ipb1, ipb2, ipb3, ipb4 соответственно
masb1=$(echo 'obase=2;'$masd1'' | bc);
masb2=$(echo 'obase=2;'$masd2'' | bc);
while [ "$(echo $masb2 | wc -m)" -le 8 ] 
do
	masb2=$(echo 0$masb2);
done
masb3=$(echo 'obase=2;'$masd3'' | bc);
# Следующие циклы необходимы, для сохранения разрядности при выводе на экран
while [ "$(echo $masb3 | wc -m)" -le 8 ] 
do
	masb3=$(echo 0$masb3);
done
masb4=$(echo 'obase=2;'$masd4'' | bc);
while [ "$(echo $masb4 | wc -m)" -le 8 ] 
do
	masb4=$(echo 0$masb4);
done
# Производим конкатенацию и выводим маску в двоичной сс
masbin=$(echo $masb1.$masb2.$masb3. $masb4);
n=1;
k=0;
while [ "$(echo $masbin | cut -c$n)" ]
do
	if [ "$(echo $masbin | cut -c$n)" == '1' ]; then
		k=$((k+1));
	fi
	n=$((n+1));
done
echo -e "\033[37mNetmask:\t\033[34m$2 =$k\t\t\033[31m$masbin";
#
#
#
wild1=$((255-$masd1));
wild2=$((255-$masd2));
wild3=$((255-$masd3));
wild4=$((255-$masd4));
wilb1=$(echo 'obase=2;'$wild1'' | bc);
while [ "$(echo $wilb1 | wc -m)" -le 8 ] 
do
	wilb1=$(echo 0$wilb1);
done
wilb2=$(echo 'obase=2;'$wild2'' | bc);
while [ "$(echo $wilb2 | wc -m)" -le 8 ] 
do
	wilb2=$(echo 0$wilb2);
done
wilb3=$(echo 'obase=2;'$wild3'' | bc);
while [ "$(echo $wilb3 | wc -m)" -le 8 ] 
do
	wilb3=$(echo 0$wilb3);
done
wilb4=$(echo 'obase=2;'$wild4'' | bc);
while [ "$(echo $wilb4 | wc -m)" -le 8 ] 
do
	wilb4=$(echo 0$wilb4);
done
wildec=$(echo $wild1.$wild2.$wild3.$wild4);
wilbin=$(echo $wilb1.$wilb2.$wilb3. $wilb4);
echo -e "\033[37mWildcard:\t\033[34m$wildec\t\t\033[33m$wilbin";
echo -e "\033[37m=>";
#
#
#
netd1=$(( $ipd1 & $masd1 ));
netd2=$(( $ipd2 & $masd2 ));
netd3=$(( $ipd3 & $masd3 ));
netd4=$(( $ipd4 & $masd4 ));
netb1=$(echo 'obase=2;'$netd1'' | bc);
while [ "$(echo $netb1 | wc -m)" -le 8 ] 
do
	netb1=$(echo 0$netb1);
done
netb2=$(echo 'obase=2;'$netd2'' | bc);
while [ "$(echo $netb2 | wc -m)" -le 8 ] 
do
	netb2=$(echo 0$netb2);
done
netb3=$(echo 'obase=2;'$netd3'' | bc);
while [ "$(echo $netb3 | wc -m)" -le 8 ] 
do
	netb3=$(echo 0$netb3);
done
netb4=$(echo 'obase=2;'$netd4'' | bc);
while [ "$(echo $netb4 | wc -m)" -le 8 ] 
do
	netb4=$(echo 0$netb4);
done
netdec=$(echo $netd1.$netd2.$netd3.$netd4);
netbin=$(echo $netb1.$netb2.$netb3. $netb4);
echo -e "\033[37mNetwork:\t\033[34m$netdec/$k\t\t\033[33m$netbin";
#
#
#
mind1=$netd1;
mind2=$netd2;
mind3=$netd3;
mind4=$((netd4+1));
minb1=$netb1;
while [ "$(echo $minb1 | wc -m)" -le 8 ] 
do
	minb1=$(echo 0$minb1);
done
minb2=$netb2;
while [ "$(echo $minb2 | wc -m)" -le 8 ] 
do
	minb2=$(echo 0$minb2);
done
minb3=$netb3;
while [ "$(echo $minb3 | wc -m)" -le 8 ] 
do
	minb3=$(echo 0$minb3);
done
minb4=$(echo 'obase=2;'$mind4'' | bc);
while [ "$(echo $minb4 | wc -m)" -le 8 ] 
do
	minb4=$(echo 0$minb4);
done
mindec=$(echo $mind1.$mind2.$mind3.$mind4);
minbin=$(echo $minb1.$minb2.$minb3. $minb4);
echo -e "\033[37mHostMin:\t\033[34m$mindec\t\t\033[33m$minbin";
#
#
#
if [ $netd1 -eq  0 ]; then
	maxd1=255;
else
	maxd1=$netd1;
fi
if [ $netd2 -eq  0 ]; then
	maxd2=255;
else
	maxd2=$netd2;
fi
if [ $netd3 -eq  0 ]; then
	maxd3=255;
else
	maxd3=$netd3;
fi
if [ $netd4 -eq  0 ]; then
	maxd4=254;
else
	maxd4=$netd4;
fi
maxb1=$(echo 'obase=2;'$maxd1'' | bc);
while [ "$(echo $maxb1 | wc -m)" -le 8 ] 
do
	maxb1=$(echo 0$maxb1);
done
maxb2=$(echo 'obase=2;'$maxd2'' | bc);
while [ "$(echo $maxb2 | wc -m)" -le 8 ] 
do
	maxb2=$(echo 0$maxb2);
done
maxb3=$(echo 'obase=2;'$maxd3'' | bc);
while [ "$(echo $maxb3 | wc -m)" -le 8 ] 
do
	maxb3=$(echo 0$maxb3);
done
maxb4=$(echo 'obase=2;'$maxd4'' | bc);
while [ "$(echo $maxb4 | wc -m)" -le 8 ] 
do
	maxb4=$(echo 0$maxb4);
done
maxdec=$(echo $maxd1.$maxd2.$maxd3.$maxd4);
maxbin=$(echo $maxb1.$maxb2.$maxb3. $maxb4);
echo -e "\033[37mHostMin:\t\033[34m$maxdec\t\t\033[33m$maxbin";
#
#
#
if [ $netd1 -eq  0 ]; then
	broadd1=255;
else
	broadd1=$netd1;
fi
if [ $netd2 -eq  0 ]; then
	broadd2=255;
else
	broadd2=$netd2;
fi
if [ $netd3 -eq  0 ]; then
	broadd3=255;
else
	broadd3=$netd3;
fi
if [ $netd4 -eq  0 ]; then
	broadd4=255;
else
	broadd4=$netd4;
fi
broadb1=$(echo 'obase=2;'$broadd1'' | bc);
while [ "$(echo $broadb1 | wc -m)" -le 8 ] 
do
	broadb1=$(echo 0$broadb1);
done
broadb2=$(echo 'obase=2;'$broadd2'' | bc);
while [ "$(echo $broadb2 | wc -m)" -le 8 ] 
do
	broadb2=$(echo 0$broadb2);
done
broadb3=$(echo 'obase=2;'$broadd3'' | bc);
while [ "$(echo $broadb3 | wc -m)" -le 8 ] 
do
	broadb3=$(echo 0$broadb3);
done
broadb4=$(echo 'obase=2;'$broadd4'' | bc);
while [ "$(echo $broadb4 | wc -m)" -le 8 ] 
do
	broadb4=$(echo 0$broadb4);
done
broaddec=$(echo $broadd1.$broadd2.$broadd3.$broadd4);
broadbin=$(echo $broadb1.$broadb2.$broadb3. $broadb4);
echo -e "\033[37mHostMin:\t\033[34m$broaddec\t\t\033[33m$broadbin";
#
#
#
resd1=$(($maxd1-$mind1));
resd2=$(($maxd2-$mind2));
resd3=$(($maxd3-$mind3));
resd4=$(($maxd4-$mind4));
resb1=$(echo 'obase=2;'$resd1'' | bc);
resb2=$(echo 'obase=2;'$resd2'' | bc);
resb3=$(echo 'obase=2;'$resd3'' | bc);
resb4=$(echo 'obase=2;'$resd4'' | bc);
resdec=$(echo $resd1.$resd2.$resd3.$resd4);
resbin=$(echo $resb1.$resb2.$resb3. $resb4);
n=1;
k=0;
while [ "$(echo $resbin | cut -c$n)" ]
do
	if [ "$(echo $resbin | cut -c$n)" == '1' ]; then
		k=$((k+1));
	fi
	n=$((n+1));
done
k=$((k+1));
resfinal=$(echo $((2**$k-2)));
if [ $ipd1 -le 126 -a $masd1 == "255" -a $masd2 == "0" -a $masd3 == "0" -a $masd4 == "0" ]; then
	class=$(echo 'A');
elif [ $ipd1 -ge 127 -a $ipd1 -le 191 -a $masd1 == "255" -a $masd2 == "255" -a $masd3 == "0" -a $masd4 == "0" ]; then
	class=$(echo 'B');
elif [ $ipd1 -ge 192 -a $ipd1 -le 223 -a $masd1 == "255" -a $masd2 == "255" -a $masd3 == "255" -a $masd4 == "0" ]; then
	class=$(echo 'C');
elif [ $ipd1 -ge 224 -a $ipd1 -le 255 -a $masd1 == "239" -a $masd2 == "255" -a $masd3 == "255" -a $masd4 == "255" ]; then
	class=$(echo 'D');
elif [ $ipd1 -ge 240 -a $ipd1 -le 255 -a $masd1 == "247" -a $masd2 == "255" -a $masd3 == "255" -a $masd4 == "255" ]; then
	class=$(echo 'E');
else
	class=$(echo -e "C\033[37m, Private Internet");
fi
echo -e "\033[37mHosts/Net:\t\033[34m$resfinal\t\t\t\033[35m Class $class";
