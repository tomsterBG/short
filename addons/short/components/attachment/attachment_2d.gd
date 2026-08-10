# IDEAS:
# - get_joints() -> Array[Joint2D]

## An attachment useful for physics joints.
##
##[br][br][b]Note:[/b] Inspired by Roblox attachments. See [url=https://create.roblox.com/docs/reference/engine/classes/Attachment]Roblox Attachment[/url].
class_name Attachment2D extends Marker2D


#region variables
## The physics body to attach to.
@export var body: PhysicsBody2D
#endregion variables


#region getters
## If [member body] is a [RigidBody2D], returns it, otherwise returns [code]null[/code].
func get_rigid_body() -> RigidBody2D:
	if body is RigidBody2D: return body
	return null
#endregion getters
