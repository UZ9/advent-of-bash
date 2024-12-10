#!/bin/bash

shopt -s extglob

first_list=()
declare -A freq_map

# Read from input.txt
input_file="./input/part2.txt"

# Process input into two lists
while read line; do
  truncated=$(echo "${line}" | tr -s ' ')

  readarray -d " " -t strarray <<< "$truncated"

  first_list+=(${strarray[0]})

  second_val=$(echo "${strarray[1]}" | tr -d '\n')

  # Hashmap in bash (technically associative array): check if key exists
  if [[ -v freq_map[$second_val] ]]; then 
    ((freq_map[$second_val]++))
  else 
    freq_map[$second_val]=1
  fi
done < $input_file

similarity_score=0

# Loop through first list, get frequencies
for((n=0; n < ${#first_list[*]};n++)) do 
  left=${first_list[n]}

  if [[ -n "${freq_map[$left]}" ]]; then 
    freq=${freq_map[$left]}
    
    similarity_score=$(($similarity_score + $freq * $left))
  fi
done

echo $similarity_score
