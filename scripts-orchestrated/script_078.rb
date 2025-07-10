class HashTable
  def initialize(size = 10)
    @size = size
    @buckets = Array.new(size) { [] }
  end

  def hash_function(key)
    key.to_s.bytes.sum % @size
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

  def remove(key)
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
end

def hash_table_simple
  hash_table = HashTable.new(5)
  
  hash_table.put("name", "Alice")
  hash_table.put("age", 30)
  hash_table.put("city", "New York")
  
  puts "Get name: #{hash_table.get("name")}"
  puts "Get age: #{hash_table.get("age")}"
  puts "Get city: #{hash_table.get("city")}"
  puts "Get non-existent: #{hash_table.get("country")}"
  
  puts "All keys: #{hash_table.keys}"
  puts "All values: #{hash_table.values}"
  
  hash_table.remove("age")
  puts "After removing age: #{hash_table.keys}"
  
  hash_table
end

if __FILE__ == $0
  hash_table_simple
end