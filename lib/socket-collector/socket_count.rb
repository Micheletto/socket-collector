# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class Socket_counter
  def initialize(sts = ['ESTABLISHED', 'TIME_WAIT', 'CLOSE_WAIT', 'LISTEN'])

    @state_types = {
      '01' => 'ESTABLISHED',
      '02' => 'SYN_SENT',
      '03' => 'SYN_RECV',
      '04' => 'FIN_WAIT1',
      '05' => 'FIN_WAIT2',
      '06' => 'TIME_WAIT',
      '07' => 'CLOSE',
      '08' => 'CLOSE_WAIT',
      '09' => 'LAST_ACK',
      '0A' => 'LISTEN',
      '0B' => 'CLOSING'
    }

    @socks = []
    sts.each do |type|
      raise "Unknown socket type #{type}" unless @state_types.has_value?(type)
      @socks.push(@state_types.index(type))
    end

  end

  def count
    h = Hash.new{ |k,v| h[v] = 0 }
    c = []

    IO.foreach('/proc/net/tcp') do |line|
      st = line.split(/\s+/, 6)[4]
      h[st] += 1
    end

    @socks.each do |type|
      c.push(h[type] * 30) # Temporary hack rate sampling is fixed
    end

    # Return c
    c
  end

end
