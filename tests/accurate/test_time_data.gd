extends GutTest


#region tests
func test_initial_values():
	var time := TimeData.new()
	assert_eq(time.hour, 0, "Hour is 0.")
	assert_eq(time.minute, 0, "Minute is 0.")
	assert_eq(time.second, 0, "Second is 0.")
	assert_eq(time.millisecond, 0, "Millisecond is 0.")
	assert_eq(time.microsecond, 0, "Microsecond is 0.")

func test_from_hms():
	var time := TimeData.from_hms(15, 7, 59)
	assert_eq(time.hour, 15, "Hour is 15.")
	assert_eq(time.minute, 7, "Minute is 7")
	assert_eq(time.second, 59, "Second is 59.")
	assert_eq(time.millisecond, 0, "Millisecond is 0.")
	assert_eq(time.microsecond, 0, "Microsecond is 0.")
#endregion tests
