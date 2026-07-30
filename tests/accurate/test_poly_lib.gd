extends GutTest


#region constants
const ERROR_INTERVAL := 0.000_001
#endregion constants


#region tests
func test_circle():
	assert_eq(PolyLib.circle(0, 1).size(), 1)
	assert_eq(PolyLib.circle(4, 4).size(), 4)
	assert_eq(PolyLib.circle(0, 4)[0].length(), 0.0)
	assert_eq(PolyLib.circle(4, 4)[0].length(), 4.0)
	# Clockwise square
	assert_almost_eq(PolyLib.circle(4, 4)[0].x, 4.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[0].y, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[1].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[1].y, 4.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[2].x, -4.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[2].y, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[3].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.circle(4, 4)[3].y, -4.0, ERROR_INTERVAL)

func test_arc():
	var arc_context := PolyLib.ArcContext.new()
	arc_context.from_angle = 0
	arc_context.to_angle = 0
	arc_context.radius = 0
	arc_context.vertices = 2
	assert_eq(PolyLib.arc(arc_context).size(), 2)
	arc_context.to_angle = deg_to_rad(90)
	arc_context.radius = 3
	assert_eq(PolyLib.arc(arc_context)[0].length(), 3.0)
	# Bottom right 90° arc
	arc_context.from_angle = 0
	arc_context.to_angle = deg_to_rad(90)
	arc_context.radius = 3
	arc_context.vertices = 4
	assert_almost_eq(PolyLib.arc(arc_context)[0].x, 3.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[0].y, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[1].x, Vector2(3, 0).rotated(deg_to_rad(30)).x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[1].y, Vector2(3, 0).rotated(deg_to_rad(30)).y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[2].x, Vector2(3, 0).rotated(deg_to_rad(60)).x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[2].y, Vector2(3, 0).rotated(deg_to_rad(60)).y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[3].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[3].y, 3.0, ERROR_INTERVAL)
	# Bottom right 90° reverse arc
	arc_context.from_angle = deg_to_rad(90)
	arc_context.to_angle = 0
	assert_almost_eq(PolyLib.arc(arc_context)[0].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[0].y, 3.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[1].x, Vector2(3, 0).rotated(deg_to_rad(60)).x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[1].y, Vector2(3, 0).rotated(deg_to_rad(60)).y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[2].x, Vector2(3, 0).rotated(deg_to_rad(30)).x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[2].y, Vector2(3, 0).rotated(deg_to_rad(30)).y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[3].x, 3.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.arc(arc_context)[3].y, 0.0, ERROR_INTERVAL)

func test_rounded_rect():
	assert_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4).size(), 16)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[0].x, 30.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[0].y, 20.0 - 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[3].x, 30.0 - 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[3].y, 20.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[4].x, 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[4].y, 20.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[7].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[7].y, 20.0 - 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[8].x, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[8].y, 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[11].x, 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[11].y, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[12].x, 30.0 - 5.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[12].y, 0.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[15].x, 30.0, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rounded_rect(Vector2(30, 20), 5, 4)[15].y, 5.0, ERROR_INTERVAL)

func test_rounded_circle():
	var rounded_polygon := PolyLib.rounded_circle(10, 2, 6, 7)
	assert_eq(rounded_polygon.size(), 6 * 7)
	assert_eq(rounded_polygon[3], Vector2(10, 0))
	for vertex in rounded_polygon:
		assert_lte(vertex.length(), 10.0)

func test_offset_2d():
	var my_points := [Vector2(0, 0), Vector2(2, 3)]
	var expected := [Vector2(-3, -1), Vector2(-1, 2)]
	assert_eq(PolyLib.offset_2d(my_points, Vector2(-3, -1))[0], expected[0])
	assert_eq(PolyLib.offset_2d(my_points, Vector2(-3, -1))[1], expected[1])
	assert_eq(my_points, [Vector2(0, 0), Vector2(2, 3)])

func test_rotate_2d():
	var my_points := [Vector2(0, 0), Vector2(2, 4)]
	var expected := [Vector2(0, 0), Vector2(-4, 2)]
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90))[0].x, expected[0].x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90))[0].y, expected[0].y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90))[1].x, expected[1].x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90))[1].y, expected[1].y, ERROR_INTERVAL)
	assert_eq(my_points, [Vector2(0, 0), Vector2(2, 4)])
	
	expected = [Vector2(2, -2), Vector2(-2, 0)]
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90), Vector2(2, 0))[0].x, expected[0].x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90), Vector2(2, 0))[0].y, expected[0].y, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90), Vector2(2, 0))[1].x, expected[1].x, ERROR_INTERVAL)
	assert_almost_eq(PolyLib.rotate_2d(my_points, deg_to_rad(90), Vector2(2, 0))[1].y, expected[1].y, ERROR_INTERVAL)
	assert_eq(my_points, [Vector2(0, 0), Vector2(2, 4)])

func test_scale_2d():
	var my_points := [Vector2(5, -3)]
	assert_eq(PolyLib.scale_2d(my_points, Vector2(2, 2))[0], Vector2(10, -6))
	assert_eq(PolyLib.scale_2d(my_points, Vector2(0, -1))[0], Vector2(0, 3))
#endregion tests
