# IDEAS:
# - Constructors:
# - Converters: to_datetime().

## @experimental: This class could change.
## A Unix timestamp that can be saved to disk, or passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] Excellent for being saved to disk and for doing date math.
##[br][br][b]Note:[/b] This assumes that the [Convert], [DateData] and [TimeData] classes exist.

class_name TimestampData extends Resource


#region variables
## Unix timestamp.
@export var timestamp := 0.0
#endregion variables


#region methods
## Creates a timestamp now in UTC.
static func now_utc() -> TimestampData:
	var new_timestamp := TimestampData.new()
	new_timestamp.timestamp = Time.get_unix_time_from_system()
	return new_timestamp

## Creates a timestamp now in local time.
static func now_local() -> TimestampData:
	var new_timestamp := TimestampData.new()
	new_timestamp.timestamp = Time.get_unix_time_from_system() + Time.get_time_zone_from_system().bias * 60
	return new_timestamp

## Converts this timestamp to a [DateData] object.
func to_date() -> DateData:
	var date_dict := Time.get_date_dict_from_unix_time(int(timestamp))
	var new_date := DateData.from_ymwd(date_dict.year, date_dict.month, date_dict.weekday, date_dict.day)
	return new_date

## Converts this timestamp to a [TimeData] object.
func to_time() -> TimeData:
	var time_dict := Time.get_time_dict_from_unix_time(int(timestamp))
	var new_time := TimeData.from_hms(time_dict.hour, time_dict.minute, time_dict.second)
	var milliseconds := Convert.sec_to_msec(timestamp - int(timestamp))
	new_time.millisecond = int(milliseconds)
	new_time.microsecond = int(Convert.msec_to_usec(milliseconds - new_time.millisecond))
	return new_time
#endregion methods


#region virtual
func _init(p_timestamp := 0.0) -> void:
	timestamp = p_timestamp
#region virtual
