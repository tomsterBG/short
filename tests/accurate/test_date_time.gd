extends GutTest


#region tests
func test_enums():
	assert_eq(DateTime.Month, {JANUARY = 1, FEBRUARY = 2, MARCH = 3, APRIL = 4, MAY = 5, JUNE = 6, JULY = 7, AUGUST = 8, SEPTEMBER = 9, OCTOBER = 10, NOVEMBER = 11, DECEMBER = 12})
	assert_eq(DateTime.Weekday, {MONDAY = 1, TUESDAY = 2, WEDNESDAY = 3, THURSDAY = 4, FRIDAY = 5, SATURDAY = 6, SUNDAY = 7})

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
	assert_eq(DateTime.is_valid_month(DateTime.Month.JANUARY), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.FEBRUARY), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.MARCH), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.APRIL), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.MAY), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.JUNE), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.JULY), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.AUGUST), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.SEPTEMBER), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.OCTOBER), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.NOVEMBER), true)
	assert_eq(DateTime.is_valid_month(DateTime.Month.DECEMBER), true)
	assert_eq(DateTime.is_valid_month(13), false)

func test_is_valid_weekday():
	assert_eq(DateTime.is_valid_weekday(0), false)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.MONDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.TUESDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.WEDNESDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.THURSDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.FRIDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.SATURDAY), true)
	assert_eq(DateTime.is_valid_weekday(DateTime.Weekday.SUNDAY), true)
	assert_eq(DateTime.is_valid_weekday(8), false)

func test_is_valid_day_in_month():
	assert_eq(DateTime.is_valid_day_in_month(0), false)
	assert_eq(DateTime.is_valid_day_in_month(1), true)
	assert_eq(DateTime.is_valid_day_in_month(31), true)
	assert_eq(DateTime.is_valid_day_in_month(32), false)

func test_does_year_start_on_monday():
	assert_eq(DateTime.does_year_start_on_monday(2001), true)
	assert_eq(DateTime.does_year_start_on_monday(2024), true)
	assert_eq(DateTime.does_year_start_on_monday(2025), false)

func test_get_days_in_month():
	assert_eq(DateTime.get_days_in_month(DateTime.Month.JANUARY), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.FEBRUARY), 29)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.FEBRUARY, 1999), 28)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.FEBRUARY, 2000), 29)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.FEBRUARY, 2024), 29)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.FEBRUARY, 2100), 28)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.MARCH), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.APRIL), 30)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.MAY), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.JUNE), 30)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.JULY), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.AUGUST), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.SEPTEMBER), 30)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.OCTOBER), 31)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.NOVEMBER), 30)
	assert_eq(DateTime.get_days_in_month(DateTime.Month.DECEMBER), 31)

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

func test_get_day_of_year():
	assert_eq(DateTime.get_day_of_year(1, DateTime.Month.JANUARY, 1999), 1)
	assert_eq(DateTime.get_day_of_year(3, DateTime.Month.MARCH, 1999), 62)
	assert_eq(DateTime.get_day_of_year(31, DateTime.Month.DECEMBER, 1999), 365)
	assert_eq(DateTime.get_day_of_year(31, DateTime.Month.DECEMBER, 2000), 366)
	assert_eq(DateTime.get_day_of_year(11, DateTime.Month.SEPTEMBER, 2001), 254)

func test_get_day_since_first_monday():
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 1999), 251)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2005), 252)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2006), 253)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2007), 254)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2013), 255)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2014), 256)
	assert_eq(DateTime.get_day_since_first_monday(11, DateTime.Month.SEPTEMBER, 2015), 257)
	assert_eq(DateTime.get_day_since_first_monday(31, DateTime.Month.DECEMBER, 2016), 363)
	assert_eq(DateTime.get_day_since_first_monday(1, DateTime.Month.JANUARY, 2017), 364)
	assert_eq(DateTime.get_day_since_first_monday(31, DateTime.Month.DECEMBER, 2022), 363)
	assert_eq(DateTime.get_day_since_first_monday(1, DateTime.Month.JANUARY, 2023), 364)
	assert_eq(DateTime.get_day_since_first_monday(1, DateTime.Month.JANUARY, 2024), 1)
	assert_eq(DateTime.get_day_since_first_monday(31, DateTime.Month.DECEMBER, 2024), 2)
	assert_eq(DateTime.get_day_since_first_monday(1, DateTime.Month.JANUARY, 2025), 3)

