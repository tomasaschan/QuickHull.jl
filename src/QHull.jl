module QHull

using FixedSizeArrays

export qhull

function qhull(xs, ys)
    points = map(Vec, xs, ys)
    hull = qhull(points)
    x, y = collect(zip(map(p -> (p...), hull)...))
    collect(x), collect(y)
end

function qhull{T<:Vec{2}}(points::Vector{T})
    hull = Vector{T}(0)

    A = points[findmin(map(p->p[1], points))[2]]
    B = points[findmax(map(p->p[1], points))[2]]

    push!(hull, A)

    s1, s2 = partition(points, A, B)

    qhull!(hull, A, B, s1)

    push!(hull, B)

    qhull!(hull, B, A, s2)

    hull
end

function qhull!(hull, P, Q, points)
    length(points) == 0 && return

    C = points[findmax(map(p -> distance(P,Q,p), points))[2]]
    
    s1, s2 = partition(points, P, Q, C)

    qhull!(hull, P, C, s1)
    push!(hull, C)
    qhull!(hull, C, Q, s2)
end

function partition{T}(points, A::T, B::T)
    s1, s2 = Vector{T}(0), Vector{T}(0)

    for p in points
        (p == A || p == B) && continue
        push!((right_of(A,B,p) ? s1 : s2), p)
    end

    s1, s2
end

function partition{T}(points, P::T, Q::T, C::T)
    s1, s2 = Vector{T}(0), Vector{T}(0)

    for p in points
        p == C && continue

        if right_of(P, C, p)
            push!(s1, p)
        elseif right_of(C, Q, p)
            push!(s2, p)
        end
    end

    s1, s2
end

@inline distance(A,B,C) = abs(cross(C-A, C-B)) 

@inline cross(A,B) = A[1]*B[2]-B[1]*A[2]

@inline right_of(A, B, C) = cross(B-A,C-A) < 0
end # module
