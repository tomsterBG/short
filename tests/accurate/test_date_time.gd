extends GutTest


#region tests
func test_is_leap_year():
	assert_eq(DateTime.is_leap_year(4), true)
	assert_eq(DateTime.is_leap_year(2016), true)
	assert_eq(DateTime.is_leap_year(2024), true)
	assert_eq(DateTime.is_leap_year(2025), false)
	assert_eq(DateTime.is_leap_year(1600), true)
	assert_eq(DateTime.is_leap_year(2000), true)
	assert_eq(DateTime.is_leap_year(2400), true)
	assert_eq(DateTime.is_leap_year(1700), false)
	assert_eq(DateTime.is_leap_year(1800), false)
	assert_eq(DateTime.is_leap_year(1900), false)
	assert_eq(DateTime.is_leap_year(2100), false)
	assert_eq(DateTime.is_leap_year(2200), false)
	assert_eq(DateTime.is_leap_year(2300), false)

func test_is_valid_month():
	assert_eq(DateTime.is_valid_month(0), false)
	assert_eq(DateTime.is_valid_month(Time.MONTH_JANUARY), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_FEBRUARY), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_MARCH), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_APRIL), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_MAY), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_JUNE), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_JULY), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_AUGUST), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_SEPTEMBER), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_OCTOBER), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_NOVEMBER), true)
	assert_eq(DateTime.is_valid_month(Time.MONTH_DECEMBER), true)
	assert_eq(DateTime.is_valid_month(13), false)

func test_is_valid_weekday():
	assert_eq(DateTime.is_valid_weekday(-1), false)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_SUNDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_MONDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_TUESDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_WEDNESDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_THURSDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_FRIDAY), true)
	assert_eq(DateTime.is_valid_weekday(Time.WEEKDAY_SATURDAY), true)
	assert_eq(DateTime.is_valid_weekday(7), false)

func test_does_year_start_on_monday():
	assert_eq(DateTime.does_year_start_on_monday(2001), true)
	assert_eq(DateTime.does_year_start_on_monday(2024), true)
	assert_eq(DateTime.does_year_start_on_monday(2025), false)

func test_get_days_in_month():
	assert_eq(DateTime.get_days_in_month(Time.MONTH_JANUARY), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_FEBRUARY), 29)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_FEBRUARY, 1999), 28)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_FEBRUARY, 2000), 29)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_FEBRUARY, 2024), 29)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_FEBRUARY, 2100), 28)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_MARCH), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_APRIL), 30)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_MAY), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_JUNE), 30)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_JULY), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_AUGUST), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_SEPTEMBER), 30)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_OCTOBER), 31)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_NOVEMBER), 30)
	assert_eq(DateTime.get_days_in_month(Time.MONTH_DECEMBER), 31)

func test_is_valid_day_in_month():
	assert_eq(DateTime.is_valid_day_in_month(0), false)
	assert_eq(DateTime.is_valid_day_in_month(1), true)
	assert_eq(DateTime.is_valid_day_in_month(31), true)
	assert_eq(DateTime.is_valid_day_in_month(32), false)
	assert_eq(DateTime.is_valid_day_in_month(29, Time.MONTH_FEBRUARY, 2024), true)
	assert_eq(DateTime.is_valid_day_in_month(30, Time.MONTH_FEBRUARY, 2024), false)
	assert_eq(DateTime.is_valid_day_in_month(28, Time.MONTH_FEBRUARY, 2025), true)
	assert_eq(DateTime.is_valid_day_in_month(29, Time.MONTH_FEBRUARY, 2025), false)
	assert_eq(DateTime.is_valid_day_in_month(30, Time.MONTH_APRIL), true)
	assert_eq(DateTime.is_valid_day_in_month(31, Time.MONTH_APRIL), false)

func test_get_days_in_year():
	assert_eq(DateTime.get_days_in_year(1999), 365)
	assert_eq(DateTime.get_days_in_year(2000), 366)
	assert_eq(DateTime.get_days_in_year(2100), 365)

func test_get_iso_weeks_in_year():
	assert_eq(DateTime.get_iso_weeks_in_year(1999), 52)
	assert_eq(DateTime.get_iso_weeks_in_year(2008), 52)
	assert_eq(DateTime.get_iso_weeks_in_year(2009), 53)
	assert_eq(DateTime.get_iso_weeks_in_year(2010), 52)
	assert_eq(DateTime.get_iso_weeks_in_year(2015), 53)
	assert_eq(DateTime.get_iso_weeks_in_year(2016), 52)
	assert_eq(DateTime.get_iso_weeks_in_year(2019), 52)
	assert_eq(DateTime.get_iso_weeks_in_year(2020), 53)

