DIRNUM = 16.1

models=[{name: "paraboloid", equation: "\$x^2+y^2\$"},
        {name: "hyperboloid",equation:"\$x^2-y^2\$"},
        {name: "egg", equation: "\$\sin(x)\cos(y)\$"},
        {name:"exponential",equation: "\$x^y\$"}]
hidemodels= ->
  for model in models
    name="#"+model.name+"container"
    eq="#"+model.name+"equation"
    $(name).toggle(false)
    $(eq).toggle(false)
  null  
$("#mega").change ->
  hidemodels()
  onname="#"+$("#mega").val()+"container"
  eqname="#"+$("#mega").val()+"equation"
  $(onname).toggle(true)
  $(eqname).toggle(true)
  null

#THREE.Object3D.prototype.up = new THREE.Vector3(0,0,1)

meshMat = ()-> new THREE.MeshNormalMaterial({transparent: true, opacity: 0.5})

nedwina = ()->
  new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
  color: 0xff0000
  ambient: 0x11111
  }))

greenwina = () ->
  new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
  color: 0x00ff00
  ambient: 0x11111
  }))

redTube = (pts)->
  path = new THREE.SplineCurve3 pts
  new THREE.Mesh(new THREE.TubeGeometry(path, 64, 0.07), new THREE.MeshPhongMaterial({
  color: 0xff0000
  opacity: 0.7
  transparent: true
  ambient: 0x222222
  }))

greenTube = (pts)->
  path = new THREE.SplineCurve3 pts
  new THREE.Mesh(new THREE.TubeGeometry(path, 64, 0.07), new THREE.MeshPhongMaterial({
  color: 0x00ff00
  opacity: 0.7
  transparent: true
  ambient: 0x222222
  }))


paraboloid= new MathModel()
paraboloid.container=document.getElementById("paraboloidcontainer")
paraboloid.populate()
paraboloid.camera.up = new THREE.Vector3(0,0,1)
paraboloid.camera.position.set 9,9,9
paraboloid.cameraControls.target.set 0,0,4   
paraboloid.embed DIRNUM + "/paraboloid.js", new meshMat
paraboloid.nedwina = nedwina()
paraboloid.nedwina.position.set 0,0,0
paraboloid.scene.add paraboloid.nedwina
paraboloid.addaxes(4)
paraboloid.addaxes(-2)
#paraboloid.init()  
#paraboloid.go()

hyperboloid= new MathModel()
hyperboloid.container=document.getElementById("hyperboloidcontainer")
hyperboloid.populate()
hyperboloid.camera.up = new THREE.Vector3 0,0,1
hyperboloid.camera.position.set 12,12,9
hyperboloid.cameraControls.target.set 0,0,0   
hyperboloid.embed DIRNUM + "/hyperboloid.js", new meshMat
hyperboloid.nedwina = nedwina()
hyperboloid.nedwina.position.set 0,0,0
#plane.receiveShadow=true
hyperboloid.scene.add hyperboloid.nedwina
hyperboloid.addaxes(4)
hyperboloid.addaxes(-2)  
#hyperboloid.init()  
#hyperboloid.go()

egg= new MathModel()
egg.container=document.getElementById("eggcontainer")
egg.populate()
egg.camera.up = new THREE.Vector3 0,0,1
egg.camera.position.set 6,6,6
egg.cameraControls.target.set 0,0,0   
egg.embed DIRNUM + "/egg.js",new meshMat
v= (x,y,z)->new THREE.Vector3(x,y,z)
f= (x,y)-> Math.sin(x)*Math.cos(y)
s=Math.PI/2
g= (m,n)-> v(m*s,n*s,f(m*s,n*s))
crits=[]
odds=[-1,1]
evens=[-2,0,2]
for i in odds
  for j in evens
    crits.push g(i,j)
    crits.push g(j,i)
egg.nedwinas=[]  
placenedwinas= ->
  for crit in crits 
    egg.nedwinas[crit] = nedwina()
    egg.nedwinas[crit].position = crit
    egg.scene.add egg.nedwinas[crit]
  null
placenedwinas()    
egg.addaxes(4)
egg.addaxes(-2)  
#egg.init()  
#egg.go()


exponential= new MathModel()
exponential.container=document.getElementById("exponentialcontainer")
exponential.populate()
exponential.camera.up = new THREE.Vector3 0,0,1
exponential.camera.position.set 6,-6,-6
exponential.cameraControls.target.set 0,0,3   
exponential.embed DIRNUM + "/exponential.js",new meshMat
exponential.nedwina = nedwina()
exponential.nedwina.position.set 1,0,1
#plane.receiveShadow=true
exponential.scene.add exponential.nedwina
exponential.addaxes(4)
exponential.addaxes(-2)
exponential.initTime=7000  
#exponential.init()  
#exponential.go()

hyp= new MathModel()
hyp.container=document.getElementById("hypcontainer")
hyp.populate()
hyp.camera.up = new THREE.Vector3 0,0,1
hyp.camera.position.set 12,12,9
hyp.cameraControls.target.set 0,0,0   
hyp.embed DIRNUM + "/hyperboloidone.js",new meshMat, true
hyp.redpts=[]
hyp.grpts=[]
t=-2
while t<=2
  hyp.redpts.push v(t,0,t*t)
  hyp.grpts.push v(0,t,-t*t)
  t+=0.1

hyp.scene.add redTube(hyp.redpts)
hyp.scene.add greenTube(hyp.grpts)
hyp.addaxes(4)
hyp.addaxes(-2)  

quad= new MathModel()
quad.container=document.getElementById("quadcontainer")
quad.HEIGHT=400
quad.WIDTH=400
quad.populate()
quad.camera.up = new THREE.Vector3 0,0,1
quad.camera.position.set 2,-2,16
quad.cameraControls.target.set 0,0,0   
quad.embed DIRNUM + "/quad.js",new meshMat
quad.redpts=[]
quad.grpts=[]
t=-4
while t<=4
  quad.redpts.push v(t,0,t*t)
  quad.grpts.push v(0,t,t*t)
  t+=0.1
quad.scene.add redTube(quad.redpts)
quad.scene.add greenTube(quad.grpts)
quad.addaxes(4)
quad.addaxes(-2)  


mathmodels=[paraboloid,hyperboloid,egg,exponential,hyp,quad]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  hidemodels()
  $("#paraboloidcontainer").toggle(true)
  $("#paraboloidequation").toggle(true)
  null 