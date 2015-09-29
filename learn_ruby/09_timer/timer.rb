class Timer
	def initialize()
		@seconds = 0
		@time_string = ""
	end

	def seconds=(new_Seconds)
		@seconds = new_Seconds
		@time_string = setTime(@seconds)
	end

	def seconds
		@seconds
	end

	def time_string
		@time_string
	end
end

# 1hr = 3600 seconds
# 1min = 60 seconds
# Format to 00:00:00
def setTime(seconds)
	timer = ""
	counter = 0

	# Get hours
	while seconds >= 3600
		seconds = seconds - 3600
		counter += 1
	end

	# Convert number of hours to string
	timer = timer + "0" + counter.to_s + ":"
	counter = 0

	# Get minutes
	while seconds >= 60
		seconds = seconds - 60
		counter += 1
	end

	# Convert number of minutes to string
	timer = timer + "0" + counter.to_s + ":"
	counter = 0

	# Set seconds
	if seconds < 10
		timer = timer + "0" + seconds.to_s
	else
		timer = timer + seconds.to_s
	end

	return timer
end