func test_get_day_in_year():
	assert_eq(DateTime.get_day_in_year(1, Time.MONTH_JANUARY, 1999), 1)
	assert_eq(DateTime.get_day_in_year(3, Time.MONTH_MARCH, 1999), 62)
	assert_eq(DateTime.get_day_in_year(31, Time.MONTH_DECEMBER, 1999), 365)
	assert_eq(DateTime.get_day_in_year(31, Time.MONTH_DECEMBER, 2000), 366)
	assert_eq(DateTime.get_day_in_year(11, Time.MONTH_SEPTEMBER, 2001), 254)

func test_get_day_since_first_monday():
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 1999), 251)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2005), 252)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2006), 253)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2007), 254)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2013), 255)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2014), 256)
	assert_eq(DateTime.get_day_since_first_monday(11, Time.MONTH_SEPTEMBER, 2015), 257)
	assert_eq(DateTime.get_day_since_first_monday(31, Time.MONTH_DECEMBER, 2016), 363)
	assert_eq(DateTime.get_day_since_first_monday(1, Time.MONTH_JANUARY, 2017), 364)
	assert_eq(DateTime.get_day_since_first_monday(31, Time.MONTH_DECEMBER, 2022), 363)
	assert_eq(DateTime.get_day_since_first_monday(1, Time.MONTH_JANUARY, 2023), 364)
	assert_eq(DateTime.get_day_since_first_monday(1, Time.MONTH_JANUARY, 2024), 1)
	assert_eq(DateTime.get_day_since_first_monday(31, Time.MONTH_DECEMBER, 2024), 2)
	assert_eq(DateTime.get_day_since_first_monday(1, Time.MONTH_JANUARY, 2025), 3)

func test_weekday_godot_to_iso():
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_MONDAY), 1)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_TUESDAY), 2)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_WEDNESDAY), 3)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_THURSDAY), 4)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_FRIDAY), 5)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_SATURDAY), 6)
	assert_eq(DateTime.weekday_godot_to_iso(Time.WEEKDAY_SUNDAY), 7)

func test_get_iso_weekday_of_date():
	assert_eq(DateTime.get_iso_weekday_of_date(1, Time.MONTH_JANUARY, 2025), DateTime.weekday_godot_to_iso(Time.WEEKDAY_WEDNESDAY))
	assert_eq(DateTime.get_iso_weekday_of_date(5, Time.MONTH_JANUARY, 2025), DateTime.weekday_godot_to_iso(Time.WEEKDAY_SUNDAY))

func test_get_iso_first_monday_of_year():
	assert_eq(DateTime.get_iso_first_monday_of_year(1999), {day = 4, month = Time.MONTH_JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2000), {day = 3, month = Time.MONTH_JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2006), {day = 2, month = Time.MONTH_JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2007), {day = 1, month = Time.MONTH_JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2008), {day = 31, month = Time.MONTH_DECEMBER})
	assert_eq(DateTime.get_iso_first_monday_of_year(2014), {day = 30, month = Time.MONTH_DECEMBER})
	assert_eq(DateTime.get_iso_first_monday_of_year(2015), {day = 29, month = Time.MONTH_DECEMBER})

func test_get_iso_week_number():
	assert_eq(DateTime.get_iso_week_number(26, Time.MONTH_OCTOBER, 2015), 44)
	assert_eq(DateTime.get_iso_week_number(1, Time.MONTH_JANUARY, 2023), 52)
	assert_eq(DateTime.get_iso_week_number(29, Time.MONTH_DECEMBER, 2019), 52)
	assert_eq(DateTime.get_iso_week_number(30, Time.MONTH_DECEMBER, 2019), 1)
	assert_eq(DateTime.get_iso_week_number(3, Time.MONTH_JANUARY, 2021), 53)
	assert_eq(DateTime.get_iso_week_number(4, Time.MONTH_JANUARY, 2021), 1)
	assert_eq(DateTime.get_iso_week_number(2, Time.MONTH_JANUARY, 2023), 1)
	assert_eq(DateTime.get_iso_week_number(27, Time.MONTH_AUGUST, 2023), 34)
	assert_eq(DateTime.get_iso_week_number(28, Time.MONTH_AUGUST, 2023), 35)
	assert_eq(DateTime.get_iso_week_number(3, Time.MONTH_SEPTEMBER, 2023), 35)
	assert_eq(DateTime.get_iso_week_number(4, Time.MONTH_SEPTEMBER, 2023), 36)
	assert_eq(DateTime.get_iso_week_number(1, Time.MONTH_JANUARY, 2025), 1)

func test_get_timezone_offset():
	assert_eq(DateTime.get_timezone_offset(), Time.get_time_zone_from_system().bias * 60)
#endregion tests
