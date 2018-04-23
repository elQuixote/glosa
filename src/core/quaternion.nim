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

