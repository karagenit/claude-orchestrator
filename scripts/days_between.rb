require 'date'

def days_between(date1, date2)
  begin
    d1 = Date.parse(date1.to_s)
    d2 = Date.parse(date2.to_s)
    (d2 - d1).to_i
  rescue ArgumentError
    nil
  end
end