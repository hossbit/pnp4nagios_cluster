
########## Declare Paths ###########################
GetParam='/log/Scripts/pnpproxy/getparam.sh'
SrvConf='/log/Scripts/pnpproxy/server.conf'

######### Get Parameters ##########################

PATH1=`$GetParam $SrvConf global PATH`
PATH2=`$GetParam $SrvConf global PATH2`
PATH3=`$GetParam $SrvConf global PATH3`
PATH4=`$GetParam $SrvConf global PATH4`
SWITCH=`$GetParam $SrvConf global switch`
SWITCHIP=`$GetParam $SrvConf global switchip`

if [ -f $PATH2 ]

then
 	echo "$PATH2 not Found"

 else

	/bin/mkdir -p /log/perfdata

fi

process_count=$(/bin/ls /dev/shm/perfdata-P-* | /usr/bin/wc -l)

if [[ $process_count -lt 10 ]]; then
 
for f in $PATH1
  do
	TIME=`/bin/date +%H%M%S$RANDOM`

    if [ -f $f ]
      then

	/bin/mv $f $PATH2/perfdata-P-$TIME

	/bin/rm -f -r $f

	f2=$PATH2/perfdata-P-$TIME

	readfile=$(/bin/cat $f2 | /usr/bin/cut -f 11)
	array=(${readfile//::/ })  # split string to array
	x=1
      for i in "${!array[@]}"           #loop for check all array value

       do
	  if [[ ${array[$((x))]}  != "" ]]; then


		/bin/grep -i PNPIP::${array[$((x))]} $f2  >> $PATH2/${array[$((x))]}_pnpdata.$TIME

	  fi
                    
         
        x=$((x+2))
     done

  /bin/rm -f -r $f2
   fi
 done
fi
