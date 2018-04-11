# NOTE: Added Set
import hashes

type
  Vector* = concept a, b
    a + b is Vector
    a.addSelf(b) is Vector
    a.addNew(b) is Vector
    a - b is Vector
    a.subtractSelf(b) is Vector
    a.subtractNew(b) is Vector
    a / float is Vector
    a / int is Vector
    a.divideSelf(float) is Vector
    a.divideNew(float) is Vector
    a * float is Vector
    a * int is Vector
    a.multiplySelf(float) is Vector
    a.multiplyNew(float) is Vector
    a.dot(b) is float
    a.cross(b) # NOTE: Different return types (No 4D)
    a.inverse() is Vector
    a.heading() is float
    a.reflect(b) is Vector
    a.refract(b, float) is Vector
    a.magnitude() is float # NOTE: Moved above normalize
    a.normalize() is Vector
    a.angleBetween(b) is Vector
    # NOTE: REMOVED
    # a.toPolar() is Vector
    # a.toCartesian() is Vector
  
  Matrix* = concept a
    a.transpose() is Matrix
    a.determinant() is float
    a.invert() is Matrix

  Compare* = concept a, b
    a > b is bool
    a < b is bool
    a >= b is bool
    a <= b is bool

  Equals* = concept a, b
    a == b is bool

  Hash* = concept a
    a.hash() is string

  Transform* = concept a
    a.rotate(float) is Transform
    a.rotate(int) is Transform
    a.scale(float) is Transform
    a.scale(int) is Transform
    a.scale(float, float, float) is Transform
    a.scale(int, int, int) is Transform
    a.translate(Vector) is Transform
    a.transform(Matrix) is Transform

  Length* = concept a
    a.length() is float

  Dimension* = concept a
    a.dimensions() is int

  Clear* = concept a
    a.clear() is Clear

  Copy* = concept a
    a.copy() is Copy

  String* = concept a
    # NOTE: This changed from design doc
    a.`$`() is string