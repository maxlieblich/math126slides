# set up the renderer; useful for swapping them to compare
setup_renderer = (renderer, container, WIDTH, HEIGHT) ->
  renderer.setSize WIDTH, HEIGHT
  renderer.domElement.style.position = "relative"
  $(container).append renderer.domElement
  renderer.clear()
  null

# a utility for later to make things double-sided
invertNormals= (geo)->
  for face in geo.faces
    foose=new THREE.Face3(face.a,face.b,face.c)
    face.a=foose.c
    face.c=foose.a
  geo.computeFaceNormals()
  geo.computeVertexNormals()
  null

# scene constructor
frame = ->
  self = @
  WIDTH = 550
  HEIGHT = 450
  
  # coffeescript wizard will use a => somewhere instead
  # of plucking out the initial this as that (as per usual js)
  # I am not a wizard

  self.scene = new THREE.Scene()
  self.container = document.getElementById("trefoilcontainer")
  
  #camera and controls
  self.camera = new THREE.PerspectiveCamera 45, WIDTH/HEIGHT, 1, 1000
  self.camera.position.set 0,4,3
  self.camera.up = new THREE.Vector3 0, 0, 1
  self.scene.add self.camera
  self.cameraControls = new THREE.TrackballControls self.camera, self.container
  self.cameraControls.target.set 0,0,0   
    
  #lights
  ambient = new THREE.AmbientLight 0xffffff
  self.scene.add ambient
  self.pointLight = new THREE.PointLight 0xffffff
  self.pointLight.intensity = 0.1
  self.pointLight.position.set 0,0,10
  self.scene.add self.pointLight

  #renderer
  if Detector.webgl
    self.renderer = new THREE.WebGLRenderer
      antialias: true
      preserve: true
  else
    self.renderer = new THREE.CanvasRenderer    
  setup_renderer self.renderer, self.container, WIDTH, HEIGHT

  #material
  mat = new THREE.MeshNormalMaterial
  
  #trefoil calcs
  trefoilFunc = (t) ->
    t2 = t + t
    t3 = t2 + t
    41 * Math.cos(t) - 18 * Math.sin(t) - 83 * Math.cos(t2) - 83 * Math.sin(t2) - 11 * Math.cos(t3) + 27 * Math.sin(t3)

  trefoilPoint = (t) ->
    kScale = 0.01
    x = trefoilFunc(t)
    y = trefoilFunc(6.283185 - t)
    z = trefoilFunc(t - 1.828453)
    new THREE.Vector3 kScale * x, kScale * y, kScale * z
    
  #construct curve
  drawPath = (T) ->
    points = []
    t = 0
    while t <= T
      points.push trefoilPoint(t)
      t += 0.01
    points
    
  self.trefoilcurve = new THREE.SplineCurve3 drawPath(6.28)
  
  trefoilgeom = new THREE.Geometry()
  trefoilgeom.vertices = drawPath(6.28)
  line = new THREE.Line trefoilgeom
  line.position.set 0,0,0
  line.rotation.set 0,0,0
  line.scale.set 1,1,1
  self.scene.add line
  
  self.sphere = new THREE.Mesh new THREE.SphereGeometry(0.05, 0.1, 0.1), new THREE.MeshNormalMaterial()
  self.scene.add self.sphere

  #Loader with callback
  implant = (geometry)->
    self.scene.add new THREE.Mesh geometry, mat
    null
 
#  loader = new THREE.JSONLoader(true)
#  loader.load "shell.js", implant
  self.rendering = false
  
  @renderloop = ()->
    self = @
    self.rendering = true
    self.update = ()->
      self.sphere.position = self.trefoilcurve.getPoint(new Date().getTime() / 6280.0 % 1 )
      self.cameraControls.update()
      self.pointLight.position = self.camera.position
      self.renderer.render self.scene, self.camera
      null
    
    self.animate = (t)->
      self.update()
      if self.rendering
        requestAnimationFrame self.animate, self.container  
      null  
    
    self.animate(new Date().getTime())  
    null
  null

