def most_frequent(arr)
  return nil if arr.empty?
  
  frequency = Hash.new(0)
  arr.each { |item| frequency[item] += 1 }
  
  max_count = 0
  most_frequent_item = nil
  
  frequency.each do |item, count|
    if count > max_count
      max_count = count
      most_frequent_item = item
    end
  end
  
  most_frequent_item
end