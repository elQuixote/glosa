import ../../src/core/vector
import unittest

var 
  v1 = Vector3(x: 1.0, y: 1.0, z: 1.0)
  v2 = Vector3(x: 1.0, y: 1.0, z: 1.0)

echo $v1
echo $v2
echo $(v1 + v2)
echo $(v1 - v2)
echo $(v1 += v2)
echo $(v1 -= v2)