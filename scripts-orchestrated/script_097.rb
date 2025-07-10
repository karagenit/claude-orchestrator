def file_checksum(file_path, algorithm = 'md5')
  return nil if file_path.nil? || !File.exist?(file_path)
  
  require 'digest'
  
  begin
    case algorithm.downcase
    when 'md5'
      digest = Digest::MD5.new
    when 'sha1'
      digest = Digest::SHA1.new
    when 'sha256'
      digest = Digest::SHA256.new
    when 'sha512'
      digest = Digest::SHA512.new
    else
      return nil
    end
    
    File.open(file_path, 'rb') do |file|
      buffer = ''
      while file.read(8192, buffer)
        digest.update(buffer)
      end
    end
    
    digest.hexdigest
  rescue => e
    nil
  end
end

def verify_checksum(file_path, expected_checksum, algorithm = 'md5')
  actual_checksum = file_checksum(file_path, algorithm)
  return false if actual_checksum.nil?
  
  actual_checksum.downcase == expected_checksum.downcase
end