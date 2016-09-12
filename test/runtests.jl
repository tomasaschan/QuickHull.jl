module QuickHullTests

using QuickHull
using Base.Test
using FixedSizeArrays

# test data
getpoints(N) = map(Vec, rand(N), rand(N))
getpoints(xs,ys) = map(Vec, xs, ys)
getxys(N::Int) = rand(N), rand(N)
getxys{T<:Vec{2}}(points::Vector{T}) = map(p->p[1],points), map(p->p[2],points)

function test_property(property)
    points = getpoints(50)
    hull = qhull(points)

    property(points, hull)

    xys = getxys(50)
    xyhull = qhull(xys...)

    property(getpoints(xys...), getpoints(xyhull...))

    nothing
end

# property: all points in hull are unique
test_property() do points, hull
    @test length(hull) == length(unique(hull))
end

# property: no point is to the right of any line through adjacent hull members
#           this property assumes counter-clockwise orientation of the hull,
#           and tests also for the pair of last-first points
test_property() do points, hull
    for (a,b) in zip(hull[1:end], vcat(hull[2:end], hull[1]))
        for q in points
            # skip points in the hull
            (q == a || q == b) && continue
            # q is to the right if |(b-a)x(q-a)| < 0 with implied z-coordinate = 0
            @test (b[1]-a[1])*(q[2]-a[2])-(b[2]-a[2])*(q[1]-a[1]) > 0
        end
    end
end

end
