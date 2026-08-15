extends GutTest


#region variables
var objects_read: Array[Object] = []
#endregion variables


#region virtual
func before_all():
	var marker := Marker2D.new()
	marker.set_gizmo_extents(19.0)
	objects_read.append(marker)
	
	marker = Marker2D.new()
	marker.set_gizmo_extents(3.0)
	objects_read.append(marker)
	
	marker = Marker2D.new()
	marker.set_gizmo_extents(8.0)
	objects_read.append(marker)
	
	marker = Marker2D.new()
	marker.set_gizmo_extents(3.0)
	objects_read.append(marker)
	
	objects_read.make_read_only()
#endregion virtual


#region tests
func test_get_properties():
	assert_eq(ArrayLib.get_properties(objects_read, ^"gizmo_extents"), [19.0, 3.0, 8.0, 3.0], "Gizmos are 19, 3, 8 and 3 respectively.")
	var marker: Marker2D = null
	assert_eq(ArrayLib.get_properties([objects_read[0], marker, objects_read[1]], ^"gizmo_extents"), [19.0, null, 3.0], "Fill null values.")

func test_get_wrapped():
	assert_eq(ArrayLib.get_wrapped(objects_read, -8).gizmo_extents, 19.0)
	assert_eq(ArrayLib.get_wrapped(objects_read, -4).gizmo_extents, 19.0)
	assert_eq(ArrayLib.get_wrapped(objects_read, 0).gizmo_extents, 19.0)
	assert_eq(ArrayLib.get_wrapped(objects_read, 4).gizmo_extents, 19.0)
	assert_eq(ArrayLib.get_wrapped(objects_read, 8).gizmo_extents, 19.0)

func test_group_by_property():
	assert_eq(ArrayLib.group_by_property(objects_read, &"gizmo_extents"), {19.0 : [objects_read[0]], 3.0 : [objects_read[1], objects_read[3]], 8.0 : [objects_read[2]]})
	var marker: Marker2D = null
	assert_eq(ArrayLib.group_by_property([objects_read[0], marker, objects_read[1]], &"gizmo_extents"), {19.0 : [objects_read[0]], 3.0 : [objects_read[1]], null : [null]})

func test_index_by_property():
	assert_eq(ArrayLib.index_by_property(objects_read, &"gizmo_extents"), {19.0 : objects_read[0], 3.0 : objects_read[3], 8.0 : objects_read[2]})

func test_cleanup():
	assert_eq(ArrayLib.cleanup(objects_read), objects_read)
	var marker: Marker2D = null
	assert_eq(ArrayLib.cleanup([objects_read[0], marker, objects_read[1]]), [objects_read[0], objects_read[1]])
	marker = Marker2D.new()
	assert_eq(ArrayLib.cleanup([objects_read[0], marker, objects_read[1]]), [objects_read[0], marker, objects_read[1]])
	marker.free()
	assert_eq(ArrayLib.cleanup([objects_read[0], marker, objects_read[1]]), [objects_read[0], objects_read[1]])

func test_flatten():
	assert_eq(ArrayLib.flatten([0, [1], 2]), [0, 1, 2])
	assert_eq(ArrayLib.flatten([0, [1], [[2]]]), [0, 1, 2])
	var depth := 1
	assert_eq(ArrayLib.flatten([0, [1], [[2]]], depth), [0, 1, [2]])

func test_intersect():
	assert_eq(ArrayLib.intersect(objects_read, [objects_read[2]]), [objects_read[2]])
	var properties := ArrayLib.get_properties(objects_read, ^"gizmo_extents")
	assert_eq(ArrayLib.intersect(properties, [3.0]), [3.0])
	assert_eq(ArrayLib.intersect(properties, [3.0], ArrayLib.IntersectMode.B_IS_FILTER), [3.0, 3.0])

func test_exclude():
	assert_eq(ArrayLib.exclude(objects_read, [objects_read[2]]), [objects_read[0], objects_read[1], objects_read[3]])
	var properties := ArrayLib.get_properties(objects_read, ^"gizmo_extents")
	assert_eq(ArrayLib.exclude(properties, [3.0]), [19.0, 8.0, 3.0])
	assert_eq(ArrayLib.exclude(properties, [3.0], ArrayLib.ExcludeMode.B_IS_FILTER), [19.0, 8.0])

func test_merge():
	var properties := ArrayLib.get_properties(objects_read, ^"gizmo_extents")
	assert_eq(ArrayLib.merge(properties, [1.0, 2.0, 3.0]), [19.0, 3.0, 8.0, 3.0, 1.0, 2.0])

