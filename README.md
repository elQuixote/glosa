### GLOSA GEOMETRY LIBRARY ###
Glosa is a cross platform, high performance geometry library written by Robert Wells & Luis Quinones at Mode Lab. The main goal behind this library was centered around improving our development turnaround time by removing the need to rewrite many of our algorithms as well as optimizing current algorithms which interface with our daily design and development tools. This process would allow us to create a single and unifying language for connecting disparate platforms.

--------------------------------------------------------------

### CORE LIBRARY ###
Currently we have created the first building blocks of the core geometry library. The primitive types are outlined below.

### Primitive Types ###
* 1-4 Dimensional Vectors [for representing spatial data]
* 3x3 & 4x4 Matrices [for calculating general spatial transforms]
* Quaternions [for calculating rotational transforms]

### Complex Types ###
* Polylines [for representing linear curve data]
* NURBS Curves [for representing non-linear curve data]
* Polygons [for representing planar shapes with linear sides]
* Circles [for representing circles]
* Half-Edge Meshes [for representing mesh data with topological information]

### Interfaces ###
* .NET Interface [for using glosa types in .NET C# or IronPython]
* Rhino [for using glosa in Rhino & Grasshopper]

--------------------------------------------------------------

### NIM ###
"Nim is a compiled, garbage-collected systems programming language with a design that focuses on efficiency, expressiveness, and elegance." 

We asked ourselves a few fundamental questions, one of which was how can we connect fundamentally different platforms? Most of the CAD platforms we interface with have APIs that can run C and "Nim presents a most original design that straddles Pascal and Python and compiles to C code or Javascript." This led us to chose Nim as the language of our core geometry library since we could write one library, in Nim, that runs on almost all platforms (with wrappers of course).

--------------------------------------------------------------

### PERFORMANCE ###
Our initial test consisted of 3 operations
* Creating 1 million vectors
* Calculate the dot product with another vector
* Perform a matrix transformation on each vector

#### Nim Proc #### 
``` 
proc transformSetOfVector*() {.cdecl, exportc, dynlib.} = 
	var vec = vector3(10.0,2.0,1.5)
	for i in 0..1000000:
		var vec2 = vector3((float)rand(10), (float)rand(10), (float)rand(10))
		discard vec.dot(vec2)
		discard vec2.transformSelf(IDMATRIX44)
```

#### Fusion Benchmarks #### 
* Native Python [3995.2 ms]
* Glosa Implementation [70 ms]

#### Dynamo Benchmarks ####
* IronPython [3769.21 ms]
* Glosa Implementation [70 ms]

#### Grasshopper C# Benchmarks ####
* RhinoCommon [583 ms]
* Glosa Implementation [70 ms]