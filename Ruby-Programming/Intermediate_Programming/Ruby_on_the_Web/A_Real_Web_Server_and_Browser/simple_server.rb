require "socket"    # Get sockets from stdlib
require "json"

server = TCPServer.open(2000)    #  Socket listens on port 2000
loop {    #Server runs forever
  client = server.accept    # Wait for client(TCPSocket) to connect

  # Get HTTP request from browser
  # If it is a GET request to /index.html, send the contents of index.html
  request = ""
  while line = client.gets
    request << line
    break if request =~ /\r\n\r\n/
  end
  method = request.split[0]
  path = request.split[1][1..-1]

  status = ""
  response_head = ""
  response_body = ""

  case method
  when "GET"
    if File.exists?(path)
      puts "HERE"
      response_body = (File.open(path, "r")).read

      status = "200"
      response_head = "HTTP/1.0 #{status} OK\n"
      response_head += "Date: #{Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S')} GMT\r\n"
      response_head += "Content-Type: #{response_body.length}\r\n"
      response_head +="Content-Length: #{File.size(path)}\r\n"
      response_head += "\r\n"
    else
      status = "404"
      response_head = "HTTP/1.0 #{status} Not Found\n"
      response_head += "Date: #{Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S')} GMT\r\n"
    end
  when "POST"
    if File.exists?(path)
    body = ""
    while line = client.gets
      body << line
      break if body =~ /\r\n\r\n$/
    end
    body = body.chomp.chomp #remove the double newline

    # Parse JSON into HTML
    params = {}
    params = JSON.parse(body)
    entries = ""
    counter = 0
    counter_max = (params["viking"].length) - 1
    params["viking"].each do |key, value|
      entries += "<li>#{key}: #{value}</li>"
      entries += "\n\      " unless counter == counter_max
      counter += 1
    end

    # Open file and replace with entries
    file = File.open(path)
    response_body = file.read.gsub("<%= yield %>", entries)
    response_head = ""
    response_head += "HTTP/1.0 200 OK\n"
    response_head += "Content-Length: #{response_body.length}\r\n\r\n"
    else
      status = "404"
      response_head = "HTTP/1.0 #{status} Not Found\n"
      response_head += "Date: #{Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S')} GMT\r\n"
    end
  end

  client.puts response_head
  client.puts response_body
  client.close    # Disconnect from the client
}
