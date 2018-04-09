type
  Vector = concept a, b
    a + b is Vector
    a.addSelf(b) is Vector
    a.addNew(b) is Vector
    a - b is Vector
    a.subtractSelf(b) is Vector
    a.subtractNew(b) is Vector
    a / float is Vector
    a / int is Vector
    a.divideSelf(float) is Vector
    a.divideSelf(int) is Vector
    a.divideNew(float) is Vector
    a.divideNew(int) is Vector
    a * float is Vector
    a * int is Vector
    a.multiplySelf(float) is Vector
    a.multiplySelf(int) is Vector
    a.multiplyNew(float) is Vector
    a.multiplySelf(int) is Vector
    a.dot(b) is float
    a.cross(b) is Vector
    a.inverse() is Vector
    a.heading() is float
    a.reflect(b) is Vector
    a.refract(b, float) is Vector
    a.normalize() is Vector
    a.magnitude() is float
    a.angleBetween(b) is Vector
    a.toPolar() is Vector
    a.toCartesian() is Vector

  Compare = concept a, b
    a > b is bool
    a < b is bool
    a >= b is bool
    a <= b is bool

  Equals = concept a, b
    a == b is bool

  Hash = concept

  Transform = concept

  Length = concept

  Dimension = concept

  Clear = concept

  Copy = concept

  String = concept