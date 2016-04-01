include("../src/Transit.jl")

using Base.Test
import Transit

function round_trip(inval)
  io = IOBuffer()
  JSON.print(io, inval) # temporary hack for json only testing, Transit.print?
  seek(io, 0)
  Transit.parse(io)
end


@test round_trip([1, 2, 3, 4]) == [1, 2, 3, 4]
@test round_trip(["some", "funny", "words"]) == ["some", "funny", "words"]
@test round_trip([1, "and", 2, "we", Dict{Any,Any}("mix"=>"it up")]) == 
                 [1, "and", 2, "we", Dict{Any,Any}("mix"=>"it up")]
@test round_trip(Dict{Any,Any}("a" => 1, "b" => 2)) == Dict{Any,Any}("a" => 1, "b" => 2)
@test round_trip(Dict{Any,Any}("a" => 1)) == Dict{Any,Any}("a" => 1)
@test round_trip(Dict{Any,Any}("a" => Dict{Any,Any}("b" => 2))) ==
                 Dict{Any,Any}("a" => Dict{Any,Any}("b" => 2))
