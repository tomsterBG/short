# TODO:
# IDEAS:
# - Helpers: get_week(), get_month(), get_month_full_weeks() -> Array[DateInfo].

## @experimental: This class could change.
## Work with date and time.
##
## Available in all scripts without any setup.
##[br][br][b]Note:[/b] This assumes that the [Convert] and [DateInfo] classes exist.

@abstract class_name DateTimeLib extends Object


#region getters
## Returns the number of days in a given [param month]. Also depends on the [param year] because of [method is_leap_year].
static func get_days_in_month(month: Time.Month, year := 0) -> int:
	match month:
		Time.MONTH_APRIL, Time.MONTH_JUNE, Time.MONTH_SEPTEMBER, Time.MONTH_NOVEMBER:
			return 30
		Time.MONTH_FEBRUARY:
			return 29 if is_leap_year(year) else 28
		_:
			return 31

## Returns the number of days in a given [param year].
static func get_days_in_year(year: int) -> int:
	return 366 if is_leap_year(year) else 365

## Returns the day in the [param year] from [code]1[/code] to [code]366[/code].
static func get_day_in_year(date: DateInfo) -> int:
	var day_in_year := 0
	var month_idx := 1
	while month_idx < date.month:
		day_in_year += get_days_in_month(month_idx, date.year)
		month_idx += 1
	return day_in_year + date.day

## Returns the day in the [param year] since the first monday from [code]1[/code] to [code]371[/code].
static func get_day_since_first_monday(date: DateInfo) -> int:
	var week_number := get_iso_week_number(date)
	var weekday := get_iso_weekday_of_date(date)
	return ((week_number - 1) * 7) + weekday

## Returns the weekday of the current date in the [enum Time.Weekday] standard from [code]0[/code] to [code]6[/code].
static func get_weekday_of_date(date: DateInfo) -> Time.Weekday:
	var datetime_dict := Time.get_datetime_dict_from_datetime_string("%d-%d-%d" % [date.year, date.month, date.day], true)
	return datetime_dict.weekday

## Returns the weekday of the current date in the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard from [code]1[/code] to [code]7[/code].
static func get_iso_weekday_of_date(date: DateInfo) -> int:
	var datetime_dict := Time.get_datetime_dict_from_datetime_string("%d-%d-%d" % [date.year, date.month, date.day], true)
	return weekday_godot_to_iso(datetime_dict.weekday) as Time.Weekday

## Returns the number of weeks in a given [param year] according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
static func get_iso_weeks_in_year(year: int) -> int:
	var jan_1st := DateInfo.from_ymd(year, Time.MONTH_JANUARY, 1)
	var dec_31st := DateInfo.from_ymd(year, Time.MONTH_DECEMBER, 31)
	var weekday_of_1st_jan := get_iso_weekday_of_date(jan_1st)
	var weekday_of_31st_dec := get_iso_weekday_of_date(dec_31st)
	if weekday_of_1st_jan == Time.WEEKDAY_THURSDAY or weekday_of_31st_dec == Time.WEEKDAY_THURSDAY:
		return 53
	return 52

## Returns the [code]day[/code] and [code]month[/code] of the first monday in the [param year]. Must be from [code]29 Dec[/code] to [code]4 Jan[/code] according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
static func get_iso_first_monday_of_year(year: int) -> DateInfo:
	var jan_4th := DateInfo.from_ymd(year, Time.MONTH_JANUARY, 4)
	var first_monday := DateInfo.from_ymd(
		year,
		Time.MONTH_JANUARY,
		4 - (get_iso_weekday_of_date(jan_4th) - 1))
	
	if !is_valid_day_in_month(first_monday.day):
		first_monday.day = 31 + first_monday.day
		first_monday.month = Time.MONTH_DECEMBER
	return first_monday

## Returns week number in the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard from [code]1[/code] to [code]53[/code].
static func get_iso_week_number(date: DateInfo) -> int:
	var day_in_year := get_day_in_year(date)
	var weekday := get_iso_weekday_of_date(date)
	var week := floori((day_in_year - weekday + 10) / 7.0)
	if week < 1:
		return get_iso_weeks_in_year(date.year - 1)
	if week == 53 and get_iso_weeks_in_year(date.year) == 52:
		return 1
	return week

## Returns timezone offset from UTC in seconds.
static func get_timezone_offset() -> int:
	return int(Convert.min_to_sec(Time.get_time_zone_from_system().bias))
#endregion getters


#region methods
## Returns [code]true[/code] if the [param year] is a [url=https://en.wikipedia.org/wiki/Leap_year]leap year[/url] according to the Gregorian calendar.
static func is_leap_year(year: int) -> bool:
	return (year % 4 == 0 and year % 100 != 0) or year % 400 == 0

## Returns [code]true[/code] if the [param month] is a valid [Time.Month].
static func is_valid_month(month: Time.Month) -> bool:
	return month >= 1 and month <= 12

## Returns [code]true[/code] if the [param weekday] is a valid [enum Time.Weekday].
static func is_valid_weekday(weekday: Time.Weekday) -> bool:
	return weekday >= 0 and weekday <= 6

## Returns [code]true[/code] if the [param day] is between [code]1[/code] and [method get_days_in_month].
static func is_valid_day_in_month(day: int, month := Time.Month.MONTH_JANUARY, year := 0) -> bool:
	return day >= 1 and day <= get_days_in_month(month, year)

## Returns [code]true[/code] if the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard says that the 1st of January in a [param year] is also a Monday.
static func does_year_start_on_monday(year: int) -> bool:
	var datetime_dict := Time.get_datetime_dict_from_datetime_string("%d-01-01" % year, true)
	return datetime_dict.weekday == Time.WEEKDAY_MONDAY

## Converts from godot weekday indexing [code]0-6 Sun-Sat[/code] to [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] weekday indexing [code]1-7 Mon-Sun[/code].
static func weekday_godot_to_iso(weekday: Time.Weekday) -> int:
	return weekday if weekday != Time.WEEKDAY_SUNDAY else 7
#endregion methods
