DIRNAME=17.3

egg=new MathModel()
egg.WIDTH=500
egg.container=document.getElementById("eggcontainer")
egg.populate()
egg.mathUp()
egg.embed DIRNAME + "/oneegg.js",new THREE.MeshNormalMaterial()
egg.camera.position.set 5,0,3
egg.cameraControls.target.set 1,0,0

mathmodels=[egg]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null