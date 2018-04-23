import ./concepts

from strformat import `&`
from math import arctan2, arccos, sqrt
import hashes

type 
    Quaternion* = object
        x*,y*,z*,w* : float 

#Constructor
proc quaternion(x, y, z, w: float): Quaternion =
    result.x = x
    result.y = y
    result.z = z
    result.w = w

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
