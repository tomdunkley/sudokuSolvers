# sudokuSolvers
A set of sudoku solvers in different programming languages

I wanted to have a project to use as a benchmark for whether I "know" a programming language.
That is, a problem that I can try to solve in a new programming language with minimal googling
to test whether I could use that language well enough to tell others I knew it. After a minimal 
amount of thought (probably less than is reasonable), I went for solving sudokus.

I chose this as it involves at the very least arrays, loops, selections and various types, and
also could be slightly altered depending on the language being used. For example, if I want to
test my Python then I can use csv IO as that's something that comes up a lot in Python, but I
don't have to use that in a language like OCaml (where csv IO is probably quite common but I
learned it in an online compiler-interpreter so hadn't actually done any yet) or JavaScript
(where it's more sensible to take input from the user directly with a webpage).



Here's a chronological list of the languages I've done so far:

# PYTHON
I started with Python as it's the language I'm most familiar with so I could work out the actual
sudoku algorithm I wanted to use without having to think about syntax.

The basic algorithm is as follows:
 - Create a 9x9 2D array of lists that stores all possible values for each square in the input
   sudoku. It should start with all values "1"-"9" in each box or just the value in the input sudoku
   if it exists.
 - For every square in the sudoku, remove itself the lists that are in its box, column or row (except
   its own box).
 - For every square in the sudoku, if its list is empty then the sudoku cannot be solved; if the list
   is a singleton then update the square with what must be the correct value; otherwise continue.
 - If we failed to update a square on the previous step then the sudoku is either solved or cannot be
   solved with this algorithm.
   
It is important to note that this algorithm can't solve all solvable sudokus. It can't solve those
with ambiguity, for example. But this basic idea is enough for the goal of this project, which is to 
show coding proficiency rather than any intimate sudoku knowledge.

The Python program consists of a Sudoku class, which can be used by calling the solveSudoku function
and passing a csv formatted in the way shown by sudokotest.csv.

# JAVA
The java code is extremely similar to the python code, with all methods enclosed in a Sudoku object.

To use the program, we call Sudoku.solve passing the same csv as the Python code. psvm shows this
implemented.

# OCAML
The algorithm I used for the OCaml implementation is slightly altered to make it work better for 
functional programming. The set of non-helper functions are defined below.
 - getVal (char list list -> int -> int -> char)
    Get the value at a particular location
 - checkValidity (char list list -> int -> int -> char -> bool)
    Checks whether a passed value can be put into a passed location
 - solveSquare (char list list -> int -> int -> char list list * bool)
    Solves a single square of a sudoku if it can, returns the updated sudoku with the new value if
    it was changed or the input sudoku if it wasn't changed. Also returns a boolean which represents
    whether the passed square was changed.
 - solve (char list list -> char list list)
    Solves a suduko if it can, gets as far as it is able otherwise.
    
I didn't implement csv read/write as I wasn't yet sure how to do this and it didn't feel wholly
appropriate, although I would like to add this later for completeness if nothing else.

solve, then, takes a 9*9 char list list and returns an updated 9*9 char list list. It does this (via
many helper functions) by recursively checking whether a particular square can be updated. If it passes
through the whole sudoku without updating a square then we have gone as far as we can with this
algorithm: the sudoku is either solved or cannot be.


# TO DO
There are many more languages I would like to do this in, a to-do list is shown below:
 - C++
 - JavaScript (with HTML for gathering input)
 - C (although this will be very messy)
 - Haskell
