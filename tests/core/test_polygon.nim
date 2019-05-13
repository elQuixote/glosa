import ../../src/core/vector
import ../../src/core/path
import ../../src/core/polygon
import unittest

from sequtils import concat

suite "Creating a new Polygon":
  let
    vertices = @[
      Vector3(x: 0.0, y: 0.0, z: 0.0),
      Vector3(x: 2.0, y: 0.0, z: 0.0),
      Vector3(x: 4.0, y: 2.0, z: 0.0),
      Vector3(x: 4.0, y: 4.0, z: 0.0),
      Vector3(x: 2.0, y: 4.0, z: 0.0),
      Vector3(x: 0.0, y: 2.0, z: 0.0)
    ]
    l = len(vertices)
  var
    segments: seq[LineSegment[Vector3]] = @[]
    closedSegments: seq[LineSegment[Vector3]] = @[]
  for i in 0..<l:
    if (i < (l - 1)):
      add(segments, lineSegment(vertices[i], vertices[i + 1]))
    add(closedSegments, lineSegment(vertices[i], vertices[(i + 1) mod l]))
  test "Creating a Polygon with a polyline":
    let
      openPolyline = polyline(segments)
      closedPolyline = polyline(closedSegments)
      p = polygon(closedPolyline)
    expect InvalidPolylineError:
      let p {.used.} = polygon(openPolyline)
    check:
      p.vertices == vertices
      p.segments == closedSegments
  test "Creating a Polygon with vertices":
    let p = polygon(vertices)
    check:
      p.vertices == vertices
      p.segments != segments
      p.segments == closedSegments
  test "Creating a Polygon with extraneous vertices":
    var extraVertices: seq[Vector3] = @[]
    for v in vertices:
      add(extraVertices, v)
      add(extraVertices, v)
    let p = polygon(extraVertices)
    check:
      p.vertices == vertices
      p.segments != segments
      p.segments == closedSegments
  test "Creating a Polygon with segments":
    expect InvalidSegmentsError:
      let p {.used.} = polygon(segments)
    let p = polygon(closedSegments)
    check:
      p.vertices == vertices
      p.segments != segments
      p.segments == closedSegments
  test "Trying to create Polygon with nonplanar vertices":
    let
      nonplanarVertices = concat(vertices, @[Vector3(x: 0.0, y: 2.0, z: 2.0)])
    expect InvalidVerticesError:
      let p {.used.} = polygon(nonplanarVertices)
  test "Trying to create Polygon with nonplanar segments":
    let
      nonplanarSegments= concat(segments, @[
        lineSegment(
          Vector3(x: 0.0, y: 2.0, z: 0.0),
          Vector3(x: 0.0, y: 2.0, z: 2.0)
        ),
        lineSegment(
          Vector3(x: 0.0, y: 2.0, z: 2.0),
          Vector3(x: 0.0, y: 0.0, z: 0.0)
        )
      ])
    expect InvalidSegmentsError:
      let p {.used.} = polygon(nonplanarSegments)
  test "Trying to create Polygon with a nonplanar polyline":
    let
      nonplanarSegments= concat(segments, @[
        lineSegment(
          Vector3(x: 0.0, y: 2.0, z: 0.0),
          Vector3(x: 0.0, y: 2.0, z: 2.0)
        ),
        lineSegment(
          Vector3(x: 0.0, y: 2.0, z: 2.0),
          Vector3(x: 0.0, y: 0.0, z: 0.0)
        )
      ])
      nonplanarPolyline = polyline(nonplanarSegments)
    expect InvalidPolylineError:
      let p {.used.} = polygon(nonplanarPolyline)