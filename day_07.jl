lines = readlines("./tests/day_07.txt")

function parse_line(line)
    result = parse(Int, split(line, ":")[1])
    values = parse.(Int, split(line, " ")[2:end])
    return result, values
end

struct Equation
    result::Int
    values::Vector{Int}
end

Equation(line) = Equation(parse_line(line)...)
equations = Equation.(lines)

function is_valid(equation::Equation, operators::Vector{<:Function})
    result = equation.values[1]
    for i in 1:length(operators)
        op = operators[i]
        value = equation.values[i+1]
        result = op(result, value)
    end
    return equation.result == result
end

# Next need a function to do all permutations of operators