func test_get_iso_weekday_of_date():
	assert_eq(DateTime.get_iso_weekday_of_date(1, DateTime.Month.JANUARY, 2025), DateTime.Weekday.WEDNESDAY)
	assert_eq(DateTime.get_iso_weekday_of_date(5, DateTime.Month.JANUARY, 2025), DateTime.Weekday.SUNDAY)

func test_get_iso_first_monday_of_year():
	assert_eq(DateTime.get_iso_first_monday_of_year(1999), {day = 4, month = DateTime.Month.JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2000), {day = 3, month = DateTime.Month.JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2006), {day = 2, month = DateTime.Month.JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2007), {day = 1, month = DateTime.Month.JANUARY})
	assert_eq(DateTime.get_iso_first_monday_of_year(2008), {day = 31, month = DateTime.Month.DECEMBER})
	assert_eq(DateTime.get_iso_first_monday_of_year(2014), {day = 30, month = DateTime.Month.DECEMBER})
	assert_eq(DateTime.get_iso_first_monday_of_year(2015), {day = 29, month = DateTime.Month.DECEMBER})

func test_get_iso_week_number():
	assert_eq(DateTime.get_iso_week_number(26, DateTime.Month.OCTOBER, 2015), 44)
	assert_eq(DateTime.get_iso_week_number(1, DateTime.Month.JANUARY, 2023), 52)
	assert_eq(DateTime.get_iso_week_number(29, DateTime.Month.DECEMBER, 2019), 52)
	assert_eq(DateTime.get_iso_week_number(30, DateTime.Month.DECEMBER, 2019), 1)
	assert_eq(DateTime.get_iso_week_number(3, DateTime.Month.JANUARY, 2021), 53)
	assert_eq(DateTime.get_iso_week_number(4, DateTime.Month.JANUARY, 2021), 1)
	assert_eq(DateTime.get_iso_week_number(2, DateTime.Month.JANUARY, 2023), 1)
	assert_eq(DateTime.get_iso_week_number(27, DateTime.Month.AUGUST, 2023), 34)
	assert_eq(DateTime.get_iso_week_number(28, DateTime.Month.AUGUST, 2023), 35)
	assert_eq(DateTime.get_iso_week_number(3, DateTime.Month.SEPTEMBER, 2023), 35)
	assert_eq(DateTime.get_iso_week_number(4, DateTime.Month.SEPTEMBER, 2023), 36)
	assert_eq(DateTime.get_iso_week_number(1, DateTime.Month.JANUARY, 2025), 1)

func test_weekday_godot_to_iso():
	assert_eq(DateTime.weekday_godot_to_iso(1), DateTime.Weekday.MONDAY)
	assert_eq(DateTime.weekday_godot_to_iso(2), DateTime.Weekday.TUESDAY)
	assert_eq(DateTime.weekday_godot_to_iso(3), DateTime.Weekday.WEDNESDAY)
	assert_eq(DateTime.weekday_godot_to_iso(4), DateTime.Weekday.THURSDAY)
	assert_eq(DateTime.weekday_godot_to_iso(5), DateTime.Weekday.FRIDAY)
	assert_eq(DateTime.weekday_godot_to_iso(6), DateTime.Weekday.SATURDAY)
	assert_eq(DateTime.weekday_godot_to_iso(0), DateTime.Weekday.SUNDAY)
#endregion tests
