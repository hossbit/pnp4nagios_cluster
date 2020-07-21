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

 for f3 in $PATH4
  do
    if [ -f $f3 ];then
	fileopencheck=`/usr/bin/lsof $f3 | /usr/bin/wc -l` 
    if [ $fileopencheck -eq 0 ]
     then
     	 filename=$(/bin/basename $f3)

    if [ -f $f3 ];then

          RN=$RANDOM$RANDOM

         /bin/rm -f -r $PATH2/scp_* #delete invalid scp file

         /bin/mv $f3 $PATH2/scp_$filename$RN
         
           f3=$PATH2/scp_$filename$RN
         
        filename=scp_$filename$RN

         array2=(${filename//_/ }) 
      	if [[ ($SWITCH == "off") ]]; then
       		 if [[ (${array2[1]} != "$") && (${array2[1]} != "127.0.0.1")  ]]; then
            		/usr/bin/scp -v $PATH2/$filename ${array2[1]}:$PATH3/ 2> /$PATH2/scpstat.res
          		scpstat=$(/bin/cat /$PATH2/scpstat.res | /bin/grep -i "Exit status 0" | /usr/bin/wc -l)
                else
          		if [[ (${array2[1]} == "127.0.0.1") ]]; then
        		     /bin/cp $PATH2/$filename $PATH3/
             			cpok=1
         		fi
       	
          	fi
          if [[ ($scpstat -ge 1) || ($cpok == 1) ]]; then
              /bin/rm -f -r $f3
            fi
        else
       	if [[ ($SWITCH == "on") ]]; then
        	    
                   if [[ (${array2[1]} != "$") && (${array2[1]} != "127.0.0.1")  ]]; then
                        /usr/bin/scp -v $PATH2/$filename $SWITCHIP:$PATH3/ 2> /$PATH2/scpstat.res
                        scpstat=$(/bin/cat /$PATH2/scpstat.res | /bin/grep -i "Exit status 0" | /usr/bin/wc -l)
          	   else
                        if [[ (${array2[1]} == "127.0.0.1") ]]; then
                             /bin/cp $PATH2/$filename $PATH3/
                                cpok=1
                        fi

                 fi

          if [[ ($scpstat -ge 1) || ($cpok == 1) ]]; then

         /bin/rm -f -r $f3
         
         fi
        fi
       fi     
    fi
 fi
 fi
 done
