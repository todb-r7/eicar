require 'eicar/version'

module EICAR

  def self.version
    EICAR::VERSION
  end

  class Error < StandardError
  end

  class EICARReadError < Error
  end

  def self.test_string
    lib_path = File.expand_path(File.dirname(__FILE__))
    bin_path = File.expand_path(File.join(lib_path, "..", "bin"))
    com_file = File.join(bin_path, "eicar.com")
    begin
    data = File.open(com_file, "rb") {|f| f.read f.stat.size}
    rescue SystemCallError
      raise EICAR::EICARReadError
    end
  end

  def self.antivirus_active?
    begin
      self.test_string
    rescue EICAR::EICARReadError
      return true
    end
    return false
  end

end

EICAR.test_string

