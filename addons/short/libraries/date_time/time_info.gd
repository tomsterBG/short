# IDEAS:
# - Constructors: from_hmsmu(), from_time_dict().
# - Converters: to_timestamp().
# - Helpers: is_valid().
# BAD IDEAS:
# - Use now() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some time that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require time data. If you want to save this data, use [TimestampData].

class_name TimeInfo extends RefCounted


#region variables
var hour := 0
var minute := 0
var second := 0
var millisecond := 0
var microsecond := 0
#endregion variables


#region methods
static func from_hms(p_hour: int, p_minute: int, p_second: int) -> TimeInfo:
	var new_time := TimeInfo.new()
	new_time.hour = p_hour
	new_time.minute = p_minute
	new_time.second = p_second
	return new_time

func to_timestamp() -> TimestampData:
	var datetime_dict := {hour = hour, minute = minute, second = second}
	var new_timestamp := TimestampData.new(Time.get_unix_time_from_datetime_dict(datetime_dict)
		+ Convert.msec_to_sec(millisecond) + Convert.usec_to_sec(microsecond))
	return new_timestamp
#endregion methods
