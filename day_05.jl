# Setup
lines = readlines("./tests/day_05.txt")
#lines = readlines("./puzzle_inputs/day_05.txt")
rules = [line for line in lines if occursin("|", line)]
updates = [line for line in lines if occursin(",", line)]

function is_valid(rule::String, update::String)
    pre, post = split(rule, "|")
    pages = split(update, ",")    
    a = findfirst(==(pre), pages)
    b = findfirst(==(post), pages)
    return isnothing(a) || isnothing(b) || a < b
end

function is_valid(rules::Vector{String}, update::String) 
    return all(is_valid.(rule, update) for rule in rules)
end

valid_updates = [update for update in updates if is_valid(rules, update)]

middle_element(update::AbstractString) = middle_element(split(update, ","))
function middle_element(update::Vector{<:Any})
    n = length(update)
    i = Int((n+1)/2)
    return parse(Int, string(update[i]))
end

part1_answer = middle_element.(valid_updates) |> sum
println("part 1 answer: $part1_answer")

# Part 2
invalid_updates = [update for update in updates if !is_valid(rules, update)]

invalid_update = invalid_updates[1]

x = parse.(Int, split(invalid_update, ","))
function is_sorted(a::Int, b::Int, rules::Vector{String})

end

# is_valid(rule::String, a::Int, b::Int) = is_valid(split(rule, ""))
# is_valid(rule::Vector{Int})

while is_not_sorted

    # check every pair in the array
    for i in 2:length(array)
        a, b = array[i-1], array[i]
        for rule in rules


        end
    end