heart = ->
  self = @
  WIDTH = 550
  HEIGHT = 450
  
  # coffeescript wizard will use a => somewhere instead
  # of plucking out the initial this as that (as per usual js)
  # I am not a wizard

  self.scene = new THREE.Scene()
  self.container = document.getElementById("heartcontainer")
  
  #camera and controls
  self.camera = new THREE.PerspectiveCamera 45, WIDTH/HEIGHT, 1, 1000
  self.camera.position.set 0,4,3
  self.camera.up = new THREE.Vector3 0, 0, 1
  self.scene.add self.camera
  self.cameraControls = new THREE.TrackballControls self.camera, self.container
  self.cameraControls.target.set 0,0,0   
    
  #lights
  ambient = new THREE.AmbientLight 0xffffff
  self.scene.add ambient
  self.pointLight = new THREE.PointLight 0xffffff
  self.pointLight.intensity = 0.1
  self.pointLight.position.set 0,0,10
  self.scene.add self.pointLight

  #renderer
  if Detector.webgl
    self.renderer = new THREE.WebGLRenderer
      antialias: true
      preserve: true
  else
    self.renderer = new THREE.CanvasRenderer    
  setup_renderer self.renderer, self.container, WIDTH, HEIGHT

  #material
  mat = new THREE.MeshNormalMaterial
  
  #Loader with callback
  implant = (geometry)->
#    self.heartGeom = geometry
    self.scene.add new THREE.Mesh geometry, mat
    generateNormals(geometry)
    null
 
  loader = new THREE.JSONLoader(true)
  loader.load "heart.json", implant
  self.rendering = false
  
  generateNormals = (geometry) ->
    geometry.computeFaceNormals()
    faces = geometry.faces
    
    for i in [0..100]
      face = faces[76453*i % faces.length]
      point = THREE.GeometryUtils.randomPointInFace face, geometry
      self.scene.add(new THREE.ArrowHelper(face.normal, point, 0.3, 0xff0000))
  
#    for arrow in arrows
#      self.scene.add arrow
    null  
  
  @renderloop = ()->
    self = @
    self.rendering = true
    self.update = ()->
      self.cameraControls.update()
      self.pointLight.position = self.camera.position
      self.renderer.render self.scene, self.camera
      null
    
    self.animate = (t)->
      self.update()
      if self.rendering
        requestAnimationFrame self.animate, self.container  
      null  
    
    self.animate(new Date().getTime())  
    null
  null

sphere = ->
  self = @
  WIDTH = 550
  HEIGHT = 450
  
  # coffeescript wizard will use a => somewhere instead
  # of plucking out the initial this as that (as per usual js)
  # I am not a wizard

  self.scene = new THREE.Scene()
  self.container = document.getElementById("spherecontainer")
  
  #camera and controls
  self.camera = new THREE.PerspectiveCamera 45, WIDTH/HEIGHT, 1, 1000
  self.camera.position.set 0,4,3
  self.camera.up = new THREE.Vector3 0, 0, 1
  self.scene.add self.camera
  self.cameraControls = new THREE.TrackballControls self.camera, self.container
  self.cameraControls.target.set 0,0,0   
    
  #lights
  ambient = new THREE.AmbientLight 0xffffff
  self.scene.add ambient
  self.pointLight = new THREE.PointLight 0xffffff
  self.pointLight.intensity = 0.1
  self.pointLight.position.set 0,0,10
  self.scene.add self.pointLight

  #renderer
  if Detector.webgl
    self.renderer = new THREE.WebGLRenderer
      antialias: true
      preserve: true
  else
    self.renderer = new THREE.CanvasRenderer    
  setup_renderer self.renderer, self.container, WIDTH, HEIGHT

  #material
  mat = new THREE.MeshNormalMaterial
  
  #Loader with callback
  implant = (geometry)->
    self.scene.add new THREE.Mesh geometry, mat
    generateNormals(geometry)
    null
 
  loader = new THREE.JSONLoader(true)
  loader.load "sphere.json", implant
  self.rendering = false
  
  @renderloop = ()->
    self = @
    self.rendering = true
    self.update = ()->
      self.cameraControls.update()
      self.pointLight.position = self.camera.position
      self.renderer.render self.scene, self.camera
      null
    
    self.animate = (t)->
      self.update()
      if self.rendering
        requestAnimationFrame self.animate, self.container  
      null  
    
    self.animate(new Date().getTime())  
    null
  null
  
