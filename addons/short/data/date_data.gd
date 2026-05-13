# IDEAS:
# - Constructors: from_date_dict().
# - Converters: to_timestamp().
# - Helpers: is_valid().
# BAD IDEAS:
# - Use now_utc(), now_local() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some date that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require date data. If you want to save this data, [TimestampData] is much more efficient.
##[br][br][b]Note:[/b] This assumes that the [DateTimeLib] class exists.

class_name DateData extends Resource


#region variables
@export var year := 0
@export var month := Time.MONTH_JANUARY
@export var weekday := Time.WEEKDAY_SUNDAY
@export var day := 0
#endregion variables


#region methods
static func from_ymd(p_year: int, p_month: Time.Month, p_day: int) -> DateData:
	var new_date := DateData.new()
	new_date.year = p_year
	new_date.month = p_month
	new_date.day = p_day
	new_date.weekday = DateTimeLib.get_weekday_of_date(new_date)
	return new_date

static func from_ymwd(p_year: int, p_month: Time.Month, p_weekday: Time.Weekday, p_day: int) -> DateData:
	var new_date := DateData.new()
	new_date.year = p_year
	new_date.month = p_month
	new_date.weekday = p_weekday
	new_date.day = p_day
	return new_date
#endregion methods
