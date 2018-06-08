type
  # Vectors
  InvalidCrossProductError* = object of Exception

  # Path & Polygon
  InvalidPolylineError* = object of Exception
  InvalidSegmentsError* = object of Exception
  InvalidVerticesError* = object of Exception

  # Curves
  InvalidDegreeError* = object of Exception
  InvalidKnotsError* = object of Exception
  InvalidInterpolationError* = object of Exception

  # Meshes
  InvalidVertexError* = object of Exception
  InvalidFaceError* = object of Exception
  InvalidEdgeError* = object of Exception
  InvalidOperationError* = object of Exception

  # JSON
  InvalidJsonError* = object of Exception