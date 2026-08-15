extends GutTest


#region variables
var binding: AnimationBinding
#endregion variables


#region virtual
func before_each():
	binding = AnimationBinding.new()
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(binding.path, ^"")
	assert_eq(binding.group, &"")
	assert_eq(binding.animation, &"")
	assert_eq(binding.animation_player, null)
#endregion tests
