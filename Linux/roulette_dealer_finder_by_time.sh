#!/bin/bash
#echo $1
#echo $2
awk -F"\t" '{print $1"\t"$3}' $1_Dealer_schedule | grep -iw "$2"
