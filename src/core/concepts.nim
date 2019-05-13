# NOTE: Added Set
import hashes

{.hint[XDeclaredButNotUsed]: off.}
type
  Vector* {.explain.} = concept a, b, var va, type T
    `+`(a, b) is T
    `+=`(va, b)
    va.addSelf(b) is T
    a.addNew(b) is T
    `-`(a, b) is T
    `-=`(va, b)
    va.subtractSelf(b) is T
    a.subtractNew(b) is T
    `/`(a, float) is T
    `/=`(va, float)
    va.divideSelf(float) is T
    a.divideNew(float) is T
    `*`(a, float) is T
    `*=`(va, float)
    va.multiplySelf(float) is T
    a.multiplyNew(float) is T
    a.dot(b) is float
    a.cross(b) # NOTE: Different return types (No 4D)
    a.inverse() is T
    a.heading() is float
    a.reflect(b) is T
    a.refract(b, float) is T
    a.magnitude() is float # NOTE: Moved above normalize
    va.normalize() is T
    a.angleBetween(b) is float
    a.toArray() is array
  # NOTE: REMOVED
  # a.toPolar() is Vector
  # a.toCartesian() is Vector

  Matrix* {.explain.} = concept a, type T
    a.transpose() is T
    a.determinant() is float
    a.invert() is T

  Compare* {.explain.} = concept a, b
    a > b is bool
    a < b is bool
    a >= b is bool
    a <= b is bool

  Equals* {.explain.} = concept a, b
    a == b is bool

  Hash* {.explain.} = concept a
    # NOTE: Changed from design doc (string to Hash)
    a.hash() is hashes.Hash

  Transform* {.explain.} = concept a, type T
    a.rotate(float) is T
    a.scale(float) is T
    a.scale(float, float, float) is T
    a.translate(Vector) is T
    a.transform(Matrix) is T

  Length* {.explain.} = concept a
    a.length() is float

  Dimension* {.explain.} = concept a
    a.dimensions() is int

  # NOTE: Added
  Set* {.explain.} = concept var va, type T
    va.set(float) is T

  Clear* {.explain.} = concept var va, type T
    va.clear() is T

  Copy* {.explain.} = concept a, type T
    a.copy() is T

  String* {.explain.} = concept a
    # NOTE: This changed from design doc
    a.`$`() is string

  Centroid* {.explain.} = concept a
    a.centroid() is Vector
    a.average() is Vector

  Shape2* {.explain.} = concept a
    a.perimeter() is float
    a.area() is float

  Closest* {.explain.} = concept a
    a.closestPoint(Vector) is Vector

  Vertices* {.explain.} = concept a, type T
    a.toPolyline() is T
    a.toPolygon() is T
    a.closestVertex(Vector) is Vector