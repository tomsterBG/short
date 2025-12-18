# Godot short - Code shortening library for Godot 4.

# About

A library designed to make your code shorter and more elegant.
Everything is documented and tested.
Using this allows you to write less code, yet focus on more complex features.

This project is designed to...
...be high quality (as much as i can, but nobody is perfect).
...seamlessly integrate with the engine.
...adhere to Godot standards and style guides.
...be as simple as possible.
...be useful to everyone, not just me.
...achieve more with less.

# Content

- The GUT addon by bitwes for unit testing.
- The short addon by me.
- Tests for the short addon.
- Other things. Either unused or specific to this project.

# Why use this?

Before even stepping forward, you should know why you're using this.

## Shorter code

Use the library if it has what you need.
This delegates code from your project to the library, speeding up the iterative process and freeing up your time to focus on other things.
One problem: Your skills may diminish 

**Note:** If you're new to programming, this might be too much of a power tool for you. Consider using it later.

Personally i don't find writing to be a problem. Autocompletion exists.
However, when reading non-library code, i would do everything i can to help my brain see less, because that lets me focus on what's truly important.
I don't want to figure out...
...a math formula, and every time i read it again, ask myself "What does this do here?".
...how to access files every time i need file access.
All that slows me down.

Long story *short*, hehe, figuring things out once is faster than dealing with them multiple times.
I say this from the frame of being this library's creator. If you want these benefits, you have to extend my code or write your own.

# How to use?

Download the project and delete anything you don't need.
- Everything you need is `addons/short/`. Everything else is just helping me develop this project.
- Careful with deleting things in the two folders. Some scripts depend on each other. You can see which script depends on which by looking at `tests/script_order_hook.gd`.

# License

This project is licensed under MIT which basically means you can do absolutely everything, except sue me.

My goal is not to limit people which is why i changed it from my original choice which was GPL V3. It makes a lot of sense to use GPL for FOSS, such as preventing distributors from taking away one's freedom to access the source code. However with games this just hurts the wrong people by preventing you from exporting to closed platforms like IOS.

If you want to use this and the license is incompatible, feel free to contact me. Though what are you doing if MIT is incompatible?

GUT has its own MIT license, respect it. I recommend just deleting my copy of GUT and using one from the asset library.

# Convention

I try to be as consistent as possible.

Each script must follow rules that make it extendable, simple and understandable.

## These rules include, but are not limited to

**Regions:**
- Strict order of regions, wrapped by region comments and separated by 2 lines.
	- Order: signals, enums, classes, constants, variables, setters, getters, methods, virtual, tests, internal.
- Everything within a region, with some exceptions, is to be separated by 1 line.
- Each nested region comment must be indented correctly.

**Other:**
- Full in-engine documentation with doc comments.
	- If documentation contains code examples, they must be asserted in tests.
- Strict order of comments at the beginning of a script.
	- Order: IMPORTANT, INFO, NOTE, SOURCES, TODO, IDEAS, BAD IDEAS.
- Getter functions:
	- This getter is useless: `get_health() -> float: return health`.
	- This getter is syntax sugar: `get_is_alive() -> bool: return !is_dead`.
	- This getter is syntax sugar: `get_health_ratio() -> float: return health / max_health`.
- If a func returns void, it mutates state. If it returns non-void, it doesn't mutate state, with some exceptions.
	- Exceptions are recognized by their name.
	- If the func returns self or a class inside self, it mutates state. Like `Health.damage()`.
- If it starts with is_ or has_, it returns a bool.
- If an inherited method is overwritten, ensure to note that in the description of the class.

## Rules for test scripts

- Each unit test should build on top of the ones before it, for easier troubleshooting.
	- Order each testcase in each script.
	- Order each test script.
	- As the Factorio devs have found, first run the tests that cover less dependent code. This way the first error will lead you closer to where the real problem is.
		- If Health has a bug, the error will also show up in HealthPlus. If you don't have a strict order for the tests, how do you determine which error to fix?
- Tests should only assume already asserted facts.
	- If a test makes an assumption, that wasn't asserted earlier, put a WARNING comment.
- If something is untested, add "@experimental: Untested." where it is defined, not where it is tested.

If in doubt, just write code however you want. Then look at how i've done it in other scripts and refactor your code. The `health` script is by far the best representative of how it should be done.

# Principles and wisdom

If you can't make it perfect, make it adjustable.
- What if you wanted the behavior of `get_resource_filename()` to also return the file extension?
  What if someone else doesn't want that?
  Solution: An optional parameter to let you decide.

A library is used.
Thus it is optimized for easier usage from the outside, containing documentation, syntax sugar, adjustability and editor integration.
- Patterns that incentivize bad usage and anti-patterns are to be avoided. Such as:
	- Many boolean parameters.
	  This may sound like a conflict to a previous point i made about optional parameters, but there's a fine balance between the two. Too few parameters: rigid code that is useless half the time. Too many parameters: madness of magic `true` and `false` everywhere.
	  I can't force you to use a variable and remove these "magic booleans", but it's a good principle.
	- Coupled hierarchy: `find_child_with_method` or `get_ancestor`.
	  This incentivizes usage of coupled hierarchies.

Make as few assumptions as possible about a class' usage context.
- If `Health` expects to be a child of, or work with a `Character`, this is very bad design.
  This is why all references are `@export` variables.
  And why `Health` is so generic, that it doesn't care what you use it for.

A library must be clean. Its users (games, projects), not so much.
- I should ask myself these questions every so often:
  Have i accumulated technical debt somewhere in this code?
  Have i made something in the fast, ugly and easily breakable way? If so, what do i do to break it?
  Have i made something too restrictive, ignoring a potential usecase where different behavior is needed?

No abstraction for the sake of abstraction.
- If it's useful, abstract it, if it's not, why?
- Math.sec_to_msec() - everyone knows that 1 second is 1000 milliseconds. If you don't, you will learn it.

This is called Godot short, not Godot long.
- If a method's name is longer than the code it abstracts, it must be gome.
  Exception: Methods that are very frequently used.

Careful with untestable features.
- It is impossible to unit test random and very hard to test `_process(delta)`. They need a different technology, maybe integration tests?
- If a feature's success cannot be guaranteed 100% of the time, it should be separated from the main unit test suite.

Little to no idiot-proofing, assert instead.
- A library is not used by idiots, it is used by developers.
  If there's a silent problem, make it loud and clear. For example: `bin_to_dec(binary: String)` may return wrong numbers for non-binary strings. Instead, it should assert if the string is binary and say "String is not binary.".
  Input edge cases are caused by users, and programmers know better when they're met with an error message.
  Covering edge cases in a library makes it slower.
  Edge cases differ from program to program.
