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

# Outside knowledge

I just got recommended this video: <https://www.youtube.com/watch?v=2OMRWPOSw9s>
It was immediately very good and it kept getting better.

The part about honest and dishonest functions really explained why HealthRegen needed to be rewritten such that it has a `simulate_regen()` function. Since dishonest functions like `get_ticks_msec()` are infectious, this immediately made my whole health regeneration logic infected with dishonesty, as in, untestable. So i looked for a better solution and found that i had to completely separate the untestable time from the fully testable logic. This also added a benefit of, if i would ever need to regenerate in different ways, rather than per frame, i would be able to do it. Like for a turn-based game where regeneration happens every turn. You just simulate 1 second of regeneration and assume that 1 second means 1 turn.
