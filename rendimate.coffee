class MathModel
  button: null
  container: null
  live: false  
  HEIGHT: 400
  WIDTH: 700
  scene: null
  camera: null
  cameraControls: null
  renderer: null
  pointLight: null
  setrenderer: ->
    self=@
    if Detector.webgl then self.renderer=new THREE.WebGLRenderer() else self.renderer=new THREE.CanvasRenderer()
  loader: new THREE.JSONLoader()
  populate: ->
    self=@
    self.scene=new THREE.Scene()
    self.camera=new THREE.PerspectiveCamera 45,self.WIDTH/self.HEIGHT,1,10000    
    self.cameraControls=new THREE.TrackballControls self.camera,self.container    
    self.scene.add self.camera
    self.scene.add (new THREE.AmbientLight 0xffffff)
    self.pointLight=new THREE.PointLight 0xffffff
    self.pointLight.intensity=1
    self.pointLight.position.set 0,0,100
    self.scene.add self.pointLight
    self.setrenderer()
    self.renderer.setSize self.WIDTH,self.HEIGHT
    self.renderer.domElement.style.position="relative"
    self.container.appendChild self.renderer.domElement
    self.renderer.clear()
    null
  addaxes: (length)->
    self=@ 
    v= (x,y,z)->
      new THREE.Vertex(new THREE.Vector3(x,y,z))
  
    linexGeo=new THREE.Geometry()
    linexGeo.vertices.push v(0,0,0)
    linexGeo.vertices.push v(length,0,0)
    linexMat=new THREE.LineBasicMaterial
      color: 0xff0000
    linex=new THREE.Line(linexGeo,linexMat)
    linex.type=THREE.Lines

    lineyGeo=new THREE.Geometry() 
    lineyGeo.vertices.push v(0,0,0)
    lineyGeo.vertices.push v(0,length,0)
    lineyMat=new THREE.LineBasicMaterial
      color: 0x00ff00
    liney=new THREE.Line(lineyGeo,lineyMat)
    liney.type=THREE.Lines
 
    linezGeo=new THREE.Geometry()
    linezGeo.vertices.push v(0,0,0)
    linezGeo.vertices.push v(0,0,length)
    linezMat=new THREE.LineBasicMaterial
      color: 0x0000ff
    linez=new THREE.Line(linezGeo,linezMat)
    linez.type=THREE.Lines

    self.scene.add linex        
    self.scene.add liney
    self.scene.add linez    
    null
  embed: (file,material)->
    self=@
    implant= (geometry)->
      mesh=new THREE.Mesh geometry,material
      mesh.rotation.set Math.PI/2,0,0
      mesh.position.set 0,0,0
      self.scene.add mesh
      null
    self.loader.load(file,implant)
    null  
  embeddae: (file,material)->
    self=@
    loadae=new THREE.ColladaLoader()
    #finish this: need collada loader, etc. (as per fhtr ex)
    implant= (collada)->
      model=collada.scene
 #     geometry=collada.dae.geometries[geometry0].mesh.primitives[0].geometry
 #     mesh=new THREE.Mesh geometry,material
 #     mesh.rotation.set Math.PI/2,0,0
 #     mesh.position.set 0,0,0
 #     self.scene.add mesh
      model.rotation.set -Math.PI/2,0,0
      self.scene.add model
      null
    loadae.load(file,implant)
    null    
  render: ->
    self=@
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
  init: ->
    T=new Date().getTime()
    self=@
    draw= (t)->
      self.render()
      requestAnimationFrame draw,self.container if t<(T+3000)
      null #stuck making this work
    draw(new Date().getTime())  
    null  
  go: ->
    self=@
    self.button.submit ()->
      self.live=!self.live
      if self.live then self.button.find(":submit").attr("value","stop") else self.button.find(":submit").attr("value","start")
      self.animate()
      self.button.parent().parent().focus() #maybe a bad way to take focus from the button so that the keydown event works!
      false
    $(window).keydown (event)->
      if event.keyCode is 76
        self.live=false
        self.button.find(":submit").attr("value","start")
        null
    null
window.MathModel=MathModel