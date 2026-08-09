# IDEAS:
# - Constructors:
# - Converters: to_datetime()

## @experimental: This class could change.
## A Unix timestamp that can be saved to disk, or passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] Excellent for being saved to disk and for doing date math.
##[br][br][b]Note:[/b] This assumes that the [Convert], [DateInfo] and [TimeInfo] classes exist.

class_name TimestampData extends Resource


#region variables
## Unix timestamp in UTC.
##[br][br][b]Note:[/b] It is recommended to always use UTC when storing or comparing timestamps. If you use local time, there's a problem. Imagine the user changes their timezone intentionally or by travelling somewhere. Now your timestamp is incorrect and you must convert it to the user's new timezone. This gets too complex too quickly.
##[br]Best practice: Only store timestamps in UTC and convert them to local when you need to show them to the user.
@export var timestamp := 0.0
#endregion variables


#region getters
## Returns a copy of this [TimestampData] in local time. Please read [member timestamp] before using.
func get_local() -> TimestampData:
	return TimestampData.new(timestamp + Time.get_time_zone_from_system().bias * 60)
#endregion getters


#region methods
## Creates a Unix timestamp now in UTC.
static func now() -> TimestampData:
	return TimestampData.new(Time.get_unix_time_from_system())

## Converts this timestamp to a [DateInfo] object.
func to_date() -> DateInfo:
	var date_dict := Time.get_date_dict_from_unix_time(int(timestamp))
	return DateInfo.from_ymd(date_dict.year, date_dict.month, date_dict.day)

## Converts this timestamp to a [TimeInfo] object.
func to_time() -> TimeInfo:
	var time_dict := Time.get_time_dict_from_unix_time(int(timestamp))
	var new_time := TimeInfo.from_hms(time_dict.hour, time_dict.minute, time_dict.second)
	var milliseconds := Convert.sec_to_msec(timestamp - int(timestamp))
	new_time.millisecond = int(milliseconds)
	new_time.microsecond = int(Convert.msec_to_usec(milliseconds - new_time.millisecond))
	return new_time
#endregion methods


#region virtual
func _init(p_timestamp := 0.0) -> void:
	timestamp = p_timestamp
#endregion virtual
