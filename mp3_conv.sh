#!/bin/bash 
 #shell script to convert my wma files to mp3
 # code taken from 
 # http://linuxprograms.wordpress.com/2007/06/17/shell-script-to-recursively-list-files/
 # and 
 # http://www.mygnulinux.com/?p=56
 #


DIR="."

function list_files(){
 if !(test -d "$1") 
   then echo $1; return;
 fi

 cd "$1"
 echo; echo `pwd`:; #Display Directory name

 for i in *
 do
   if test -d "$i" #if dictionary
     then 
     list_files "$i" #recursively list files
   cd ..
   else
     if [[ "$i" == *".wma"* ]]
       then 
       echo Converting "$i"; #Display File name
       ffmpeg -i "$i" -acodec mp3 -ab 192k  "${i%wma}mp3"
       rm -f "$i"
     fi
fi

 done
}

if [ $# -eq 0 ]
then list_files .
exit 0
fi

for i in $*
do
 DIR="$1"
 list_files "$DIR"
 shift 1 #To read next directory/file name
done
