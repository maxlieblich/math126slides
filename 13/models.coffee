cloud = new MathModel("cloudcontainer")
cloud.camera.position.set 0,0,8
cloud.pointLight.intensity = 0.1
cloud.embed "13/cloud.js",
            new THREE.MeshNormalMaterial({opacity: 0.7}),
            null, null, null, null, true


rainier = new MathModel("mountaincontainer")
rainier.camera.position.set 0,8,15
rainier.cameraControls.target.set 0,4,0
rainier.embed "13/rainier.js", new THREE.MeshLambertMaterial({color: 0xb88a00, ambient: 0x555555})
rainier.plane = new THREE.Mesh(new THREE.CubeGeometry(10,10,0.1), new THREE.MeshLambertMaterial({
  color: 0xff0000
  ambient: 0x444444
  opacity: 0.5
  transparent:true
}))
rainier.plane.rotation.x = Math.PI/2
rainier.plane.position.set 0,0,0
rainier.scene.add rainier.plane


sliced = new MathModel("slicedcontainer")
sliced.camera.position.set 0,8,15
sliced.cameraControls.target.set 0,4,0
sliced.embed "13/sliced.js", new THREE.MeshLambertMaterial({color: 0xb88a00, ambient: 0x555555, transparent: true, opacity: 0.6})

mathmodels = [cloud, rainier, sliced]
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  $("#vectornames").toggle(false)
  startmodels()
  null


map= ->
  levels=[]
  data=[]
  options=
    xaxis:
      min:-3.5
      max:3.5
    yaxis:
      min:-3.5
      max:3.5
  for j in [0..8]
    levels[j]=[]
    r=Math.sqrt 9-j
    t=0
    while t<=2*Math.PI+0.1
      levels[j].push [r*Math.cos(t),r*Math.sin(t)]
      t+=0.05
    data.push {label: "#{j}", data: levels[j]}
  $.plot $("#isomountain"),data,options
  null
map()

distinguisher= ->
  plevels=[]
  clevels=[]
  pdata=[]
  cdata=[]
  options=
    xaxis:
      min:-3.5
      max:3.5
    yaxis:
      min:-3.5
      max:3.5
  for j in [0..8]
    plevels[j]=[]
    clevels[j]=[]
    pr=Math.sqrt 9-j
    cr=(9-j)/3
    t=0
    while t<=2*Math.PI+0.1
      plevels[j].push [pr*Math.cos(t),pr*Math.sin(t)]
      clevels[j].push [cr*Math.cos(t),cr*Math.sin(t)]
      t+=0.05
    pdata.push {label: "#{j}", data: plevels[j]}
    cdata.push {label: "#{j}", data: clevels[j]}
  $.plot $("#paraboloidcontour"),pdata,options
  $.plot $("#conecontour"),cdata,options
  null
distinguisher()
