function parse_line(line)
    first, second = split(line, "   ")
    return parse(Int, first), parse(Int, second)
end

lines = readlines("./puzzle_inputs/day_01.txt")
parsed_lines = parse_line.(lines)

array1 = (x -> x[1]).(parsed_lines)
array2 = (x -> x[2]).(parsed_lines)

part1_answer = sort(array1) .- sort(array2) .|> abs |> sum
println("part 1 answer: $part1_answer")

# Part 2
counts = [sum(x .== array2) for x in array1]
part2_answer = counts .* array1 |> sum

println("part 2 answer: $part2_answer")