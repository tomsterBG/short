extends GutTest


#region tests
func test_initial_values():
	var date := DateData.new()
	assert_eq(date.year, 0, "Year is 0.")
	assert_eq(date.month, Time.MONTH_JANUARY, "Month is January.")
	assert_eq(date.weekday, Time.WEEKDAY_SUNDAY, "Weekday is Sunday.")
	assert_eq(date.day, 0, "Day is 0.")

func test_from_ymd():
	var date := DateData.from_ymd(2026, Time.MONTH_MARCH, 4)
	assert_eq(date.year, 2026, "Year is 2026.")
	assert_eq(date.month, Time.MONTH_MARCH, "Month is March")
	assert_eq(date.weekday, Time.WEEKDAY_WEDNESDAY, "Weekday is Wednesday.")
	assert_eq(date.day, 4, "Day is 4.")
	date = DateData.from_ymd(2025, Time.MONTH_OCTOBER, 19)
	assert_eq(date.year, 2025, "Year is 2025.")
	assert_eq(date.month, Time.MONTH_OCTOBER, "Month is October")
	assert_eq(date.weekday, Time.WEEKDAY_SUNDAY, "Weekday is Sunday.")
	assert_eq(date.day, 19, "Day is 19.")
#endregion tests
