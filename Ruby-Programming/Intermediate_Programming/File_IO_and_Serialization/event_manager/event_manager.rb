require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

# Clean up phone number input
# Get only integers if user used seperators
# If the phone number is less than 10 digits assume that it is a bad number
# If the phone number is 10 digits assume that it is good
# If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
# If the phone number is 11 digits and the first number is not 1, then it is a bad number
# If the phone number is more than 11 digits assume that it is a bad number
def clean_phone_numbers(phone_number)
  if phone_number.nil?
    "0000000000"
  else
    numbers = ""
    phone_number.split("").each do |num|
      if num =~ /[[:digit:]]/
        numbers << num
      end
    end

    # Check validity of numbers
    if numbers.length < 10
      numbers = "0000000000"
    elsif numbers.length == 11
      if numbers[0] == "1"
        numbers[1..10]
      else
        numbers = "0000000000"
      end
    elsif numbers.length > 11
      numbers = "0000000000"
    else
      numbers
    end
  end
end

=begin
def clean_zipcode(zipcode)
  if zipcode.nil?
    "00000"
  elsif zipcode.length < 5
    zipcode.rjust(5,"0")
  elsif zipcode.length > 5
    zipcode[0..4]
  else
    zipcode
  end
end
=end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
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

def save_number_letters(id,number_letter)
  Dir.mkdir("output2") unless Dir.exists?("output2")

  filename = "output2/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts number_letter
  end
end

=begin
Using the registration date and time we want to find out what are the peak registration hours.
Ruby has a Date library which contains classes for Date and DateTime.
DateTime#strptime is a method that allows us to parse date-time strings and convert them into Ruby objects.
DateTime#strftime is a good reference on the characters necessary to match the specified date-time format.
Use Date#hour to find out the hour of the day.
=end
def find_peak_registration_hours(contents)
  hours = Hash.new(0)
  contents.each do |row|
  date_time = row[:regdate]
  hour = DateTime.strptime(date_time, "%m/%d/%y %H:%M").hour
  hours[hour] += 1
end

hours = hours.sort_by { |hour, num| num}.reverse
puts "The peak hours are:"
hours.each do |hour, num|
  puts "#{hour}:00 with #{num} registerations"
  end
puts ""
end

=begin
The big boss gets excited about the results from your hourly tabulations.
It looks like there are some hours that are clearly more important than others.
But now, tantalized, she wants to know "What days of the week did most people
register?"
=end
def find_peak_day_of_week(contents)
  days = Hash.new(0)
  contents.each do |row|
  date_time = row[:regdate]
  day = DateTime.strptime(date_time, "%m/%d/%y %H:%M").wday
  days[day] += 1
end

days = days.sort_by { |day, num| num}.reverse
puts "The peak days are:"
days.each do |day, num|

  day = day.to_s
  day_of_week = ""

  case day
  when "0"
    day_of_week = "Sunday"
  when "1"
    day_of_week = "Monday"
  when "2"
    day_of_week = "Tuesday"
  when "3"
    day_of_week = "Wednesday"
  when "4"
    day_of_week = "Thursday"
  when "5"
    day_of_week = "Friday"
  when "6"
    day_of_week = "Saturday"
  else
    # should not reach this line
  end

  puts "#{day_of_week} with #{num} registerations"
  end
puts ""
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_numbers(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)
end

# Could combine following runs with the above run to run more efficiently,
# it is currently split to better see how each iteration is done

# Iteration: Clean Phone Numbers

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_data = File.read "number_letter.erb"
erb_template = ERB.new template_data

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone_number = clean_phone_numbers(row[:homephone])

  number_letter = erb_template.result(binding)

  save_number_letters(id, number_letter)
end

# Iteration: Time Targeting

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
find_peak_registration_hours(contents)

# Iteration: Day of the Week Targeting
contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
find_peak_day_of_week(contents)

puts "DONE"
