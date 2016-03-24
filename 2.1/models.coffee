MathModel.statustext=$("#modelstatus")

vectorcolor = 0xff00ff
origin = new THREE.Vector3 0,0,0
neworigin = new THREE.Vector3 -0.5,-0.2,0.6
newneworigin = new THREE.Vector3 -1, -1, -1
vector1 = new THREE.Vector3 -4,5,6

vectors1 = new MathModel()
vectors1.container = document.getElementById('vectors1container')
vectors1.populate()
vectors1.camera.position.set 2, 2, 3
vectors1.scene.add new THREE.ArrowHelper(vector1, origin, 1, vectorcolor)
vectors1.addaxes 4

vectors2 = new MathModel()
vectors2.container = document.getElementById('vectors2container')
vectors2.populate()
vectors2.camera.position.set 2, 2, 3
vectors2.scene.add new THREE.ArrowHelper(vector1, origin, 1, vectorcolor)
vectors2.scene.add new THREE.ArrowHelper(vector1, neworigin, 1, vectorcolor)
vectors2.scene.add new THREE.ArrowHelper(vector1, newneworigin, 1, vectorcolor)
vectors2.addaxes(4)

vectors3 = new MathModel()
vectors3.animated = false
vectors3.container = document.getElementById('vectors3container')
vectors3.populate()
vectors3.camera.position.set 2, 0, 7
vectors3.origin = []
vectors3.vector = []
vectors3.length = []
vectors3.origin[0] = new THREE.Vector3 0,0,0
vectors3.origin[1] = new THREE.Vector3 1,0,0
vectors3.origin[2] = new THREE.Vector3 2,0,0
vectors3.origin[3] = new THREE.Vector3 3,0,0
vectors3.origin[4] = new THREE.Vector3 4,0,0
vectors3.vector[0] = new THREE.Vector3 1,1,0
vectors3.vector[1] = new THREE.Vector3 1,1,0
vectors3.vector[2] = new THREE.Vector3 1,3,0
vectors3.vector[3] = new THREE.Vector3 -2,3,0
vectors3.vector[4] = new THREE.Vector3 1,3,0
vectors3.length[0] = 1
vectors3.length[1] = 2
vectors3.length[2] = 1
vectors3.length[3] = 1
vectors3.length[4] = 1
for i in [0..4]
  vectors3.scene.add new THREE.ArrowHelper(vectors3.vector[i], vectors3.origin[i], vectors3.length[i], vectorcolor)


vectors4 = new MathModel()
vectors4.container = document.getElementById('vectors4container')
vectors4.populate()
vectors4.camera.position.set 4, 4, 6
vectors4.origin = []
vectors4.vector = []
vectors4.length = []
vectors4.origin[0] = new THREE.Vector3 0,0,0
vectors4.origin[1] = new THREE.Vector3 0,0,0
vectors4.origin[2] = new THREE.Vector3 0,0,0
vectors4.origin[3] = new THREE.Vector3 0,0,0
vectors4.origin[4] = new THREE.Vector3 0,0,0
vectors4.vector[0] = new THREE.Vector3 1,1,0
vectors4.vector[1] = new THREE.Vector3 -1,1,0
vectors4.vector[2] = new THREE.Vector3 1,3,4
vectors4.vector[3] = new THREE.Vector3 -2,3,10
vectors4.vector[4] = new THREE.Vector3 -1,-3,-2
vectors4.length[0] = 1
vectors4.length[1] = 1.5
vectors4.length[2] = 2
vectors4.length[3] = 2.5
vectors4.length[4] = 3
vectors4.addaxes(6)
for i in [0..4]
  vectors4.scene.add new THREE.ArrowHelper(vectors4.vector[i], vectors4.origin[i], vectors4.length[i], vectorcolor)


vectors5 = new MathModel()
vectors5.animated = false
vectors5.container = document.getElementById('vectors5container')
vectors5.populate()
vectors5.camera.position.set 0, 0, 7
vectors5.origin = []
vectors5.vector = []
vectors5.length = []
vectors5.color = []
vectors5.origin[0] = new THREE.Vector3 0,0,0
vectors5.origin[1] = new THREE.Vector3 1,1,0
vectors5.origin[2] = new THREE.Vector3 0,0,0
vectors5.origin[3] = new THREE.Vector3 2,0,0
vectors5.origin[4] = new THREE.Vector3 2.2,0,0
vectors5.vector[0] = new THREE.Vector3 1,1,0
vectors5.vector[1] = new THREE.Vector3 -1,1,0
vectors5.vector[2] = new THREE.Vector3 0,1,0
vectors5.vector[3] = new THREE.Vector3 0,1,0
vectors5.vector[4] = new THREE.Vector3 0,1,0
vectors5.length[0] = Math.sqrt(2)
vectors5.length[1] = Math.sqrt(2)
vectors5.length[2] = 2
vectors5.length[3] = 1
vectors5.length[4] = 2
vectors5.color[0] = 0xff0000
vectors5.color[1] = 0x0000ff
vectors5.color[2] = vectorcolor
vectors5.color[3] = vectorcolor
vectors5.color[4] = vectorcolor
for i in [0..4]
  vectors5.scene.add new THREE.ArrowHelper(vectors5.vector[i], vectors5.origin[i], vectors5.length[i], vectors5.color[i])

vectors6 = new MathModel()
vectors6.animated = false
vectors6.container = document.getElementById('vectors6container')
vectors6.populate()
vectors6.camera.position.set 0, 0, 7
for i in [0..1]
  vectors6.scene.add new THREE.ArrowHelper(vectors5.vector[i], vectors5.origin[0], vectors5.length[i], vectors5.color[i])


vectors7 = new MathModel()
vectors7.animated = false
vectors7.container = document.getElementById('vectors7container')
vectors7.populate()
vectors7.camera.position.set 0, 0, 7
for i in [0..1]
  vectors7.scene.add new THREE.ArrowHelper(vectors5.vector[i], vectors5.origin[i], vectors5.length[i], vectors5.color[i])


vectors8 = new MathModel()
vectors8.animated = false
vectors8.container = document.getElementById('vectors8container')
vectors8.populate()
vectors8.camera.position.set 0, 0, 7
for i in [0..2]
  vectors8.scene.add new THREE.ArrowHelper(vectors5.vector[i], vectors5.origin[i], vectors5.length[i], vectors5.color[i])


mathmodels=[vectors1, vectors2, vectors3, vectors4, vectors5, vectors6, vectors7, vectors8]
#window.MathModelNumber=mathmodels.length
window.LoadedMathModels = mathmodels

startmodels= ->
  for model in mathmodels
    model.go()
  null

$(document).ready ()->
  startmodels()
  null

