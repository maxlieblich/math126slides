MathModel.statustext=$("#modelstatus")


h = 0.01

#position and derivative for all of these scenes
#p=(t) -> new THREE.Vector3 Math.cos(t)*(2-Math.cos(4*t)),Math.sin(t)*(2-Math.cos(4*t)),Math.sin(4*t)
der= (f) ->
  (t) -> (f(t+h).subSelf f(t)).divideScalar(h)
a=(p) ->
  (t) -> der(der(p))(t)
#unit tangent and derivative
T=(p) ->
  (t) -> (der(p)(t)).normalize()
#unit normal and binormal
N=(p) ->
  (t) -> (der(T(p))(t)).normalize()
B=(p) ->
  (t) -> (T(p)(t)).crossSelf(N(p)(t))
aT= (p) ->
  (t) -> (T(p)(t)).multiplyScalar((a(p)(t)).dot(T(p)(t)))
aN=(p) ->
  (t) -> (N(p)(t)).multiplyScalar((a(p)(t)).dot(N(p)(t)))

visible = (object, value)->
  object.traverse( (node)->
    node.visible = value
  )
  null

electron = (model)->
  model.electron = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
  ambient: 0x555555,
  color: 0xffff00,
  reflectivity: 100
  }))
  return model.electron

acceleration = (model)->
  model.accel = new THREE.ArrowHelper(a(model.p)(0), model.p(0), 1.0, 0xff0000)
  return model.accel

tangential_acceleration = (model)->
  model.taccel = new THREE.ArrowHelper(aT(model.p)(0), model.p(0), 1.0, 0x00ff00)
  return model.taccel

normal_acceleration = (model)->
  model.naccel = new THREE.ArrowHelper(aN(model.p)(0), model.p(0), 1.0, 0xff00ff)
  return model.naccel


path = (model)->
  model.pathGeo = new THREE.Geometry()
  model.s=-10
  while model.s<=10
    model.pathGeo.vertices.push (model.p)(model.s)
    model.s+=0.005
  model.pathMat = new THREE.LineBasicMaterial({color: 0x998800, lineWidth: 10})
  model.path = new THREE.Line model.pathGeo, model.pathMat
  return model.path

update = (model, vector, f, time)->
  vector.setDirection f(time)
  vector.setLength f(time).length()
  vector.position = model.p(time)
  null

drawstring = new MathModel()
drawstring.WIDTH = 500
drawstring.HEIGHT = 400
drawstring.container = document.getElementById "stringcontainer"
drawstring.acceleration = false
drawstring.p = (t) -> new THREE.Vector3 Math.pow(t-1,3),0,0
drawstring.populate()
drawstring.camera.position.set 0,0,4
drawstring.electron = electron(drawstring)
drawstring.electron.position.set -1,0,0
drawstring.scene.add drawstring.electron
drawstring.accel = acceleration(drawstring)
drawstring.scene.add drawstring.accel
visible drawstring.accel, false

drawstring.calc= (t)->
  time = 0.001*(t%2000)
  drawstring.electron.position=(drawstring.p)(time)
  update(drawstring, drawstring.accel, a(drawstring.p), time)
  null

drawstring.gui=new dat.GUI(autoPlace: false)

$("#stringcontrols").append drawstring.gui.domElement
drawstring.trol=drawstring.gui.add drawstring,"acceleration"
drawstring.trol.onChange (value)->
    visible drawstring.accel, value
    null


cubicpath = new MathModel()
cubicpath.WIDTH = 500
cubicpath.HEIGHT = 400
cubicpath.container = document.getElementById "cubiccontainer"
cubicpath.vectors = false
cubicpath.speed = 0.5
cubicpath.p = (t) -> new THREE.Vector3 (t-2)*(t-2)-1,(t-2)*((t-2)*(t-2)-1),0
cubicpath.populate()
cubicpath.camera.position.set 0,0,10
cubicpath.electron = electron(cubicpath)
cubicpath.electron.position.set -1,0,0
cubicpath.scene.add cubicpath.electron
cubicpath.plane = new THREE.Mesh(new THREE.CubeGeometry(10,10,0.1), new THREE.MeshPhongMaterial({
  ambient		: 0x111111,
  color		: 0x111111,
  shininess	: 0,
  specular	: 0x11111,
  shading		: THREE.SmoothShading
}))
cubicpath.plane.position.z = -0.2
cubicpath.scene.add cubicpath.plane
cubicpath.path = path(cubicpath)
cubicpath.scene.add cubicpath.path
cubicpath.accel = acceleration(cubicpath)
cubicpath.scene.add cubicpath.accel
visible cubicpath.accel, false
cubicpath.taccel = tangential_acceleration(cubicpath)
cubicpath.scene.add cubicpath.taccel
visible cubicpath.taccel, false
cubicpath.naccel = normal_acceleration(cubicpath)
cubicpath.scene.add cubicpath.naccel
visible cubicpath.naccel, false

cubicpath.calc = (t)->
  time = 2 if cubicpath.speed is 0
  time = cubicpath.speed*0.001*(t%Math.floor(4000/cubicpath.speed)) if cubicpath.speed isnt 0
  cubicpath.electron.position=(cubicpath.p)(time)
  update(cubicpath, cubicpath.accel, a(cubicpath.p), time)
  update(cubicpath, cubicpath.taccel, aT(cubicpath.p), time)
  update(cubicpath, cubicpath.naccel, aN(cubicpath.p), time)
  null

cubicpath.gui=new dat.GUI(autoPlace: false)

$("#cubiccontrols").append cubicpath.gui.domElement

cubicpath.vtrol=cubicpath.gui.add cubicpath,"vectors"

cubicpath.strol=cubicpath.gui.add cubicpath,"speed",0,1

cubicpath.vtrol.onChange (value)->
  $("#vectornames").toggle(value)
  visible cubicpath.accel, value
  visible cubicpath.taccel, value
  visible cubicpath.naccel, value
  null

cubicpath.strol.onChange (value)->
  cubicpath.speed = value
  null


mathmodels = [drawstring, cubicpath]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  $("#vectornames").toggle(false)
  startmodels()
  null


