## A procedurally generated rounded rectangle.

@tool
class_name RoundedRectPoly2D extends ProceduralPoly2D


#region variables
@export_group("Shape Parameters")

## Size of each rectangle side.
@export var size: Vector2 = Vector2(40.0, 40.0):
	set(value):
		size = value
		call_remake_polygon()

## Radius of each corner (in pixels).
@export var corner_radius: float = 8.0:
	set(value):
		corner_radius = value
		call_remake_polygon()

## Vertices of every corner. The total shape vertices are equal to [member corner_vertices] [code]* 4[/code]. Can't be less than [code]2[/code] (use [RectPoly2D] in such cases).
@export var corner_vertices: int = 7:
	set(value):
		corner_vertices = maxi(value, 2)
		call_remake_polygon()

## Local offset, visual only.
@export var offset_position: Vector2 = Vector2.ZERO:
	set(value):
		offset_position = value
		call_remake_polygon()
#endregion variables


#region virtual
func _generate_poly() -> PackedVector2Array:
	return PolyLib.rounded_rect(size, corner_radius, corner_vertices, offset_position)
#endregion virtual
