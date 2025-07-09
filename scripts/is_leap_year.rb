def is_leap_year(year)
  return false if year % 4 != 0
  return true if year % 100 != 0
  return true if year % 400 == 0
  false
end