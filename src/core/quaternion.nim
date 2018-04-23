import ./concepts

from strformat import `&`
from math import arctan2, arccos, sqrt
import hashes

import matrix 
import vector

type 
    Quaternion* = object
        x*,y*,z*,w* : float 

#Constructor
proc quaternion(x, y, z, w: float): Quaternion =
    result.x = x
    result.y = y
    result.z = z
    result.w = w

proc quaternion(w: float, v: Vector3): Quaternion =
    result.w = w
    result.x = v.x
    result.y = v.y
    result.z = v.z

#Copy
proc copy*(q: Quaternion): Quaternion = 
    result = Quaternion(x: q.x, y: q.y, z: q.z, w: q.w)

#Set
#NOTE : This is Added, not in design doc
proc set*(q: var Quaternion, x,y,z,w: float): var Quaternion {.noinit.} = 
    result.x = x
    result.y = y
    result.z = z
    result.w = w

proc set*(q: var Quaternion, n: float): var Quaternion {.noinit.} =
    result.x = x
    result.y = y
    result.z = z
    result.w = w

#Clear
template clear*(q: var Quaternion): var Quaternion = set(q, 0.0)

#Equals
proc `==`*(q1, q1: Quaternion): bool =
    result = q1.x == q2.x and q1.y == q2.y and q1.z == q2.z and q1.w == q2.w 

#Hash
proc hash*(q: Quaternion): hashes.Hash =
    result = !$(result !& hash(q.x) !& hash(q.y) !& hash(q.z) !& hash(q.w))

#String
proc `$`*(q: Quaternion): string = 
    result = &"[{q.x}, {q.y}, {q.z}, {q.w}]"

#Magnitude
proc magnitude*(q: Quaternion): float = 
    result = sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)

#Length
template length*(q: Quaternion): float = magnitude(q)

#Normalize
proc normalizeSelf*(q: var Quaternion, m: float = 1.0): var Quaternion {.noinit.} =
    let magnitude = magnitude(q)
    if(magnitude > 0):
        result = multiplySelf(q, m / magnitude)
    else:
        result = copy(q)

proc normalizeNew*(q: Quaternion, m: float = 1.0): Quaternion =
    let magnitude = magnitude(q)
    if(magnitude > 0):
        result = multiplyNew(q, m / magnitude)
    else:
        result = copy(q)

template normalize*(q: var Quaternion, m: float = 1.0): var Quaternion = normalizeSelf(q, m)

#Multiply
proc multiplyNew(q: Quaternion, f: float): Quaternion = 
    result.x = q.x * f
    result.y = q.y * f
    result.z = q.y * f
    result.w = q.w * f

proc multiplyNew(q1,q2: Quaternion): Quaternion =
    result.x = q1.x * q2.x 
    result.y = q1.y * q2.y
    result.z = q1.z * q2.z
    result.w = q1.w * q2.w

proc multiplySelf(q: var Quaternion, f: float) var Quaternion {.noinit.} = 
    q.x *= f
    q.y *= f 
    q.z *= f
    q.w *= f 
    result = q

proc multiplySelf(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit.} =
    q1.x *= q2.x
    q2.y *= q2.y
    q1.z *= q2.z
    q1.w *= q2.w 
    result = q1

template `*`*(q: Quaternion, f: float): Quaternion = multiplyNew(q,f)
template `*=`*(q: var Quaternion, f: float): var Quaternion = multiplySelf(q,f)

#Addition
proc addNew(q: Quaternion, f: float): Quaternion =
    result.x = q.x + f 
    result.y = q.y + f 
    result.z = q.z + f 
    result.w = q.w + f 

proc addNew(q1, q2: Quaternion): Quaternion = 
    result.x = q1.x + q2.x
    result.y = q1.y + q2.y
    result.z = q1.z + q2.z
    result.w = q1.w + q2.w

proc addSelf(q: var Quaternion, f: float): var Quaternion {.noinit.} = 
    q.x += f 
    q.y += f
    q.z += f
    q.w += f
    result = q

proc addSelf(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit} = 
    q1.x += q2.x 
    q1.y += q2.y 
    q1.z += q2.z 
    q1.w += q2.w 
    result = q1

template `+`*(q1,q2: Quaternion): Quaternion = addNew(q1, q2)
template `+`*(q: Quaternion, f: float): Quaternion = addNew(q, f)
template `+=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = addSelf(q1, q2)
template `+=`*(q: var Quaternion, f: float): var Quaternion = addSelf(q, f)

#Subtract
proc subtractNew(q: Quaternion, f: float): Quaternion =
    result.x = q.x - f 
    result.y = q.y - f 
    result.z = q.z - f 
    result.w = q.w - f 

proc subtractNew(q1, q2: Quaternion): Quaternion = 
    result.x = q1.x - q2.x
    result.y = q1.y - q2.y
    result.z = q1.z - q2.z
    result.w = q1.w - q2.w

proc subtractSelf(q: var Quaternion, f: float): var Quaternion {.noinit.} = 
    q.x -= f 
    q.y -= f
    q.z -= f
    q.w -= f
    result = q

proc subtractSelf(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit} = 
    q1.x -= q2.x 
    q1.y -= q2.y 
    q1.z -= q2.z 
    q1.w -= q2.w 
    result = q1

template `-`*(q1,q2: Quaternion): Quaternion = subtractNew(q1, q2)
template `-`*(q: Quaternion, f: float): Quaternion = subtractNew(q, f)
template `-=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = subtractSelf(q1, q2)
template `-=`*(q: var Quaternion, f: float): var Quaternion = subtractSelf(q, f)

