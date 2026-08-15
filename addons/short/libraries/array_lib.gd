# NOTE:
# TODO:
# - Test them all!!!
# IDEAS:
# - make get_properties compatible with deep properties

## @experimental: This class could change.
## Work with arrays.
##
## Available in all scripts without any setup.
##[br][br]A collection of utilities for list transformation, deep searching, and node-list synchronization.

@abstract class_name ArrayLib extends Object


#region enums
## Defines how duplicates are handled during an intersection. See [method intersect].
enum IntersectMode {
	## Standard intersection. Result contains all duplicates found in a A and B.
	##[br][br]Examples:
	##[br][code][1, 1, 1][/code] intersected with [code][1, 1][/code] results in [code][1, 1][/code].
	##[br][code][1, 1][/code] intersected with [code][1, 1, 1][/code] results in [code][1, 1][/code].
	STANDARD,
	## Filter mode. Result contains every element from A that exists in B.
	##[br][br]Examples:
	##[br][code][1, 1, 1][/code] intersected with [code][1, 1][/code] results in [code][1, 1, 1][/code].
	##[br][code][1, 1][/code] intersected with [code][1, 1, 1][/code] results in [code][1, 1][/code].
	B_IS_FILTER,
}

## Defines how duplicates are handled during an exclusion. See [method exclude].
enum ExcludeMode {
	## Standard exclusion. Result excludes all duplicates found in A and B.
	##[br][br]Examples:
	##[br][code][1, 1, 1][/code] excluded with [code][1, 1][/code] results in [code][1][/code].
	##[br][code][1, 1][/code] excluded with [code][1, 1, 1][/code] results in [code][1][/code].
	STANDARD,
	## Filter mode. Result contains every element from A that doesn't exist in B.
	##[br][br]Examples:
	##[br][code][1, 1, 1][/code] excluded with [code][1, 1][/code] results in [code][][/code].
	##[br][code][1, 1][/code] excluded with [code][1, 1, 1][/code] results in [code][][/code].
	B_IS_FILTER,
}
#endregion enums


#region getters
## Returns an [Array] of values extracted from the [param property_path] of each [Object] in [param objects].
##[br][br]Fills each failed object with [code]null[/code], this way input indices correspond to output indices.
static func get_objects_property(objects: Array[Object], property_path: NodePath) -> Array:
	var result := []
	
	for object in objects:
		if object:
			result.append(object.get_indexed(property_path))
		else:
			result.append(null)
	
	return result

## Returns an [Array] of values extracted from the [param property_paths] of the [param object].
##[br][br]Fills each failed path with [code]null[/code], this way input indices correspond to output indices.
static func get_object_properties(object: Object, property_paths: Array[NodePath]) -> Array:
	var result := []
	
	for property_path in property_paths:
		result.append(object.get_indexed(property_path))
	
	return result

## Returns the element at [param index], wrapping around if the index is out of bounds.
static func get_wrapped(array: Array, index: int) -> Variant:
	if array.is_empty():
		return null
	return array[posmod(index, array.size())]
#endregion getters


#region methods
## Returns a [Dictionary] where keys are the values of [param property] of each [Object], and values are arrays of [Object]s sharing that property value.
static func group_by_property(objects: Array[Object], property: StringName) -> Dictionary:
	var result := {}
	
	for object in objects:
		var key: Variant = object.get(property) if object and property in object else null
		if !result.has(key):
			result[key] = []
		result[key].append(object)
	
	return result

# TODO: Add settings to flip which is key and value.
## Returns a dictionary where keys are the values of [param property], and values are the items themselves.
##[br][br][b]Note:[/b] If multiple items share the same property value, the last one wins.
static func index_by_property(objects: Array[Object], property: StringName) -> Dictionary:
	var result := {}
	
	for object in objects:
		if property in object:
			result[object.get(property)] = object
	
	return result

## Returns a new array with all [code]null[/code] or previously freed objects removed.
static func cleanup(array: Array) -> Array:
	return array.filter(
		func(item: Variant) -> bool:
			if typeof(item) == TYPE_OBJECT:
				if item and item is Node:
					return !item.is_queued_for_deletion()
				return is_instance_valid(item)
			return item != null
	)

