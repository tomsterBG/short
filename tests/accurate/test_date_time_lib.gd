extends GutTest


#region tests
func test_is_leap_year():
	assert_eq(DateTimeLib.is_leap_year(4), true)
	assert_eq(DateTimeLib.is_leap_year(2016), true)
	assert_eq(DateTimeLib.is_leap_year(2024), true)
	assert_eq(DateTimeLib.is_leap_year(2025), false)
	assert_eq(DateTimeLib.is_leap_year(1600), true)
	assert_eq(DateTimeLib.is_leap_year(2000), true)
	assert_eq(DateTimeLib.is_leap_year(2400), true)
	assert_eq(DateTimeLib.is_leap_year(1700), false)
	assert_eq(DateTimeLib.is_leap_year(1800), false)
	assert_eq(DateTimeLib.is_leap_year(1900), false)
	assert_eq(DateTimeLib.is_leap_year(2100), false)
	assert_eq(DateTimeLib.is_leap_year(2200), false)
	assert_eq(DateTimeLib.is_leap_year(2300), false)

func test_is_valid_month():
	assert_eq(DateTimeLib.is_valid_month(0), false)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_JANUARY), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_FEBRUARY), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_MARCH), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_APRIL), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_MAY), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_JUNE), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_JULY), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_AUGUST), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_SEPTEMBER), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_OCTOBER), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_NOVEMBER), true)
	assert_eq(DateTimeLib.is_valid_month(Time.MONTH_DECEMBER), true)
	assert_eq(DateTimeLib.is_valid_month(13), false)

func test_is_valid_weekday():
	assert_eq(DateTimeLib.is_valid_weekday(-1), false)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_SUNDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_MONDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_TUESDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_WEDNESDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_THURSDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_FRIDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(Time.WEEKDAY_SATURDAY), true)
	assert_eq(DateTimeLib.is_valid_weekday(7), false)

func test_does_year_start_on_monday():
	assert_eq(DateTimeLib.does_year_start_on_monday(2001), true)
	assert_eq(DateTimeLib.does_year_start_on_monday(2024), true)
	assert_eq(DateTimeLib.does_year_start_on_monday(2025), false)

func test_get_days_in_month():
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_JANUARY), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_FEBRUARY), 29)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_FEBRUARY, 1999), 28)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_FEBRUARY, 2000), 29)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_FEBRUARY, 2024), 29)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_FEBRUARY, 2100), 28)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_MARCH), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_APRIL), 30)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_MAY), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_JUNE), 30)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_JULY), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_AUGUST), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_SEPTEMBER), 30)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_OCTOBER), 31)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_NOVEMBER), 30)
	assert_eq(DateTimeLib.get_days_in_month(Time.MONTH_DECEMBER), 31)

func test_is_valid_day_in_month():
	assert_eq(DateTimeLib.is_valid_day_in_month(0), false)
	assert_eq(DateTimeLib.is_valid_day_in_month(1), true)
	assert_eq(DateTimeLib.is_valid_day_in_month(31), true)
	assert_eq(DateTimeLib.is_valid_day_in_month(32), false)
	assert_eq(DateTimeLib.is_valid_day_in_month(29, Time.MONTH_FEBRUARY, 2024), true)
	assert_eq(DateTimeLib.is_valid_day_in_month(30, Time.MONTH_FEBRUARY, 2024), false)
	assert_eq(DateTimeLib.is_valid_day_in_month(28, Time.MONTH_FEBRUARY, 2025), true)
	assert_eq(DateTimeLib.is_valid_day_in_month(29, Time.MONTH_FEBRUARY, 2025), false)
	assert_eq(DateTimeLib.is_valid_day_in_month(30, Time.MONTH_APRIL), true)
	assert_eq(DateTimeLib.is_valid_day_in_month(31, Time.MONTH_APRIL), false)

func test_get_days_in_year():
	assert_eq(DateTimeLib.get_days_in_year(1999), 365)
	assert_eq(DateTimeLib.get_days_in_year(2000), 366)
	assert_eq(DateTimeLib.get_days_in_year(2100), 365)

func test_get_iso_weeks_in_year():
	assert_eq(DateTimeLib.get_iso_weeks_in_year(1999), 52)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2008), 52)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2009), 53)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2010), 52)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2015), 53)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2016), 52)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2019), 52)
	assert_eq(DateTimeLib.get_iso_weeks_in_year(2020), 53)

