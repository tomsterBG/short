extends GutTest


#region tests
func test_get_projected_vector():
	assert_eq(Math.get_projected_vector(Vector2(3, 0), Vector2(3, 0)), Vector2(3, 0), "No change.")
	assert_eq(Math.get_projected_vector(Vector3(3, 2, 0), Vector3(3, 0, 0)), Vector3(3, 0, 0), "Flatten.")
	assert_eq(Math.get_projected_vector(Vector2(0, 3), Vector2(3, 0)), Vector2(0, 0), "Perpendicular.")
	assert_eq(Math.get_projected_vector(Vector3(-3, 2, 0), Vector3(3, 0, 0)), Vector3(-3, 0, 0), "Reverse.")
#endregion tests