## Returns a new flat array containing elements from nested arrays up to the specified [param depth].
##[br][br][b]Note:[/b] A [param depth] of [code]1[/code] flattens exactly one level of nesting.
##[br][br]Example with depth 1: [code][1, [2, [3]]][/code] becomes [code][1, 2, [3]][/code].
static func flatten(array: Array, depth := 999) -> Array:
	var result: Array = []
	
	for item: Variant in array:
		if depth > 0 and typeof(item) == TYPE_ARRAY:
			result.append_array(flatten(item, depth - 1))
		else:
			result.append(item)
	
	return result

## Returns an array of items that are in both [param array_a] and [param array_b].
##[br][br]By default, [enum IntersectMode] is [code]STANDARD[/code].
##[br]Use [code]IntersectMode.B_IS_FILTER[/code] to treat this as a filter where all copies in A are included if the item exists in B.
static func intersect(array_a: Array, array_b: Array, mode := IntersectMode.STANDARD) -> Array:
	var result: Array = []
	
	match mode:
		IntersectMode.STANDARD:
			var temp_b: Array = array_b.duplicate()
			for item: Variant in array_a:
				var index: int = temp_b.find(item)
				if index != -1:
					result.append(item)
					temp_b.remove_at(index)
		
		IntersectMode.B_IS_FILTER:
			for item: Variant in array_a:
				if array_b.has(item):
					result.append(item)
	
	return result

## Returns an array of items that are in [param array_a] but NOT in [param array_b].
##[br][br]By default, [enum ExcludeMode] is [code]STANDARD[/code].
##[br]Use [code]ExcludeMode.B_IS_FILTER[/code] to treat this as a filter where all copies in A are excluded if the item exists in B.
static func exclude(array_a: Array, array_b: Array, mode := ExcludeMode.STANDARD) -> Array:
	var result: Array = []
	
	match mode:
		ExcludeMode.STANDARD:
			var temp_b: Array = array_b.duplicate()
			for item: Variant in array_a:
				var index: int = temp_b.find(item)
				if index == -1:
					result.append(item)
				else:
					temp_b.remove_at(index)
		
		ExcludeMode.B_IS_FILTER:
			for item: Variant in array_a:
				if !array_b.has(item):
					result.append(item)
	
	return result

## Returns an array combining both arrays, except duplicates.
##[br][br][b]Note:[/b] Use [method Array.append_array] if you just want to merge two arrays.
static func merge(array_a: Array, array_b: Array) -> Array:
	var result: Array = array_a.duplicate()
	
	for item: Variant in array_b:
		if !result.has(item):
			result.append(item)
	
	return result

## Returns [code]true[/code] if every element in [param small_array] exists in [param large_array].
##[br][br][b]Note:[/b] Use [method Array.all] for similar uses.
static func contains_all(large_array: Array, small_array: Array) -> bool:
	return small_array.all(
		func(item: Variant) -> bool:
			return large_array.has(item)
	)

# IDEAS: Simplify by using NodePath and dropping call support.
## Searches through [param context.objects] for the first [Object] for which [param context.condition] returns true. See [ArrayLib.FindObjectContext] for more info.
##[br][br]If [param context.object_children] isn't an empty [StringName], this function becomes recursive and searches each object's children too. Supports dot syntax and methods. See [ArrayLib.FindObjectContext] for more info.
static func find_object(context: FindObjectContext) -> Object:
	for object in context.objects:
		if context.condition.call(object):
			return object
		
		if context.object_children.is_empty(): continue
		
		var properties := context.object_children.split(".", !StringLib.ALLOW_EMPTY)
		var children: Variant = object
		for property in properties:
			if property.ends_with("()"):
				if children.has_method(property.trim_suffix("()")):
					children = children.call(property.trim_suffix("()"))
			elif property in children:
				children = children.get(property)
		
		if typeof(children) == TYPE_ARRAY:
			var _context := context
			_context.objects = children
			var result: Variant = find_object(_context)
			if result:
				return result
	
	return null

