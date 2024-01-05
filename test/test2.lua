local vector = require "lib/vector3d"
local rotation = require "lib/rotation"
local pretty = require "cc.pretty"
local print = pretty.pretty_print
local a = vector:newVector(1,2,3)
local b = rotation:newVector(1,1,0)
local r = rotation:newFromAxisAngle(math.pi/4,0,1,0) -- axis angle, radians
print(b.q:toString())
--print(b:getEulerAngle321())
print(r.q:toString())
local rb = b:rotateClockwise(r)
--print(rb:getEulerAngle321())
print(rb.q:toString())
local rm = rotation:newFromEulerAngle321(rb:getEulerAngle321())
print(rm.q:toString())

