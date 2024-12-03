# Part 1
text = readlines("./puzzle_inputs/day_03.txt") |> join
regex = r"(?<=mul\()\d+,\d+(?=\))"

function parse_text(text, regex)
    pairs = [x.match for x in eachmatch(regex, text)]
    pairs = [parse.(Int, pair) for pair in split.(pairs, ",")]
    return pairs # Vector{Vector{Int}}
end

pairs = parse_text(text, regex)
part1_answer = sum(x * y for (x, y) in pairs)
println("Part 1 answer: $part1_answer")

# Part 2 - Find the deactivated instructions and subtract from part 1 answer
regex2 = r"don't().*?(do\(\)|$)"
deactivated_text = [x.match for x in eachmatch(regex2, text)] |> join
deactivated_pairs = parse_text(deactivated_text, regex)
part2_answer = part1_answer - sum(x * y for (x, y) in deactivated_pairs)
println("Part 2 answer: $part2_answer")