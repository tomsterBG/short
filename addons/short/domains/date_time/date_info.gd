# TODO:
# - Write in notes something about moving from var weekday to get_weekday().
# 	- Part of it is, the weekday can be inferred from year, month, day.
# 	- Having var weekday and get_weekday() hides the fact that weekday runs get_weekday().
# IDEAS:
# - Constructors:
# - Converters:
# - Helpers: is_valid()
# BAD IDEAS:
# - Use now() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some date that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require date data. If you want to save this data, use [TimestampData].
##[br][br][b]Note:[/b] This assumes that the [DateTimeLib] and [TimestampData] classes exist.

class_name DateInfo extends RefCounted


#region variables
## The year of this [DateInfo].
@export var year := 1
## The month of this [DateInfo].
@export var month := Time.MONTH_JANUARY
## The day of this [DateInfo].
@export var day := 1
#endregion variables


#region getters
## The weekday of this date.
func get_weekday() -> Time.Weekday:
	return DateTimeLib.get_weekday_of_date(self)
#endregion getters


#region methods
## Constructor from year, month and day.
static func from_ymd(p_year: int, p_month: Time.Month, p_day: int) -> DateInfo:
	var new_date := DateInfo.new()
	new_date.year = p_year
	new_date.month = p_month
	new_date.day = p_day
	return new_date

## Constructor from a date [Dictionary], typically received from [Time].
static func from_date_dict(date_dict: Dictionary) -> DateInfo:
	var new_date := DateInfo.new()
	new_date.year = date_dict.year
	new_date.month = date_dict.month
	new_date.day = date_dict.day
	return new_date

## Converts this instance to a date [Dictionary], typically received from [Time].
func to_date_dict() -> Dictionary:
	return {
		&"year": year,
		&"month": month,
		&"day": day,
		&"weekday": get_weekday(),
	}

## Converts this instance to [TimestampData].
func to_timestamp() -> TimestampData:
	var datetime_dict := {year = year, month = month, day = day}
	var new_timestamp := TimestampData.new(Time.get_unix_time_from_datetime_dict(datetime_dict))
	return new_timestamp
#endregion methods
