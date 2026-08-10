extends GutTest


#region variables
var attachment: Attachment2D
#endregion variables


#region virtual
func before_each():
	attachment = Attachment2D.new()
	add_child_autofree(attachment)
	watch_signals(attachment)
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(attachment.body, null, "Body is null.")
	assert_eq(attachment.rigid_body, null, "Rigid body is null.")

func test_set_body():
	var char_body := CharacterBody2D.new()
	attachment.body = char_body
	assert_eq(attachment.body, char_body, "Body is set properly.")
	assert_eq(attachment.rigid_body, null, "Body is not rigid.")
	
	var rigid_body := RigidBody2D.new()
	attachment.body = rigid_body
	assert_eq(attachment.body, rigid_body, "Body is set properly.")
	assert_eq(attachment.rigid_body, rigid_body, "Body is rigid.")
	
	attachment.body = char_body
	assert_eq(attachment.body, char_body, "Body is set properly.")
	assert_eq(attachment.rigid_body, null, "Body is not rigid.")
#endregion tests
