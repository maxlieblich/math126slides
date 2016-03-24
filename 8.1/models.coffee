MathModel.statustext=$("#modelstatus")

ET = new MathModel()
ET.container = document.getElementById "electrontoruscontainer"
ET.populate()
ET.camera.position.set 0,0,10
ET.torusgeo = new THREE.TorusGeometry(2, 1, 64, 48)
ET.inttor = ET.torusgeo.clone()
MathModel.invertNormals ET.inttor
THREE.GeometryUtils.merge ET.torusgeo, ET.inttor
ET.torus = new THREE.Mesh(ET.torusgeo, new THREE.MeshPhongMaterial({
ambient: 0x555555,
color: 0xee0000,
emmissive: 0x00eeee,
specular: 0x123456,
shininess: 5,
opacity: 0.7,
transparent: true
}))
ET.scene.add ET.torus

ET.electron = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
ambient: 0x555555,
color: 0xffff00,
reflectivity: 100
}))
ET.scene.add ET.electron
ET.electron.position.set 1,0,0

ET.calc = (t) ->
  t = t/1000
  ET.electron.position.set Math.cos(t)*(2-Math.cos(4*t)),Math.sin(t)*(2-Math.cos(4*t)),Math.sin(4*t)

mathmodels=[ET]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null