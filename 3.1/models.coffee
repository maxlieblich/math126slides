MathModel.statustext=$("#modelstatus")

proj = new MathModel()
proj.container = document.getElementById "projcontainer"
#proj.camera = new THREE.OrthographicCamera(-20, 20, -20, 20)
proj.populate()
proj.camera.position.set -4,8,8
proj.camera.up = new THREE.Vector3 0,0,1
proj.renderer.shadowMapEnabled = true
proj.renderer.shadowMapSoft = true
proj.renderer.shadowCameraNear = 3
proj.renderer.shadowCameraFar = proj.camera.far
proj.renderer.shadowCameraFov = 50
proj.renderer.shadowMapBias = 0.0039
proj.renderer.shadowMapDarkness = 1.0
proj.renderer.shadowMapWidth = 1024
proj.renderer.shadowMapHeight = 1024
proj.pointLight.intensity = 0
proj.light = new THREE.SpotLight 0xffffff,0.7
proj.light.position.set 50, 50, 50
proj.light.castShadow = true
#proj.light.onlyShadow = true
proj.light.shadowDarkness = 1.0
proj.light.shadowCameraFov = 10
proj.scene.add proj.light
proj.cylgeom = new THREE.CylinderGeometry(0.1, 0.1, Math.sqrt(50), 100, 100)
proj.cyl = new THREE.Mesh proj.cylgeom, new THREE.MeshPhongMaterial({
  ambient		: 0x444444,
  color		: 0x8844AA,
  shininess	: 300,
  specular	: 0x33AA33,
  shading		: THREE.SmoothShading
})
proj.cyl.castShadow = true
proj.cyl.receiveShadow = false
proj.cyl.rotation.x -= Math.PI / 2.0
proj.cyl.rotation.z = Math.PI / 4.0
proj.cyl.rotation.y = -0.9273
proj.scene.add proj.cyl
proj.planegeom = new THREE.CubeGeometry(10,10,0.1)
proj.ground = new THREE.Mesh proj.planegeom, new THREE.MeshPhongMaterial({
  ambient		: 0x444444,
  color		: 0x66aa66,
  shininess	: 150,
  specular	: 0x888888,
  shading		: THREE.SmoothShading
})
proj.ground.castShadow = false
proj.ground.receiveShadow = true
proj.ground.rotation.x -= Math.PI / 4.0
proj.ground.rotation.y += Math.PI / 4.0
#proj.ground.position.set 0.5, 0.5, -1
proj.scene.add proj.ground
#proj.addaxes 6

ang = new MathModel()
ang.container = document.getElementById "angcontainer"
ang.populate()
ang.camera.position.set 8,8,8
ang.camera.up = new THREE.Vector3 0,0,1
ang.origin = new THREE.Vector3 0,0,0
ang.vector1 = new THREE.Vector3 -2,2,5
ang.vector2 = new THREE.Vector3 2,0,2
ang.addaxes 5
ang.scene.add new THREE.ArrowHelper ang.vector1, ang.origin, 4, 0xff00ff
ang.scene.add new THREE.ArrowHelper ang.vector2, ang.origin, 5, 0xff00ff


mathmodels=[proj, ang]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null

