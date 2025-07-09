def quadratic_formula(a, b, c)
  return nil if a == 0
  
  discriminant = b ** 2 - 4 * a * c
  
  return nil if discriminant < 0
  
  if discriminant == 0
    [-b / (2 * a)]
  else
    sqrt_discriminant = Math.sqrt(discriminant)
    [
      (-b + sqrt_discriminant) / (2 * a),
      (-b - sqrt_discriminant) / (2 * a)
    ]
  end
end