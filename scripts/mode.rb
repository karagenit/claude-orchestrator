def mode(arr)
  return [] if arr.empty?
  
  frequency = Hash.new(0)
  arr.each { |item| frequency[item] += 1 }
  
  max_frequency = frequency.values.max
  modes = []
  
  frequency.each do |item, count|
    modes << item if count == max_frequency
  end
  
  modes
end