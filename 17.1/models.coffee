DIRNAME = 17.1

MathModel.statustext=$("#modelstatus")

mathUp = (model)->
  model.camera.up = new THREE.Vector3 0,0,1

rainierMaterial = -> new THREE.MeshLambertMaterial({
color: 0x55ccff
transparent: true
opacity: 0.9
ambient: 0x212121
fog: true
})

blockMaterial = -> new THREE.MeshLambertMaterial({
color: 0xff1100
opacity: 1
ambient: 0x555555
})

rainier=new MathModel()
rainier.container=document.getElementById("rainiercontainer")
rainier.populate()
mathUp(rainier)
rainier.camera.position.set 5,5,2
rainier.cameraControls.target.set 0,0,1
rainier.embed DIRNAME + "/rainier.js", new rainierMaterial, true
  
block=new MathModel()
block.container=document.getElementById("blockcontainer")
block.populate()
mathUp(block)
block.pointLight.intensity=0.5
block.spotLight=new THREE.SpotLight 0xffffff, 0.7
block.spotLight.position.set 5,-5,2
block.scene.add block.spotLight
block.camera.position.set 5,5,1
block.cameraControls.target.set 0,0,1
block.embed DIRNAME + "/rainier.js",new rainierMaterial,true#,null,null,null,false
block.cube = new THREE.CubeGeometry(4,4,3.1622)
block.material = new blockMaterial
block.approx=new THREE.Mesh(block.cube,block.material)
block.approx.castShadow=block.approx.receiveShadow=true
block.approx.position.set 0,0,3.1622/2
block.scene.add block.approx

riemann=new MathModel()
riemann.container=document.getElementById("riemanncontainer")
riemann.populate()
mathUp(riemann)
riemann.pointLight.intensity=0.5
riemann.spotLight=new THREE.SpotLight 0xffffff, 0.7
riemann.spotLight.position.set 5,-5,2
riemann.scene.add riemann.spotLight
riemann.camera.position.set 5,5,1
riemann.cameraControls.target.set 0,0,1
riemann.embed DIRNAME + "/rainier.js", new rainierMaterial,true#,null,null,null,false
riemann.material=new blockMaterial
riemann.f= (x,y)-> Math.sqrt((10-x*x-y*y)/Math.exp(x*x+y*y))  
riemann.mesh=[]  
riemann.ge=[]
riemann.grid= (n)->
  V=0.0000
  if riemann.totalmesh? then riemann.scene.remove riemann.totalmesh
  riemann.totalgeo = new THREE.Geometry()
  for i in [1..n]
    for j in [1..n]
      h=riemann.f(-2+(4*i-2)/n,-2+(4*j-2)/n)
      riemann.ge[[i,j]]=new THREE.CubeGeometry 4/n,4/n,h
      riemann.ge[[i,j]].applyMatrix(new THREE.Matrix4().translate(new THREE.Vector3(-2+(4*i-2)/n,-2+(4*j-2)/n,h/2)))
      THREE.GeometryUtils.merge(riemann.totalgeo, riemann.ge[[i,j]])
      V+=4/n*4/n*h
  riemann.totalmesh=new THREE.Mesh riemann.totalgeo,riemann.material
  riemann.totalmesh.castShadow=riemann.totalmesh.receiveShadow=true
  riemann.scene.add riemann.totalmesh
  $("#volumeprox").text(V.toFixed(4))
  null
riemann.grid(1)  
riemann.N=1
riemannGui=new dat.GUI(
  autoPlace:false
  )
$("#riemanngui").append riemannGui.domElement
riemannGuitrol=riemannGui.add(riemann,"N",1,50).step(1)
riemannGuitrol.onChange (value)->
  riemann.grid(value)
  riemann.renderer.render riemann.scene,riemann.camera
  null
      
goodapprox=new MathModel()
goodapprox.container=document.getElementById("goodapproxcontainer")
goodapprox.populate()
mathUp(goodapprox)
goodapprox.pointLight.intensity=0.5
goodapprox.spotLight=new THREE.SpotLight 0xffffff, 0.7
goodapprox.spotLight.position.set 5,-5,2
goodapprox.scene.add goodapprox.spotLight
goodapprox.camera.position.set 5,5,1
goodapprox.cameraControls.target.set 0,0,1
goodapprox.material=new blockMaterial
goodapprox.f= (x,y)-> Math.sqrt((10-x*x-y*y)/Math.exp(x*x+y*y))  
goodapprox.mesh=[]  
goodapprox.ge=[]
goodapprox.grid= (n)->
  V=0.0000
#  for i in [1..20]
#    for j in [1..20]
#      if goodapprox.mesh[[i,j]]? then goodapprox.scene.remove goodapprox.mesh[[i,j]]
  goodapprox.totalgeo = new THREE.Geometry()
  for i in [1..n]
    for j in [1..n]
      h=goodapprox.f(-2+(4*i-2)/n,-2+(4*j-2)/n)
      goodapprox.ge[[i,j]]=new THREE.CubeGeometry 4/n,4/n,h
      goodapprox.ge[[i,j]].applyMatrix(new THREE.Matrix4().translate(new THREE.Vector3(-2+(4*i-2)/n,-2+(4*j-2)/n,h/2)))
      THREE.GeometryUtils.merge(goodapprox.totalgeo, goodapprox.ge[[i,j]])
      V+=4/n*4/n*h
  goodapprox.totalmesh=new THREE.Mesh goodapprox.totalgeo,goodapprox.material
  goodapprox.totalmesh.castShadow=goodapprox.totalmesh.receiveShadow=true
  goodapprox.scene.add goodapprox.totalmesh

  $("#volumesweet").text(V.toFixed(4))
  null 
goodapprox.grid(100)


mathmodels=[rainier,block,riemann,goodapprox]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null 