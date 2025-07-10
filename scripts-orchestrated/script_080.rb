class TrieNode
  attr_accessor :children, :is_end_of_word

  def initialize
    @children = {}
    @is_end_of_word = false
  end
end

class Trie
  def initialize
    @root = TrieNode.new
  end

  def insert(word)
    node = @root
    
    word.each_char do |char|
      unless node.children[char]
        node.children[char] = TrieNode.new
      end
      node = node.children[char]
    end
    
    node.is_end_of_word = true
  end

  def search(word)
    node = find_node(word)
    node && node.is_end_of_word
  end

  def starts_with(prefix)
    find_node(prefix) != nil
  end

  def find_node(word)
    node = @root
    
    word.each_char do |char|
      return nil unless node.children[char]
      node = node.children[char]
    end
    
    node
  end

  def all_words_with_prefix(prefix)
    words = []
    node = find_node(prefix)
    
    return words unless node
    
    collect_words(node, prefix, words)
    words
  end

  private

  def collect_words(node, current_word, words)
    words << current_word if node.is_end_of_word
    
    node.children.each do |char, child_node|
      collect_words(child_node, current_word + char, words)
    end
  end
end

def trie_insert
  trie = Trie.new
  
  words = ["apple", "app", "apricot", "banana", "band", "bandana"]
  
  words.each { |word| trie.insert(word) }
  
  puts "Inserted words: #{words}"
  
  test_words = ["app", "apple", "appl", "banana", "band", "orange"]
  test_words.each do |word|
    puts "#{word} in trie: #{trie.search(word)}"
  end
  
  puts "Words with prefix 'app': #{trie.all_words_with_prefix("app")}"
  puts "Words with prefix 'ban': #{trie.all_words_with_prefix("ban")}"
  
  trie
end

if __FILE__ == $0
  trie_insert
end