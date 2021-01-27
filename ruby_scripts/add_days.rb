def register(params)
	@days_to_add = params["days_to_add"]
	@field_name = params["field_name"]
end

def parse_and_add_days(date_string, days_to_add)
	$date = DateTime::parse(date_string)
	$date = $date + days_to_add
	return $date
end

def filter(event)
	$date = parse_and_add_days(event.get(@field_name), @days_to_add)
	event.set(@field_name, $date.to_s)
	return [event]
end