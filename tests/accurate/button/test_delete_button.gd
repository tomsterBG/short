extends GutTest


#region variables
var delete_button: DeleteButton
#endregion variables


#region virtual
func before_each():
	delete_button = DeleteButton.new()
	add_child_autofree(delete_button)
	watch_signals(delete_button)
#endregion virtual


#region tests
func test_initial_values():
	assert_false(delete_button.delete_on_pressed, "Delete on pressed is disabled.")
	assert_null(delete_button.delete_node, "Node is null.")
	assert_eq(delete_button.delete_method, DeleteButton.DeletionMethod.QUEUE_FREE, "Method is queue free.")

func test_initial_method_values():
	assert_eq(delete_button._get_configuration_warnings().size(), 1, "Node is null.")
#endregion tests
