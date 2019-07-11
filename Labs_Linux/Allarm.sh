#!/bin/bash
echo "Вас приветствует скрипт для установки будильника";
echo "Выполнил: Фатеев Александр Михайлович";
echo "################################################";
echo " ";
while [ true ] 
do
	echo "################################################";
	echo "1 - просмотр всех будильников и  их редактирование";
	echo "2 - создание нового будильника";
	echo "3 - завершение работы скрипта";
	echo "Введите вашу команду:";
	# Переменная cmd используется для отслеживания пунктов основного меню
	read cmd;
	scrip=$(cat melodi.conf);
	echo "################################################";
	case $cmd in 
		1)
			# Описание логики 1 подменю - просмотра, удаления и редактирования будильников
			# Записывает будильники в отдельный файл
			cat /var/spool/cron/crontabs/autdan  | grep -e "mpg123" > mycron;
			# Узнаем число строк в файле (число будильников)
			num=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | wc -l); 
			# i - иттератор цикла от 1 до num
			i=1
			while [ $i -le $num ]
			do
				# mtime - переменная хранит минуты
				# htime - переменная хранит часы
				#sed -n "$i"p path.txt > path2.txt;
				#sed -n "$i"p path.txt >> mycron;
				set +H;
				mtime=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c1-2);
				htime=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c4-5);
				#echo $mtime $htime;
				#read x;
				
				# Условный выбор логики разработанного скрипта, ищем числа, отличны от "*"
				# d - число, установленное на будильнике
				# m - месяц, установленный на будильнике
				# check - день недели
				if [ "$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c7)" != "*" ]; then
					d=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c7-8);
					m=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c10-11);
					echo "$i. Будильник поставлен на "$htime":"$mtime" лишь на сегодня $d $m";
				elif [ "$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c11)" != "*" ]; then
					check=$(sed '/mpg123/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c11);
					echo "$i. Будильник поставлен на "$htime":"$mtime" и сработает в $check день недели";
				else
					echo "$i. Будильник поставлен на "$htime":"$mtime" и работает каждый день";
				fi
				i=$(($i+1));
			done
			echo "################################################";
			echo "Введите:";
			echo "1 - чтобы перейти в меню редактирования будильников";
			#echo "2 - чтобы создать новый будильник";
			echo "2 - чтобы удалить будильник";
			echo "3 - чтобы вернуться в предыдущее меню";
			echo "0 - завершение работы скрипта";
			echo "################################################";
			read lcmd;
			if [ $lcmd -eq 0 ]; then
				exit 0;
			elif [ $lcmd -eq 1 ]; then
				echo "Введите номер будильника, который хотите отредактировать";
				read nalarm;
				i=1;
				echo "Введите:";
				echo "1 - чтобы изменить время будильника";
				echo "2 - чтобы изменить день недели";
				echo "3 - чтобы изменить мелодию будильника";
				echo "################################################";
				read newval;
				if [ $newval -eq 1 ]; then
					while [ true ]
					do
						echo "Введите новое время в формате HH:MM";
						read time;
						nnum=$(echo $time | wc -c);
						nnum=$((nnum-1));
						htime=$(echo $time | cut -c1-2);
						mtime=$(echo $time | cut -c4-5);
						if [ $htime -ge 00 -a $htime -le 24 -a $mtime -ge 00 -a $mtime -le 59 -a $nnum -eq 5 -a $dd == ':'  ]; then
							break;
						fi
						echo "Введен неверный формат времени";
					done
					sed -i "$nalarm"d mycron;
					echo "$mtime $htime * * * mpg123 $scrip" >> mycron;
					(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
					crontab mycron;
				elif [ $newval -eq 2 ]; then
					#sed -n "$nalarm"p path.txt > path2.txt;
					while [ true ]
					do
						echo "Введите новый день недели";
						read newdate;
						if [ $newdate -ge 0 -a $newdate -le 7 ]; then
							break;
						fi
						echo "Введен неверный формат дня недели";
					done
					mtime=$(sed -n "$nalarm"p mycron | cut -c1-2);
					htime=$(sed -n "$nalarm"p mycron | cut -c4-5);
					sed -i "$nalarm"d mycron;
					echo "$mtime $htime * * $newdate mpg123  $scrip" >> mycron;
					(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
					crontab mycron;
				elif [ $newval -eq 3 ]; then 
					echo "Введите путь к новой мелодии будильника";
					read newscrip;
					echo $newscrip > melodi.conf;
					mtime=$(sed -n "$nalarm"p mycron | cut -c1-2);
					htime=$(sed -n "$nalarm"p mycron | cut -c4-5);
					newdate=$(sed -n "$nalarm"p mycron | cut -c11);
					sed -i "$nalarm"d mycron;
					echo "$mtime $htime * * $newdate mpg123 $newscrip" >> mycron;
					(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
					crontab mycron;
				fi
				continue;
			fi
			if [ $lcmd -eq 2 ]; then
				echo "Введите номер будильника, который хотите удалить";
				read del;
				#del=$(($del+1));
				#echo $del;
				sed -i "$del"d mycron;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
				crontab mycron;
				continue;
			fi
			if [ $lcmd -eq 3 ]; then
				continue;
			fi
			#exit 0;
			;;
			
		2)
			# Записывает будильники в отдельный файл
			cat /var/spool/cron/crontabs/autdan  | grep -e "mpg123" > mycron;
		
			# Описание логики 2 подменю - создание новых будильников
			while [ true ]
			do
				echo "Введите новое время в формате HH:MM";
				read time;
				nnum=$(echo $time | wc -c);
				nnum=$((nnum-1));
				htime=$(echo $time | cut -c1-2);
				mtime=$(echo $time | cut -c4-5);
				dd=$(echo $time | cut -c3);
				if [ $htime -ge 00 -a $htime -le 24 -a $mtime -ge 00 -a $mtime -le 59 -a $nnum -eq 5 -a $dd == ':' ]; then
					break;
				fi
				echo "Введен неверный формат времени";
			done
			# В этой части кода переменная check используется, как переменная выборки подменю 2
			echo "Введите:";
			echo "0 - если будильник будет использоваться каждый день";
			echo "Цифру от 1 - до 7 , если будильник будет использоваться в определенный день недели"
			echo "1 - Пн, 2 - Вт, 3 - Ср, 4 - Чт, 5 - Пт, 6 - Сб, 7 - Вс";
			echo "8 - если будильник будет использоваться только сегодня";
			read check;
			if [ $check -eq 0 ]; then
				echo "$mtime $htime * * * mpg123 $scrip" >> mycron;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
				crontab mycron;
			elif [[ $check -ge 1 && $check -le 7 ]]; then
				echo "$mtime $htime * * $check $scrip" >> mycron;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
				crontab mycron;
				
			elif [ $check -eq 8 ]; then
				m=$(date +"%m");
				d=$(date +"%d");
				#echo "$m $d";
				echo "$mtime $htime $d $m * $scrip" >> mycron;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "mpg123" | grep -v "#") >> mycron;
				crontab mycron;
				#echo 3;
			fi
			echo "Вы ввели неверный формат времени";
			continue;
			#exit 0;
			;;
		3)
			exit 0;
			;;
			*)
	esac
done
exit 0;
