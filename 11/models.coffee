MathModel.statustext=$("#modelstatus")

h = 0.01

#position and derivative for all of these scenes
p=(t)-> new THREE.Vector3 Math.cos(t)*(2-Math.cos(4*t)),Math.sin(t)*(2-Math.cos(4*t)),Math.sin(4*t)
pp=(t)-> (p(t+h).subSelf p(t)).divideScalar(h)
#unit tangent and derivative
T=(t)-> pp(t).normalize()
TT=(t)-> (T(t+h).subSelf T(t)).divideScalar(h)
#unit normal and binormal
N=(t)-> TT(t).normalize()
B=(t)-> T(t).crossSelf(N(t))


torus = (model)->
  model.torus = new THREE.Mesh(new THREE.TorusGeometry(2, 1, 64, 48), new THREE.MeshPhongMaterial({
    ambient: 0x555555,
    color: 0xee0000,
    emissive: 0xee0000,
    specular: 0x123456,
    shininess: 5,
    opacity: 0.7,
    transparent: true
  }))
  model.torus.position.set 0,0,0
  model.scene.add model.torus
  null

electron = (model)->
  model.electron = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
  ambient: 0x555555,
  color: 0xffff00,
  reflectivity: 100
  }))
  model.electron.position.set 1,0,0
  model.scene.add model.electron
  null

tangent = (model)->
  model.tgt = new THREE.ArrowHelper(T(0), p(0), 1.0, 0x00ff00)
  return model.tgt

normal = (model)->
  model.nrml = new THREE.ArrowHelper(T(0), p(0), 1.0, 0xff00ff)
  return model.nrml

binormal = (model)->
  model.binormal = new THREE.ArrowHelper(T(0), p(0), 1.0, 0x0000ff)
  return model.binormal

path = (model)->
  model.pathGeo = new THREE.Geometry()
  model.s=0
  while model.s<=2*Math.PI
    model.pathGeo.vertices.push p(model.s)
    model.s+=0.005
  model.pathMat = new THREE.LineBasicMaterial({color: 0x998800, lineWidth: 10})
  model.path = new THREE.Line model.pathGeo, model.pathMat
  return model.path

#tupdate = (vector, f, t)->
#  vector.geometry.vertices[0] = p(t)
#  vector.geometry.vertices[1] = p(t).addSelf(f t)
#  vector.geometry.dynamic = true
#  vector.geometry.verticesNeedUpdate = true
#  null

update = (vector, f, time)->
  vector.setDirection f(time)
  vector.position = p(time)


frameparams = ()->
  @speed = 0.5
  @solid = true
  null

fparams = new frameparams()

frame = new MathModel()
frame.container = document.getElementById "wholeframecontainer"
frame.solid = fparams.solid
frame.speed = fparams.speed
frame.populate()
frame.camera.position.set 0, 0, 8
torus(frame)
electron(frame)
frame.scene.add tangent(frame)
frame.scene.add normal(frame)
frame.scene.add binormal(frame)
frame.scene.add path(frame)

frame.calc = (t)->
  time=frame.speed*0.001*t
  frame.electron.position=p(time)
#  frame.tgt.geometry.verticesNeedUpdate = true
#  frame.tgt.setDirection T(time)
#  frame.tgt.setPosition p(time)
  update frame.tgt, T, time
  update frame.nrml, N, time
  update frame.binormal, B, time
  null


frame.gui=new dat.GUI(
  autoPlace: false
)

$("#wholeframecontrols").append frame.gui.domElement
frametrol=frame.gui.add fparams,"solid"
frametrol.onChange (value)->
  frame.torus.visible = value
  null
speedtrol=frame.gui.add fparams,"speed",0,1
speedtrol.onChange (value)->
  frame.speed = value
  null

tgparams = ()->
  @speed = 0.5
  @solid = true
  null

tparams = new tgparams()

tg = new MathModel()
tg.container = document.getElementById "tangentcontainer"
tg.solid = tparams.solid
tg.speed = tparams.speed
tg.populate()
tg.camera.position.set 0, 0, 8
torus(tg)
electron(tg)
tg.scene.add tangent(tg)
tg.scene.add path(tg)


tg.calc = (t)->
  time=tg.speed*0.001*t
  tg.electron.position = p(time)
  update tg.tgt, T, time
  null

tg.gui=new dat.GUI(
  autoPlace: false
)

$("#tangentcontrols").append tg.gui.domElement
tgtrol=tg.gui.add tparams,"solid"
tgtrol.onChange (value)->
  tg.torus.visible = value
  null
tgspeedtrol=tg.gui.add tparams,"speed",0,1
tgspeedtrol.onChange (value)->
  tg.speed = value
  null


tgnrparams = ()->
  @speed = 0.5
  @solid = true
  null

tnparams = new tgnrparams()

tn = new MathModel()
tn.container = document.getElementById "tangentnormalcontainer"
tn.solid = tnparams.solid
tn.speed = tnparams.speed
tn.populate()
tn.camera.position.set 0, 0, 8
torus(tn)
electron(tn)
tn.scene.add tangent(tn)
tn.scene.add normal(tn)
tn.scene.add path(tn)

tn.calc = (t)->
  time=tn.speed*0.001*t
  tn.electron.position=p(time)
  update tn.tgt, T, time
  update tn.nrml, N, time
  null


tn.gui=new dat.GUI(
  autoPlace: false
)

$("#tangentnormalcontrols").append tn.gui.domElement
tntrol=tn.gui.add tnparams,"solid"
tntrol.onChange (value)->
  tn.torus.visible = value
  null
speedtrol=tn.gui.add tnparams,"speed",0,1
speedtrol.onChange (value)->
  tn.speed = value
  null


mathmodels=[frame, tn, tg]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null