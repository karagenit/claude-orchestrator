def colorize_text(text, color)
  colors = {
    'black' => 30,
    'red' => 31,
    'green' => 32,
    'yellow' => 33,
    'blue' => 34,
    'magenta' => 35,
    'cyan' => 36,
    'white' => 37
  }
  
  color_code = colors[color.downcase]
  return text unless color_code
  
  "\e[#{color_code}m#{text}\e[0m"
end