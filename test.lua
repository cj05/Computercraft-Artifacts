local quaternion = require "lib/quaternion"
local a = quaternion:new(1,2,3,5)
local r = quaternion:new(-1,4,1,8)
print("A = "..a:toString())
print("R = "..r:toString())
print("Sum of A and R = "..a:sum(r):toString())
print("Sum of A and 2 = "..a:sum(2):toString())
print("Subtraction of A and R = "..a:sub(r):toString())
print("Subtraction of A and 2 = "..a:sub(2):toString())
print("Product of A and R = "..a:mul(r):toString())
print("Product of A and scalar 2 = "..a:mul(2):toString())
print("Division of A and R = "..a:div(r):toString())
print("Division of A and scalar 2 = "..a:div(2):toString())
local rc = r:conjugate()
print("Conjugate Of R = "..rc:toString())
print("Magnitude Of R = ",r:magnitude())
print("Inverse Of A = ",a:inverse():toString())
