#!/bin/bash

flutter drive --driver=test_driver/integration_test.dart --target=integration_test/performance_test.dart --profile

# # Number of test runs
# RUNS=10
# # Output file
# OUTPUT_FILE="performance_results.csv"

# # Initialize CSV file with headers
# echo "Run,Time" > $OUTPUT_FILE

# for (( i=1; i<=$RUNS; i++ ))
# do
#     echo "Running test $i of $RUNS..."
#     # Run the test and save output to a temporary file
#     flutter drive --driver=test_driver/integration_test.dart --target=integration_test/performance_test.dart --profile > temp_output.txt
    
#     # Extract the metrics using grep and awk (adjust based on your print format)
#     TIME=$(grep "Text "this is a test" appeared in:" temp_output.txt | awk '{print $5}')
    
#     # Write to CSV
#     echo "$i,$TIME" >> $OUTPUT_FILE
    
#     # Optional: add some delay between runs to let the device cool down
#     sleep 2
# done

# # Calculate averages
# AVG_TIME=$(awk -F, 'NR>1 {sum+=$2} END {print sum/(NR-1)}' $OUTPUT_FILE)

# echo "===== RESULTS ====="
# echo "Average time: $AVG_TIME ms"

# # Clean up
# rm temp_output.txt