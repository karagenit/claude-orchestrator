class HashTable
  def initialize(size = 10)
    @size = size
    @buckets = Array.new(size) { [] }
  end
  
  def hash_function(key)
    key.hash % @size
  end
  
  def put(key, value)
    index = hash_function(key)
    bucket = @buckets[index]
    
    existing_pair = bucket.find { |pair| pair[0] == key }
    
    if existing_pair
      existing_pair[1] = value
    else
      bucket << [key, value]
    end
  end
  
  def get(key)
    index = hash_function(key)
    bucket = @buckets[index]
    
    pair = bucket.find { |pair| pair[0] == key }
    pair ? pair[1] : nil
  end
  
  def delete(key)
    index = hash_function(key)
    bucket = @buckets[index]
    
    bucket.reject! { |pair| pair[0] == key }
  end
  
  def keys
    @buckets.flatten(1).map { |pair| pair[0] }
  end
  
  def values
    @buckets.flatten(1).map { |pair| pair[1] }
  end
  
  def size
    @buckets.flatten(1).length
  end
  
  def empty?
    size == 0
  end
  
  def to_hash
    result = {}
    @buckets.each do |bucket|
      bucket.each do |key, value|
        result[key] = value
      end
    end
    result
  end
  
  def load_factor
    size.to_f / @size
  end
  
  def display
    @buckets.each_with_index do |bucket, index|
      puts "Bucket #{index}: #{bucket.inspect}"
    end
  end
end

if __FILE__ == $0
  hash_table = HashTable.new(5)
  
  hash_table.put("name", "John")
  hash_table.put("age", 30)
  hash_table.put("city", "New York")
  hash_table.put("country", "USA")
  
  puts "Get name: #{hash_table.get("name")}"
  puts "Get age: #{hash_table.get("age")}"
  puts "Get unknown key: #{hash_table.get("unknown")}"
  
  puts "Keys: #{hash_table.keys}"
  puts "Values: #{hash_table.values}"
  puts "Size: #{hash_table.size}"
  puts "Load factor: #{hash_table.load_factor}"
  
  hash_table.display
  
  hash_table.delete("age")
  puts "After deleting age:"
  puts "Keys: #{hash_table.keys}"
  puts "As hash: #{hash_table.to_hash}"
end