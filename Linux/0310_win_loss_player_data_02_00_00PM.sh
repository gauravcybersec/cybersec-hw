#!/bin/bash
awk -F"\t" '{print $1"\t"$3}' 0310_Dealer_schedule | grep "02:00:00 PM"