func test_contains_all():
	assert_true(ArrayLib.contains_all(objects_read, [objects_read[0], objects_read[1]]))
	var marker: Marker2D = null
	assert_false(ArrayLib.contains_all(objects_read, [objects_read[0], marker, objects_read[1]]))

func test_find_object():
	var context := ArrayLib.FindObjectContext.new(
		objects_read,
		func(obj: Object) -> bool: return obj[&"gizmo_extents"] == 3.0)
	assert_eq(ArrayLib.find_object(context), objects_read[1])
	# TODO: Test recursive behavior with one parameter, two dot-syntax parameters and method parameters.

func test_find_objects():
	var context := ArrayLib.FindObjectContext.new(
		objects_read,
		func(obj: Object) -> bool: return obj[&"gizmo_extents"] == 3.0)
	assert_eq(ArrayLib.find_objects(context), [objects_read[1], objects_read[3]])
	# TODO: Test recursive behavior with one parameter, two dot-syntax parameters and method parameters.

func test_sum_property():
	assert_eq(ArrayLib.sum_property(objects_read, &"gizmo_extents"), 33.0)

func test_average_property():
	assert_eq(ArrayLib.average_property(objects_read, &"gizmo_extents"), 8.25)

func test_pick_random():
	var weighted_array: Array[ArrayLib.WeightedValue] = [
		ArrayLib.WeightedValue.new(objects_read[0], 0.0),
		ArrayLib.WeightedValue.new(objects_read[1], 0.0),
		ArrayLib.WeightedValue.new(objects_read[2], 99.0),
		ArrayLib.WeightedValue.new(objects_read[3], 0.0),
	]
	assert_eq(ArrayLib.pick_random(weighted_array).value, objects_read[2])

func test_move():
	var properties := ArrayLib.get_properties(objects_read, ^"gizmo_extents")
	assert_eq(properties, [19.0, 3.0, 8.0, 3.0])
	ArrayLib.move(properties, 0, 2)
	assert_eq(properties, [3.0, 8.0, 19.0, 3.0])
	ArrayLib.move(properties, 1, 99)
	assert_eq(properties, [3.0, 19.0, 3.0, 8.0])
	ArrayLib.move(properties, 2, -6)
	assert_eq(properties, [3.0, 3.0, 19.0, 8.0])

func test_swap():
	var properties := ArrayLib.get_properties(objects_read, ^"gizmo_extents")
	assert_eq(properties, [19.0, 3.0, 8.0, 3.0])
	ArrayLib.swap(properties, 0, 2)
	assert_eq(properties, [8.0, 3.0, 19.0, 3.0])
	ArrayLib.swap(properties, 1, 99)
	assert_eq(properties, [8.0, 3.0, 19.0, 3.0])
	ArrayLib.swap(properties, 2, -6)
	assert_eq(properties, [8.0, 3.0, 19.0, 3.0])

func test_diff():
	var diff_result := ArrayLib.diff(objects_read, [objects_read[0], null, objects_read[1]])
	assert_eq(diff_result.added, [null])
	assert_eq(diff_result.kept, [objects_read[0], objects_read[1]])
	assert_eq(diff_result.removed, [objects_read[2], objects_read[3]])

func test_sync_nodes():
	var data_array := [1, 3, 9]
	var parent_node := Node.new()
	var factory := func(data: int) -> Node: return Node.new()
	var sync_context := ArrayLib.SyncContext.new(data_array, parent_node, factory, &"synced_node")
	ArrayLib.sync_nodes(sync_context)
	assert_eq(parent_node.get_children().size(), 3)
	assert_eq(parent_node.get_child(0).get_meta(&"synced_node"), 1)
	assert_eq(parent_node.get_child(1).get_meta(&"synced_node"), 3)
	assert_eq(parent_node.get_child(2).get_meta(&"synced_node"), 9)
	
	data_array.append(12)
	data_array.erase(3)
	ArrayLib.sync_nodes(sync_context)
	assert_eq(ArrayLib.cleanup(parent_node.get_children()).size(), 3)
	assert_eq(parent_node.get_child(0).get_meta(&"synced_node"), 1)
	assert_eq(parent_node.get_child(1).get_meta(&"synced_node"), 9)
	assert_eq(parent_node.get_child(2).get_meta(&"synced_node"), 12)

func test_from_csv():
	assert_eq(ArrayLib.from_csv("Hello,world,!"), PackedStringArray(["Hello", "world", "!"]))
#endregion tests
