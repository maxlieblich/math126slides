DIRNAME = 19

fin=new MathModel()
fin.container=document.getElementById("fincontainer")
fin.button=$("#finlivebutton")
fin.populate()
fin.mathUp()
fin.camera.position.set 0,-2,1
fin.cameraControls.target.set .5,0,.5
fin.embed DIRNAME + "/fin.js",new THREE.MeshNormalMaterial(),true

tear=new MathModel()
tear.container=document.getElementById("tearcontainer")
tear.button=undefined
tear.WIDTH=500
tear.populate()
tear.camera.up=new THREE.Vector3 0,1,0
tear.camera.position.set 0,0,2
tear.cameraControls.target.set 0,0,0
tear.embed DIRNAME + "/fin.js",new THREE.MeshBasicMaterial({color: 0x000055, opacity:.6,transparent:true}),true
tear.addaxes 2,2,0
tear.addaxes -.5,-.5,0
  
### 
shell=new MathModel()
shell.container=document.getElementById("shellcontainer")
shell.button=$("#shelllivebutton")
shell.HEIGHT=250
shell.populate()
shell.camera.position.set 0,-0.1,8
shell.cameraControls.target.set 0,0,0
shell.embed DIRNAME + "/shell.js",new THREE.MeshNormalMaterial(),true
###  
mathmodels=[fin,tear]#,shell]
window.LoadedMathModels = mathmodels


startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null 