# SOURCES:
# - https://www.omnicalculator.com
# INFO:
# Some methods that were useless, were simply removed or not implemented. That was abstraction for the sake of abstraction. Such as:
# - circle_area, circle_circumference
# - cylinder_volume
# - rectangle_area, rectangle_diagonal, rectangle_perimeter
# - square_area, square_diagonal, square_perimeter
# - triangle_area_from_base_and_height, triangle_area_from_two_sides_and_angle_between, triangle_area_from_side_and_adjacent_angles
# - rand_point_in_circle, rand_point_in_fov
# TODO:
# - SQRT_2 = sqrt(2)
# - geometry
# 	- cone_surface(radius, height)
# 	- cone_volume(radius, height)
# 	- right_triangle_area(side_x, side_y)
# 	- triangle_perimeter(a, b, c)
# IDEAS:
# - class or class_name Matrix to more easily define what a matrix is
# - add_matrix(matrix_a, matrix_b)
# - multiply_matrix(matrix_a, matrix_b)
# - Instead of get_shape_something, we can make classes of each shape and they can have methods such as Square.perimeter() and Triangle.area().

## @experimental: This class is immature.
## Work with math.
##
## Available in all scripts without any setup.

@abstract class_name Math extends Node


#region constants
## The golden ratio.
const PHI = (1.0 + sqrt(5)) / 2.0
#endregion constants


#region getters
## Returns [param vector_a] projected on [param vector_b].
static func get_projected_vector(vector_a, vector_b):
	return vector_b.normalized() * vector_a.dot(vector_b.normalized())
#endregion getters


#region methods
	#region geometry
## Returns the surface of a sphere.
static func sphere_surface(radius: float) -> float:
	return 4.0 * PI * pow(radius, 2)

## Returns the volume of a sphere.
static func sphere_volume(radius: float) -> float:
	return (4.0/3.0) * PI * pow(radius, 3)

## Returns the area of a triangle, given three sides.
static func triangle_area_from_three_sides(a: float, b: float, c: float) -> float:
	assert(a + b > c and b + c > a and c + a > b, "Triangle inequality theorem failed: The sum of any 2 sides must be > than the 3rd.")
	return 0.25 * sqrt( (a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c) )
	#endregion geometry

## Returns [code]true[/code] if [param vector_a]'s direction relative to [param vector_b] is within [param max_angle_rad] radians.
static func is_vector2_within_angle(vector_a: Vector2, vector_b: Vector2, max_angle_rad: float) -> bool:
	var angle_to = absf(vector_a.angle_to(vector_b))
	return angle_to <= max_angle_rad
#endregion methods
