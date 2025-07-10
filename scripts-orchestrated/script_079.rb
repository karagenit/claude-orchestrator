class BloomFilter
  def initialize(size = 100, hash_count = 3)
    @size = size
    @hash_count = hash_count
    @bit_array = Array.new(size, false)
  end

  def hash_functions(item)
    hashes = []
    str = item.to_s
    
    (0...@hash_count).each do |i|
      hash_value = 0
      str.each_byte.with_index do |byte, index|
        hash_value = (hash_value * 31 + byte + i * 7) % @size
      end
      hashes << hash_value.abs
    end
    
    hashes
  end

  def add(item)
    hash_functions(item).each do |hash|
      @bit_array[hash] = true
    end
  end

  def might_contain?(item)
    hash_functions(item).all? { |hash| @bit_array[hash] }
  end

  def false_positive_rate
    set_bits = @bit_array.count(true)
    (1 - Math.exp(-@hash_count * set_bits.to_f / @size)) ** @hash_count
  end

  def size
    @size
  end

  def hash_count
    @hash_count
  end
end

def bloom_filter
  filter = BloomFilter.new(50, 3)
  
  items = ["apple", "banana", "cherry", "date", "elderberry"]
  
  items.each { |item| filter.add(item) }
  
  puts "Added items: #{items}"
  
  items.each do |item|
    puts "#{item} might be in filter: #{filter.might_contain?(item)}"
  end
  
  test_items = ["grape", "kiwi", "apple"]
  test_items.each do |item|
    puts "#{item} might be in filter: #{filter.might_contain?(item)}"
  end
  
  puts "Estimated false positive rate: #{filter.false_positive_rate.round(4)}"
  
  filter
end

if __FILE__ == $0
  bloom_filter
end