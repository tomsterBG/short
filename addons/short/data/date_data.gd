# TODO:
# - Write in notes something about moving from var weekday to get_weekday().
# 	- Part of it is, the weekday can be inferred from year, month, day.
# 	- Having var weekday and get_weekday() hides the fact that weekday runs get_weekday().
# - Change DateData to DateContext, TimeData to TimeContext, DateTimeData to DateTimeContext.
# 	- Rename and move them to a different folder before any changes to preserve Git history.
# 	- Rename their scripts and test scripts and entries in script_order_hook.
# 	- Change them to RefCounted to ensure no ability to be saved to disk. This is for TimestampData.
# 	- Ensure full compatibility with TimestampData for proper work within needed context.
# IDEAS:
# - Constructors: from_date_dict().
# - Converters: to_date_dict().
# - Helpers: is_valid().
# BAD IDEAS:
# - Use now_utc(), now_local() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some date that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require date data. If you want to save this data, [TimestampData] is much more efficient.
##[br][br][b]Note:[/b] This assumes that the [DateTimeLib] and [TimestampData] classes exist.

class_name DateData extends Resource


#region variables
@export var year := 1
@export var month := Time.MONTH_JANUARY
@export var day := 1
#endregion variables


#region getters
func get_weekday() -> Time.Weekday:
	return DateTimeLib.get_weekday_of_date(self)
#endregion getters


#region methods
static func from_ymd(p_year: int, p_month: Time.Month, p_day: int) -> DateData:
	var new_date := DateData.new()
	new_date.year = p_year
	new_date.month = p_month
	new_date.day = p_day
	return new_date

func to_timestamp() -> TimestampData:
	var datetime_dict := {year = year, month = month, day = day}
	var new_timestamp := TimestampData.new(Time.get_unix_time_from_datetime_dict(datetime_dict))
	return new_timestamp
#endregion methods
