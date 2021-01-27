def register(params)
	@days_to_add = params["days_to_add"]
end

def parse_and_add_days(date_string, days_to_add)
	$date = DateTime::parse(date_string)
	$date = $date + days_to_add
	return $date
end

def filter(event)
	event.get("groups").each_with_index do |group, index|
		$digest = Digest::SHA2.new(512).hexdigest group["modified_by"]
		event.set("[groups][" + index.to_s + "][modified_by]", $digest)
		$digest = Digest::SHA2.new(512).hexdigest group["created_by"]
		event.set("[groups][" + index.to_s + "][created_by]", $digest)
		$digest = Digest::SHA2.new(512).hexdigest group["assignment_rule"]
		event.set("[groups][" + index.to_s + "][assignment_rule]", $digest)
		$digest = Digest::SHA2.new(512).hexdigest group["id"]
		event.set("[groups][" + index.to_s + "][id]", $digest)
		$digest = Digest::SHA2.new(512).hexdigest group["name"]
		event.set("[groups][" + index.to_s + "][name]", $digest)
		$date = parse_and_add_days(group["created_timestamp"], @days_to_add)
		event.set("[groups][" + index.to_s + "][created_timestamp]", $date.to_s)
		$date = parse_and_add_days(group["modified_timestamp"], @days_to_add)
		event.set("[groups][" + index.to_s + "][modified_timestamp]", $date.to_s)
	end
	return [event]
end