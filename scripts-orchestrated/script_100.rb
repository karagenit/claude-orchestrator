def config_parser(config_file_path, format = 'ini')
  return {} if config_file_path.nil? || !File.exist?(config_file_path)
  
  begin
    case format.downcase
    when 'ini'
      parse_ini_config(config_file_path)
    when 'json'
      parse_json_config(config_file_path)
    when 'yaml', 'yml'
      parse_yaml_config(config_file_path)
    else
      parse_ini_config(config_file_path)
    end
  rescue => e
    {}
  end
end

def parse_ini_config(file_path)
  config = {}
  current_section = 'default'
  
  File.foreach(file_path) do |line|
    line.strip!
    next if line.empty? || line.start_with?('#') || line.start_with?(';')
    
    if line.match(/^\[(.+)\]$/)
      current_section = $1
      config[current_section] = {} unless config[current_section]
    elsif line.include?('=')
      key, value = line.split('=', 2)
      key.strip!
      value.strip!
      
      config[current_section] = {} unless config[current_section]
      config[current_section][key] = parse_value(value)
    end
  end
  
  config
end

def parse_json_config(file_path)
  require 'json'
  JSON.parse(File.read(file_path))
end

def parse_yaml_config(file_path)
  require 'yaml'
  YAML.load_file(file_path)
end

def parse_value(value)
  return true if value.downcase == 'true'
  return false if value.downcase == 'false'
  return value.to_i if value.match(/^\d+$/)
  return value.to_f if value.match(/^\d+\.\d+$/)
  
  value.gsub(/^["']|["']$/, '')
end