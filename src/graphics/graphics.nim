from ../core/vector import Vector1, Vector2, Vector3, Vector4, vector3, randomize
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

proc render*(m: HalfEdgeMesh[Vector4]): void =
  glBegin(GL_TRIANGLES)
  var color = vector3(0)
  for f in m.faces:
    let
      edges: seq[HalfEdge[Vector4]] = toSeq(faceCirculator(m, f.edge))
      positions = map(edges, proc(e: HalfEdge[Vector4]): Vector4 = e.vertex.position)
    glColor3f(positions[0].w, positions[1].w, positions[2].w)
    for p in positions:
      render(p)
  glEnd()

# proc render*[Vector](m: HalfEdgeMesh[Vector]): void =
#   glBegin(GL_TRIANGLES)
#   var color = vector3(0)
#   for f in m.faces:
#     discard randomize(color)
#     glColor3f(color.x, color.y, color.z)
#     for e in faceCirculator(m, f.edge):
#       render(e.vertex.position)
#   glEnd()