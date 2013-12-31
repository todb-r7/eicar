require 'eicar/version'

module EICAR

  # Antivirus should /not/ pick this up, ever.
  ROT13_DOWNCASE_EICAR = "k5b!c%@nc[4cmk54(c^)7pp)7}$rvpne-fgnaqneq-nagvivehf-grfg-svyr!$u+u*"

  def self.version
    EICAR::VERSION
  end

  class Error < StandardError
  end

  class EICARReadError < Error
  end

  def self.test_file_path
    lib_path = File.expand_path(File.dirname(__FILE__))
    bin_path = File.expand_path(File.join(lib_path, "..", "bin"))
    File.join(bin_path, "eicar.com")
  end

  def self.test_string
    begin
    data = File.open(self.test_file_path, "rb") {|f| f.read f.stat.size}
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

  def self.rot13(str)
    str.tr "A-Za-z", "N-ZA-Mn-za-m"
  end

  def self.create
    data = self.rot13(ROT13_DOWNCASE_EICAR).upcase
    File.open(self.test_file_path, "wb") {|f| f.write data}
  end

end

EICAR.test_string

