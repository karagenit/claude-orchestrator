def volume_of_sphere(radius)
  return 0 if radius <= 0
  
  (4.0 / 3.0) * Math::PI * radius ** 3
end