def uuid_generator
  chars = '0123456789abcdef'
  uuid = ''
  
  (0..35).each do |i|
    if [8, 13, 18, 23].include?(i)
      uuid += '-'
    elsif i == 14
      uuid += '4'
    elsif i == 19
      uuid += chars[8 + rand(4)]
    else
      uuid += chars[rand(16)]
    end
  end
  
  uuid
end