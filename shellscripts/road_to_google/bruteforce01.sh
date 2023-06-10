#!/bin/bash

# Function to find the indices of two numbers that add up to a target
find_indices() {
    # Get the array of numbers and the target from command-line arguments
    numbers=("${!1}")
    target=$2
    
    # Loop through all possible pairs of numbers
    for ((i=0; i<${#numbers[@]}-1; i++)); do
        for ((j=i+1; j<${#numbers[@]}; j++)); do
            # Check if the pair of numbers adds up to the target
            if ((numbers[i] + numbers[j] == target)); then
                echo "Indices: $i $j"
                return
            fi
        done
    done
    
    # No two numbers found that add up to the target
    echo "No indices found"
}

# Test the function with the provided example
numbers=(1 3 7 9 2)
target=11
find_indices numbers[@] $target
