file = File.open("sample.txt", "r")
contents = file.read
puts contents   #=> Lorem ipsum etc.

contents = file.read
puts contents   #=> ""

