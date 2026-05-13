# IDEAS:
# - Constructors: now_utc(), now_local().
# - Converters: to_timestamp().

## @experimental: This class could change.
## Some time that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require time data. If you want to save this data, [TimestampData] is much more efficient.

class_name TimeData extends Resource


#region variables
@export var hour := 0
@export var minute := 0
@export var second := 0
@export var millisecond := 0
@export var microsecond := 0
#endregion variables


#region methods
static func from_hms(p_hour: int, p_minute: int, p_second: int) -> TimeData:
	var new_time := TimeData.new()
	new_time.hour = p_hour
	new_time.minute = p_minute
	new_time.second = p_second
	return new_time
#endregion methods
