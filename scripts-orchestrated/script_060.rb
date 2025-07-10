def permutations(arr)
  return [] if arr.nil? || arr.empty?
  return [arr] if arr.length == 1
  
  result = []
  
  (0...arr.length).each do |i|
    element = arr[i]
    remaining = arr[0...i] + arr[i+1..-1]
    
    permutations(remaining).each do |perm|
      result << [element] + perm
    end
  end
  
  result
end

def permutations_iterative(arr)
  return [] if arr.nil? || arr.empty?
  return [arr.dup] if arr.length == 1
  
  result = [arr.dup]
  
  (arr.length - 1).downto(0) do |i|
    new_result = []
    
    result.each do |perm|
      (0..i).each do |j|
        new_perm = perm.dup
        new_perm[i], new_perm[j] = new_perm[j], new_perm[i]
        new_result << new_perm
      end
    end
    
    result = new_result.uniq
  end
  
  result
end

def permutations_with_repetition(arr, k)
  return [] if arr.nil? || arr.empty? || k <= 0
  return [[]] if k == 0
  
  result = []
  
  def generate_with_repetition(arr, k, current_perm, result)
    if current_perm.length == k
      result << current_perm.dup
      return
    end
    
    arr.each do |element|
      current_perm << element
      generate_with_repetition(arr, k, current_perm, result)
      current_perm.pop
    end
  end
  
  generate_with_repetition(arr, k, [], result)
  result
end

def next_permutation(arr)
  return nil if arr.nil? || arr.length <= 1
  
  perm = arr.dup
  i = perm.length - 2
  
  while i >= 0 && perm[i] >= perm[i + 1]
    i -= 1
  end
  
  return nil if i < 0
  
  j = perm.length - 1
  while perm[j] <= perm[i]
    j -= 1
  end
  
  perm[i], perm[j] = perm[j], perm[i]
  
  perm[i + 1..-1] = perm[i + 1..-1].reverse
  
  perm
end