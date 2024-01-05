local quaternion = {0,0,0,0}

function quaternion:new(p1,p2,p3,p4,o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    if type(p1) == "table" then
        o[1] = p1[1]
        o[2] = p1[2]
        o[3] = p1[3]
        o[4] = p1[4]
        return o
    end
    o[1] = p1
    o[2] = p2
    o[3] = p3
    o[4] = p4
    return o
end

function quaternion.sum(q1,q2,qr)
    qr = qr or {0,0,0,0}
    if type(q2) == "table" then
        qr[1] = q1[1]+q2[1]
        qr[2] = q1[2]+q2[2]
        qr[3] = q1[3]+q2[3]
        qr[4] = q1[4]+q2[4]
    elseif type(q2) == "number" then
        qr[1] = q1[1]+q2
        qr[2] = q1[2]+q2
        qr[3] = q1[3]+q2
        qr[4] = q1[4]+q2
    end
    return quaternion:new(qr)
end

function quaternion:sub(q,qr)
    if type(q) == "table" then
        return self:sum(q:inverseSum(),qr)
    elseif type(q) == "number" then
        return self:sum(-q,qr)
    end
end

function quaternion.mul(q1,q2,qr)
    qr = qr or {0,0,0,0}
    if type(q2) == "table" then
        qr[1] = q1[1]*q2[1] - q1[2]*q2[2] - q1[3]*q2[3] - q1[4]*q2[4]
        qr[2] = q1[1]*q2[2] + q1[2]*q2[1] + q1[3]*q2[4] - q1[4]*q2[3]
        qr[3] = q1[1]*q2[3] - q1[2]*q2[4] + q1[3]*q2[1] + q1[4]*q2[2]
        qr[4] = q1[1]*q2[4] + q1[2]*q2[3] - q1[3]*q2[2] + q1[4]*q2[1]
    elseif type(q2) == "number" then
        qr[1] = q1[1]*q2
        qr[2] = q1[2]*q2
        qr[3] = q1[3]*q2
        qr[4] = q1[4]*q2
    end
    return quaternion:new(qr)
end

function quaternion:div(q1,qr)
    if type(q1) == "table" then
        return self:mul(q1:inverse(),qr)
    elseif type(q1) == "number" then
        return self:mul(1/q1,qr)
    end
end

function quaternion:conjugate()
    return quaternion:new(self[1],-self[2],-self[3],-self[4])
end

function quaternion:inverseSum()
    return quaternion:new(-self[1],-self[2],-self[3],-self[4])
end

function quaternion:magnitude()
    return math.sqrt(self[1]*self[1]+self[2]*self[2]+self[3]*self[3]+self[4]*self[4])
end

function quaternion:toString(format)
    format = format or "q(%.2f,%.2f,%.2f,%.2f)"
    return string.format(format,self[1],self[2],self[3],self[4])
end

function quaternion:inverse()
    return self:conjugate():mul(1/self:magnitude()/self:magnitude())
end

function quaternion:normalize()
    return self:mul(1/self:magnitude())
end

return quaternion
