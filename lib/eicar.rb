require 'eicar/version'

# The EICAR mixin. It's quite useful for EICAR things.
module EICAR

  # This is the EICAR test string, obfuscated as a downcased, ROT13
  # string. Antivirus should /not/ pick this up, ever, since it's out of
  # spec to try to decode it.
  #
  ROT13_DOWNCASE_EICAR = "k5b!c%@nc[4\\cmk54(c^)7pp)7}$rvpne-fgnaqneq-nagvivehf-grfg-svyr!$u+u*"

  # @return [String] The library/gem version.
  #
  def self.version
    EICAR::VERSION
  end

  # A generic Error class.
  # 
  class Error < StandardError
  end

  # Raised when there's a problem with reading the EICAR file.
  #
  class EICARReadError < Error
  end

  # Raised when there's a problem with writing the EICAR file.
  #
  class EICARWriteError < Error
  end

  # The default path for the EICAR test file. Usually, it will be in the
  # bin path of your GEM_HOME
  # @return [String] the full path of the EICAR test file
  #
  def self.test_file_path
    lib_path = File.expand_path(File.dirname(__FILE__))
    bin_path = File.expand_path(File.join(lib_path, "..", "bin"))
    File.join(bin_path, "eicar.com")
  end

  # The EICAR test string, as read from the test file path.
  # @return [String] the EICAR test string
  #
  def self.test_string
    begin
    data = File.open(self.test_file_path, "rb") {|f| f.read f.stat.size}
    rescue SystemCallError
      raise EICAR::EICARReadError
    end
  end

  # Tests if antivirus is active as far as the EICAR test file is
  # concerned.
  # @return [Boolean]
  #
  def self.antivirus_active?
    begin
      self.test_string
    rescue EICAR::EICARReadError
      return true
    end
    return false
  end

  # Creates a ROT13 encoded string.
  # @param str [String] the string to encode
  # @return [String] the encoded string
  #
  def self.rot13(str)
    str.tr "A-Za-z", "N-ZA-Mn-za-m"
  end

  # Creates the EICAR test file in a given path. If successful, returns
  # the path written to. Without an argument, it attempts to write to
  # the expected EICAR.test_file_path For system-wide gem installs, this
  # will usually need to be run as root, or else you'll raise.
  #
  # @param path [String] the path to write to
  # @return [String] the full, non-relative path written to
  #
  def self.create(path=self.test_file_path)
    write_data = self.rot13(ROT13_DOWNCASE_EICAR).upcase
    expanded_path = File.expand_path(path)

    begin
      File.open(expanded_path, "wb") {|f| f.write write_data}
    rescue SystemCallError
      raise EICAR::EICARWriteError
    end

    begin
      if File.readable? expanded_path
        read_data = File.open(expanded_path, "rb") {|f| f.read f.stat.size}
      end
    rescue SystemCallError
      raise EICAR::EICARReadError
    end

    if read_data == write_data
      return File.path(expanded_path)
    else
      raise EICAR::Error
    end
  end

end

EICAR.test_string

