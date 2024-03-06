"""
$(TYPEDEF)
$(TYPEDFIELDS)

A dummy struct for testing purposes
"""
struct DummyStruct{T}
    "A parametric field"
    x::T
    "An integer field"
    y::Int
    "A float field"
    z::Float64
end


"""
$(TYPEDSIGNATURES)

An example dummy function that multiplies the argument by 10
"""
function dummymult10(x::Number)
    return 10x
end

"""
$(TYPEDSIGNATURES)

An example dummy function that returns some text
"""
function dummyfunction()
    return "A dummy function"
end

"""
$(TYPEDSIGNATURES)

An example dummy function that is not exported and returns some text
"""
function privatefunction()
    return "This function is not exported"
end

"""
$(TYPEDSIGNATURES)


An SECOND example dummy function that is not exported and returns some text

"""
function dummyfunction_02()
    return "A dummy function_02"
end