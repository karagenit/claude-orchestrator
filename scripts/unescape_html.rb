def unescape_html(str)
  return "" if str.nil?
  
  str.gsub('&amp;', '&')
     .gsub('&lt;', '<')
     .gsub('&gt;', '>')
     .gsub('&quot;', '"')
     .gsub('&#39;', "'")
end