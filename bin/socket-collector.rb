#!/usr/bin/env ruby
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Script to enumerate arbitrary socket states and report them to statsd

# Libraries
require 'optparse'
require 'socket-collector/statdsend'
require 'socket-collector/socket_count'

# Defaults
options = {}

# Parse command line options.
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: [ -i SECONDS ] [ -s SOCKET STATES ] "

  options[:interval] = 60
  opts.on( '-i', '--interval SECONDS', "Seconds between checks. Defaults to " + options[:interval].to_s + " seconds.") do |sec|
    options[:interval] = sec
  end


  options[:states] = 'ESTABLISHED,TIME_WAIT,CLOSE_WAIT,LISTEN'
  opts.on( '-s', '--states SOCKET STATES', "Comma separated list of socket states") do |s|
    options[:states] = s
  end

  opts.on( '-h', '--help', "Display help information.") do
    puts opts
    exit
  end
end

# Make it happen.
optparse.parse!

# Parse socket types into array
s = options[:states].split(/,/)
i = options[:interval].to_i

# Build objects
st = Statsd.new()
r  = (0..(s.length - 1))
c  = Socket_counter.new(s)

# Main
loop do
  
  n = c.count
  r.each do |x|
    st.send("socket_count.#{s[x]}", n[x])
  end

  # Delay for interval
  sleep(i)
end