#Divide
proc divideNew(q: Quaternion, f: float): Quaternion =
    if f == 0.0:
        raise newException(DivByZeroError,"Cannot divide by zero")
    result.x = q.x / f 
    result.y = q.y / f 
    result.z = q.z / f 
    result.w = q.w / f 

proc divideNew(q1, q2: Quaternion): Quaternion = 
    if q2.x == 0.0 or q2.y == 0.0 or q2.z == 0.0 or q2.w == 0.0:
        raise newException(DivByZeroError,"Cannot divide by zero")
    result.x = q1.x / q2.x
    result.y = q1.y / q2.y
    result.z = q1.z / q2.z
    result.w = q1.w / q2.w

proc divideSelf(q: var Quaternion, f: float): var Quaternion {.noinit.} = 
    if f == 0.0:
        raise newException(DivByZeroError,"Cannot divide by zero")
    q.x /= f 
    q.y /= f
    q.z /= f
    q.w /= f
    result = q

proc divideSelf(q1: var Quaternion, q2: Quaternion): var Quaternion {.noinit} = 
    if q2.x == 0.0 or q2.y == 0.0 or q2.z == 0.0 or q2.w == 0.0:
        raise newException(DivByZeroError,"Cannot divide by zero")
    q1.x /= q2.x 
    q1.y /= q2.y 
    q1.z /= q2.z 
    q1.w /= q2.w 
    result = q1

template `/`*(q1,q2: Quaternion): Quaternion = divideNew(q1, q2)
template `/`*(q: Quaternion, f: float): Quaternion = divideNew(q, f)
template `/=`*(q1: var Quaternion, q2: Quaternion): var Quaternion = divideSelf(q1, q2)
template `/=`*(q: var Quaternion, f: float): var Quaternion = divideSelf(q, f)

#Dot
proc dot*(q1, q2: Quaternion): float =
    result = q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w

#Invert
proc invertNew(q: Quaternion): Quaternion = 
    result.x = -q.x
    result.y = -q.y
    result.z = -q.z
    result.w = -q.w

proc invertSelf(q: var Quaternion): var Quaternion {.noinit.} = 
    q.x = -q.x
    q.y = -q.y
    q.z = -q.z
    q.w = -q.w
    result = q

template inverse*(q: Quaternion): Quaternion = invertNew(q)
template inverse*(q: var Quaternion): var Quaternion = invertSelf(q)

#Conjugate
proc conjugateNew(q: Quaternion): Quaternion {.noinit.} = 
    result.x = -q.x
    result.y = -q.y
    result.z = -q.z
    result.w = q.w

proc conjugateSelf(q: var Quaternion): var Quaternion {.noinit.} = 
    q.x = -q.x
    q.y = -q.y
    q.z = -q.z
    q.w = q.w
    result = q

template conjugate*(q: Quaternion): Quaternion = conjugateNew(q)
template conjugate*(q: var Quaternion): var Quaternion = conjugateSelf(q)

#Module Level Procs (Constructors)
#FromMatrix44
proc fromMatrix(m: Matrix44): Quaternion =
    var 
        s = 0.0
        q : array[4,float]
        t = m.matrix[0][0] + m.matrix[1][1] + m.matrix[2][2]
    if t > 0:
        s = 0.5 / sqrt(t + 1.0)
        q = [(m.matrix[2][1] - m.matrix[1][2]) * s,(m.matrix[0][2] - m.matrix[2][0]) * s,
            (m.matrix[1][0] - m.matrix[0][1]) * s, 0.25 / s]
    else:
        var 
            n = [1,2,0]
            i,j,k = 0
        if m.matrix[1][1] > m.matrix[0][0]:
            i = 1
        if m.matrix[2][2] > m.matrix[i][i]:
            i = 2
        j = n[i]
        k = n[j]
        s = 2 * sqrt((m.matrix[i][i] - m.matrix[j][j] - m.matrix[k][k]) + 1.0)
        var ss = 1.0 / s
        q[i] = s * 0.25
        q[j] = (m.matrix[j][i] + m.matrix[i][j]) * ss
        q[k] = (m.matrix[k][i] + m.matrix[i][k]) * ss
        q[3] = (m.matrix[k][j] + m.matrix[j][k]) * ss
    result.z = q[0]
    result.y = q[1]
    result.z = q[2]
    result.w = q[3]

#FromAxisAngle
proc fromAxisAngle(v: var Vector3, a: float): Quaternion = 
    var 
        s = sin(a * 0.5)
        c = cos(a * 0.5)
    result = quaternion(c, normalize(v, s))

