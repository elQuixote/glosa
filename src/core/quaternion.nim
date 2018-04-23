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
