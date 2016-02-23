file = File.open("sample.txt", 'r')
while !file.eof?
   line = file.readline
   puts line
end
