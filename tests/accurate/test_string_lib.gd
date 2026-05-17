extends GutTest


#region tests
func test_is_affirmative():
	assert_true(StringLib.is_affirmative("yes"), "Affirmative.")
	assert_true(StringLib.is_affirmative("y"), "Affirmative.")
	assert_true(StringLib.is_affirmative("true"), "Affirmative.")
	assert_true(StringLib.is_affirmative("1"), "Affirmative.")
	
	assert_false(StringLib.is_affirmative(""), "Not affirmative.")
	assert_false(StringLib.is_affirmative("no"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("n"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("false"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("0"), "Not affirmative.")

func test_is_negative():
	assert_true(StringLib.is_negative("n"), "Negative.")
	assert_true(StringLib.is_negative("false"), "Negative.")
	assert_true(StringLib.is_negative("0"), "Negative.")
	assert_true(StringLib.is_negative("no"), "Negative.")
	
	assert_false(StringLib.is_negative(""), "Not negative.")
	assert_false(StringLib.is_negative("yes"), "Not negative.")
	assert_false(StringLib.is_negative("y"), "Not negative.")
	assert_false(StringLib.is_negative("true"), "Not negative.")
	assert_false(StringLib.is_negative("1"), "Not negative.")

func test_is_binary():
	assert_true(StringLib.is_binary("100111011101100"), "A number in binary.")
	assert_false(StringLib.is_binary("100O1101O101100"), "Not a number in binary.")
	assert_false(StringLib.is_binary(""), "Not a number in binary.")

func test_is_character():
	assert_true(StringLib.is_character("7"), "A character.")
	assert_true(StringLib.is_character("A"), "A character.")
	assert_true(StringLib.is_character("*"), "A character.")
	assert_false(StringLib.is_character("923"), "Not a character.")
	assert_false(StringLib.is_character("chap"), "Not a character.")
	assert_false(StringLib.is_character(""), "Not a character.")

func test_is_digit():
	assert_true(StringLib.is_digit("2"), "A digit.")
	assert_false(StringLib.is_digit("69"), "Not a digit.")
	assert_false(StringLib.is_digit("a"), "Not a digit.")
	assert_false(StringLib.is_digit(""), "Not a digit.")

func test_is_letter():
	assert_true(StringLib.is_letter("t"), "A letter.")
	assert_false(StringLib.is_letter("zag"), "Not a letter.")
	assert_false(StringLib.is_letter("8"), "Not a letter.")
	assert_false(StringLib.is_letter(""), "Not a letter.")

func test_is_func_definition():
	assert_true(StringLib.is_func_definition("func"), "A function.")
	assert_true(StringLib.is_func_definition(" func "), "A function.")
	assert_true(StringLib.is_func_definition("func my_problem"), "A function.")
	assert_true(StringLib.is_func_definition("static func my_problem"), "A function.")
	assert_true(StringLib.is_func_definition("@abstract func my_problem"), "A function.")
	assert_false(StringLib.is_func_definition("static var"), "Not a function.")
	assert_false(StringLib.is_func_definition(""), "Not a function.")
#endregion tests
