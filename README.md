eicar
=====

EICAR test string for anti-virus functionality detection

Usage
=====

If you believe you have anti-virus checking your rubygems install path,
you can check to make sure with simply:

````ruby
require 'eicar'
````

If anti-virus is active, this will raise `EICAR::EICARReadError`.
Therefore, code that wants anti-virus active should `rescue` this on
load. I know, it's a little backwards.

Code exercising this might look like this:

````
#!/usr/bin/env ruby

begin
  require 'eicar'
rescue EICAR::EICARReadError
  @antivirus_active = true
end
````

TODO
====

Actual specs for testing

