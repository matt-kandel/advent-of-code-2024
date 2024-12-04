# Setup
# lines = readlines("./tests/day_04.txt")
lines = readlines("./puzzle_inputs/day_04.txt")

# function definitions
function parse_input_as_matrix(lines)
    hcat(collect.(lines)...) |> permutedims
end

function count_xmas(chars) 
    matches = eachmatch(r"(XMAS|SAMX)", string(join(chars)), overlap=true)
    return matches |> collect |> length |> sum
end

function count_xmas(grid::Matrix{Char})
    left_diags = create_offset(grid, "left")
    right_diags = create_offset(grid, "right")
    a = count_xmas.(eachrow(grid)) |> sum
    b = count_xmas.(eachcol(grid)) |> sum
    c = count_xmas.(eachcol(left_diags)) |> sum
    d = count_xmas.(eachcol(right_diags)) |> sum
    return sum([a, b, c, d])
end

"""
assuming grid is n by n square
(okay for this particular problem)

Turns:
[1 2 3;
4 5 6;
7 8 9]

into (how="left")
[1 2 3 0 0;
0 4 5 6 0;
0 0 7 8 9]

or (how="right")
[0 0 1 2 3;
0 4 5 6 0;
7 8 9 0 0]

So that you can read the diagonals off the columns
"""
function create_offset(grid, how="left")
    m, n = size(grid)
    output = fill('.', (m, 2n-1))
    for i in 1:m
        if how == "left"
            output[i, i:i+n-1] = grid[i, :]
        elseif how == "right"
            output[i, n+1-i:2n-i] = grid[i, :]
        end
    end
    return output
end

# part 1
grid = parse_input_as_matrix(lines)
part1_answer = count_xmas(grid)
println("Part 1 answer: $part1_answer")    
    
# part 2
    
#  count_xmas_crossed(grid)
#     left_diags = create_offset(grid, "left")
#     right_diags = create_offset(grid, "left")
#     regex = r"MAS|SAM"
# end

"""
column 4 in the first matches with column end-9 = 10 in the second
So I just need to align the columns somehow, and if there are two vertical matches
in the same place (row index), then it's a valid X

"""
test = """..........
..A.......
......BC..
..D.E.....
..........
..........
..........
.F.G.H.I..
..........
.........."""
test = """....AB....
....AB....
....AB....
....AB....
....AB....
....AB....
....AB....
....AB....
....AB....
....AB...."""

9
7
5
3
1
1
3
5
7
9

test = parse_input_as_matrix(split(test, "\n"))

left_diags = create_offset(test, "left")
right_diags = create_offset(test, "right")


