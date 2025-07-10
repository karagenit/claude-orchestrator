#!/bin/bash

# Create scripts-orchestrated directory and logs directory
mkdir -p scripts-orchestrated
mkdir -p orchestrator_logs

# Array of sub-tasks - each creates 10 Ruby files to total 100
subtasks=(
    "Create 10 Ruby files (script_001.rb to script_010.rb) in scripts-orchestrated/ with DS&A functions: binary_search, bubble_sort, factorial, fibonacci, palindrome_check, reverse_string, prime_check, gcd, merge_arrays, find_max. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_011.rb to script_020.rb) in scripts-orchestrated/ with functions: quicksort, linear_search, count_vowels, capitalize_words, remove_duplicates, sum_array, average_array, min_max, string_contains, array_intersection. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_021.rb to script_030.rb) in scripts-orchestrated/ with functions: selection_sort, insertion_sort, levenshtein_distance, anagram_check, word_count, url_encode, url_decode, base64_encode, base64_decode, md5_hash. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_031.rb to script_040.rb) in scripts-orchestrated/ with functions: heap_sort, radix_sort, caesar_cipher, rot13, json_parse_safe, json_stringify, date_format, time_diff, random_string, shuffle_array. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_041.rb to script_050.rb) in scripts-orchestrated/ with functions: validate_email, validate_phone, credit_card_mask, slug_generator, html_escape, html_unescape, sql_escape, csv_parse, xml_escape, regex_match. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_051.rb to script_060.rb) in scripts-orchestrated/ with functions: tree_traversal, graph_dfs, graph_bfs, dijkstra_simple, knapsack_01, lcs_length, edit_distance, coin_change, tower_hanoi, permutations. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_061.rb to script_070.rb) in scripts-orchestrated/ with functions: combinations, subset_sum, matrix_multiply, matrix_transpose, determinant, prime_factors, lcm, power_mod, fibonacci_memo, factorial_memo. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_071.rb to script_080.rb) in scripts-orchestrated/ with functions: binary_tree_height, binary_tree_inorder, binary_tree_preorder, binary_tree_postorder, linked_list_reverse, queue_implementation, stack_implementation, hash_table_simple, bloom_filter, trie_insert. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_081.rb to script_090.rb) in scripts-orchestrated/ with functions: lru_cache, priority_queue, union_find, topological_sort, strongly_connected, minimum_spanning_tree, max_flow, shortest_path, traveling_salesman, n_queens. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
    
    "Create 10 Ruby files (script_091.rb to script_100.rb) in scripts-orchestrated/ with functions: sudoku_solver, maze_solver, expression_evaluator, rpn_calculator, word_ladder, boggle_solver, file_checksum, directory_tree, log_parser, config_parser. Each file should have one function with 10-50 lines of Ruby code and no external dependencies."
)

echo "Starting orchestrator with ${#subtasks[@]} sub-tasks..."
echo "Logs will be saved to orchestrator_logs/"

# Execute each sub-task in parallel using nohup and disown
for i in "${!subtasks[@]}"; do
    task_num=$((i + 1))
    log_file="orchestrator_logs/task_${task_num}.log"
    
    echo "Starting task ${task_num}..."
    
    # Run claude command in background with nohup and disown
    nohup claude -p "${subtasks[$i]}" --permission-mode acceptEdits > "$log_file" 2>&1 &
    
    # Disown the process to fully detach it
    disown
    
    # Small delay to prevent overwhelming the system
    sleep 1
done

echo "All tasks have been started in the background."
echo "Monitor progress with: tail -f orchestrator_logs/task_*.log"
echo "Check completion with: ls -la scripts-orchestrated/ | wc -l"