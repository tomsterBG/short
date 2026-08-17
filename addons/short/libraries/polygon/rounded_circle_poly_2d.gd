## A procedurally generated rounded circle.

@tool
class_name RoundedCirclePoly2D extends ProceduralPoly2D


#region variables
@export_group("Shape Parameters")

## Radius from the center (in pixels). Can't be negative.
@export var radius: float = 20.0:
	set(value):
		radius = maxf(value, 0.0)
		call_remake_polygon()

## Radius of each corner (in pixels). This preserves [member radius] by keeping the farthest point perfectly at that distance.
@export var corner_radius: float = 8.0:
	set(value):
		corner_radius = value
		call_remake_polygon()

## Vertices of the circle itself. You can think of it as the sides of an n-gon. Can't be negative.
@export var vertices: int = 6:
	set(value):
		vertices = maxi(value, 0)
		call_remake_polygon()

## Vertices of every corner. The total shape vertices are equal to [member vertices] [code]*[/code] [member corner_vertices]. Can't be less than [code]2[/code] (use [CirclePoly2D] in such cases).
@export var corner_vertices: int = 7:
	set(value):
		corner_vertices = maxi(value, 2)
		call_remake_polygon()

## Local offset, visual only.
@export var offset_position: Vector2 = Vector2.ZERO:
	set(value):
		offset_position = value
		call_remake_polygon()

## Starting angle (in radians). When this is [code]0[/code], the start is towards [constant Vector2.RIGHT].
@export var from_angle: float = 0.0:
	set(value):
		from_angle = value
		call_remake_polygon()
#endregion variables


#region virtual
func _generate_poly() -> PackedVector2Array:
	return PolyLib.rounded_circle(radius, corner_radius, vertices, corner_vertices, offset_position, from_angle)
#endregion virtual
