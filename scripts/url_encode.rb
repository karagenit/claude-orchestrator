def url_encode(str)
  encoded = ""
  
  str.each_char do |char|
    if char.match(/[A-Za-z0-9\-_.~]/)
      encoded += char
    else
      encoded += "%" + char.ord.to_s(16).upcase.rjust(2, '0')
    end
  end
  
  encoded
end