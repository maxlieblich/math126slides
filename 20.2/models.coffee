DIRNAME = 20.2

MathModel.statustext=$("#modelstatus")

squirrel=new MathModel()
squirrel.container=document.getElementById("squirrelcontainer")
squirrel.button=$("#squirrellivebutton")
squirrel.HEIGHT=200
squirrel.WIDTH=400
squirrel.populate()
squirrel.camera.up=new THREE.Vector3 0,0,1
squirrel.camera.position.set -1,-2,1
squirrel.cameraControls.target.set 0,0,0
squirrel.dotsGeo=new THREE.Geometry()
squirrel.dotsMat=new THREE.ParticleBasicMaterial {vertexColors:true,size:0.1}
v= (x,y,z)->new THREE.Vector3(x,y,z)
x=-0.5
while x<=0.5
  y=-0.5
  while y<=0.5
    squirrel.dotsGeo.vertices.push v(x,y,0)
    squirrel.dotsGeo.colors.push new THREE.Color().setHSV(0,1,Math.exp(x+y)/Math.E)
    y+=.01
  x+=.01  
squirrel.dots=new THREE.ParticleSystem squirrel.dotsGeo,squirrel.dotsMat
squirrel.scene.fog=new THREE.FogExp2 0xffffff,0.0035
squirrel.scene.add squirrel.dots
squirrel.init()

squirrel2=new MathModel()
squirrel2.container=document.getElementById("squirrel2container")
squirrel2.button=undefined#$("#squirrel2livebutton")
squirrel2.HEIGHT=200
squirrel2.WIDTH=400
squirrel2.populate()
squirrel2.camera.up=new THREE.Vector3 0,1,0
squirrel2.camera.position.set 0,0,1.5
squirrel2.cameraControls.target.set 0,0,0
squirrel2.dotsGeo=new THREE.Geometry()
squirrel2.dotsMat=new THREE.ParticleBasicMaterial {vertexColors:true,size:0.1}
v= (x,y,z)->new THREE.Vector3(x,y,z)
x=-0.5
while x<=0.5
  y=-0.5
  while y<=0.5
    squirrel2.dotsGeo.vertices.push v(x,y,0)
    squirrel2.dotsGeo.colors.push new THREE.Color().setHSV(0,1,Math.exp(x+y)/Math.E)
    y+=.01
  x+=.01
squirrel2.dots=new THREE.ParticleSystem squirrel2.dotsGeo,squirrel2.dotsMat
squirrel2.scene.fog=new THREE.FogExp2 0xffffff,0.0035
squirrel2.scene.add squirrel2.dots
squirrel2.center=(3-Math.E)/(2*Math.E-2)
squirrel2.marker=new THREE.Mesh(new THREE.SphereGeometry(0.02),new THREE.MeshLambertMaterial({color: 0x00ff00,opacity:1}))
squirrel2.marker.position.set squirrel2.center,squirrel2.center,0
squirrel2.scene.add squirrel2.marker
squirrel2.init()

mathmodels=[squirrel,squirrel2]
window.LoadedMathModels = mathmodels


startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null 