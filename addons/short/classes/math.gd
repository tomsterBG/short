# SOURCES:
# - https://www.omnicalculator.com
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
## Returns the area of a circle.
static func circle_area(radius: float) -> float:
	return PI * pow(radius, 2)

## Returns the circumference of a circle.
static func circle_circumference(radius: float) -> float:
	return TAU * radius

## Returns the volume of a cylinder.
static func cylinder_volume(radius: float, height: float) -> float:
	return circle_area(radius) * height

## Returns the surface of a sphere.
static func sphere_surface(radius: float) -> float:
	return 4.0 * PI * pow(radius, 2)

## Returns the volume of a sphere.
static func sphere_volume(radius: float) -> float:
	return (4.0/3.0) * PI * pow(radius, 3)

## Returns the area of a rectangle.
static func rectangle_area(side_x: float, side_y: float) -> float:
	return side_x * side_y

## Returns the diagonal of a rectangle.
static func rectangle_diagonal(side_x: float, side_y: float) -> float:
	return sqrt(pow(side_x, 2) + pow(side_y, 2))

## Returns the perimeter of a rectangle.
static func rectangle_perimeter(side_x: float, side_y: float) -> float:
	return 2.0 * (side_x + side_y)

## Returns the area of a square.
static func square_area(side: float) -> float:
	return pow(side, 2)

## Returns the diagonal of a square.
static func square_diagonal(side: float) -> float:
	return side * sqrt(2)

## Returns the perimeter of a square.
static func square_perimeter(side: float) -> float:
	return side * 4.0

## Returns the area of a triangle, given base and height.
static func triangle_area_from_base_and_height(base: float, height: float) -> float:
	return 0.5 * base * height

## Returns the area of a triangle, given three sides.
static func triangle_area_from_three_sides(a: float, b: float, c: float) -> float:
	return 0.25 * sqrt( (a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c) )

## Returns the area of a triangle, given two sides and [param angle_between_rad] them in [code]radians[/code].
static func triangle_area_from_two_sides_and_angle_between(a: float, b: float, angle_between_rad: float) -> float:
	return 0.5 * a * b * sin(angle_between_rad)

## Returns the area of a triangle, given a side and two adjacent angles in [code]radians[/code].
static func triangle_area_from_side_and_adjacent_angles(side_between: float, angle_a_rad: float, angle_b_rad: float) -> float:
	return pow(side_between, 2) * sin(angle_a_rad) * sin(angle_b_rad) / (2.0 * sin(angle_a_rad + angle_b_rad))
	#endregion geometry

## Returns [code]true[/code] if [param vector_a]'s direction relative to [param vector_b] is within [param max_angle_rad] radians.
static func is_vector2_within_angle(vector_a: Vector2, vector_b: Vector2, max_angle_rad: float) -> bool:
	var angle_to = absf(vector_a.angle_to(vector_b))
	return angle_to <= max_angle_rad
#endregion methods
