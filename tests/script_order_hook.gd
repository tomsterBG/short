# INFO:
# When adding new test scripts, add them here.
# First are global scripts. If a script has a dependency, its dependency must be tested first.
# TODO:
# IDEAS:
# - Make the ordering function recursive. add_script_to_order(name, order), if a dependency isn't found, call the function recursively until the dependency is found or doesn't exist. Protect from circular dependencies.

extends GutHookScript


#region constants
const ACCURATE_PATH_PREFIX := "res://tests/accurate/test_"
const INACCURATE_PATH_PREFIX := "res://tests/inaccurate/test_"
const PATH_SUFFIX := ".gd"

const IS_DEEP := true
#endregion constants


#region variables
var accurate_test_scripts: Dictionary[StringName, Array] = {
	# name = [dependencies],
	# components:
	fold_button = [],
	health = [&"convert"],
	health_regen = [&"health"],
	# data:
	date_data = [&"date_time_lib"],
	date_time_data = [&"date_data", &"time_data"],
	time_data = [],
	timestamp_data = [],
	# libraries:
	console = [],
	convert = [&"helper"],
	date_time_lib = [&"convert"], # NOTE: &"date_data" circular dependency
	helper = [],
	math = [],
	physics = [],
}

var inaccurate_test_scripts: Dictionary[StringName, Array] = {
	# name = [dependencies],
	all = [&"health"],
}
#endregion variables


#region getters
func get_all_test_scripts() -> Dictionary[StringName, Array]:
	return accurate_test_scripts.merged(inaccurate_test_scripts)

func get_ordered_tests(all_test_scripts: Dictionary[StringName, Array]) -> Array[StringName]:
	var ordered_tests: Array[StringName]
	
	for test: StringName in all_test_scripts.keys():
		var dependencies := all_test_scripts[test]
		if dependencies.size() == 0:
			ordered_tests.push_front(test)
			continue
		
		var idx_of_last_dependency := -1
		for dependency: StringName in dependencies:
			if ordered_tests.find(dependency) > idx_of_last_dependency:
				idx_of_last_dependency = ordered_tests.find(dependency)
		ordered_tests.insert(idx_of_last_dependency+1, test)
	
	print("ordered_tests = ", ordered_tests)
	return ordered_tests

func get_test_paths(tests: Array[StringName]) -> Array[StringName]:
	for idx in range(tests.size()):
		if accurate_test_scripts.keys().has(tests[idx]):
			tests[idx] = ACCURATE_PATH_PREFIX + tests[idx] + PATH_SUFFIX
		elif inaccurate_test_scripts.keys().has(tests[idx]):
			tests[idx] = INACCURATE_PATH_PREFIX + tests[idx] + PATH_SUFFIX
	
	return tests
#endregion getters


#region methods
func are_tests_ordered_correctly(ordered_tests: Array[StringName]) -> bool:
	var tests := ordered_tests.duplicate(IS_DEEP)
	tests.reverse()
	
	for idx in range(tests.size()):
		var test_name: StringName = tests[idx]
		var dependencies: Array = get_all_test_scripts()[test_name]
		for dependency: StringName in dependencies:
			var dependency_idx: int = tests.find(dependency)
			if dependency_idx < idx:
				return false
	return true
#endregion methods


#region virtual
func run() -> void:
	var ordered_tests := get_ordered_tests(get_all_test_scripts())
	if are_tests_ordered_correctly(ordered_tests):
		print("Tests are in the correct order.\n")
	else:
		push_error("Tests are in the wrong order.")
	ordered_tests.assign(get_test_paths(ordered_tests))
	
	for test_script in gut.get_test_collector().scripts:
		if ordered_tests.has(test_script.path): continue
		ordered_tests.append(test_script.path)
		push_error(str(test_script.path) + " is not added to pre-run order.")
	
	gut.get_test_collector().scripts.sort_custom(func(a, b) -> bool:
		return ordered_tests.find(a.path) < ordered_tests.find(b.path)
	)
	
	#gut.get_test_collector().clear()
	#for test in ordered_tests:
		#gut.add_script(test)
#endregion virtual
