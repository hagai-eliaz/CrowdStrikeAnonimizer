def register(params)
	@field_name = params["field_name"]
end


def filter(event)
	$mac_addr = event.get(@field_name).split(/[\W]/)[0..2].join("-") + '-' + (['xx'] * 3).join('-')
	event.set(@field_name, $mac_addr.to_s)
	return [event]
end