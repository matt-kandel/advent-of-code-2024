# lines = readlines("./tests/day_02.txt")
lines = readlines("./puzzle_inputs/day_02.txt")
lines = [parse.(Int, split(line)) for line in lines]

function is_valid(line::Vector{<:Int})
    changes = line[2:end] .- line[1:end-1]
    all_increasing = all(changes .> 0)
    all_decreasing = all(changes .< 0)
    all_gradual = all(1 .<= abs.(changes) .<= 3)
    return (all_increasing | all_decreasing) & all_gradual
end

println("Part 1 answer: $(sum(is_valid.(lines)))")

# part 2
function get_every_combo(line)
    n = length(line)
    combos = []
    for i in eachindex(line)
        indexes = [x for x in collect(1:n) if x != i]
        push!(combos, line[indexes])
    end
    return combos
end

# Vector{Vector{Vector{Int}}}, I think
function is_valid(line::Vector{<:Any})
    return any(is_valid.(line))
end

println("Part 2 answer: $(sum(is_valid.(get_every_combo.(lines))))")