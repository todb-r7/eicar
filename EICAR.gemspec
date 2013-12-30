lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eicar/version'

Gem::Specification.new do |spec|
  spec.name = 'EICAR'
  spec.version = EICAR::VERSION
  spec.authors = ["Tod Beardsley"]
  spec.email = ["tod_beardsley@rapid7.com"]
  spec.summary = "A gem to test local anti-virus filesystem coverage"
  spec.description = %q{
    This gem is designed to fail in the face of anti-virus coverage
    of your gem path. If you are running anti-virus systemwide, this
    gem will not load since it will be deleted or quarantined.
  }
  spec.homepage = "https://github.com/todb-r7/eicar"
  spec.license = "BSD 3-Clause"
  spec.files = `git ls-files`.split($/)
  spec.require_paths = ["lib"]
end
