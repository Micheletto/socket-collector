# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Libraries
require "socket"

# Class to make UDP connections to statsd, and send timers
class Statsd

  # Deliver counter to statsd
  def send (counter, data)
    # Send the message to statsd.
    usocket = UDPSocket.new
    usocket.connect('127.0.0.1', '8125')
    usocket.send("#{counter}:#{data}|c", 0)
  end

end
