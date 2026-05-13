extends GutTest


#region constants
const ERROR_INTERVAL := 0.000_030
#endregion constants


#region tests
func test_initial_values():
	var time := TimestampData.new()
	assert_eq(time.timestamp, 0.0, "Timestamp is 0.0.")

func test_init():
	var time := TimestampData.new(1778685141)
	assert_eq(time.timestamp, 1778685141.0, "Timestamp is 1778685141.0.")

func test_now_utc():
	assert_almost_eq(TimestampData.now_utc().timestamp, Time.get_unix_time_from_system(), ERROR_INTERVAL)

func test_now_local():
	var local_time: float = Time.get_unix_time_from_system() + Time.get_time_zone_from_system().bias * 60.0
	assert_almost_eq(TimestampData.now_local().timestamp, local_time, ERROR_INTERVAL)

func test_to_date():
	var date := TimestampData.new().to_date()
	assert_eq(date.year, 1970, "Unix epoch year.")
	assert_eq(date.month, Time.MONTH_JANUARY, "Unix epoch month.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_THURSDAY, "Unix epoch weekday.")
	assert_eq(date.day, 1, "Unix epoch day.")
	date = TimestampData.new(1778685141.454071).to_date()
	assert_eq(date.year, 2026, "Development year.")
	assert_eq(date.month, Time.MONTH_MAY, "Development month.")
	assert_eq(date.get_weekday(), Time.WEEKDAY_WEDNESDAY, "Development weekday.")
	assert_eq(date.day, 13, "Development day.")

func test_to_time():
	var time := TimestampData.new().to_time()
	assert_eq(time.hour, 0, "Unix epoch hour.")
	assert_eq(time.minute, 0, "Unix epoch minute.")
	assert_eq(time.second, 0, "Unix epoch second.")
	assert_eq(time.millisecond, 0, "Unix epoch millisecond.")
	assert_eq(time.microsecond, 0, "Unix epoch microsecond.")
	time = TimestampData.new(1778685141.454071).to_time()
	assert_eq(time.hour, 15, "Development hour.")
	assert_eq(time.minute, 12, "Development minute.")
	assert_eq(time.second, 21, "Development second.")
	assert_eq(time.millisecond, 454, "Development millisecond.")
	assert_eq(time.microsecond, 71, "Development microsecond.")
#endregion tests
