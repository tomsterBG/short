# INFO:
# When adding new test scripts, add them here.
# First are global scripts. If a script has a dependency, its dependency must be tested first.
# TODO:
# - Add a system to append unadded scripts and tell me about it.
# - Turn this into a dependency table.

extends GutHookScript


#region variables
var test_prefix = "res://tests/test_"
var test_suffix = ".gd"

var test_order: Array[String] = [
	# Globals:
	"helpers",
	# Components:
	"health",
	"health_plus",
]
#endregion variables


#region methods
func get_test_paths(tests: Array[String]) -> Array[String]:
	for idx in range(tests.size()):
		tests[idx] = test_prefix + tests[idx] + test_suffix
	return tests
#endregion methods


#region virtual methods
func run():
	var ordered_tests = get_test_paths(test_order)
	
	print("Pre-run hook is re-ordering the tests.")
	
	for test_script in gut.get_test_collector().scripts:
		if ordered_tests.has(test_script.path): continue
		ordered_tests.append(test_script.path)
		push_warning(str(test_script.path) + " is not added to pre-run order.")
	
	gut.get_test_collector().clear()
	for test_path in ordered_tests:
		gut.add_script(test_path)
	
	print("Hook has finished re-ordering tests.\n")
#endregion virtual methods
