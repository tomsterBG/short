extends GutTest


#region variables
var attachment: Attachment3D
#endregion variables


#region virtual
func before_each():
	attachment = Attachment3D.new()
	add_child_autofree(attachment)
	watch_signals(attachment)
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(attachment.body, null, "Body is null.")

func test_initial_method_values():
	assert_eq(attachment.get_rigid_body(), null, "Rigid body is null.")

func test_get_rigid_body():
	var char_body := CharacterBody3D.new()
	add_child_autofree(char_body)
	attachment.body = char_body
	assert_eq(attachment.body, char_body, "Body is set.")
	assert_eq(attachment.get_rigid_body(), null, "Body is not rigid.")
	
	var rigid_body := RigidBody3D.new()
	add_child_autofree(rigid_body)
	attachment.body = rigid_body
	assert_eq(attachment.body, rigid_body, "Body is set.")
	assert_eq(attachment.get_rigid_body(), rigid_body, "Body is rigid.")
	
	attachment.body = char_body
	assert_eq(attachment.body, char_body, "Body is set.")
	assert_eq(attachment.get_rigid_body(), null, "Body is not rigid.")
#endregion tests
