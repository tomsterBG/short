# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:
# - Instead of just two, make it any number of animations.

## @experimental: This class could change.
## Data that defines a binding to an [AnimationPlayer]'s [Animation].
##
##[br][br][b]Note:[/b] This assumes that the [Helper] class exists.

class_name AnimationBinding extends Resource


#region variables
## [NodePath] where to find the node. Relative paths are relative to the [Node] that holds these bindings, unless [member group] is defined, in which case the path will be relative to the first [Node] found at that group.
@export var path: NodePath = ^""
## Group, the first node of which will be set as [member node]. If [member path] is a relative path that points to a [Node], this node will be taken as the starting point of that [NodePath].
@export var group: StringName = &""
## [Animation] to play in the [AnimationPlayer] found at [path].
@export var animation: StringName = &""

## [AnimationPlayer] node found at [path].
var animation_player: AnimationPlayer
#endregion variables


#region methods
## Shortcut for [method AnimationPlayer.play].
func play(custom_blend: float = -1.0, custom_speed: float = 1.0, from_end: bool = false) -> void:
	animation_player.play(animation, custom_blend, custom_speed, from_end)

## Shortcut for [method AnimationPlayer.play_backwards].
func play_backwards(custom_blend: float = -1.0) -> void:
	animation_player.play_backwards(animation, custom_blend)

## Updates [member animation_player]. [param node] is the [Node] to which relative paths will relate to. [param null_only] will only update the [member animation_player] if it is [code]null[/code].
func update_animation_player(node: Node, null_only: bool = true) -> void:
	if (null_only and animation_player == null) or !null_only:
		animation_player = Helper.get_node(node, path, group)
#endregion methods
