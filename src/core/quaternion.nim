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