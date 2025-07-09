def compound_interest(principal, rate, time, n = 1)
  return principal if rate == 0 || time == 0
  
  principal * ((1 + rate / n) ** (n * time))
end