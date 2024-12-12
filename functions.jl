function parse_input_as_matrix(lines::Vector{<:Any})
    hcat(collect.(lines)...) |> permutedims
end

function parse_input_as_matrix(file::String)
    parse_input_as_matrix(readlines(file))
end
