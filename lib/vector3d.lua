local vector3d = {}

local quaternion = require "./lib/quaternion"
local mcos = math.cos
local msin = math.sin
local matan2 = math.atan2
local masin = math.asin
local pi = math.pi
local sqrt = math.sqrt

function vector3d:new(o)
    --a 3d vector
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end


function vector3d:newVector(p1,p2,p3,o)
    --a 3d vector
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    if type(p1) == "table" then
        --quaternion
        x = p1[1]
        y = p1[2]
        z = p1[3]
    elseif type(p1) == "number" then
        x = p1
        y = p2
        z = p3
    end
    
    o.q = quaternion:new(0,x,y,z)

    return o
end

function vector3d:newFromQuaternion(p1,p2,p3,p4,o)
    --a 3d vector
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    if type(p1) == "table" then
        --quaternion
        w = p1[1]
        x = p1[2]
        y = p1[3]
        z = p1[4]
    elseif type(p1) == "number" then
        w = p1
        x = p2
        y = p3
        z = p4
    end
    
    o.q = quaternion:new(w,x,y,z)

    return o
end

function vector3d:rotateClockwise(R) -- input is a rotational quaternion, passive rotation
    --clockwise relative to the right hand rule coordinates
    --RVR*
    return vector3d:newFromQuaternion(R.q:mul(self.q:mul(R.q:inverse())))
end

function vector3d:rotateCounterClockwise(R) -- input is a rotational quaternion, active rotation
    --counter clockwise relative to the right hand rule coordinates
    --R*VR
    return vector3d:newFromQuaternion(R.q:inverse():mul(self.q:mul(R.q)))
end

function vector3d:getQuaternion() 
    return quaternion:new(R.q)
end

function vector3d:translate(v) 
    return vector3d:new(self.q:sum(v.q))
end

return vector3d
