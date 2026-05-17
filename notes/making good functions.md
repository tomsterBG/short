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
