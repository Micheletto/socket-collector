# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
Gem::Specification.new do |s|
  s.name          = 'socket-collector'
  s.version       = '1.0.2'
  s.summary       = 'Socket collector for statsd'
  s.description   = 'A statsd collector for TCP socket states.'
  s.authors       = ['Bob Micheletto']
  s.email         = 'bobm@mozilla.com'
  s.files         = ['bin/socket-collector.rb', 'lib/socket-collector/socket_count.rb', 'lib/socket-collector/statdsend.rb', 'LICENSE', 'README.md']
  s.executables   << 'socket-collector.rb'
  s.homepage      = 'https://github.com/Micheletto/socket-collector'
end
