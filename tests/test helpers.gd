# TODO:
# - Ensure correct code formatting.
# - Use unit testing.tscn as a mock scene for the find_child methods.
# - Look at Godot source code to accurately improve the find_child functions.
# - Test find_child_with_method, find_children_with_method, find_child_with_signal, find_children_with_signal. Test for recursive, owners and other combinations.

extends GutTest


#region tests
func test_existence():
	assert_is(Helpers, HelperMethods, "Helpers exists.")

func test_find_child_with():
	fail_test("TODO: Test the methods on unit testing.tscn.")
#endregion tests
