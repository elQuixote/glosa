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