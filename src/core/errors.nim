type
  # Vectors
  InvalidCrossProductError* = object of Exception

  # Path & Polygon
  InvalidPolylineError* = object of Exception
  InvalidSegmentsError* = object of Exception
  InvalidVerticesError* = object of Exception

  # JSON
  InvalidJsonError* = object of Exception