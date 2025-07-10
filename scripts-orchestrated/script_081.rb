class LRUCache
  def initialize(capacity)
    @capacity = capacity
    @cache = {}
    @order = []
  end

  def get(key)
    if @cache.key?(key)
      @order.delete(key)
      @order.push(key)
      @cache[key]
    else
      nil
    end
  end

  def put(key, value)
    if @cache.key?(key)
      @order.delete(key)
    elsif @cache.size >= @capacity
      oldest_key = @order.shift
      @cache.delete(oldest_key)
    end
    
    @cache[key] = value
    @order.push(key)
  end

  def size
    @cache.size
  end

  def capacity
    @capacity
  end
end

def lru_cache(capacity)
  cache = LRUCache.new(capacity)
  
  cache.put("key1", "value1")
  cache.put("key2", "value2")
  cache.put("key3", "value3")
  
  puts "Get key1: #{cache.get("key1")}"
  puts "Get key2: #{cache.get("key2")}"
  puts "Cache size: #{cache.size}"
  
  cache.put("key4", "value4")
  puts "After adding key4, get key3: #{cache.get("key3")}"
  
  cache
end