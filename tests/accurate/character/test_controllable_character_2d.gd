extends GutTest


#region variables
var character: ControllableCharacter2D
#endregion variables


#region virtual
func before_each():
	character = ControllableCharacter2D.new()
	add_child_autofree(character)
	watch_signals(character)
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(character.move_in__process, false, "Movement in _process is disabled.")
	assert_eq(character.move_in__physics_process, false, "Movement in _physics_process is disabled.")
	assert_eq(character.gravity_enabled, false, "Gravity is disabled.")
	assert_eq(character.walk_enabled, false, "Walk is disabled.")
	assert_eq(character.walk_left_action, &"", "No action.")
	assert_eq(character.walk_right_action, &"", "No action.")

func test_get_walk_direction():
	assert_eq(character.get_walk_direction(), Vector2.ZERO, "Direction is 0.")
	
	character.walk_left_action = &"walk_left"
	assert_eq(character.get_walk_direction(), Vector2.ZERO, "Direction is 0.")
	
	Input.action_press(character.walk_left_action)
	assert_eq(Input.is_action_pressed(character.walk_left_action), true, "Walk left is pressed.")
	assert_eq(Input.get_action_strength(character.walk_left_action), 1.0, "Walk left is pressed.")
	assert_eq(character.get_walk_direction(), Vector2.LEFT, "Direction is left.")
	
	character.walk_up_action = &"walk_up"
	Input.action_press(character.walk_up_action)
	assert_eq(character.get_walk_direction(), (Vector2.LEFT + Vector2.UP).normalized(), "Direction is left up normalized.")
	
	Input.action_press(character.walk_left_action, 0.0)
	Input.action_press(character.walk_up_action, 0.0)

func test_calculate_velocity():
	assert_eq(character.calculate_velocity(0.1), Vector2.ZERO, "Velocity is 0.")
	character.gravity_enabled = true
	assert_eq(character.calculate_velocity(0.1), character.get_gravity() * 0.1, "Velocity is gravity * delta.")
	
	character.gravity_enabled = false
	character.walk_enabled = true
	character.walk_left_action = &"walk_left"
	assert_eq(character.calculate_velocity(0.1), Vector2.ZERO, "Velocity is 0.")
	
	Input.action_press(character.walk_left_action)
	assert_eq(character.calculate_velocity(0.1), Vector2.LEFT * 0.1, "Velocity is left * delta.")
	
	Input.action_press(character.walk_left_action, 0.0)
#endregion tests
