MathModel.statustext=$("#modelstatus")

twoplanes = new MathModel()
twoplanes.container = document.getElementById "twoplanescontainer"
twoplanes.populate()
twoplanes.camera.position.set -4,8,15
twoplanes.camera.up = new THREE.Vector3 0,0,1
twoplanes.plane1 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
  ambient: 0x111111,
  color: 0xff00ff,
  shininess: 300,
  specular: 0x00ff00,
  shading: THREE.SmoothShading
}))
twoplanes.plane1.rotation.x += Math.PI / 4.0
twoplanes.scene.add twoplanes.plane1
twoplanes.plane2 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
ambient: 0x111111,
color: 0xff0055,
shininess: 300,
specular: 0x00ff00,
shading: THREE.SmoothShading
}))
twoplanes.plane2.rotation.y += Math.PI / 4.0
twoplanes.plane2.rotation.z -= Math.PI / 3.0
#twoplanes.plane2.position.set -1,-1,-1
twoplanes.scene.add twoplanes.plane2

coordplanes = new MathModel()
coordplanes.container = document.getElementById "coordplanes"
coordplanes.populate()
coordplanes.camera.position.set -4,8,15
coordplanes.camera.up = new THREE.Vector3 0,0,1
coordplanes.plane1 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
ambient: 0x111111,
color: 0xff00ff,
shininess: 300,
specular: 0x00ff00,
shading: THREE.SmoothShading
}))
coordplanes.plane1.rotation.x += Math.PI / 2.0
coordplanes.scene.add coordplanes.plane1
coordplanes.plane2 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
ambient: 0x111111,
color: 0xff0055,
shininess: 300,
specular: 0x00ff00,
shading: THREE.SmoothShading
}))
coordplanes.plane2.rotation.y += Math.PI / 2.0
coordplanes.scene.add coordplanes.plane2
coordplanes.addaxes 6

enemy = new MathModel()
enemy.container = document.getElementById "enemycontainer"
enemy.populate()
enemy.camera.position.set -6, 6, 12
enemy.camera.up = new THREE.Vector3 0,0,1
enemy.ground = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
  ambient: 0x111111,
  color: 0xff00ff,
  shininess: 300,
  specular: 0x00ff00,
  shading: THREE.SmoothShading
}))
enemy.cylinder = new THREE.Mesh(new THREE.CylinderGeometry(0.05, 0.05, 10), new THREE.MeshPhongMaterial({
  ambient: 0x111111,
  color: 0x00ff00,
  shininess: 150,
  specular: 0xff0000,
  shading: THREE.SmoothShading
}))
enemy.cylinder.rotation.x += Math.PI / 2.0
enemy.scene.add enemy.ground
enemy.scene.add enemy.cylinder

parplanes = new MathModel()
parplanes.container = document.getElementById "parplanescontainer"
parplanes.populate()
parplanes.camera.position.set -8,8,6
parplanes.camera.up = new THREE.Vector3 0,0,1
parplanes.plane1 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
ambient: 0x111111,
color: 0xff00ff,
shininess: 300,
specular: 0x00ff00,
shading: THREE.SmoothShading
}))
parplanes.scene.add parplanes.plane1
parplanes.plane2 = new THREE.Mesh(new THREE.CubeGeometry(10, 10, 0.01), new THREE.MeshPhongMaterial({
ambient: 0x111111,
color: 0xff0055,
shininess: 300,
specular: 0x00ff00,
shading: THREE.SmoothShading
}))
parplanes.plane2.position.set 0,0,4
parplanes.scene.add parplanes.plane2
parplanes.addaxes 6


mathmodels=[twoplanes, coordplanes, enemy, parplanes]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null