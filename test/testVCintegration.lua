local vector = require "./lib/vector3d"
local rotation = require "./lib/rotation"
local pretty = require "cc.pretty"
local print = pretty.pretty_print
local Euler = rotation:newFromQuaternion(0,1,2,3):getEulerAngle321()
print(Euler)
local sr = peripheral.wrap("bottom")
local mon = peripheral.wrap("right")
term.redirect(mon)
while true do
    print(sr.getRotation())
    local c = sr.getRotation(true)
    local n = rotation:newFromQuaternion(c):getEulerAngle321()
    print(c)
    print(n)
    sleep()
end

