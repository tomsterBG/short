# INFO:
# When adding new test scripts, add them here.
# First are global scripts. If a script has a dependency, its dependency must be tested first.
# TODO:
# IDEAS:
# - Make the ordering function recursive. add_script_to_order(name, order), if a dependency isn't found, call the function recursively until the dependency is found or doesn't exist. Protect from circular dependencies.

extends GutHookScript


#region constants
const IS_DEEP = true
#region constants


#region variables
var path_prefix = "res://tests/test_"
var path_suffix = ".gd"

var test_scripts: Dictionary[StringName, Array] = {
	# name = [dependencies],
	# classes:
	convert = [],
	helper = [],
	# components:
	health = [&"convert"],
	health_plus = [&"health", &"convert"],
}
#endregion variables


#region methods
func get_ordered_tests() -> Array[StringName]:
	var ordered_tests: Array[StringName]
	
	for test: StringName in test_scripts.keys():
		var dependencies := test_scripts[test]
		if dependencies.size() == 0:
			ordered_tests.push_front(test)
			continue
		
		var idx_of_last_dependency: int = -1
		for dependency in dependencies:
			if ordered_tests.find(dependency) > idx_of_last_dependency:
				idx_of_last_dependency = ordered_tests.find(dependency)
		ordered_tests.insert(idx_of_last_dependency+1, test)
	
	print("ordered_tests = ", ordered_tests)
	return ordered_tests

func are_tests_ordered_correctly(ordered_tests: Array[StringName]) -> bool:
	var tests := ordered_tests.duplicate(IS_DEEP)
	tests.reverse()
	
	for idx in range(tests.size()):
		var test_name: StringName = tests[idx]
		var dependencies: Array = test_scripts[test_name]
		for dependency in dependencies:
			var dependency_idx: int = tests.find(dependency)
			if dependency_idx < idx:
				return false
	return true

func get_test_paths(tests: Array[StringName]) -> Array[StringName]:
	for idx in range(tests.size()):
		tests[idx] = path_prefix + tests[idx] + path_suffix
	return tests
#endregion methods


#region virtual methods
func run():
	var ordered_tests := get_ordered_tests()
	if are_tests_ordered_correctly(ordered_tests):
		print("Tests are in the correct order.\n")
	else:
		push_error("Tests are in the wrong order.")
	ordered_tests = get_test_paths(ordered_tests)
	
	for test_script in gut.get_test_collector().scripts:
		if ordered_tests.has(test_script.path): continue
		ordered_tests.append(test_script.path)
		push_error(str(test_script.path) + " is not added to pre-run order.")
	
	gut.get_test_collector().clear()
	for test in ordered_tests:
		gut.add_script(test)
#endregion virtual methods
