// Generated by CoffeeScript 1.4.0
(function() {
  var EC, ET, mathmodels, startmodels;

  MathModel.statustext = $("#modelstatus");

  ET = new MathModel();

  ET.container = document.getElementById("electrontoruscontainer");

  ET.populate();

  ET.camera.position.set(0, 0, 10);

  ET.torusgeo = new THREE.TorusGeometry(2, 1, 64, 48);

  ET.inttor = ET.torusgeo.clone();

  MathModel.invertNormals(ET.inttor);

  THREE.GeometryUtils.merge(ET.torusgeo, ET.inttor);

  ET.torus = new THREE.Mesh(ET.torusgeo, new THREE.MeshPhongMaterial({
    ambient: 0x555555,
    color: 0xee0000,
    emmissive: 0x00eeee,
    specular: 0x123456,
    shininess: 5,
    opacity: 0.7,
    transparent: true
  }));

  ET.scene.add(ET.torus);

  ET.electron = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
    ambient: 0x555555,
    color: 0xffff00,
    reflectivity: 100
  }));

  ET.scene.add(ET.electron);

  ET.electron.position.set(1, 0, 0);

  ET.calc = function(t) {
    t = t / 1000;
    return ET.electron.position.set(Math.cos(t) * (2 - Math.cos(4 * t)), Math.sin(t) * (2 - Math.cos(4 * t)), Math.sin(4 * t));
  };

  EC = new MathModel();

  EC.container = document.getElementById("electroncylindercontainer");

  EC.populate();

  EC.camera.position.set(0, 1, 10);

  EC.cameraControls.target.set(0, 2, 0);

  EC.cylgeo = new THREE.CylinderGeometry(1, 1, 4, 64, 48);

  EC.intcyl = EC.cylgeo.clone();

  MathModel.invertNormals(EC.intcyl);

  THREE.GeometryUtils.merge(EC.cylgeo, EC.intcyl);

  EC.cyl = new THREE.Mesh(EC.cylgeo, new THREE.MeshPhongMaterial({
    ambient: 0x555555,
    color: 0xee0000,
    emmissive: 0x00eeee,
    specular: 0x123456,
    shininess: 5,
    opacity: 0.7,
    transparent: true
  }));

  EC.scene.add(EC.cyl);

  EC.cyl.position.set(0, 2, 0);

  EC.electron = new THREE.Mesh(new THREE.SphereGeometry(0.1), new THREE.MeshLambertMaterial({
    ambient: 0x555555,
    color: 0xffff00,
    reflectivity: 100
  }));

  EC.scene.add(EC.electron);

  EC.electron.position.set(1, 0, 0);

  EC.calc = function(t) {
    t = t / 400;
    return EC.electron.position.set(Math.cos(2 * t), t / Math.PI % 4.000, Math.sin(-2 * t));
  };

  mathmodels = [ET, EC];

  window.LoadedMathModels = mathmodels;

  startmodels = function() {
    var model, _i, _len;
    for (_i = 0, _len = mathmodels.length; _i < _len; _i++) {
      model = mathmodels[_i];
      model.go();
    }
    return null;
  };

  $(document).ready(function() {
    startmodels();
    return null;
  });

}).call(this);
