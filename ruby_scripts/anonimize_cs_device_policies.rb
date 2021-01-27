def register(params)
	@days_to_add = params["days_to_add"]
end

def parse_and_add_days(date_string, days_to_add)
	$date = DateTime::parse(date_string)
	$date = $date + days_to_add
	return $date
end

def hash_array(array)
	array.each_with_index do |element, index|
		$digest = Digest::SHA2.new(512).hexdigest element.to_s
		array[index] = $digest	
	end
	return array
end

def filter(event)
	event.get("policies").each_with_index do |policy, index|
		$digest = Digest::SHA2.new(512).hexdigest policy["policy_id"]
		event.set("[policies][" + index.to_s + "][policy_id]", $digest)
		$digest = Digest::SHA2.new(512).hexdigest policy["settings_hash"]
		event.set("[policies][" + index.to_s + "][settings_hash]", $digest)
		$date = parse_and_add_days(policy["applied_date"], @days_to_add)
		event.set("[policies][" + index.to_s + "][applied_date]", $date.to_s)
		$date = parse_and_add_days(policy["assigned_date"], @days_to_add)
		event.set("[policies][" + index.to_s + "][assigned_date]", $date.to_s)
		event.set("[policies][" + index.to_s + "][rule_groups]", hash_array(policy["rule_groups"]))
	end
	return [event]
end