func test_get_day_in_year():
	assert_eq(DateTimeLib.get_day_in_year(DateData.from_ymd(1999, Time.MONTH_JANUARY, 1)), 1)
	assert_eq(DateTimeLib.get_day_in_year(DateData.from_ymd(1999, Time.MONTH_MARCH, 3)), 62)
	assert_eq(DateTimeLib.get_day_in_year(DateData.from_ymd(1999, Time.MONTH_DECEMBER, 31)), 365)
	assert_eq(DateTimeLib.get_day_in_year(DateData.from_ymd(2000, Time.MONTH_DECEMBER, 31)), 366)
	assert_eq(DateTimeLib.get_day_in_year(DateData.from_ymd(2001, Time.MONTH_SEPTEMBER, 11)), 254)

func test_get_day_since_first_monday():
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(1999, Time.MONTH_SEPTEMBER, 11)), 251)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2005, Time.MONTH_SEPTEMBER, 11)), 252)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2006, Time.MONTH_SEPTEMBER, 11)), 253)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2007, Time.MONTH_SEPTEMBER, 11)), 254)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2013, Time.MONTH_SEPTEMBER, 11)), 255)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2014, Time.MONTH_SEPTEMBER, 11)), 256)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2015, Time.MONTH_SEPTEMBER, 11)), 257)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2016, Time.MONTH_DECEMBER, 31)), 363)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2017, Time.MONTH_JANUARY, 1)), 364)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2022, Time.MONTH_DECEMBER, 31)), 363)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2023, Time.MONTH_JANUARY, 1)), 364)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2024, Time.MONTH_JANUARY, 1)), 1)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2024, Time.MONTH_DECEMBER, 31)), 2)
	assert_eq(DateTimeLib.get_day_since_first_monday(DateData.from_ymd(2025, Time.MONTH_JANUARY, 1)), 3)

func test_weekday_godot_to_iso():
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_MONDAY), 1)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_TUESDAY), 2)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_WEDNESDAY), 3)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_THURSDAY), 4)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_FRIDAY), 5)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_SATURDAY), 6)
	assert_eq(DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_SUNDAY), 7)

func test_get_weekday_of_date():
	assert_eq(DateTimeLib.get_weekday_of_date(DateData.from_ymd(2025, Time.MONTH_JANUARY, 1)), Time.WEEKDAY_WEDNESDAY)
	assert_eq(DateTimeLib.get_weekday_of_date(DateData.from_ymd(2025, Time.MONTH_JANUARY, 5)), Time.WEEKDAY_SUNDAY)

func test_get_iso_weekday_of_date():
	assert_eq(DateTimeLib.get_iso_weekday_of_date(DateData.from_ymd(2025, Time.MONTH_JANUARY, 1)), DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_WEDNESDAY))
	assert_eq(DateTimeLib.get_iso_weekday_of_date(DateData.from_ymd(2025, Time.MONTH_JANUARY, 5)), DateTimeLib.weekday_godot_to_iso(Time.WEEKDAY_SUNDAY))

func test_get_iso_first_monday_of_year():
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(1999).to_timestamp().timestamp, DateData.from_ymd(1999, Time.MONTH_JANUARY, 4).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2000).to_timestamp().timestamp, DateData.from_ymd(2000, Time.MONTH_JANUARY, 3).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2006).to_timestamp().timestamp, DateData.from_ymd(2006, Time.MONTH_JANUARY, 2).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2007).to_timestamp().timestamp, DateData.from_ymd(2007, Time.MONTH_JANUARY, 1).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2008).to_timestamp().timestamp, DateData.from_ymd(2008, Time.MONTH_DECEMBER, 31).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2014).to_timestamp().timestamp, DateData.from_ymd(2014, Time.MONTH_DECEMBER, 30).to_timestamp().timestamp)
	assert_eq(DateTimeLib.get_iso_first_monday_of_year(2015).to_timestamp().timestamp, DateData.from_ymd(2015, Time.MONTH_DECEMBER, 29).to_timestamp().timestamp)

func test_get_iso_week_number():
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2015, Time.MONTH_OCTOBER, 26)), 44)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_JANUARY, 1)), 52)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2019, Time.MONTH_DECEMBER, 29)), 52)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2019, Time.MONTH_DECEMBER, 30)), 1)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2021, Time.MONTH_JANUARY, 3)), 53)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2021, Time.MONTH_JANUARY, 4)), 1)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_JANUARY, 2)), 1)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_AUGUST, 27)), 34)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_AUGUST, 28)), 35)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_SEPTEMBER, 3)), 35)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2023, Time.MONTH_SEPTEMBER, 4)), 36)
	assert_eq(DateTimeLib.get_iso_week_number(DateData.from_ymd(2025, Time.MONTH_JANUARY, 1)), 1)

func test_get_timezone_offset():
	assert_eq(DateTimeLib.get_timezone_offset(), Time.get_time_zone_from_system().bias * 60)
#endregion tests
