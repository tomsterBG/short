# IDEAS:
# - get_joints() -> Array[Joint3D]

## An attachment useful for physics joints.
##
##[br][br][b]Note:[/b] Inspired by Roblox attachments. See [url=https://create.roblox.com/docs/reference/engine/classes/Attachment]Roblox Attachment[/url].
class_name Attachment3D extends Marker3D


#region variables
## The physics body to attach to.
@export var body: PhysicsBody3D
#endregion variables


#region getters
## If [member body] is a [RigidBody3D], returns it, otherwise returns [code]null[/code].
func get_rigid_body() -> RigidBody3D:
	return body as RigidBody3D
#endregion getters
