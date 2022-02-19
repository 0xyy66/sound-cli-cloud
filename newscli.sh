#! /bin/bash

url=https://soundcloud.com/search?q=
soundcloud=https://soundcloud.com
separator=______________________________________________________________________________
R="\033[1;31m"  #Red
N="\033[0m"     #Normal
B="\033[1m"     #Bold
Y="\033[33m"  	#Yellow
M="\033[35m" 	#Magenta



printf "%bSong or artist%b -> " "$M" "$N"
read search
search=$(echo $search | sed 's/ /\%20/g')

#grep songs and artist links
links=$(curl "$url$search" | grep "<li><h2>")

printf "$separator\n\n"
# filters path and save it in $href
# filters song or artist name and save it in $name
#then prints out what has been found
i=0
while read line; do
        href[$i]=$(echo $line | awk 'BEGIN{RS="\">"; FS="href=\""}NF>1{print $NF}')
        name[$i]=$(echo $line | awk 'BEGIN{RS="</a>"; FS="\">"}NF>1{print $NF}')
        printf " $i - %b${href[$i]}%b - %b${name[$i]}%b\n" "$Y" "$N" "$R" "$N"
        ((i++))
done <<< "$links"

printf "\n%bChoose a song or an artist.%b\n" "$B" "$N"
printf "If you searched for an artist, usually the first option is the artist profile. You know it by seeing a / in the path(yellow text)\n"
printf "%bEnter index%b -> " "$M" "$N" 
read choice

#finally let's play some music
printf "\n\nNow playing: %b${name[$choice]}%b\n" "$R" "$N"
printf "$separator\n"
mpv $soundcloud${href[$choice]}

#TODO
#keep play 1 song
#play entire search list
