# Setup
lines = readlines("./puzzle_inputs/day_05.txt")
struct Rule
    before::Int
    after::Int
end
Rule(before, after) = Rule(parse(Int, before), parse(Int, after))
Rule(vector) = Rule(vector[1], vector[2])
Update = Vector{Int}

rule_strings = [string.(split(line, "|")) for line in lines if occursin("|", line)]
rules = Rule.(rule_strings)
update_strings = [string.(split(line, ",")) for line in lines if occursin(",", line)]
updates = [parse.(Int, update) for update in update_strings]

function is_valid(rule::Rule, update::Update)
    x = findfirst(==(rule.before), update)
    y = findfirst(==(rule.after), update)
    return isnothing(x) || isnothing(y) || x < y
end

function is_valid(rules::Vector{Rule}, update::Update) 
    return all(is_valid(rule, update) for rule in rules)
end

function middle_element(update::Update)
    n = length(update)
    i = Int((n+1)/2)
    return update[i]
end

valid_updates = [update for update in updates if is_valid(rules, update)]
part1_answer = middle_element.(valid_updates) |> sum
println("part 1 answer: $part1_answer")

# Part 2
invalid_updates = [update for update in updates if !is_valid(rules, update)]

# checking is page 2 before page 1 in any of the rules
function is_valid(page1::Int, page2::Int, rules::Vector{Rule})
    for rule in rules
        # if you break a rule
        if page1 == rule.after && page2 == rule.before
            return false
        end
    end
    return true
end

function sort_all!(rules::Vector{Rule}, updates::Vector{Update})
    while !all(is_valid(rules, update) for update in updates)
        for update in updates
            # check every pair in the array, going right to left
            for i in length(update):-1:2
                a, b = update[i-1], update[i]
                
                # if the pair isn't valid, swap them
                if !is_valid(a, b, rules)            
                    update[i-1], update[i] = b, a
                end
            end
        end
    end
end

while !all(is_valid(rules, update) for update in invalid_updates)
    sort_all!(rules, invalid_updates)
end

part2_answer = middle_element.(invalid_updates) |> sum
println("Part 2 answer: $part2_answer")
