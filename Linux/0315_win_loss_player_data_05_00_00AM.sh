#!/bin/bash
awk -F"\t" '{print $1"\t"$3}' 0315_Dealer_schedule | grep "05:00:00 AM"
