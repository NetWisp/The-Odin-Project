require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  number = []
  phone_number.to_s.each_char do |char|
    if char =~ /[[:digit:]]/
      number.push(char).to_s 
    end
  end
  
  size = number.size 
  number = number.join("")
  bad_number = "0000000000"

  if size < 10 
    return bad_number
  elsif size == 10
    return number 
  elsif size == 11 
    if number[0] == 1
      return number[1..-1]
    else
      return bad_number
    end 
  else 
    return bad_number
  end 
end 

def legislators_by_zipcode(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def peak_time(registration_times)
  hours = Hash.new(0)
  days = Hash.new(0)
  week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  
  registration_times.each do |time|
    hour=DateTime.strptime(time, '%m/%d/%y %H:%M').hour
    hours[hour] += 1
  end 

  sorted_hours = hours.sort { |l, r| r[1]<=>l[1] }
  puts "The most popular hours are #{sorted_hours[0][0]}:00 and #{sorted_hours[1][0]}:00"

  registration_times.each do |time|
    day=DateTime.strptime(time, '%m/%d/%y %H:%M').wday
    days[week[day]] += 1
  end 

  sorted_days = days.sort { |l, r| r[1]<=>l[1] }
  puts "The most popular days are #{sorted_days[0][0]} and #{sorted_days[1][0]}"
end 

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

registration_times = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone])
  registration_times << row[:regdate]

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
end

peak_time(registration_times)

