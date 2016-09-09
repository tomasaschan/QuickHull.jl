module QHullTests

using QHull
using Base.Test
using FixedSizeArrays

# Verified graphically
points = [
 Vec(0.899106, 0.193778),
 Vec(0.687794, 0.766121),
 Vec(0.953124, 0.0108885),
 Vec(0.0238696, 0.198551),
 Vec(0.256684, 0.64828),
 Vec(0.580733, 0.474375),
 Vec(0.157125, 0.0315691),
 Vec(0.464983, 0.561721),
 Vec(0.942566, 0.77378),
 Vec(0.146051, 0.549534)
]

expected = [
 Vec(0.0238696, 0.198551),
 Vec(0.157125, 0.0315691),
 Vec(0.953124, 0.0108885),
 Vec(0.942566, 0.77378),
 Vec(0.687794, 0.766121),
 Vec(0.256684, 0.64828),
 Vec(0.146051, 0.549534)
]

# helper methods
setequals(A, B) = length(setdiff(union(A,B), intersect(A,B))) == 0

# test implementation
actual = qhull(points)
@test setequals(actual, expected)

end