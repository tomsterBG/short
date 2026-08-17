# NOTE:
# - Due to this being an abstract class, some tests are impossible, such as test_initial_values.

## A base class for procedurally generated polygons.
##
## Override [method _generate_poly] for your custom shapes. It goes very well with methods from [PolyLib]!

@tool
@abstract class_name ProceduralPoly2D extends Polygon2D


#region signals
## Emitted at the end of [method remake_polygon].
signal remade_polygon()
#endregion signals


#region variables
@export_group("Remake Polygon", "do_remake_polygon_")

## If true, calls [method remake_polygon] every time a parameter has been changed. For this to work, you have to write proper setters for each custom polygon parameter that you make. See [method call_remake_polygon].
@export var do_remake_polygon: bool = true

## If true, calls [method remake_polygon] every time a parameter has been changed in the editor. For this to work, you have to write proper setters for each custom polygon parameter that you make. See [method call_remake_polygon].
@export var do_remake_polygon_in_editor: bool = true
#endregion variables


#region methods
## Recalculates [member Polygon2D.polygon] via [method _generate_poly].
##[br]Recalculates [member Polygon2D.polygons] via [method _generate_polys].
func remake_polygon() -> void:
	polygon = _generate_poly()
	polygons = _generate_polys()
	remade_polygon.emit()

## Calls [method remake_polygon] only if [member do_remake_polygon] or [member do_remake_polygon_in_editor] are [code]true[/code] and the result from [method Engine.is_editor_hint] makes sense.
func call_remake_polygon() -> void:
	if !is_node_ready(): return
	if !Engine.is_editor_hint() and do_remake_polygon:
		remake_polygon()
	elif Engine.is_editor_hint() and do_remake_polygon_in_editor:
		remake_polygon()
#endregion methods


#region virtual
## Virtual method to generate the procedural polygon. Override this to change [member Polygon2D.polygon] when calling [method remake_polygon].
@abstract func _generate_poly() -> PackedVector2Array

## Virtual method to generate the procedural polygons. Override this to change [member Polygon2D.polygons] when calling [method remake_polygon].
func _generate_polys() -> Array[PackedInt32Array]:
	return []
#endregion virtual
