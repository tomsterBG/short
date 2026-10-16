# TODO:
# IDEAS:
# - x icon for the node

## A button that deletes a [Node].
##
## When the button is pressed, the [member delete_node] will be deleted.
##[br][br][b]Note:[/b] This overrides [method Node._get_configuration_warnings] and [method BaseButton._pressed]. Use [code]super()[/code] if you want to extend the same methods.

@tool
class_name DeleteButton extends Button


#region enums
## A method to use for deletion.
enum DeletionMethod {
	## Use [method Node.free].
	FREE,
	## Use [method Node.queue_free].
	QUEUE_FREE,
}
#endregion enums


#region variables
@export_group("Delete", "delete_")

## Toggles whether to trigger deletion when the button is pressed.
@export var delete_on_pressed: bool = false

## Deletes this [Node] when the button is pressed.
@export var delete_node: Node: set = set_delete_node

## Uses this method for deletion.
@export var delete_method: DeletionMethod = DeletionMethod.QUEUE_FREE
#endregion variables


#region setters
func set_delete_node(value: Node) -> void:
	delete_node = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region methods
## Deletes [member delete_node] according to [member delete_method].
func delete() -> void:
	if !delete_node: return
	match delete_method:
		DeletionMethod.FREE:
			delete_node.free()
		DeletionMethod.QUEUE_FREE:
			delete_node.queue_free()
#endregion methods


#region virtual
func _pressed() -> void:
	if !delete_on_pressed: return
	delete()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !delete_node:
		warnings.append("Missing node to delete.")
	return warnings
#endregion virtual
