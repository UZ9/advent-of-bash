#!/bin/bash

# Day 1:
# Two lists
#
# Objective: find distance between each nth smallest number of two lists
# First requiremnet: sort each list 
# Second requirement: loop over both lists at same time, find difference 
# Sum up differences to find answer 
shopt -s extglob

first_list=()
second_list=()

# Read from input.txt
input_file="./input/part1.txt"

# Process input into two lists
while read line; do
  truncated=$(echo "${line}" | tr -s ' ')

  readarray -d " " -t strarray <<< "$truncated"

  first_list+=(${strarray[0]})
  second_list+=(${strarray[1]})

done < $input_file

# Sort the two lists 
IFS=$'\n'
first_list_sorted=($(sort <<< "${first_list[*]}"))
second_list_sorted=($(sort <<< "${second_list[*]}"))
unset IFS

# Running sum of total difference
difference_sum=0

for((n=0; n < ${#first_list_sorted[*]};n++)) do 
  difference=$(expr ${first_list_sorted[n]} - ${second_list_sorted[n]})
  abs_difference=${difference#-}

  # Take absolute value
  difference_sum=$(expr $difference_sum + $abs_difference)
done

echo "Difference sum: $difference_sum"
