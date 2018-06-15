from ../core/vector import Vector1, Vector2, Vector3, Vector4, vector3, randomize
import ../core/curve
import ../core/mesh

from sequtils import map, toSeq

import opengl

proc render*(v: Vector1): void =
  glVertex3f(v.x, 0.0, 0.0)

proc render*(v: Vector2): void =
  glVertex3f(v.x, v.y, 0.0)

proc render*(v: Vector3): void =
  glVertex3f(v.x, v.y, v.z)

proc render*(v: Vector4): void =
  glVertex3f(v.x, v.y, v.z)

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
