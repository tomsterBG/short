extends GutTest


#region variables
var binding: PropertyBinding
#endregion variables


#region virtual
func before_each():
	binding = PropertyBinding.new()
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(binding.path_a, ^"")
	assert_eq(binding.group_a, &"")
	assert_eq(binding.path_b, ^"")
	assert_eq(binding.group_b, &"")
	assert_eq(binding.node_a, null)
	assert_eq(binding.node_b, null)
#endregion tests
