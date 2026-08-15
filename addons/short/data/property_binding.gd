# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:
# - Instead of just two, make it any number of proeprties.
# - A function that takes the value found at [member node_a]'s property and returns the value to be set at [member node_b]'s property.
# - A CSV string for signal names and methods to (un)bind a Node to all defined signals. This lets me use that to more briefly connect each binding to different node signals.

## @experimental: This class could change.
## Data that defines a binding between two [Node] properties.
##
##[br][br][b]Note:[/b] This assumes that the [Helper] class exists.

class_name PropertyBinding extends Resource


#region variables
@export_group("Node A")
## [NodePath] where to find the node. Also used to point to a property. Relative paths are relative to the [Node] that holds these bindings, unless [member group_a] is defined, in which case the path will be relative to the first [Node] found at that group.
@export var path_a: NodePath = ^""
## Group, the first node of which will be set as [member node_a]. If [member path_a] is a relative path that points to a [Node], this node will be taken as the starting point of that [NodePath].
@export var group_a: StringName = &""

@export_group("Node B")
## [NodePath] where to find the node. Also used to point to a property. Relative paths are relative to the [Node] that holds these bindings, unless [member group_b] is defined, in which case the path will be relative to the first [Node] found in that group.
@export var path_b: NodePath = ^""
## Group, the first node of which will be set as [member node_b]. If [member path_b] is a relative path that points to a [Node], this node will be taken as the starting point of that [NodePath].
@export var group_b: StringName = &""

## A node to bind. This is the data source.
var node_a: Node
## B node to bind. This is the data receiver.
var node_b: Node
#endregion variables


#region methods
## Applies the binding.
func apply(do_transform: bool = true) -> void:
	if do_transform:
		node_b.set_indexed(path_b.get_concatenated_subnames() as String,
			_transform(node_a.get_indexed(path_a.get_concatenated_subnames() as String))
		)
	else:
		node_b.set_indexed(path_b.get_concatenated_subnames() as String,
			node_a.get_indexed(path_a.get_concatenated_subnames() as String)
		)

## Updates [member node_a] and [member node_b]. [param node] is the [Node] to which relative paths will relate to. [param null_only] will only update the nodes if they are [code]null[/code].
func update_nodes(node: Node, null_only: bool = true) -> void:
	if (null_only and node_a == null) or !null_only:
		node_a = Helper.get_node(node, path_a, group_a)
	if (null_only and node_b == null) or !null_only:
		node_b = Helper.get_node(node, path_b, group_b)
#endregion methods


#region virtual
## Virtual method to transform the input data from [member node_a] to output data for [member node_b]. Override this to change binding output.
func _transform(input: Variant) -> Variant:
	return input
#endregion virtual
