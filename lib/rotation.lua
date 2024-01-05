local rotation = {}

local quaternion = require "./lib/quaternion"
local mcos = math.cos
local msin = math.sin
local matan2 = math.atan2
local masin = math.asin
local pi = math.pi
local sqrt = math.sqrt

function rotation:newVector(p1,p2,p3,o)
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
    
    o.q = quaternion:new(0,x,y,z):normalize()

    return o
end

function rotation:newFromQuaternion(p1,p2,p3,p4,o)
    --a 3d vector
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    
    if type(p1) == "table" then
        --quaternion
        if type(p1.w) == "number" then
            w = p1.w
            x = p1.x
            y = p1.y
            z = p1.z
        else
            w = p1[1]
            x = p1[2]
            y = p1[3]
            z = p1[4]
        end
    elseif type(p1) == "number" then
        w = p1
        x = p2
        y = p3
        z = p4
    end
    
    o.q = quaternion:new(w,x,y,z):normalize()

    return o
end

function rotation:newFromAxisAngle(p1,p2,p3,p4,o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    local angle = p1/2
    local q1 = mcos(angle)
    local q2 = msin(angle)
    local q3 = msin(angle)
    local q4 = msin(angle)
    if type(p2) == "table" then
        --quaternion
        q2 = q2 * p2[1]
        q3 = q3 * p2[2]
        q4 = q4 * p2[3]
        return o
    end
    q2 = q2 * p2
    q3 = q3 * p3
    q4 = q4 * p4
    o.q = quaternion:new(q1,q2,q3,q4):normalize()
    return o
end

function rotation:newFromEulerAngle321(p1,p2,p3,o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    local u = 0
    local v = 0
    local w = 0
    if type(p1) == "table" then
        
        if type(p1.pitch) == "number" then
            u = p1.roll
            v = p1.pitch
            w = p1.yaw
        else
            u = p1[1]
            v = p1[2]
            w = p1[3]
        end
    else 
        u = p1
        v = p2
        w = p3
    end
    
    local q1 =  mcos(u/2)*mcos(v/2)*mcos(w/2) + msin(u/2)*msin(v/2)*msin(w/2)
    local q2 =  msin(u/2)*mcos(v/2)*mcos(w/2) - mcos(u/2)*msin(v/2)*msin(w/2)
    local q3 =  mcos(u/2)*msin(v/2)*mcos(w/2) + msin(u/2)*mcos(v/2)*msin(w/2)
    local q4 =  mcos(u/2)*mcos(v/2)*msin(w/2) - msin(u/2)*msin(v/2)*mcos(w/2)
    o.q = quaternion:new(q1,q2,q3,q4):normalize()
    return o
end

function rotation:rotateClockwise(R) -- input is a rotational quaternion, passive rotation
    --clockwise relative to the right hand rule coordinates
    --RVR*
    return rotation:newFromQuaternion(R.q:mul(self.q:mul(R.q:inverse())))
end

function rotation:rotateCounterClockwise(R) -- input is a rotational quaternion, active rotation
    --counter clockwise relative to the right hand rule coordinates
    --R*VR
    return rotation:newFromQuaternion(R.q:inverse():mul(self.q:mul(R.q)))
end

function rotation:getAxisAngle() 
    return {}
end

function rotation:getEulerAngle321(o)-- not recommended cause it causes gimbal lock
    o = o or {}
    local q = self.q
    local test = q[2]*q[3]+q[4]*q[1]

    local sp = sqrt(1+2*(q[1]*q[3]+q[2]*q[4]))
    local cp = sqrt(1-2*(q[1]*q[3]+q[2]*q[4]))
    o[2] = 2*matan2(sp,cp) - pi/2
    if test > 0.499 then
        o[1] = 0
        o[3] = -2*matan2(q[2],q[1])
        o[2] = pi/2
    elseif test < -0.499 then
        o[1] = 0
        o[3] = 2*matan2(q[2],q[1])
        o[2] = pi/2
    else
        o[1] = matan2(2*(q[1]*q[2]+q[3]*q[4]),1-2*(q[2]*q[2]+q[3]*q[3]))
        o[3] = matan2(2*(q[1]*q[4]+q[2]*q[3]),1-2*(q[3]*q[3]+q[4]*q[4]))
    end
    o.roll = o[1]
    o.pitch = o[3]
    o.yaw = o[2]
    return o
end

function rotation:getQuaternion() 
    return quaternion:new(R.q)
end

return rotation
