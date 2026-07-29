# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:
# - bevel - like blender bevel for rounding corners in an alternative way

## @experimental: This class could change.
## Work with polygons of 2D and 3D points.
##
## Available in all scripts without any setup.

@abstract class_name PolyLib extends Object


#region methods
## Generates points that represent a circle. The first point is directly to the right by default, [constant Vector2.RIGHT], unless you use [param start_angle] (in radians).
##[br][br][b]Note:[/b] [param vertices] can't be negative.
static func circle(radius: float, vertices := 24, position := Vector2.ZERO, from_angle := 0) -> PackedVector2Array:
	assert(vertices >= 0)
	var result: PackedVector2Array = []
	for i in range(vertices):
		result.append(position + Vector2.from_angle(from_angle + i / float(vertices) * TAU) * radius)
	return result

## Generates points that represent a circular arc, starting from [param from_angle] and ending at [param to_angle], where [code]0[/code] represents [constant Vector2.RIGHT] (in radians).
##[br][br][b]Note:[/b] [param vertices] can't be negative.
static func arc(from_angle: float, to_angle: float, radius: float, vertices := 7, position := Vector2.ZERO) -> PackedVector2Array:
	assert(vertices >= 0)
	var result: PackedVector2Array = []
	for i in range(vertices):
		result.append(position + Vector2.from_angle(lerpf(from_angle, to_angle, float(i) / (vertices - 1))) * radius)
	return result

## Generates points that represent a rounded rectangle.
##[br][br][b]Note:[/b] [param corner_vertices] can't be negative.
static func rounded_rect(size: Vector2, corner_radius: float, corner_vertices := 7, position := Vector2.ZERO) -> PackedVector2Array:
	var result: PackedVector2Array = []
	result.append_array(arc(0, PI/2, corner_radius, corner_vertices, position + Vector2(size.x - corner_radius, size.y - corner_radius)))
	result.append_array(arc(PI/2, PI, corner_radius, corner_vertices, position + Vector2(corner_radius, size.y - corner_radius)))
	result.append_array(arc(PI, PI+PI/2, corner_radius, corner_vertices, position + Vector2(corner_radius, corner_radius)))
	result.append_array(arc(PI+PI/2, TAU, corner_radius, corner_vertices, position + Vector2(size.x - corner_radius, corner_radius)))
	return result

## Generates points that represent a rounded circle. Useful for lower [param vertices], such as 3, 5 or 6, which give rounded triangle, pentagon and hexagon respectively. Rounding makes the sides bulge out, but preserves the maximum radius of the shape.
##[br][br][b]Note:[/b] [param vertices] and [param corner_vertices] can't be negative.
static func rounded_circle(radius: float, corner_radius: float, vertices := 6, corner_vertices := 7, position := Vector2.ZERO) -> PackedVector2Array:
	var result: PackedVector2Array = []
	var _circle: PackedVector2Array = circle(radius, vertices)
	var angle_per_corner := TAU / float(vertices)
	for i in vertices:
		result.append_array(arc(
			(i * angle_per_corner) - (angle_per_corner / 2),
			(i * angle_per_corner) + (angle_per_corner / 2),
			corner_radius,
			corner_vertices,
			position + _circle[i] - _circle[i].normalized() * corner_radius)
		)
	return result

## Moves 2D points by [param offset], without modifying the input [param points].
static func offset_2d(points: PackedVector2Array, offset: Vector2) -> PackedVector2Array:
	for i in points.size():
		points[i] += offset
	return points

## Rotates 2D points by [param angle] (in radians) around [param pivot], without modifying the input [param points].
static func rotate_2d(points: PackedVector2Array, angle: float, pivot := Vector2.ZERO) -> PackedVector2Array:
	if pivot != Vector2.ZERO:
		points = offset_2d(points, -pivot)
	for i in points.size():
		points[i] = points[i].rotated(angle)
	if pivot != Vector2.ZERO:
		points = offset_2d(points, pivot)
	return points

## Scales 2D points by [param scale] (this is equivalent to multiplying each point), without modifying the input [param points].
static func scale_2d(points: PackedVector2Array, scale: Vector2) -> PackedVector2Array:
	for i in points.size():
		points[i] *= scale
	return points
#endregion methods
