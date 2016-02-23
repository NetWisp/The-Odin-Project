require "socket"    # Sockets are in standard library

hostname = "localhost"
port = 2000

s = TCPSocket.open(hostname, port)

while line = s.gets    # Read lines from socket
  puts line.chop       # Print with platform line terminator
end

s.close    # Close the socket when done
