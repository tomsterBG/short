# How to make good functions?

You want to write "lego bricks". Functions that compliment each other.

For example:
I was making a tool that prints the lines of all scripts in a project.
To achieve that, i need to find all files in the file explorer, choose only scripts and count their lines.
I wrote it multiple times and asked, how could i shorten this with my library?
The answer was `get_dir_children()` and `get_lines_in_file()`.
`get_dir_children()` helped me recursively get all files in a chosen directory.
`get_lines_in_file()` helped me count all lines in a file.
Together these two functions complimented my requirement and greatly shortened my code.

What happened after?
I could more easily read my logic.
I could add more complex rules.

So in turn the script was shortened, but grew again.

Code shortening and abstraction isn't as much about writing shorter code, as it is about letting you pack more functionality in the same amount of lines.

# Parameters

The more, the merrier.
Some functions just can't work well without enough parameters.

For example:
`PolyLib.arc`.

# Performance

But will abstraction cause issues with performance?
Even if it does you have the tools to solve that problem.

You can manually "inline" any function call and find duplicate logic.

Here's an analogy:
	I was playing a logic game, it has NAND gates. From NAND gates you build everything. The first, simplest gate would be the NOT, then you use those two to create AND, then on and on until you finally get an 8-bit adder.
	This was cool, but then i dove into the implementation of each logic gate and replaced it with its components. Basically i did the equivalent of an "inline" function.
	I saw many redundant gates and removed them.

If performance is ever an issue, you have the tools to solve it without needing to sacrifice the outside contract of what the function looks like.

How to ensure that performance *is* a problem?
Simple, unit-test a big amount of operations and fail the test if it takes too long.
