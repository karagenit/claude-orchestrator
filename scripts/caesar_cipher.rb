def caesar_cipher(text, shift)
  result = ""
  
  text.each_char do |char|
    if char.match(/[a-zA-Z]/)
      base = char.ord < 97 ? 65 : 97
      shifted = ((char.ord - base + shift) % 26) + base
      result += shifted.chr
    else
      result += char
    end
  end
  
  result
end