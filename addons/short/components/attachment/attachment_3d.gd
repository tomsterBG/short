# IDEAS:
# - get_joints() -> Array[Joint3D]

## An attachment useful for physics joints.
##
##[br][br][b]Note:[/b] Inspired by Roblox attachments. See [url=https://create.roblox.com/docs/reference/engine/classes/Attachment]Roblox Attachment[/url].
class_name Attachment3D extends Marker3D


#region variables
## The physics body to attach to.
##[br][br][b]Note:[/b] Automatically sets [member rigid_body].
@export var body: PhysicsBody3D: set = set_body

## The rigid body to affect. Automatically gets set if [member body] is [RigidBody3D].
@export var rigid_body: RigidBody3D
#endregion variables


#region setters
func set_body(value: PhysicsBody3D) -> void:
	body = value
	if value is RigidBody3D:
		rigid_body = value
#endregion setters
