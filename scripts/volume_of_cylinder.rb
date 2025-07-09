def volume_of_cylinder(radius, height)
  return 0 if radius <= 0 || height <= 0
  
  Math::PI * radius ** 2 * height
end