## Searches through [param context.objects] for all [Object]s for which [param context.condition] returns true. See [ArrayLib.FindObjectContext] for more info.
##[br][br]If [param context.object_children] isn't an empty [StringName], this function becomes recursive and searches each object's children too. Supports dot syntax and methods. See [ArrayLib.FindObjectContext] for more info.
static func find_objects(context: FindObjectContext) -> Array[Object]:
	var results: Array[Object] = []
	
	for object in context.objects:
		if context.condition.call(object):
			results.append(object)
		
		if context.object_children.is_empty(): continue
		
		var properties := context.object_children.split(".", !StringLib.ALLOW_EMPTY)
		var children: Variant = object
		for property in properties:
			if property.ends_with("()"):
				if children.has_method(property.trim_suffix("()")):
					children = children.call(property.trim_suffix("()"))
			elif property in children:
				children = children.get(property)
		
		if typeof(children) == TYPE_ARRAY:
			var _context := context
			_context.objects = children
			results.append_array(find_objects(_context))
	
	return results

## Returns the sum of the given [param property] across all [Object]s in [param objects].
static func sum_property(objects: Array[Object], property: StringName) -> float:
	var total: float = 0.0
	
	for object in objects:
		if property in object:
			total += float(object.get(property))
	
	return total

## Returns the average of the given [param property] across all [Object]s in [param objects].
static func average_property(objects: Array[Object], property: StringName) -> float:
	if objects.is_empty():
		return 0.0
	
	return sum_property(objects, property) / objects.size()

## Picks a random element from [param weighted_array] according to its [param weighted_array.weight]. All weights must be positive [float]s.
##[br]If [param shuffle] is [code]true[/code], [param weighted_array] will be shuffled.
##[br][br][b]Note:[/b] See also [method Array.pick_random] which is more commonly used.
##[br][br][b]Note:[/b] This is useful for music playlists, loot drops and more.
static func pick_random(weighted_array: Array[WeightedValue], shuffle := true) -> WeightedValue:
	assert(weighted_array.all(func(weighted_value: WeightedValue) -> bool: return weighted_value.weight >= 0.0), "All weights must be positive [float]s.")
	var total_weight: float
	total_weight = weighted_array.reduce(func(sum: float, weighted_value: WeightedValue) -> float: return sum + weighted_value.weight, total_weight)
	if shuffle: weighted_array.shuffle()
	var random_number := randf_range(0.0, total_weight)
	var current_weight := 0.0
	
	for weighted_value in weighted_array:
		current_weight += weighted_value.weight
		if random_number <= current_weight:
			return weighted_value
	return null

## Safely moves an item from [param from_index] to [param to_index], shifting others.
static func move(array: Array, from_index: int, to_index: int) -> void:
	var size := array.size()
	if size < 2: return
	
	from_index = clampi(from_index, 0, size - 1)
	to_index = clampi(to_index, 0, size - 1)
	if from_index == to_index: return
	
	var item: Variant = array.pop_at(from_index)
	array.insert(to_index, item)

## Swaps the positions of two items at the given indices.
##[br][br][b]Note:[/b] Does nothing if [param index_a] or [param index_b] is invalid.
static func swap(array: Array, index_a: int, index_b: int) -> void:
	var size := array.size()
	if index_a < 0 or index_a >= size or index_b < 0 or index_b >= size:
		return
	# NOTE: Could use XOR swap, but elements may be incompatible with it, idk. Must test first.
	var temp: Variant = array[index_a]
	array[index_a] = array[index_b]
	array[index_b] = temp

# TODO: Add a way to know if the order of a new element is different, without the influence of added/removed elements.
## Compares two arrays and returns an [ArrayLib.DiffResult].
static func diff(old_array: Array, new_array: Array) -> DiffResult:
	var result := DiffResult.new()
	
	for item: Variant in new_array:
		if !old_array.has(item):
			result.added.append(item)
		else:
			result.kept.append(item)
	
	for item: Variant in old_array:
		if !new_array.has(item):
			result.removed.append(item)
	
	return result

