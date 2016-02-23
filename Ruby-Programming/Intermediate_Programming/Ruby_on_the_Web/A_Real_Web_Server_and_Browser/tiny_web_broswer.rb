require 'socket'
require "json"

host = "localhost"     # The web server
port = 2000                           # Default HTTP port
socket = TCPSocket.open(host,port)  # Connect to server

puts "1. GET Request"
puts "2. POST Request"
print "Enter choice: "
choice = gets.chomp
puts ""

case choice
when "1"
  puts "GET initiated"
  puts ""

  path = "/index.html"                 # The file we want
  # This is the HTTP request we send to fetch a file
  request = "GET #{path} HTTP/1.0\r\n\r\n"

  socket.print(request)               # Send request
  response = socket.read              # Read complete response
  # Split response at first blank line into headers and body
  headers,body = response.split("\r\n\r\n", 2)
  print body                          # And display it
  puts ""
when "2"
  puts "POST initiated"
  puts ""

  path = "/thanks.html"
  print "Enter viking name: "
  name = gets.chomp
  print "Enter viking email: "
  email = gets.chomp

  viking = {viking: {name: name, email: email}}
  request_body = viking.to_json

  request_head = ""
  request_head += "POST #{path} HTTP/1.0\n"
  request_head += "From: #{email}\n"
  request_head += "User-Agent: TinyBrowser/1.0\n"
  request_head += "Content-Type: text/json\n"
  request_head += "Content-Length: #{request_body.size}\r\n\r\n"

  request = request_head + request_body + "\r\n\r\n"

  socket.print(request)               # Send request
  response = socket.read              # Read complete response
  # Split response at first blank line into headers and body
  headers,body = response.split("\r\n\r\n", 2)
  print body                          # And display it
  puts ""
end
