# IDEAS:
# - get_joints() -> Array[Joint2D]

## An attachment useful for physics joints.
##
##[br][br][b]Note:[/b] Inspired by Roblox attachments. See [url=https://create.roblox.com/docs/reference/engine/classes/Attachment]Roblox Attachment[/url].
class_name Attachment2D extends Marker2D


#region variables
## The physics body to attach to.
##[br][br][b]Note:[/b] Automatically sets [member rigid_body].
@export var body: PhysicsBody2D: set = set_body

## The rigid body to affect. Automatically gets set if [member body] is [RigidBody2D].
@export var rigid_body: RigidBody2D
#endregion variables


#region setters
func set_body(value: PhysicsBody2D) -> void:
	body = value
	if value is RigidBody2D:
		rigid_body = value
#endregion setters
