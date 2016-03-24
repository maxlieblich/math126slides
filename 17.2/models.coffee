DIRNAME=17.2



volume=new MathModel()
volume.WIDTH=350
volume.HEIGHT=350
volume.initTime=5000
volume.container=document.getElementById("volumecontainer")
volume.populate()
volume.mathUp()
volume.camera.position.set 5,5,2
volume.cameraControls.target.set 0,0,1
volume.embed DIRNAME + "/volume.js",new THREE.MeshNormalMaterial({
  opacity:1
}),true


mathmodels=[volume]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null