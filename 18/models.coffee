DIRNAME = 18

rotateAroundObjectAxis = (object, axis, radians) ->
  rotObjectMatrix = new THREE.Matrix4()
  rotObjectMatrix.makeRotationAxis axis.normalize(), radians
  object.applyMatrix rotObjectMatrix # post-multiply
  null

preImplant= (geometry)->
  rotateAroundObjectAxis(geometry, new THREE.Vector3(1,0,0), -1*Math.PI/4)
  null


eye=new MathModel()
eye.WIDTH=400
eye.container=document.getElementById("eyecontainer")
#eye.shadow=true
eye.populate()
eye.mathUp()
eye.camera.position.set 2,2,3
eye.cameraControls.target.set 0,0,0
#eye.renderer.shadowMapEnabled=true
eye.bigSphere=new THREE.Mesh(new THREE.SphereGeometry(1,20,20),new THREE.MeshPhongMaterial({
  color: 0xff0000
  opacity:0.8
  ambient: 0x555555
  transparent: true
}))
eye.bigSphere.castShadow=eye.bigSphere.receiveShadow=true  
eye.bigSphere.position.set 0,0,0
eye.smallSphere=new THREE.Mesh(new THREE.SphereGeometry(.5,20,20),new THREE.MeshPhongMaterial({
  color: 0xffff00
  opacity:0.6
  transparent:true
  ambient: 0x555555
}))
eye.smallSphere.castShadow=eye.smallSphere.receiveShadow=true  
eye.smallSphere.position.set 0,0,.75
eye.scene.add eye.bigSphere
eye.scene.add eye.smallSphere

eye2=new MathModel()
eye2.WIDTH=400
eye2.container=document.getElementById("eye2container")
#eye2.shadow=true
eye2.populate()
eye2.camera.position.set 2,2,3
eye2.cameraControls.target.set 0,0,0
#eye2.renderer.shadowMapEnabled=true
eye2.bigSphere=new THREE.Mesh(new THREE.SphereGeometry(1,20,20),new THREE.MeshPhongMaterial({
  color: 0xff0000
  opacity:0.8
  ambient: 0x555555
  transparent: true
}))
eye2.bigSphere.castShadow=eye2.bigSphere.receiveShadow=true  
eye2.bigSphere.position.set 0,0,0
eye2.smallSphere=new THREE.Mesh(new THREE.SphereGeometry(.5,20,20),new THREE.MeshPhongMaterial({
  color: 0xffff00
  opacity:0.6
  transparent:true
  ambient: 0x555555
}))
eye2.smallSphere.castShadow=eye2.smallSphere.receiveShadow=true  
eye2.smallSphere.position.set 0,0,.75
eye2.scene.add eye2.bigSphere
eye2.scene.add eye2.smallSphere


mathmodels=[eye,eye2]
window.LoadedMathModels = mathmodels


startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null 