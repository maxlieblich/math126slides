MathModel.statustext=$("#modelstatus")

trefoil = new MathModel()
trefoil.container = document.getElementById('trefoilcontainer')
trefoil.populate()
trefoil.camera.position.set 2.2,2.2,3.3
#trefoil calcs
trefoil.trefoilFunc = (t) ->
  t2 = t + t
  t3 = t2 + t
  41 * Math.cos(t) - 18 * Math.sin(t) - 83 * Math.cos(t2) - 83 * Math.sin(t2) - 11 * Math.cos(t3) + 27 * Math.sin(t3)

trefoil.trefoilPoint = (t) ->
  kScale = 0.01
  x = trefoil.trefoilFunc(t)
  y = trefoil.trefoilFunc(6.283185 - t)
  z = trefoil.trefoilFunc(t - 1.828453)
  new THREE.Vector3 kScale * x, kScale * y, kScale * z

#construct curve
trefoil.drawPath = (T) ->
  points = []
  t = 0
  while t <= T
    points.push trefoil.trefoilPoint(t)
    t += 0.01
  points

trefoil.trefoilcurve = new THREE.SplineCurve3 trefoil.drawPath(6.28)

trefoil.trefoilgeom = new THREE.Geometry()
trefoil.trefoilgeom.vertices = trefoil.drawPath(6.28)
trefoil.line = new THREE.Line trefoil.trefoilgeom
trefoil.line.position.set 0,0,0
trefoil.line.rotation.set 0,0,0
trefoil.line.scale.set 1,1,1
trefoil.scene.add trefoil.line

trefoil.sphere = new THREE.Mesh new THREE.SphereGeometry(0.05, 0.1, 0.1), new THREE.MeshNormalMaterial()
trefoil.scene.add trefoil.sphere
trefoil.calc = (t)->
  trefoil.sphere.position = trefoil.trefoilcurve.getPoint(new Date().getTime() / 6280.0 % 1 )

heart = new MathModel()
heart.container = document.getElementById('heartcontainer')
heart.populate()
heart.camera.position.set 2,2,3
heart.embed "1.1/heart.json", new THREE.MeshNormalMaterial()
heart.preImplant = (geometry) ->
  geometry.computeFaceNormals
  faces = geometry.faces
  for i in [0..100]
    face = faces[76453*i % faces.length]
    point = THREE.GeometryUtils.randomPointInFace face, geometry
    heart.scene.add(new THREE.ArrowHelper(face.normal, point, 0.3, 0xff0000))
  null

sphere = new MathModel()
sphere.container = document.getElementById('spherecontainer')
sphere.populate()
sphere.camera.position.set 2,2,3
sphere.embed "1.1/sphere.json", new THREE.MeshNormalMaterial()

ellipsoid = new MathModel()
ellipsoid.container = document.getElementById('ellipsoidcontainer')
ellipsoid.populate()
ellipsoid.camera.position.set 2,2,3
ellipsoid.embed "1.1/ellipsoid.json", new THREE.MeshNormalMaterial()

mathmodels=[trefoil, heart, sphere, ellipsoid]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null