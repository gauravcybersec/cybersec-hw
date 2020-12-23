#!/bin/bash
#echo $1
#echo $2
#echo $3
game="$3"
if [ "$game" == "BlackJack" ]; then	
awk -F"\t" '{print $1"\t"$2}' $1_Dealer_schedule | grep -iw "$2"
elif [ "$game" == "Roulette" ]; then
awk -F"\t" '{print $1"\t"$3}' $1_Dealer_schedule | grep -iw "$2"
elif [ "$game" == "Texas_Hold_EM" ]; then
awk -F"\t" '{print $1"\t"$4}' $1_Dealer_schedule | grep -iw "$2"
else
awk -F"\t" '{print $1"\t"$2"\t"$3"\t"$4}' $1_Dealer_schedule | grep -iw "$2"
fi
