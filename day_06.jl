include("./functions.jl")

function initialize()
    board = parse_input_as_matrix("./puzzle_inputs/day_06.txt")
    x₀, y₀ = collect(Tuple(findfirst(==('^'), board)))
    board[x₀, y₀] = 'X'
    return board, Guard([x₀, y₀], next_index['↑'], '↑')
end

Board = Matrix{Char}
"""
Maybe refactor later to:

mutable struct Guard
    x::Int
    y::Int
    arrow::Char # ↑, ←, →, or ↓
end
Guard(x, y, orientation)

Δ = Dict('↑' => (-1, 0), '→' => (0, 1), '↓' => (1, 0), '←' => (0, -1)
Δx, Δy = Δ[guard.arrow] 

"""
mutable struct Guard
    position::Vector{Int}
    Δ::Vector{Int}
    orientation::Char # ↑, ←, →, or ↓
end

next_index = Dict('↑' => [-1, 0], '→' => [0, 1], '↓' => [1, 0], '←' => [0, -1])
next_orientation = Dict('↑' => '→', '→' => '↓', '↓' => '←', '←' => '↑')

function rotate!(guard::Guard)  
    guard.orientation = next_orientation[guard.orientation]
    guard.Δ = next_index[guard.orientation]
end

function move!(guard::Guard, board::Board)
    m, n = size(board)
    # x, y are indexes for next position
    x, y = guard.position + guard.Δ
    if (1 <= x <= m) && (1 <= y <= n)
        if board[x, y] == '#'
            rotate!(guard)
        elseif (board[x, y] == '.') || (board[x, y] == 'X')
            board[x, y] = 'X'
            guard.position = [x, y] 
        end
    end
end

function play!(guard::Guard, board::Board)
    m, n = size(board)
    is_loop = false
    seen = [] # keep track of positions and orientations
    while true
        push!(seen_positions, (guard.position, guard.orientation))
        move!(guard, board)
        x, y = guard.position + guard.Δ
        if !(1 <= x <= m) || !(1 <= y <= n) # If you've reached the border
            break
        end

        if (guard.position, guard.orientation) in seen
            is_loop = true
            break
        end
    end
    return board, is_loop
end

# Part 1
board, guard = initialize()
board, is_loop = play!(guard, board)
println("Number of Xs: $(sum(1 for space in board if space == 'X'))")

# Part 2
import Base.copy
Base.copy(g::Guard) = Guard(g.position, g.Δ, g.orientation)

function count_loops(board₀, guard₀)
    m, n = size(board₀)
    number_loops = 0
    for i in 1:m
        for j in 1:n
            board, guard = copy(board₀), copy(guard₀)
            if board[i, j] == '.'
                board[i, j] = '#'
                print("Playing ($i, $j)... ")
                board, is_loop = play!(guard, board)
                if is_loop
                    number_loops += 1
                    println("is loop")
                else
                    println("not loop")
                end
            end
        end
    end
    return number_loops
end

board₀, guard₀ = initialize()
number_loops = count_loops(board₀, guard₀)

# This code produced the right answer, but it took 4-5 hours. There's gotta be
# some trick I'm missing to reduce the number of calculations
println("number of loops = $number_loops")
