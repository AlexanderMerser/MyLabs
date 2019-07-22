#!/bin/bash
echo "Вас приветствует скрипт для резервного копирования (архивирования) данных на Bash";
echo "Выполнил: Фатеев Александр Михайлович";
echo "################################################";
echo " ";
while [ true ] 
do
	echo "################################################";
	echo "1 - просмотр архивов и их редактирование";
	echo "2 - создание нового архива";
	echo "3 - завершение работы скрипта";
	echo "Введите вашу команду:";
	read cmd;
	echo "################################################";
	case $cmd in 
		1)
			cat /var/spool/cron/crontabs/autdan  | grep -e "#RCopy" | grep -v "# "  > myrcopy;
			# Узнаем число строк в файле
			num=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | wc -l); 
			# i - иттератор цикла от 1 до num
			i=1;
			while [ $i -le $num ]
			do
				# mtime - переменная хранит минуты
				# htime - переменная хранит часы
				mtime=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c1-2);
				htime=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c4-5);
				
				
				# Условный выбор логики разработанного скрипта, ищем числа, отличны от "*"
				# d - число, установленное на будильнике
				# m - месяц, установленный на будильнике
				# check - день недели
				
				d=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c7-8);
				m=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c10-11);
				if [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c15-17)" == "tar" ]; then
					#echo "YES";
					n=25;
					while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
					do
						when=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c25-$n);
						n=$(($n+1));
					done
					n=$(($n+1));
					k=$n;
					while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
					do
						what=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$k-$n);
						n=$(($n+1));
					done
				elif [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c15-16)" == "dd" ]; then
					#echo "YES";
					n=21;
					while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
					do
						what=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c21-$n);
						n=$(($n+1));
					done
					while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != "=" ]
					do
						n=$(($n+1));
					done
					n=$(($n+1));
					k=$n;
					while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
					do
						when=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$k-$n);
						n=$(($n+1));
					done
				fi
			echo "$i. Резервное копирование файла "$what" в архив "$when", будет произведено в "$htime":"$mtime" "$d"."$m" ";
			i=$(($i+1));
			done
			while [ true ]
			do
				echo "################################################";
				echo "Введите:";
				echo "1 - чтобы перейти в меню редактирования задач резервного копирования";
				echo "2 - чтобы удалить задачу резервного копирования";
				echo "3 - чтобы вернуться в предыдущее меню";
				echo "0 - завершение работы скрипта";
				echo "################################################";
				read lcmd;
				if [ $lcmd -eq 0 ]; then
					exit 0;
				elif [ $lcmd -eq 1 ]; then
					echo "Введите номер задачи, которую хотите отредактировать";
					read nalarm;
					i=1;
					mtime=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c1-2);
					htime=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c4-5);
					
					day=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c7-8);
					mounth=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c10-11);
					if [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c15-17)" == "tar" ]; then
						#echo "YES";
						n=25;
						while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
						do
							when=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c25-$n);
							n=$(($n+1));
						done
						n=$(($n+1));
						k=$n;
						while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
						do
							what=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c$k-$n);
							n=$(($n+1));
						done
					elif [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c15-16)" == "dd" ]; then
						#echo "YES";
						n=21;
						while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
						do
							what=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c21-$n);
							n=$(($n+1));
						done
						while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != "=" ]
						do
							n=$(($n+1));
						done
						n=$(($n+1));
						k=$n;
						while [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$n)" != " " ]
						do
							when=$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$i"p | cut -c$k-$n);
							n=$(($n+1));
						done
					fi
					while [ true ]
					do
						echo "Введите:";
						echo "1 - чтобы изменить время и дату задачи копирования";
						echo "2 - чтобы изменить путь и названия архива";
						echo "3 - чтобы изменить путь к самому файлй резервного копирования";
						echo "4 - чтобы вернуться в предыдущее меню";
						echo "################################################";
						read newval;
						if [ $newval -eq 1 ]; then
							while [ true ]
							do
								echo "Введите новый день и месяц копирования в формате DD.MM";
								read time;
								nnum=$(echo $time | wc -c);
								nnum=$((nnum-1));
								day=$(echo $time | cut -c1-2);
								mounth=$(echo $time | cut -c4-5);
								dd=$(echo $time | cut -c3);
								if [ $day -ge 00 -a $day -le 31 -a $mounth -ge 00 -a $mounth -le 12 -a $nnum -eq 5 -a $dd == '.' ]; then
									break;
								fi
								echo "Введен неверный формат даты, введите дату копирования заново";
							done
							while [ true ]
							do
								echo "Введите новое время копирования в формате HH:MM";
								read time;
								nnum=$(echo $time | wc -c);
								nnum=$((nnum-1));
								htime=$(echo $time | cut -c1-2);
								mtime=$(echo $time | cut -c4-5);
								dd=$(echo $time | cut -c3);
								if [ $htime -ge 00 -a $htime -le 24 -a $mtime -ge 00 -a $mtime -le 59 -a $nnum -eq 5 -a $dd == ':' ]; then
									break;
								fi
								echo "Введен неверный формат времени, введите время копирования заново";
							done
							(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-17);
							read lul;
							if [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-17)" == "tar" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * tar -cjvf $when $what #RCopy" >> myrcopy;
							elif [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-16)" == "dd" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * dd if=$what of=$when #RCopy" >> myrcopy;
							fi
							(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
							crontab myrcopy;
							echo "Редактирование успешно завершено";
						elif [ $newval -eq 2 ]; then
							echo "Укажите новый полный путь к файлу, который хотите скопировать";
							read what;
							if [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-17)" == "tar" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * tar -cjvf $when $what #RCopy" >> myrcopy;
							elif [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-16)" == "dd" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * dd if=$what of=$when #RCopy" >> myrcopy;
							fi
							(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
							crontab myrcopy;
							echo "Редактирование успешно завершено";
						elif [ $newval -eq 3 ]; then
							echo "Укажите директорию, куда хотите скопировать";
							read when;
							if [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-17)" == "tar" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * tar -cjvf $when.tar $what #RCopy" >> myrcopy;
							elif [ "$(sed '/#RCopy/!d' /var/spool/cron/crontabs/autdan | sed -n "$nalarm"p | cut -c15-16)" == "dd" ]; then
								sed -i "$nalarm"d myrcopy;
								echo "$mtime $htime $day $mounth * dd if=$what of=$when/disk.img #RCopy" >> myrcopy;
							fi
							(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
							crontab myrcopy;
							echo "Редактирование успешно завершено";
						elif [ $newval -eq 4 ]; then
							break;
						fi
					done
				elif [ $lcmd -eq 2 ]; then
					echo "Введите номер задачи копирования, которую хотите удалить";
					read del;
					#del=$(($del+1));
					#echo $del;
					sed -i "$del"d myrcopy;
					(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
					crontab myrcopy;
					continue;
				elif [ $lcmd -eq 3 ]; then
					break;
				fi
			done
			;;
			
		2)
			#Перезаписываем старые задачи архивирование во временной файл myrcopy
			cat /var/spool/cron/crontabs/autdan  | grep -e "#RCopy" | grep -v "# "> myrcopy;
			echo "Укажите полный путь к файлу, который хотите скопировать";
			read mydir;
			# Архиватор tar использует относительную адресацию, поэтому, для качественного копирования, необходимо разделить
			# путь к файлу/папке, который копируем и непосредственно сам файл
			#
			# Разделение
			# Переменные n - итератор для посимвольного сравнения считанной строки, k - счетчик слэшей "/" 
			n=1;
			k=0;
			# Этот цикл подсчитывает количество слэшей "/" в переданной строки
			while [ $n -lt "$(echo $mydir | wc -c)" ]
			do
				if [ "$(echo $mydir | cut -c"$n")" == "/" ]; then
					k=$((k+1));
				fi
				n=$(($n+1));
			done
			n=1;
			m=0;
			# Цикл - реализация разделения
			while [ $n -lt "$(echo $mydir | wc -c)" ]
			do
				if [ "$(echo $mydir | cut -c"$n")" == "/" ]; then
					m=$((m+1));
				fi
				if [ $m -lt $k ]; then
					dirfile=$(echo $mydir | cut -c1-"$n");
					l=$((n+2));
				elif [ $n -gt $l ]; then
					file=$(echo $mydir | cut -c"$l"-"$n");
				fi
				n=$(($n+1));
			done
			
			#
			# Разделение завершено
			# Теперь в переменной $dirtfile - лежит путь к файлу, папке, а в $file - сам файл
			#echo $dirfile;
			#echo $file;
			#cd $dirfile;
			#echo "$(ls -la | grep $file | cut -c1)";
			
			# Реализация логики определения файла/папки/блочного_устройства
			if [ -b $mydir ]; then
				echo "Вы копируете блочное устройство";
			elif [ -d $mydir ]; then
				echo "Вы копируете папку";
			elif [ -e $mydir ]; then
				echo "Вы копируте файл";
			else
				echo "Такого файла/папки не существует";
			fi
			#
			
			echo "################################################";
			echo "Укажите директорию, куда хотите скопировать";
			read indir;
			while [ true ]
			do
				echo "Введите день и месяц копирования в формате DD.MM";
				read time;
				nnum=$(echo $time | wc -c);
				nnum=$((nnum-1));
				day=$(echo $time | cut -c1-2);
				mounth=$(echo $time | cut -c4-5);
				dd=$(echo $time | cut -c3);
				if [ $day -ge 00 -a $day -le 31 -a $mounth -ge 00 -a $mounth -le 12 -a $nnum -eq 5 -a $dd == '.' ]; then
					break;
				fi
				echo "Введен неверный формат даты, введите дату копирования заново";
			done
			while [ true ]
			do
				echo "Введите время копирования в формате HH:MM";
				read time;
				nnum=$(echo $time | wc -c);
				nnum=$((nnum-1));
				htime=$(echo $time | cut -c1-2)
				mtime=$(echo $time | cut -c4-5);
				dd=$(echo $time | cut -c3);
				if [ $htime -ge 00 -a $htime -le 24 -a $mtime -ge 00 -a $mtime -le 59 -a $nnum -eq 5 -a $dd == ':' ]; then
					break;
				fi
				echo "Введен неверный формат времени, введите время копирования заново";
			done
			if [ -b $mydir ]; then
				echo "Вы копируете блочное устройство";
				echo "$mtime $htime $day $mounth * dd if=$mydir of=$indir/$file.img #RCopy" >> myrcopy;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
				crontab myrcopy;
				
			elif [ -d $mydir]; then
				echo "Вы копируете папку";
				echo "$mtime $htime $day $mounth * tar -cjvf $indir/$file.tar $mydir #RCopy" >> myrcopy;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
				crontab myrcopy;
			elif [ -e $mydir ]; then
				echo "Вы копируте файл";
				echo "$mtime $htime $day $mounth * tar -cjvf $indir/$file.tar $mydir #RCopy" >> myrcopy;
				(cat /var/spool/cron/crontabs/autdan  | grep -v "#RCopy" | grep -v "# ") >> myrcopy;
				crontab myrcopy;
			fi
			continue;
			;;
		3)
			exit 0;
			;;
			*)
	esac
done
exit 0;
