def shuffle_array(arr, options = {})
  return [] if arr.nil? || arr.empty?
  
  method = options[:method] || :fisher_yates
  in_place = options[:in_place] || false
  
  array = in_place ? arr : arr.dup
  
  case method
  when :fisher_yates
    fisher_yates_shuffle(array)
  when :knuth
    knuth_shuffle(array)
  when :inside_out
    inside_out_shuffle(array)
  when :sort_by_random
    sort_by_random_shuffle(array)
  else
    fisher_yates_shuffle(array)
  end
  
  array
end

def fisher_yates_shuffle(array)
  n = array.length
  
  # Start from the last element and swap with random element
  (n - 1).downto(1) do |i|
    j = rand(i + 1)
    array[i], array[j] = array[j], array[i]
  end
  
  array
end

def knuth_shuffle(array)
  # Knuth shuffle (same as Fisher-Yates modern algorithm)
  fisher_yates_shuffle(array)
end

def inside_out_shuffle(array)
  # Inside-out Fisher-Yates shuffle
  result = Array.new(array.length)
  
  array.each_with_index do |element, i|
    j = rand(i + 1)
    result[i] = result[j] if j != i
    result[j] = element
  end
  
  array.replace(result)
end

def sort_by_random_shuffle(array)
  # Simple but less efficient shuffle using sort_by
  array.sort_by! { rand }
end

def shuffle_with_seed(array, seed)
  # Shuffle with reproducible results using a seed
  srand(seed)
  shuffled = shuffle_array(array)
  srand # Reset to random seed
  shuffled
end

def partial_shuffle(array, positions)
  # Shuffle only specific positions in the array
  return array if positions.empty?
  
  result = array.dup
  positions = positions.select { |pos| pos >= 0 && pos < array.length }
  
  # Extract elements at specified positions
  elements_to_shuffle = positions.map { |pos| result[pos] }
  
  # Shuffle the extracted elements
  shuffled_elements = shuffle_array(elements_to_shuffle)
  
  # Put shuffled elements back
  positions.each_with_index do |pos, index|
    result[pos] = shuffled_elements[index]
  end
  
  result
end

def weighted_shuffle(array, weights = nil)
  return shuffle_array(array) if weights.nil? || weights.empty?
  
  if weights.length != array.length
    raise ArgumentError, "Weights array must have same length as input array"
  end
  
  # Create pairs of [element, weight]
  pairs = array.zip(weights)
  
  # Sort by weighted random values
  pairs.sort_by! { |element, weight| rand ** (1.0 / weight) }
  
  # Extract just the elements
  pairs.map { |element, weight| element }
end

def shuffle_preserving_order(array, group_size)
  # Shuffle while preserving order within groups
  return array if group_size <= 0 || group_size >= array.length
  
  groups = array.each_slice(group_size).to_a
  shuffled_groups = shuffle_array(groups)
  shuffled_groups.flatten
end

def multi_shuffle(array, times = 1)
  # Perform multiple shuffle operations
  result = array.dup
  
  times.times do
    result = shuffle_array(result)
  end
  
  result
end

def conditional_shuffle(array, condition_proc = nil)
  # Shuffle elements that meet a condition
  return shuffle_array(array) if condition_proc.nil?
  
  result = array.dup
  indices_to_shuffle = []
  elements_to_shuffle = []
  
  result.each_with_index do |element, index|
    if condition_proc.call(element)
      indices_to_shuffle << index
      elements_to_shuffle << element
    end
  end
  
  shuffled_elements = shuffle_array(elements_to_shuffle)
  
  indices_to_shuffle.each_with_index do |index, i|
    result[index] = shuffled_elements[i]
  end
  
  result
end

def shuffle_algorithm_benchmark(array, iterations = 1000)
  # Benchmark different shuffle algorithms
  methods = [:fisher_yates, :knuth, :inside_out, :sort_by_random]
  results = {}
  
  methods.each do |method|
    start_time = Time.now
    
    iterations.times do
      shuffle_array(array, method: method)
    end
    
    end_time = Time.now
    results[method] = end_time - start_time
  end
  
  results
end