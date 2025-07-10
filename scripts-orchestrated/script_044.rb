def slug_generator(text, options = {})
  return "" if text.nil? || text.strip.empty?
  
  separator = options[:separator] || '-'
  max_length = options[:max_length] || 100
  preserve_case = options[:preserve_case] || false
  
  slug = text.strip
  
  slug = slug.downcase unless preserve_case
  
  slug = transliterate_unicode(slug)
  
  slug = slug.gsub(/[''`]/, '')
  
  slug = slug.gsub(/[^\w\s#{Regexp.escape(separator)}]/, '')
  
  slug = slug.gsub(/\s+/, separator)
  
  slug = slug.gsub(/#{Regexp.escape(separator)}+/, separator)
  
  slug = slug.gsub(/\A#{Regexp.escape(separator)}+|#{Regexp.escape(separator)}+\z/, '')
  
  if slug.length > max_length
    slug = slug[0, max_length]
    if slug.include?(separator)
      parts = slug.split(separator)
      while parts.join(separator).length > max_length && parts.length > 1
        parts.pop
      end
      slug = parts.join(separator)
    end
  end
  
  slug
end

def transliterate_unicode(text)
  transliterations = {
    'à' => 'a', 'á' => 'a', 'â' => 'a', 'ã' => 'a', 'ä' => 'a', 'å' => 'a', 'æ' => 'ae',
    'ç' => 'c', 'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e', 'ì' => 'i', 'í' => 'i',
    'î' => 'i', 'ï' => 'i', 'ð' => 'd', 'ñ' => 'n', 'ò' => 'o', 'ó' => 'o', 'ô' => 'o',
    'õ' => 'o', 'ö' => 'o', 'ø' => 'o', 'ù' => 'u', 'ú' => 'u', 'û' => 'u', 'ü' => 'u',
    'ý' => 'y', 'þ' => 'th', 'ÿ' => 'y', 'ß' => 'ss',
    'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ã' => 'A', 'Ä' => 'A', 'Å' => 'A', 'Æ' => 'AE',
    'Ç' => 'C', 'È' => 'E', 'É' => 'E', 'Ê' => 'E', 'Ë' => 'E', 'Ì' => 'I', 'Í' => 'I',
    'Î' => 'I', 'Ï' => 'I', 'Ð' => 'D', 'Ñ' => 'N', 'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O',
    'Õ' => 'O', 'Ö' => 'O', 'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U', 'Û' => 'U', 'Ü' => 'U',
    'Ý' => 'Y', 'Þ' => 'TH', 'Ÿ' => 'Y'
  }
  
  result = text.dup
  transliterations.each do |unicode_char, ascii_char|
    result = result.gsub(unicode_char, ascii_char)
  end
  
  result
end

if __FILE__ == $0
  test_strings = [
    "Hello World!",
    "The Quick Brown Fox",
    "CamelCase Example",
    "Special @#$% Characters!!!",
    "   Extra   Spaces   ",
    "café & résumé",
    "múltiple---dashes",
    "This is a very long string that should be truncated to fit within the maximum length limit",
    "混合中文English",
    ""
  ]
  
  test_strings.each do |text|
    slug = slug_generator(text)
    puts "\"#{text}\" -> \"#{slug}\""
  end
  
  puts "\nWith custom options:"
  puts slug_generator("Hello World!", separator: '_', max_length: 20)
  puts slug_generator("Hello World!", preserve_case: true)
end