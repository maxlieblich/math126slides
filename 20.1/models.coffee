DIRNAME = 20.1

MathModel.statustext=$("#modelstatus")

shell=new MathModel()
shell.container=document.getElementById("shellcontainer")
shell.button=$("#shelllivebutton")
shell.HEIGHT=300
shell.WIDTH=700
shell.populate()
#shell.mathUp()
shell.camera.up=new THREE.Vector3 0,1,0
shell.camera.position.set 0,-1,6
shell.cameraControls.target.set 0,-1,0
shell.embed DIRNAME + "/shell.js",new THREE.MeshNormalMaterial(),true
shell.addaxes 3,3,3

mathmodels=[shell]
window.LoadedMathModels = mathmodels


startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null 