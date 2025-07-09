require 'date'

def calculate_age(birth_date, current_date = Date.today)
  begin
    birth = Date.parse(birth_date.to_s)
    current = Date.parse(current_date.to_s)
    
    age = current.year - birth.year
    
    if current.month < birth.month || (current.month == birth.month && current.day < birth.day)
      age -= 1
    end
    
    age
  rescue ArgumentError
    nil
  end
end