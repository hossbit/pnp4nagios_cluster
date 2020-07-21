#!/bin/bash

FileName=$1
Section=$2
Param=$3

FileLine=`cat $FileName | wc -l`
SecLine=`grep -m 1 -n "\[$Section\]" $FileName | cut -f1 -d:`

if [[ -z $SecLine ]]
then
	echo Error
	exit
fi

let "StartLine=$FileLine-$SecLine"
EndLine=`tail -$StartLine $FileName | grep -m 1 -n "\[" | cut -f1 -d:`

if [[ -n $EndLine ]]
then
        Res=`tail -$StartLine $FileName | head -$EndLine | grep -w $Param | cut -f2 -d=`
else
        Res=`tail -$StartLine $FileName | grep -w $Param | cut -f2 -d=`
fi

if [[ -n $Res ]]
then
	echo $Res
        exit
fi

echo Error
