local vector = require "./lib/vector3d"
local rotation = require "./lib/rotation"
local pretty = require "cc.pretty"
local print = pretty.pretty_print
local Euler = rotation:newFromQuaternion(1,0,0,0):getEulerAngle321()
print(Euler)