## Synchronizes children nodes of [member ArrayLib.SyncContext.parent_node] to match the state of [member ArrayLib.SyncContext.data_array].
##[br][br][b]Note:[/b] [member ArrayLib.SyncContext.factory] must be a [Callable] that takes a data item and returns a new [Node].
##[br][br][b]Note:[/b] This method uses metadata [member ArrayLib.SyncContext.metadata_name] to track node ownership.
static func sync_nodes(context: SyncContext) -> void:
	var data_to_node_map: Dictionary = {}
	
	# NOTE: Populate data_to_node_map.
	# BUG: What if multiple nodes have the same value for metadata_name? Overwrite?
	for child in context.parent_node.get_children():
		if child.has_meta(context.metadata_name):
			data_to_node_map[child.get_meta(context.metadata_name)] = child
	
	for i in context.data_array.size():
		var data: Variant = context.data_array[i]
		var node: Node
		
		# NOTE: Find existing node.
		if data_to_node_map.has(data):
			node = data_to_node_map[data]
			data_to_node_map.erase(data)
		else: # NOTE: Create new node.
			node = context.factory.call(data)
			assert(node, "Factory failed to create node.")
			node.set_meta(context.metadata_name, data)
			context.parent_node.add_child(node)
		
		if context.sync_position: # NOTE: Sync the position.
			context.parent_node.move_child(node, i)
	
	# NOTE: Erase nodes with unfound data.
	for data: Variant in data_to_node_map:
		var orphaned_node: Node = data_to_node_map[data]
		orphaned_node.queue_free()

## Constructs an array from a CSV line.
static func from_csv(line: String) -> PackedStringArray:
	return line.split(",")
#endregion methods


#region classes
## Result of an array comparison.
class DiffResult:
	## Items added in the new array.
	var added: Array = []
	## Items removed from the old array.
	var removed: Array = []
	## Items present in both arrays. May have a different order.
	var kept: Array = []

## Context for [method ArrayLib.find_object] and [method ArrayLib.find_objects].
class FindObjectContext:
	## Array of [Objects] to search in.
	var objects: Array[Object]
	## A [bool] function which is called with each [Object] as a parameter. If it returns [code]true[/code], the [Object] will be included in the result.
	var condition: Callable
	## The property or method where children of an object can be found. Used for recursive search. No recursion if this is [code]null[/code].
	##[br][br]If a property ends in [code]()[/code], it will be called like a method, otherwise accessed like a property.
	##[br][br]Supports nested access with dot syntax.
	##[br]For example: [code]&"children.array"[/code] will go to [Object][code].children.array[/code] to get the children. 
	##[br]Method example: [code]&"my_children().array"[/code] will go to [Object][code].my_children().array[/code] to get the children. These methods must have no parameters.
	var object_children := &""
	
	
	func _init(p_objects: Array[Object], p_condition: Callable, p_object_children := &"") -> void:
		objects = p_objects
		condition = p_condition
		object_children = p_object_children

## Context for [method ArrayLib.sync_nodes].
class SyncContext:
	## Data corresponding to each node.
	var data_array: Array
	## Node that hosts children which correspond to [member data_array].
	var parent_node: Node
	## Method tat creates a new child [Node] for a given data in [member data_array].
	var factory: Callable
	## Name of the metadata used to track which child [Node] corresponds to which data.
	var metadata_name: StringName
	## If true, sync the position of nodes in list.
	var sync_position := true
	
	
	func _init(p_data_array: Array, p_parent_node: Node, p_factory: Callable, p_metadata_name: StringName, p_sync_position := true) -> void:
		data_array = p_data_array
		parent_node = p_parent_node
		factory = p_factory
		metadata_name = p_metadata_name
		sync_position = p_sync_position

## A [member value] with a [member weight]. Used for [method ArrayLib.pick_random].
class WeightedValue:
	## The value to weight.
	var value: Variant
	## The weight.
	var weight: float
	
	
	func _init(p_value: Variant, p_weight: float) -> void:
		value = p_value
		assert(p_weight >= 0.0, "Weight must be positive.")
		weight = p_weight
#endregion classes
