from ../core/vector import Vector1, Vector2, Vector3, Vector4, vector3, randomize
import ../core/path
import ../core/polygon
import ../core/curve
import ../core/mesh

from sequtils import map, toSeq

import opengl

# NOTE: Refactor to be based on length
const SAMPLE_CONST = 100

proc render*(v: Vector1): void =
  glVertex3f(v.x, 0.0, 0.0)

proc render*(v: Vector2): void =
  glVertex3f(v.x, v.y, 0.0)

proc render*(v: Vector3): void =
  glVertex3f(v.x, v.y, v.z)

proc render*(v: Vector4): void =
  glVertex3f(v.x, v.y, v.z)

proc render*[Vector](s: LineSegment[Vector]): void =
  glBegin(GL_LINES)
  render(s.startVector)
  render(s.endVector)
  glEnd()

proc render*[Vector](p: Polyline[Vector]): void =
  for s in p.segments:
    render(s)

proc render*[Vector](p: Polygon[Vector]): void =
  glBegin(GL_POLYGON)
  for v in p.polyline.vertices:
    render(v)
  glEnd()

proc render*[Vector](nc: NurbsCurve[Vector]): void =
  let points = regularSample(nc, SAMPLE_CONST)
  for i in 0..<(len(points) - 1):
    glBegin(GL_LINES)
    render(points[i])
    render(points[i + 1])
    glEnd()

proc render4DColor*(m: HalfEdgeMesh[Vector4]): void =
  var color = vector3(0)
  for f in m.faces:
    let
      edges: seq[HalfEdge[Vector4]] = toSeq(faceCirculator(m, f.edge))
      positions = map(edges, proc(e: HalfEdge[Vector4]): Vector4 = e.vertex.position)
    glBegin(GL_POLYGON)
    glColor3f(positions[0].w, positions[1].w, positions[2].w)
    for p in positions:
      render(p)
    glEnd()

proc render3DColor*(m: HalfEdgeMesh[Vector3]): void =
  var color = vector3(0)
  for f in m.faces:
    let
      edges: seq[HalfEdge[Vector3]] = toSeq(faceCirculator(m, f.edge))
      positions = map(edges, proc(e: HalfEdge[Vector3]): Vector3 = e.vertex.position)
    glBegin(GL_POLYGON)
    glColor3f(positions[0].z, positions[1].z, positions[2].z)
    for p in positions:
      render(p)
    glEnd()

proc render*[Vector](m: HalfEdgeMesh[Vector]): void =
  glBegin(GL_TRIANGLES)
  glColor3f(0.0, 0.0, 0.0)
  for f in m.faces:
    for e in faceCirculator(m, f.edge):
      render(e.vertex.position)
  glEnd()
