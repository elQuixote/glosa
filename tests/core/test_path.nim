import ../../src/core/vector
import ../../src/core/path
import unittest

suite "Creating a new Polyline":
  let
    vertices = @[
      Vector3(x: 0.0, y: 0.0, z: 0.0),
      Vector3(x: 2.0, y: 0.0, z: 0.0),
      Vector3(x: 4.0, y: 2.0, z: 0.0),
      Vector3(x: 4.0, y: 4.0, z: 0.0),
      Vector3(x: 2.0, y: 4.0, z: 0.0),
      Vector3(x: 0.0, y: 2.0, z: 0.0)
    ]
  var segments: seq[LineSegment[Vector3]] = @[]
  for i in 0..<(len(vertices) - 1):
    add(segments, lineSegment(vertices[i], vertices[i + 1]))
  test "Creating a Polyline with vertices":
    let p = polyline(vertices)
    check:
      p.vertices == vertices
      p.segments == segments
  test "Creating a Polyline with extraneous vertices":
    var extraVertices: seq[Vector3] = @[]
    for v in vertices:
      add(extraVertices, v)
      add(extraVertices, v)
    let p = polyline(extraVertices)
    check:
      p.vertices == vertices
      p.segments == segments
  test "Creating a Polyline with segments":
    let
      disjointSegments: seq[LineSegment[Vector3]] = @[
        lineSegment(
          Vector3(x: 0.0, y: 0.0, z: 0.0),
          Vector3(x: 2.0, y: 2.0, z: 2.0)
        ),
        lineSegment(
          Vector3(x: 2.0, y: 2.0, z: 2.0),
          Vector3(x: 4.0, y: 0.0, z: 4.0)
        ),
        lineSegment(
          Vector3(x: 0.0, y: 0.0, z: 0.0),
          Vector3(x: 4.0, y: 4.0, z: 4.0)
        ),
        lineSegment(
          Vector3(x: 4.0, y: 4.0, z: 4.0),
          Vector3(x: 0.0, y: 0.0, z: 0.0)
        )
      ]
    expect InvalidSegmentsError:
      let p {.used.} = polyline(disjointSegments)
    let p = polyline(segments)
    check:
      p.vertices == vertices
      p.segments == segments