def frequency_counter(arr)
  frequency = Hash.new(0)
  
  arr.each do |item|
    frequency[item] += 1
  end
  
  frequency
end