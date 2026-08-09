extends GutTest


#region tests
func test_initial_values():
	var datetime := DateTimeInfo.new()
	assert_eq(datetime.date, null, "Date is null.")
	assert_eq(datetime.time, null, "Time is null.")
#endregion tests
