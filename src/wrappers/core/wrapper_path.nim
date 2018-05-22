import ../../core/path
import ../../core/vector

type
  LineSegment_Net* = object
    startPoint*: Vector3
    endPoint*: Vector3

  Polyline_Net* = object
    vertices*: seq[Vector3]
    segments*: seq[LineSegment_Net]

proc lineSegment_Net*[Vector](s: LineSegment_Net): LineSegment[Vector] = 
  result = LineSegment[Vector](startVertex: s.startPoint, endVertex: s.endPoint)

proc lineSegment_Net*(s: LineSegment[Vector]): LineSegment_Net = 
  result = LineSegment_Net(startPoint: s.startVertex, endPoint: s.endVertex)

proc polyline_Net*[Vector](s: Polyline_Net): Polyline[Vector] =
    result.vertices = s.vertices
    result.segments = s.segments

proc polyline_Net*(s: Polyline[Vector]): Polyline_Net =
  result.vertices = s.vertices
  result.segments = s.segments

# ***************************************
#     LineSegment Proc Wrappers
# ***************************************
#proc segmentFromVectors*[Vector](v1,v2: Vector): LineSegment[Vector] {.cdecl, exportc, dynlib.} = lineSegment(v1, v2)
proc segmentFromVectors*(v1,v2: Vector3): LineSegment_Net {.cdecl, exportc, dynlib.} = lineSegment_Net(lineSegment(v1, v2))

