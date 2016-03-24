class MathModel
  constructor: (containerName) ->
    if containerName?
      @container = document.getElementById containerName
      @populate()
  @statustext: null
  @models: 0
  @loadedModels: 0
  ready: false
  button: null
  #container: null
  geometries: []
  live: false
  HEIGHT: 400
  WIDTH: 700
  scene: null
  camera: null
  cameraControls: null
  renderer: null
  pointLight: null
  shadow: false
  animated: true
  @invertNormals: (geo)->
    for face in geo.faces
      foose=new THREE.Face3(face.a,face.b,face.c)
      face.a=foose.c
      face.c=foose.a
    geo.computeFaceNormals()
    geo.computeVertexNormals()
    null
  preImplant: ->
  getgeometry: (i)->
    @geometries[i]
  setrenderer: ->
    self=@
    if Detector.webgl then self.renderer=new THREE.WebGLRenderer({preserveDrawingBuffer: true, antialias: true}) else self.renderer=new THREE.CanvasRenderer()
  loader: new THREE.JSONLoader(true)
  populate: ->
    self=@
    self.scene=new THREE.Scene()
    self.scene.add (new THREE.AmbientLight 0xffffff)
    if not self.camera
      self.camera=new THREE.PerspectiveCamera 45, self.WIDTH/self.HEIGHT
      self.camera.position.set 3,3,3
    if self.shadow
      self.renderer.shadowMapEnabled = true
      self.renderer.shadowMapSoft = true
      self.renderer.shadowCameraNear = 3
      self.renderer.shadowCameraFar = self.camera.far
      self.renderer.shadowCameraFov = 50
      self.renderer.shadowMapBias = 0.0039
      self.renderer.shadowMapDarkness = 1.0
      self.renderer.shadowMapWidth = 1024
      self.renderer.shadowMapHeight = 1024
      self.pointLight=new THREE.SpotLight 0xffffff
      self.pointLight.castShadow=true
    else 
      self.pointLight=new THREE.PointLight 0xffffff
    self.pointLight.intensity=1
    self.pointLight.position.set 0,0,100
    self.scene.add self.pointLight
    # camera and controls
    self.cameraControls=new THREE.TrackballControls self.camera,self.container
    self.cameraControls.target.set 0,0,0
    self.scene.add self.camera

    # renderer
    self.setrenderer()
    self.renderer.setSize self.WIDTH,self.HEIGHT
    self.renderer.domElement.style.position="relative"
    self.container.appendChild self.renderer.domElement
    self.renderer.clear()
    null
  mathUp: ->
    self = @
    self.camera.up = new THREE.Vector3 0,0,1

  addaxes: (length)->
    self=@ 
    self.scene.add new THREE.AxisHelper(length)
    null
  embed: (file,material,doubleSide,reskin,position,rotation,shadow)->
    self=@
    meshes=[]
    meshIndex=0
    doubles=doubleSide ? true
    resk=reskin ? false
    shad=shadow ? false
    if shad then self.renderer.shadowMapEnabled=true
    invertNormals= (geo)->
      for face in geo.faces
        foose=new THREE.Face3(face.a,face.b,face.c)
        face.a=foose.c
        face.c=foose.a
      geo.computeFaceNormals()
      geo.computeVertexNormals()
      null
    implant= (geometry)->
      self.ready=false
      self.geometries.push geometry
      self.preImplant(geometry)
      if doubles
        geo = geometry.clone()
        invertNormals geo
        THREE.GeometryUtils.merge geometry,geo
      materials=[]
      if resk and geometry.materials? then materials=geometry.materials else materials=[material] 
      for mat in materials
        meshes[meshIndex]=new THREE.Mesh geometry,mat
        meshes[meshIndex].position=position ? new THREE.Vector3 0,0,0
        meshes[meshIndex].rotation=rotation ? new THREE.Vector3 0,0,0
        if shad then meshes[meshIndex].castShadow=meshes[meshIndex].receiveShadow=true
        self.scene.add meshes[meshIndex]
        meshIndex++
      self.init()
      null
    self.loader.load(file,implant)
  render: ->
    self=@
    if self.animated
      self.cameraControls.update()
      self.pointLight.position=self.camera.position
    self.renderer.render self.scene,self.camera
    null
  calc: (t)->  
  animate: ->
    self=@
    framing= (t)->
      self.calc(t)
      self.render()
      requestAnimationFrame framing, self.container if self.live
      null
    framing(new Date().getTime())  
    null
  initTime: 3000  
  renderloop: ->
    self = @
    self.live = true
    self.animate()
  init: ->
    T=new Date().getTime()
    self=@
    self.render()
#    draw= (t)->
#      self.render()
#      requestAnimationFrame draw,self.container if t<(T+self.initTime)
#      null
#    draw(new Date().getTime())
    self.ready=true
    self.live = false
    MathModel.loadedModels += 1
    #MathModel.statustext.append("OK ")
    null
  go: ->
    self=@
    self.init()
#    $(document).bind 'deck.change', (event, from , to) ->
#      near = $('.deck-current').find($(self.container)).length + $('.deck-next').find($(self.container)).length + $('.deck-previous').find($(self.container)).length
#      if near and self.live is false
#        self.renderloop()
#      else
#        self.live = false
#      return
    null
window.MathModel=MathModel