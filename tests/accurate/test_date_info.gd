extends GutTest


#region variables
var date: DateInfo
#endregion variables


#region virtual
func before_each():
	date = DateInfo.new()
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(date.year, 1, "Year is 1 AD.")
	assert_eq(date.month, Time.MONTH_JANUARY, "Month is January.")
	assert_eq(date.day, 1, "Day is 1.")

func test_initial_method_values():
	assert_eq(date.get_weekday(), Time.WEEKDAY_MONDAY, "Weekday is Monday.")

func test_from_ymd():
	date = DateInfo.from_ymd(2026, Time.MONTH_MARCH, 4)
	assert_eq(date.year, 2026, "Year is 2026.")
	assert_eq(date.month, Time.MONTH_MARCH, "Month is March")
	assert_eq(date.day, 4, "Day is 4.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_WEDNESDAY, "Weekday is Wednesday.")
	
	date = DateInfo.from_ymd(2025, Time.MONTH_OCTOBER, 19)
	assert_eq(date.year, 2025, "Year is 2025.")
	assert_eq(date.month, Time.MONTH_OCTOBER, "Month is October")
	assert_eq(date.day, 19, "Day is 19.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_SUNDAY, "Weekday is Sunday.")

func test_from_date_dict():
	date = DateInfo.from_date_dict(Time.get_date_dict_from_unix_time(1772582400))
	assert_eq(date.year, 2026, "Year is 2026.")
	assert_eq(date.month, Time.MONTH_MARCH, "Month is March")
	assert_eq(date.day, 4, "Day is 4.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_WEDNESDAY, "Weekday is Wednesday.")
	
	date = DateInfo.from_date_dict(Time.get_date_dict_from_unix_time(1760832000))
	assert_eq(date.year, 2025, "Year is 2025.")
	assert_eq(date.month, Time.MONTH_OCTOBER, "Month is October")
	assert_eq(date.day, 19, "Day is 19.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_SUNDAY, "Weekday is Sunday.")

func test_to_date_dict():
	var dict := DateInfo.from_ymd(2025, Time.MONTH_JULY, 9).to_date_dict()
	assert_eq(dict.year, 2025, "Year is 2025.")
	assert_eq(dict.month, Time.MONTH_JULY, "Month is July")
	assert_eq(dict.day, 9, "Day is 9.")
	assert_eq(dict.weekday, Time.WEEKDAY_WEDNESDAY, "Weekday is Wednesday.")

func test_to_timestamp():
	var time := DateInfo.from_ymd(2025, Time.MONTH_AUGUST, 29).to_timestamp()
	assert_eq(time.timestamp, TimestampData.new(1756425600).timestamp, "Timestamps match.")
#endregion tests
