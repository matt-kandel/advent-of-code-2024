# Setup
lines = readlines("./puzzle_inputs/day_04.txt")
grid = parse_input_as_matrix(lines)

# function definitions
function parse_input_as_matrix(lines)
    hcat(collect.(lines)...) |> permutedims
end

function count_xmas(chars) 
    matches = eachmatch(r"(XMAS|SAMX)", join(chars), overlap=true)
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
part1_answer = count_xmas(grid)
println("Part 1 answer: $part1_answer")    

# part 2  - Really hackish way to do it, but I couldn't get a more elegant
# solution using regex or the left_diag / right_diag approach from part 1 :/
lines = readlines("./puzzle_inputs/day_04.txt")
grid = parse_input_as_matrix(lines)

function is_valid_MAS(a, b, c)
    return a == 'A' && ((b == 'M' && c == 'S') || (b == 'S' && c == 'M'))
end

m, n = size(grid)

valid_matches = 0
for i in 2:(m-1)
    for j in 2:(n-1)
        point = grid[i, j]
        top_left = grid[i-1, j-1]
        top_right = grid[i-1, j+1]
        bottom_left = grid[i+1, j-1]
        bottom_right = grid[i+1, j+1]
        valid_matches += (is_valid_MAS(point, top_left, bottom_right) &&
                          is_valid_MAS(point, top_right, bottom_left))
    end
end
println("Part 2 answer: $valid_matches")