function startswith(str::AbstractString, pats...)
    for pat in pats
        if start(search(str, pat)) != 1
            return false
        end
    end
    true
end

function constantly(value)
    function(_...)
        value
    end
end