import ../../src/core/mesh
import ../../src/core/vector
import ../../src/graphics/graphics

import random

import sdl2
import opengl
import glu

var m = halfEdgeMesh[Vector4]()

addVertices(m, @[
  # Top face (y = 1.0f)
  meshVertex(vector4( 1.0, 1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, 1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, 1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, 1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, 1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, 1.0,  1.0, rand(1.0)), nil),

  # Bottom face (y = -1.0f)
  meshVertex(vector4( 1.0, -1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, -1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, -1.0, rand(1.0)), nil),

  # Front face  (z = 1.0f)
  meshVertex(vector4( 1.0,  1.0, 1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0,  1.0, 1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, 1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, -1.0, 1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0,  1.0, 1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, 1.0, rand(1.0)), nil),

  # Back face (z = -1.0f)
  meshVertex(vector4( 1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0,  1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0,  1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4( 1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0,  1.0, -1.0, rand(1.0)), nil),

  # Left face (x = -1.0f)
  meshVertex(vector4(-1.0,  1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0,  1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0,  1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(-1.0, -1.0, -1.0, rand(1.0)), nil),

  # Right face (x = 1.0f)
  meshVertex(vector4(1.0,  1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(1.0,  1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(1.0, -1.0,  1.0, rand(1.0)), nil),
  meshVertex(vector4(1.0, -1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(1.0,  1.0, -1.0, rand(1.0)), nil),
  meshVertex(vector4(1.0, -1.0,  1.0, rand(1.0)), nil)
])

for i in 0..<((int)(len(m.vertices) / 3)):
  discard addFace(m, @[m.vertices[3 * i], m.vertices[3 * i + 1], m.vertices[3 * i + 2]])

discard sdl2.init(INIT_EVERYTHING)

var screenWidth: cint = 640
var screenHeight: cint = 480

var window = createWindow("SDL/OpenGL Skeleton", 100, 100, screenWidth, screenHeight, SDL_WINDOW_OPENGL or SDL_WINDOW_RESIZABLE)
var context = window.glCreateContext()

# Initialize OpenGL
# loadExtensions()
glClearColor(0.0, 0.0, 0.0, 1.0)                  # Set background color to black and opaque
glClearDepth(1.0)                                 # Set background depth to farthest
glEnable(GL_DEPTH_TEST)                           # Enable depth testing for z-culling
glDepthFunc(GL_LEQUAL)                            # Set the type of depth-test
glShadeModel(GL_SMOOTH)                           # Enable smooth shading
glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST) # Nice perspective corrections

proc reshape(newWidth: cint, newHeight: cint) =
  glViewport(0, 0, newWidth, newHeight)   # Set the viewport to cover the new window
  glMatrixMode(GL_PROJECTION)             # To operate on the projection matrix
  glLoadIdentity()                        # Reset
  gluPerspective(45.0, newWidth / newHeight, 0.1, 100.0)  # Enable perspective projection with fovy, aspect, zNear and zFar

proc render() =
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT) # Clear color and depth buffers
  glMatrixMode(GL_MODELVIEW)                          # To operate on model-view matrix
  glLoadIdentity()                 # Reset the model-view matrix
  glTranslatef(1.5, 0.0, -7.0)     # Move right and into the screen

  # Render a cube consisting of 6 quads
  # Each quad consists of 2 triangles
  # Each triangle consists of 3 vertices

  render4DColor(m)

  window.glSwapWindow() # Swap the front and back frame buffers (double buffering)

# Frame rate limiter

let targetFramePeriod: uint32 = 20 # 20 milliseconds corresponds to 50 fps
var frameTime: uint32 = 0

proc limitFrameRate() =
  let now = getTicks()
  if frameTime > now:
    delay(frameTime - now) # Delay to maintain steady frame rate
  frameTime += targetFramePeriod

# Main loop

var
  evt = sdl2.defaultEvent
  runGame = true

reshape(screenWidth, screenHeight) # Set up initial viewport and projection

while runGame:
  while pollEvent(evt):
    if evt.kind == QuitEvent:
      runGame = false
      break
    if evt.kind == WindowEvent:
      var windowEvent = cast[WindowEventPtr](addr(evt))
      if windowEvent.event == WindowEvent_Resized:
        let newWidth = windowEvent.data1
        let newHeight = windowEvent.data2
        reshape(newWidth, newHeight)

  render()

  limitFrameRate()

destroy(window)