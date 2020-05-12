#!/bin/bash
##############################################################################################
# Rex Matthews ..............................................................................#
#............................................................................................#
##############################################################################################
cols=$(tput cols)
lineBreak="_"

#arrowUP="\xE2\x87\xA7"
#arrowDown="\xE2\x87\xA9"
arrowUP=">"
arrowDown="<"
equals="="

red="\033[91m"
yellow="\033[93m"
green="\033[92m"
blue="\033[94m"
white="\033[97m"
reset="\033[0m"

_self="${0##*/}"

#printf "\033c"
lineBreak(){ printf "%${cols}s\n" |tr " " "${lineBreak}"; }
# Check is $1 = null "Blank"
if [ -z $1 ]
    then
        printf "${yellow}EXAMPLE:\$ ./$_self somedate.txt\n${reset}"
        printf "${yellow}EXAMPLE:\$ ./$_self somedate.txt debug\n${reset}"
        exit 2
fi
if [ -z $1 ] || [ "$2" == "debug" ]
    then
    set -x
fi

old=0
lineBreak
printf "${blue}*Blue [=] equals count or previous day,\n${red}*Red [>] counts increase over previous day,\n${green}*Green [<] counts decreased over previous day,\n${yellow}*Yellow [< or >] reflects, over scale of view\n"
printf "${reset}"
lineBreak

tput cud 1

while read date counts
do 
tput bold
    if (( ${counts} == ${old} ))
        then
            printf "${blue}"
            printf "%s\t%${counts}s\n" "$date""[$counts]" |sed -e "s/ /${equals}/g"
            printf "${reset}"
    fi

    if (( ${counts} > ${old} )) #printf "BIG -gl  "
        then
        if (( ${counts} > ${cols} ))
            then
            #TO Big for cols will wrap
                printf "${yellow}"
                printf "%s\t%${counts}s\n" "$date""[$counts]"  |sed -e "s/ /${arrowUP}/g"
                printf "${reset}"
        else
                printf "${red}"
                printf "%s\t%${counts}s\n" "$date""[$counts]" |sed -e "s/ /${arrowUP}/g"
                printf "${reset}"
        fi
    fi
    if (( ${counts} < ${old} )) #printf "SMALL -le "
        then
        if (( ${counts} > ${cols} ))
            then
            #TO Big for cols will wrap
                printf "${green}"
                printf "%s\t%${counts}s\n" "$date""[$counts]" |sed -e "s/ /${arrowDown}/g"
                printf "${reset}"
        else
                printf "${green}"
                printf "%s\t%${counts}s\n" "$date""[$counts]" |sed -e "s/ /${arrowDown}/g"
                printf "${reset}"
        fi
    fi
    #sleep 0.2
    old=$counts
done < $1
lineBreak
