DIRNUM = 14.1

rotateAroundObjectAxis = (object, axis, radians) ->
  rotObjectMatrix = new THREE.Matrix4()
  rotObjectMatrix.makeRotationAxis axis.normalize(), radians
  object.applyMatrix rotObjectMatrix # post-multiply
  null

preImplant= (geometry)->
  rotateAroundObjectAxis(geometry, new THREE.Vector3(1,0,0), Math.PI/2)
  null

rainier = new MathModel("rainiercontainer")
rainier.preImplant = preImplant
rainier.camera.position.set 6,6,6
rainier.camera.up = new THREE.Vector3 0,0,1
rainier.embed DIRNUM + "/rainier.js", new THREE.MeshNormalMaterial({color: 0xb88a00, opacity: 0.5, transparent: true}), true
rainier.addaxes 4
rainier.nedwina = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
  color: 0xff0000
  ambient: 0x111111
}))
rainier.nedwina.position.set 0,0,0
rainier.scene.add rainier.nedwina

oid = new MathModel("oidcontainer")
oid.preImplant = preImplant
oid.camera.position.set 8,4,8
oid.camera.up = new THREE.Vector3 0,0,1
oid.embed DIRNUM + "/oid.js", new THREE.MeshNormalMaterial({color: 0xb88a00, opacity: 0.5, transparent: true}), true
oid.addaxes 4
oid.nedwina = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
color: 0xff0000
ambient: 0x111111
}))
oid.nedwina.position.set 1,1,2
oid.scene.add oid.nedwina

oidslice = new MathModel()
oidslice.HEIGHT = 300
oidslice.WIDTH = 300
oidslice.preImplant = preImplant
oidslice.container = document.getElementById "oidslicecontainer"
oidslice.populate()
oidslice.camera.position.set 8,4,8
oidslice.camera.up = new THREE.Vector3 0,0,1
oidslice.embed DIRNUM + "/oidslice.js", new THREE.MeshNormalMaterial({color: 0xb88a00, opacity: 0.5, transparent: true}), true
oidslice.addaxes 4
oidslice.nedwina = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
color: 0xff0000
ambient: 0x111111
}))
oidslice.nedwina.position.set 1,1,2
oidslice.scene.add oidslice.nedwina


mathmodels = [rainier, oid, oidslice]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null

oidmap= ->
  options=
    xaxis:
      min:-3
      max:3
    yaxis:
      min:0
      max:10
  d1=[]
  d2=[]
  x=-3
  while x<=3
    d1.push [x,x*x+1]
    d2.push [x,2*x]
    x+=0.05
  data=[{label: "z^2=x^2+1", data: d1},{label: "z=2x", data: d2}]
  $.plot $("#sliceplot"),data,options
  null
oidmap()