ellipsoid = ->
  self = @
  WIDTH = 550
  HEIGHT = 450
  
  # coffeescript wizard will use a => somewhere instead
  # of plucking out the initial this as that (as per usual js)
  # I am not a wizard

  self.scene = new THREE.Scene()
  self.container = document.getElementById("ellipsoidcontainer")
  
  #camera and controls
  self.camera = new THREE.PerspectiveCamera 45, WIDTH/HEIGHT, 1, 1000
  self.camera.position.set 0,4,3
  self.camera.up = new THREE.Vector3 0, 0, 1
  self.scene.add self.camera
  self.cameraControls = new THREE.TrackballControls self.camera, self.container
  self.cameraControls.target.set 0,0,0   
    
  #lights
  ambient = new THREE.AmbientLight 0xffffff
  self.scene.add ambient
  self.pointLight = new THREE.PointLight 0xffffff
  self.pointLight.intensity = 0.1
  self.pointLight.position.set 0,0,10
  self.scene.add self.pointLight

  #renderer
  if Detector.webgl
    self.renderer = new THREE.WebGLRenderer
      antialias: true
      preserve: true
  else
    self.renderer = new THREE.CanvasRenderer    
  setup_renderer self.renderer, self.container, WIDTH, HEIGHT

  #material
  mat = new THREE.MeshNormalMaterial
  
  #Loader with callback
  implant = (geometry)->
#    self.heartGeom = geometry
    self.scene.add new THREE.Mesh geometry, mat
    null
 
  loader = new THREE.JSONLoader(true)
  loader.load "ellipsoid.json", implant
  self.rendering = false
    
  @renderloop = ()->
    self = @
    self.rendering = true
    self.update = ()->
      self.cameraControls.update()
      self.pointLight.position = self.camera.position
      self.renderer.render self.scene, self.camera
      null
    
    self.animate = (t)->
      self.update()
      if self.rendering
        requestAnimationFrame self.animate, self.container  
      null  
    
    self.animate(new Date().getTime())  
    null
  null  
  
#construct scenes
frame = new frame()
window.frame = frame
window.frame.rendering = false
#start action
$(document).bind 'deck.change', (event, from , to) ->
   if $('.deck-current').find('#trefoilcontainer').length + 
     $('.deck-next').find('#trefoilcontainer').length + 
     $('.deck-previous').find('#trefoilcontainer').length and window.frame.rendering is false
    frame.renderloop()
   else
    window.frame.rendering = false 
   return
   
heart = new heart()
window.heart = heart
window.heart.rendering = false
#start action
$(document).bind 'deck.change', (event, from , to) ->
   if $('.deck-current').find('#heartcontainer').length + 
     $('.deck-next').find('#heartcontainer').length + 
     $('.deck-previous').find('#heartcontainer').length and window.heart.rendering is false
    heart.renderloop()
   else
    window.heart.rendering = false 
   return
   

sphere = new sphere()
window.sphere = sphere
window.sphere.rendering = false
#start action
$(document).bind 'deck.change', (event, from , to) ->
   if $('.deck-current').find('#spherecontainer').length + 
     $('.deck-next').find('#spherecontainer').length + 
     $('.deck-previous').find('#spherecontainer').length and window.sphere.rendering is false
    sphere.renderloop()
   else
    window.sphere.rendering = false 
   return
   
ellipsoid = new ellipsoid()
window.ellipsoid = ellipsoid
window.ellipsoid.rendering = false
#start action
$(document).bind 'deck.change', (event, from , to) ->
   if $('.deck-current').find('#ellipsoidcontainer').length + 
     $('.deck-next').find('#ellipsoidcontainer').length + 
     $('.deck-previous').find('#ellipsoidcontainer').length and window.ellipsoid.rendering is false
    ellipsoid.renderloop()
   else
    window.ellipsoid.rendering = false 
   return