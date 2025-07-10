def md5_hash(string)
  return '' if string.nil?
  
  message = string.dup
  original_length = message.length
  
  message += "\x80"
  
  while (message.length % 64) != 56
    message += "\x00"
  end
  
  message += [original_length * 8].pack('Q<')
  
  h = [0x67452301, 0xEFCDAB89, 0x98BADCFE, 0x10325476]
  
  s = [
    7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
    5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
    4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
    6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21
  ]
  
  k = [
    0xD76AA478, 0xE8C7B756, 0x242070DB, 0xC1BDCEEE, 0xF57C0FAF, 0x4787C62A, 0xA8304613, 0xFD469501,
    0x698098D8, 0x8B44F7AF, 0xFFFF5BB1, 0x895CD7BE, 0x6B901122, 0xFD987193, 0xA679438E, 0x49B40821,
    0xF61E2562, 0xC040B340, 0x265E5A51, 0xE9B6C7AA, 0xD62F105D, 0x02441453, 0xD8A1E681, 0xE7D3FBC8,
    0x21E1CDE6, 0xC33707D6, 0xF4D50D87, 0x455A14ED, 0xA9E3E905, 0xFCEFA3F8, 0x676F02D9, 0x8D2A4C8A,
    0xFFFA3942, 0x8771F681, 0x6D9D6122, 0xFDE5380C, 0xA4BEEA44, 0x4BDECFA9, 0xF6BB4B60, 0xBEBFBC70,
    0x289B7EC6, 0xEAA127FA, 0xD4EF3085, 0x04881D05, 0xD9D4D039, 0xE6DB99E5, 0x1FA27CF8, 0xC4AC5665,
    0xF4292244, 0x432AFF97, 0xAB9423A7, 0xFC93A039, 0x655B59C3, 0x8F0CCC92, 0xFFEFF47D, 0x85845DD1,
    0x6FA87E4F, 0xFE2CE6E0, 0xA3014314, 0x4E0811A1, 0xF7537E82, 0xBD3AF235, 0x2AD7D2BB, 0xEB86D391
  ]
  
  (0...message.length).step(64) do |chunk_start|
    chunk = message[chunk_start, 64]
    w = chunk.unpack('V16')
    
    a, b, c, d = h
    
    (0...64).each do |i|
      if i < 16
        f = (b & c) | (~b & d)
        g = i
      elsif i < 32
        f = (d & b) | (~d & c)
        g = (5 * i + 1) % 16
      elsif i < 48
        f = b ^ c ^ d
        g = (3 * i + 5) % 16
      else
        f = c ^ (b | ~d)
        g = (7 * i) % 16
      end
      
      f = (f + a + k[i] + w[g]) & 0xFFFFFFFF
      a = d
      d = c
      c = b
      b = (b + left_rotate(f, s[i])) & 0xFFFFFFFF
    end
    
    h[0] = (h[0] + a) & 0xFFFFFFFF
    h[1] = (h[1] + b) & 0xFFFFFFFF
    h[2] = (h[2] + c) & 0xFFFFFFFF
    h[3] = (h[3] + d) & 0xFFFFFFFF
  end
  
  h.pack('V4').unpack('H*').first
end

def left_rotate(value, amount)
  ((value << amount) | (value >> (32 - amount))) & 0xFFFFFFFF
end

def md5_hash_with_steps(string)
  return { hash: '', steps: [] } if string.nil?
  
  steps = []
  steps << "Input: #{string.inspect}"
  steps << "Length: #{string.length} bytes"
  
  hash = md5_hash(string)
  steps << "MD5 Hash: #{hash}"
  
  { hash: hash, steps: steps }
end

if __FILE__ == $0
  test_strings = [
    "",
    "a",
    "abc",
    "message digest",
    "abcdefghijklmnopqrstuvwxyz",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
    "The quick brown fox jumps over the lazy dog",
    "Hello World!"
  ]
  
  puts "MD5 Hash Examples:"
  puts "=" * 60
  
  test_strings.each do |string|
    hash = md5_hash(string)
    puts "Input:  #{string.inspect}"
    puts "MD5:    #{hash}"
    puts
  end
  
  puts "Known test vectors:"
  known_vectors = [
    ["", "d41d8cd98f00b204e9800998ecf8427e"],
    ["a", "0cc175b9c0f1b6a831c399e269772661"],
    ["abc", "900150983cd24fb0d6963f7d28e17f72"],
    ["message digest", "f96b697d7cb7938d525a2f31aaf161d0"],
    ["The quick brown fox jumps over the lazy dog", "9e107d9d372bb6826bd81d3542a419d6"]
  ]
  
  known_vectors.each do |input, expected|
    calculated = md5_hash(input)
    status = calculated == expected ? "✓" : "✗"
    puts "#{status} #{input.inspect} -> #{calculated} (expected: #{expected})"
  end
end