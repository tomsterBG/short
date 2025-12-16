# TODO:

## @experimental: This class is immature.
## Work with date and time.
##
## Available in all scripts without any setup.

@abstract class_name DateTime extends Node


#region enums
## All months according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
##[br][br][b]Note:[/b] In the real standard the index must have two digits. For example [code]02[/code], [code]09[/code].
enum Month {
	JANUARY = 1,
	FEBRUARY = 2,
	MARCH = 3,
	APRIL = 4,
	MAY = 5,
	JUNE = 6,
	JULY = 7,
	AUGUST = 8,
	SEPTEMBER = 9,
	OCTOBER = 10,
	NOVEMBER = 11,
	DECEMBER = 12,
}

## All weekdays according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
enum Weekday {
	MONDAY = 1,
	TUESDAY = 2,
	WEDNESDAY = 3,
	THURSDAY = 4,
	FRIDAY = 5,
	SATURDAY = 6,
	SUNDAY = 7,
}
#endregion enums


#region getters
## Returns the number of days in a given [param month]. Also depends on the [param year] because of [method is_leap_year].
static func get_days_in_month(month: Month, year := 0) -> int:
	match month:
		Month.APRIL, Month.JUNE, Month.SEPTEMBER, Month.NOVEMBER:
			return 30
		Month.FEBRUARY:
			return 29 if is_leap_year(year) else 28
		_:
			return 31

## Returns the number of days in a given [param year].
static func get_days_in_year(year: int) -> int:
	return 366 if is_leap_year(year) else 365

## Returns the number of weeks in a given [param year] according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
static func get_iso_weeks_in_year(year: int) -> int:
	var weekday_of_1st_jan := get_iso_weekday_of_date(1, Month.JANUARY, year)
	var weekday_of_31st_dec := get_iso_weekday_of_date(31, Month.DECEMBER, year)
	if weekday_of_1st_jan == Weekday.THURSDAY or weekday_of_31st_dec == Weekday.THURSDAY:
		return 53
	return 52

## Returns the day in the [param year] from [code]1[/code] to [code]366[/code].
static func get_day_of_year(day: int, month: Month, year: int) -> int:
	var day_of_year := 0
	var month_idx := 1
	while month_idx < month:
		day_of_year += get_days_in_month(month_idx, year)
		month_idx += 1
	return day_of_year + day

## Returns the day in the [param year] since the first monday from [code]1[/code] to [code]371[/code].
static func get_day_since_first_monday(day: int, month: Month, year: int) -> int:
	var week_number := get_iso_week_number(day, month, year)
	var weekday := get_iso_weekday_of_date(day, month, year)
	return ((week_number - 1) * 7) + weekday

## Returns the weekday of the current date in the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard from [code]1[/code] to [code]7[/code].
static func get_iso_weekday_of_date(day: int, month: Month, year: int) -> Weekday:
	var datetime_dict := Time.get_datetime_dict_from_datetime_string("%d-%d-%d" % [year, month, day], true)
	return weekday_godot_to_iso(datetime_dict.weekday)

## Returns the [code]day[/code] and [code]month[/code] of the first monday in the [param year]. Must be from [code]29 Dec[/code] to [code]4 Jan[/code] according to the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard.
static func get_iso_first_monday_of_year(year: int) -> Dictionary:
	var weekday_of_4th_jan := get_iso_weekday_of_date(4, Month.JANUARY, year)
	var first_monday: Dictionary = {
		day = 4 - (weekday_of_4th_jan - 1),
		month = Month.JANUARY,
	}
	if !is_valid_day_in_month(first_monday.day):
		first_monday.day = 31 + first_monday.day
		first_monday.month = Month.DECEMBER
	return first_monday

## Returns week number in the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard from [code]1[/code] to [code]53[/code].
static func get_iso_week_number(day: int, month: Month, year: int) -> int:
	var day_of_year := get_day_of_year(day, month, year)
	var weekday := get_iso_weekday_of_date(day, month, year)
	var week := floori((day_of_year - weekday + 10) / 7.0)
	if week < 1:
		return get_iso_weeks_in_year(year - 1)
	if week == 53 and get_iso_weeks_in_year(year) == 52:
		return 1
	return week
#endregion getters


#region methods
## Returns [code]true[/code] if the [param year] is a [url=https://en.wikipedia.org/wiki/Leap_year]leap year[/url] according to the Gregorian calendar.
static func is_leap_year(year: int) -> bool:
	return (year % 4 == 0 and year % 100 != 0) or year % 400 == 0

## Returns [code]true[/code] if the [param month] is valid.
static func is_valid_month(month: int) -> bool:
	return Month.values().has(month)

## Returns [code]true[/code] if the [param weekday] is valid.
static func is_valid_weekday(weekday: int) -> bool:
	return Weekday.values().has(weekday)

## Returns [code]true[/code] if the [param day] is between [code]1[/code] and [code]31[/code].
static func is_valid_day_in_month(day: int) -> bool:
	return day >= 1 and day <= 31

## Returns [code]true[/code] if the [url=https://en.wikipedia.org/wiki/ISO_8601]ISO 8601[/url] standard says that the 1st of January in a [param year] is also a Monday.
static func does_year_start_on_monday(year: int) -> bool:
	var datetime_dict := Time.get_datetime_dict_from_datetime_string("%d-01-01" % year, true)
	return datetime_dict.weekday == Weekday.MONDAY

## Converts from godot weekday indexing [code]0-6 Sun-Sat[/code] to iso weekday indexing [code]1-7 Mon-Sun[/code].
static func weekday_godot_to_iso(weekday: int) -> int:
	if weekday == 0: return 7
	else: return weekday
#endregion methods
