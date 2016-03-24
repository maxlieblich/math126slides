MathModel.statustext=$("#modelstatus")

cone = new MathModel()
cone.container = document.getElementById "containercone"
cone.populate()
cone.camera.position.set 5, 5, 10
#cone.camera.up = new THREE.Vector3 0,0,1
cone.embed("6/coneobject.js", new THREE.MeshNormalMaterial(), true)

fcyl = new MathModel()
fcyl.container = document.getElementById "containerfreakycylinder"
fcyl.populate()
fcyl.camera.position.set 5,5,10
#fcyl.camera.up = new THREE.Vector3 0,0,1
fcyl.embed("6/freakycylinder.js", new THREE.MeshNormalMaterial(), true)

ellipsoid = new MathModel()
ellipsoid.container = document.getElementById "containerellipsoid"
ellipsoid.populate()
ellipsoid.camera.position.set 3,3,6
#ellipsoid.camera.up = new THREE.Vector3 0,0,1
ellipsoid.embed("6/ellipsoid.js", new THREE.MeshNormalMaterial(), true)

hpoid = new MathModel()
hpoid.container = document.getElementById "containerhpoid"
hpoid.populate()
hpoid.camera.position.set 15,15,30
#hpoid.camera.up = new THREE.Vector3 0,0,1
hpoid.embed("6/hpoid.js", new THREE.MeshNormalMaterial(), true)

epoid = new MathModel()
epoid.container = document.getElementById "containerepoid"
epoid.populate()
epoid.camera.position.set 15,15,30
#epoid.camera.up = new THREE.Vector3 0,0,1
epoid.embed("6/epoid.js", new THREE.MeshNormalMaterial(), true)

taco = new MathModel()
taco.container = document.getElementById "containertaco"
taco.populate()
taco.camera.position.set -15,15,30
#taco.camera.up = new THREE.Vector3 0,0,1
taco.embed("6/taco.js", new THREE.MeshNormalMaterial(), true)

vtrace = new MathModel()
vtrace.container = document.getElementById "containerepoidverticaltrace"
vtrace.populate()
vtrace.camera.position.set 15,15,30
#vtrace.camera.up = new THREE.Vector3 0,0,1
vtrace.camera.lookAt new THREE.Vector3 0,2,0
vtrace.cameraControls.target.set 0,2,0
vtrace.embed("6/epoid.js", new THREE.MeshNormalMaterial(), true)
vtrace.slicer = new THREE.Mesh(new THREE.CubeGeometry(20,20,0.01), new THREE.MeshLambertMaterial({
  color: 0xfe0000,
  ambient: 0x333333,
  opacity: 0.5,
  transparent: true,
  reflectivity: 10
}))
vtrace.slicer.position.set 0,4,0
vtrace.scene.add vtrace.slicer

htrace = new MathModel()
htrace.container = document.getElementById "containerepoidhorizontaltrace"
htrace.populate()
htrace.camera.position.set 15,15,30
#htrace.camera.up = new THREE.Vector3 0,0,1
htrace.camera.lookAt new THREE.Vector3 0,2,0
htrace.cameraControls.target.set 0,2,0
htrace.embed("6/epoid.js", new THREE.MeshNormalMaterial(), true)
htrace.slicer = new THREE.Mesh(new THREE.CubeGeometry(20,20,0.01), new THREE.MeshLambertMaterial({
  color: 0xfe0000,
  ambient: 0x333333,
  opacity: 0.5,
  transparent: true,
  reflectivity: 10
}))
htrace.slicer.rotation.x = Math.PI/2.0
htrace.slicer.position.set 0,4,0
htrace.scene.add htrace.slicer



mathmodels=[cone, fcyl, ellipsoid, hpoid, epoid, htrace, vtrace, taco]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null