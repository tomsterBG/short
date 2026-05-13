extends GutTest


#region tests
func test_initial_values():
	var time := TimestampData.new()
	assert_eq(time.timestamp, 0.0, "Timestamp is 0.0.")
#endregion tests
