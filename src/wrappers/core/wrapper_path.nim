import ../../core/path
import ../../core/vector

type
  LineSegment_Net* = object
    startPoint*: Vector3
    endPoint*: Vector3

  Polyline_Net* = object
    vertices*: seq[Vector3]
    segments*: seq[LineSegment_Net]

proc lineSegment_Net*(s: LineSegment_Net): LineSegment[Vector3] = 
  result = LineSegment[Vector3](startVertex: s.startPoint, endVertex: s.endPoint)

proc lineSegment_Net*(s: LineSegment[Vector3]): LineSegment_Net = 
  result = LineSegment_Net(startPoint: s.startVertex, endPoint: s.endVertex)

# ***************************************
#     LineSegment Proc Wrappers
# ***************************************
proc segmentFromVectors*(v1,v2: Vector3): LineSegment_Net {.cdecl, exportc, dynlib.} = lineSegment_Net(lineSegment(v1, v2))

proc arrayToSegments(segments: openArray[LineSegment_Net]): seq[LineSegment[Vector3]] =
  var arr : seq[LineSegment[Vector3]] = @[]
  for i in 0..<len(segments):
    arr.add(lineSegment_Net(segments[i]))
  result = arr

proc arrayToSegments(segments: openArray[LineSegment[Vector3]]): seq[LineSegment_Net] =
  var arr : seq[LineSegment_Net] = @[]
  for i in 0..<len(segments):
    arr.add(lineSegment_Net(segments[i]))
  result = arr  

proc polyline_Net*[Vector3](s: Polyline_Net): Polyline[Vector3] =
  result = Polyline[Vector3](vertices: s.vertices, segments: arrayToSegments(s.segments))

proc polyline_Net*(s: Polyline[Vector3]): Polyline_Net =
  result = Polyline_Net(vertices: s.vertices, segments: arrayToSegments(s.segments))

# ***************************************
#     Polyline Proc Wrappers
# ***************************************
# proc createPolyline*[Vector3](segments: openArray[LineSegment_Net]): Polyline_Net {.cdecl, exportc, dynlib.} =
#   polyline_Net(polyline(arrayToSegments(segments)))

#proc createPolyline*(verts: openArray[Vector3], closed: bool): Polyline_Net {.cdecl, exportc, dynlib.} = polyline_Net(polyline[Vector3](verts, closed))
# proc createPolyline*(verts: openArray[Vector3], closed: bool): seq[Vector3] {.cdecl, exportc, dynlib.} = 
#   result = polyline_Net(polyline[Vector3](verts, closed)).vertices

# proc createPolyline*(verts: var seq[cdouble], closed: bool): void {.cdecl, exportc, dynlib.} = 
#   #setupForeignThreadGc()
#   #var a = polyline_Net(polyline[Vector3](verts, closed))
#   #verts = [a.vertices[0], a.vertices[1]]
#   #verts = @[]
#   verts.add(1.0)
#   verts.add(2.0)

proc createPolyline2*(verts: openArray[cdouble]): ptr seq[cdouble] {.cdecl, exportc, dynlib.} = 
  var a = @verts
  result = addr a