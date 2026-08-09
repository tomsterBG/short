# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:
# - bevel - like blender bevel for rounding corners in an alternative way
# - chain/spine/rope - takes a list of points and a distance (optionally curve distance_curve), applies distance constraint/forward kinematic
# - rename _curve to _profile or something

## @experimental: This class could change.
## Work with polygons of 2D and 3D points.
##
## Available in all scripts without any setup.

@abstract class_name PolyLib extends Object


#region methods
## Generates points that represent a circle. The first point is directly to the right by default, [constant Vector2.RIGHT], unless you use [param from_angle] (in radians).
##[br][br][b]Note:[/b] [param vertices] can't be negative.
static func circle(radius: float, vertices := 24, position := Vector2.ZERO, from_angle := 0.0) -> PackedVector2Array:
	assert(vertices >= 0, "Vertices can't be negative.")
	var result: PackedVector2Array = []
	for i in range(vertices):
		result.append(position + Vector2.from_angle(from_angle + i / float(vertices) * TAU) * radius)
	return result

## Generates points that represent a circular arc, starting from [member PolyLib.ArcContext.from_angle] and ending at [member PolyLib.ArcContext.to_angle], where [code]0[/code] represents [constant Vector2.RIGHT] (in radians).
##[br][br][b]Note:[/b] [member PolyLib.ArcContext.vertices] can't be negative.
static func arc(context: ArcContext) -> PackedVector2Array:
	assert(context.vertices >= 0, "Vertices can't be negative.")
	var result: PackedVector2Array = []
	for i in range(context.vertices):
		var progress := float(i) / (context.vertices - 1)
		var radius := context.radius if !context.radius_curve else context.radius * context.radius_curve.sample(progress)
		result.append(context.position + Vector2.from_angle(lerpf(context.from_angle, context.to_angle, progress)) * radius)
	return result

## Generates points that represent a rounded rectangle.
##[br][br][b]Note:[/b] [param corner_vertices] can't be negative.
static func rounded_rect(size: Vector2, corner_radius: float, corner_vertices := 7, position := Vector2.ZERO) -> PackedVector2Array:
	var result: PackedVector2Array = []
	var arc_context := ArcContext.new()
	arc_context.radius = corner_radius; arc_context.vertices = corner_vertices
	
	arc_context.from_angle = 0
	arc_context.to_angle = PI/2
	arc_context.position = position + Vector2(size.x - corner_radius, size.y - corner_radius)
	result.append_array(arc(arc_context))
	
	arc_context.from_angle = PI/2
	arc_context.to_angle = PI
	arc_context.position = position + Vector2(corner_radius, size.y - corner_radius)
	result.append_array(arc(arc_context))
	
	arc_context.from_angle = PI
	arc_context.to_angle = PI+PI/2
	arc_context.position = position + Vector2(corner_radius, corner_radius)
	result.append_array(arc(arc_context))
	
	arc_context.from_angle = PI+PI/2
	arc_context.to_angle = TAU
	arc_context.position = position + Vector2(size.x - corner_radius, corner_radius)
	result.append_array(arc(arc_context))
	return result

## Generates points that represent a rounded circle. Useful for lower [param vertices], such as 3, 5 or 6, which give rounded triangle, pentagon and hexagon respectively. Rounding makes the sides bulge out, but preserves the maximum radius of the shape. The first point is directly to the right by default, [constant Vector2.RIGHT], unless you use [param from_angle] (in radians).
##[br][br][b]Note:[/b] [param vertices] and [param corner_vertices] can't be negative.
static func rounded_circle(radius: float, corner_radius: float, vertices := 6, corner_vertices := 7, position := Vector2.ZERO, from_angle := 0.0) -> PackedVector2Array:
	var result: PackedVector2Array = []
	var _circle: PackedVector2Array = circle(radius, vertices, Vector2.ZERO, from_angle)
	var angle_per_corner := TAU / float(vertices)
	for i in vertices:
		var arc_context := ArcContext.new()
		arc_context.from_angle = from_angle + (i * angle_per_corner) - (angle_per_corner / 2)
		arc_context.to_angle = from_angle + (i * angle_per_corner) + (angle_per_corner / 2)
		arc_context.radius = corner_radius
		arc_context.vertices = corner_vertices
		arc_context.position = position + _circle[i] - _circle[i].normalized() * corner_radius
		result.append_array(arc(arc_context))
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


#region classes
## Context for [method PolyLib.arc].
class ArcContext:
	## Starting arc angle (in radians).
	var from_angle: float = 0.0
	## Ending arc angle (in radians).
	var to_angle: float = PI / 2.0
	## Arc radius.
	var radius: float = 8.0
	## Arc radius multiplier via [Curve]. Radius is sampled in the curve domain range of [code][0, 1][/code] and multiplied by [member radius].
	var radius_curve: Curve
	## Arc vertices.
	var vertices: int = 7
	## Arc position.
	var position: Vector2 = Vector2.ZERO
	
	
	func _init(p_from_angle: float = 0, p_to_angle: float = PI / 2.0, p_radius: float = 8.0, p_vertices: int = 7, p_position: Vector2 = Vector2.ZERO) -> void:
		from_angle = p_from_angle
		to_angle = p_to_angle
		radius = p_radius
		vertices = p_vertices
		position = p_position
	
	## Constructor for [PolyLib.ArcContext], except it also takses [member radius_curve].
	static func from_radius_curve(p_from_angle: float = 0, p_to_angle: float = PI / 2.0, p_radius: float = 8.0, p_radius_curve: Curve = Curve.new(), p_vertices: int = 7, p_position: Vector2 = Vector2.ZERO) -> ArcContext:
		var arc_context := ArcContext.new(p_from_angle, p_to_angle, p_radius, p_vertices, p_position)
		arc_context.radius_curve = p_radius_curve
		return arc_context
#endregion classes
