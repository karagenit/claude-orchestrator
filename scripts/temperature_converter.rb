def temperature_converter(temp, from_unit, to_unit)
  from_unit = from_unit.downcase
  to_unit = to_unit.downcase
  
  return temp if from_unit == to_unit
  
  celsius = case from_unit
  when 'fahrenheit', 'f'
    (temp - 32) * 5.0 / 9.0
  when 'kelvin', 'k'
    temp - 273.15
  when 'celsius', 'c'
    temp
  else
    return nil
  end
  
  case to_unit
  when 'fahrenheit', 'f'
    celsius * 9.0 / 5.0 + 32
  when 'kelvin', 'k'
    celsius + 273.15
  when 'celsius', 'c'
    celsius
  else
    nil
  end
end