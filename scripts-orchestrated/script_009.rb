def merge_arrays(arr1, arr2)
  return arr2.dup if arr1.nil? || arr1.empty?
  return arr1.dup if arr2.nil? || arr2.empty?
  
  arr1 + arr2
end

def merge_sorted_arrays(arr1, arr2)
  return arr2.dup if arr1.nil? || arr1.empty?
  return arr1.dup if arr2.nil? || arr2.empty?
  
  result = []
  i = j = 0
  
  while i < arr1.length && j < arr2.length
    if arr1[i] <= arr2[j]
      result << arr1[i]
      i += 1
    else
      result << arr2[j]
      j += 1
    end
  end
  
  result.concat(arr1[i..-1]) if i < arr1.length
  result.concat(arr2[j..-1]) if j < arr2.length
  
  result
end

def merge_unique_arrays(arr1, arr2)
  return arr2.dup if arr1.nil? || arr1.empty?
  return arr1.dup if arr2.nil? || arr2.empty?
  
  (arr1 + arr2).uniq
end

def merge_multiple_arrays(*arrays)
  return [] if arrays.empty?
  
  arrays.compact.reduce([]) do |result, arr|
    result + arr
  end
end

def merge_multiple_sorted_arrays(*arrays)
  return [] if arrays.empty?
  
  arrays.compact.reduce([]) do |result, arr|
    merge_sorted_arrays(result, arr)
  end
end

def merge_with_callback(arr1, arr2, &block)
  return arr2.dup if arr1.nil? || arr1.empty?
  return arr1.dup if arr2.nil? || arr2.empty?
  
  if block_given?
    result = []
    i = j = 0
    
    while i < arr1.length && j < arr2.length
      if yield(arr1[i], arr2[j]) <= 0
        result << arr1[i]
        i += 1
      else
        result << arr2[j]
        j += 1
      end
    end
    
    result.concat(arr1[i..-1]) if i < arr1.length
    result.concat(arr2[j..-1]) if j < arr2.length
    
    result
  else
    merge_arrays(arr1, arr2)
  end
end

def merge_hash_arrays(arr1, arr2, key)
  return arr2.dup if arr1.nil? || arr1.empty?
  return arr1.dup if arr2.nil? || arr2.empty?
  
  result = []
  i = j = 0
  
  while i < arr1.length && j < arr2.length
    if arr1[i][key] <= arr2[j][key]
      result << arr1[i]
      i += 1
    else
      result << arr2[j]
      j += 1
    end
  end
  
  result.concat(arr1[i..-1]) if i < arr1.length
  result.concat(arr2[j..-1]) if j < arr2.length
  
  result
end

if __FILE__ == $0
  puts "Array merging examples:"
  
  arr1 = [1, 3, 5, 7, 9]
  arr2 = [2, 4, 6, 8, 10]
  
  puts "Array 1: #{arr1.inspect}"
  puts "Array 2: #{arr2.inspect}"
  puts "Simple merge: #{merge_arrays(arr1, arr2)}"
  puts "Sorted merge: #{merge_sorted_arrays(arr1, arr2)}"
  
  arr3 = [1, 3, 5, 7]
  arr4 = [3, 5, 9, 11]
  puts "\nArray 3: #{arr3.inspect}"
  puts "Array 4: #{arr4.inspect}"
  puts "Unique merge: #{merge_unique_arrays(arr3, arr4)}"
  
  puts "\nMultiple arrays:"
  arrays = [[1, 2], [3, 4], [5, 6]]
  puts "Arrays: #{arrays.inspect}"
  puts "Merged: #{merge_multiple_arrays(*arrays)}"
  
  sorted_arrays = [[1, 5, 9], [2, 6, 10], [3, 7, 11]]
  puts "Sorted arrays: #{sorted_arrays.inspect}"
  puts "Sorted merge: #{merge_multiple_sorted_arrays(*sorted_arrays)}"
  
  puts "\nCustom merge with callback (reverse order):"
  custom_merge = merge_with_callback(arr1, arr2) { |a, b| b <=> a }
  puts "Result: #{custom_merge}"
end