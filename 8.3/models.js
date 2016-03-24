// Generated by CoffeeScript 1.6.3
(function() {
  var joey, mathmodels, startmodels;

  MathModel.statustext = $("#modelstatus");

  joey = new MathModel();

  joey.container = document.getElementById("joeycontainer");

  joey.populate();

  joey.camera.position.set(22, 20, 15);

  joey.cameraControls.target.set(3, 0, 3);

  joey.renderer.shadowMapEnabled = true;

  joey.renderer.shadowMapSoft = true;

  joey.renderer.shadowCameraNear = 3;

  joey.renderer.shadowCameraFar = joey.camera.far;

  joey.renderer.shadowCameraFov = 50;

  joey.renderer.shadowMapBias = 0.0039;

  joey.renderer.shadowMapDarkness = 1.0;

  joey.renderer.shadowMapWidth = 1024;

  joey.renderer.shadowMapHeight = 1024;

  joey.pointLight.intensity = 0;

  joey.spot = new THREE.SpotLight(0xffffff, 0.7);

  joey.spot.position.set(40, 40, 40);

  joey.spot.castShadow = true;

  joey.spot.shadowDarkness = 1.0;

  joey.spot.shadowCameraFov = 50;

  joey.scene.add(joey.spot);

  joey.joey = new THREE.Mesh(new THREE.SphereGeometry(0.6), new THREE.MeshLambertMaterial({
    color: 0xff0000,
    ambient: 0x333333
  }));

  joey.joey.castShadow = true;

  joey.joey.receiveShadow = true;

  joey.scene.add(joey.joey);

  joey.joey.position.set(0, 0, 1);

  joey.joeylet = new THREE.Mesh(new THREE.SphereGeometry(0.3), new THREE.MeshLambertMaterial({
    color: 0xffff00,
    ambient: 0x123456
  }));

  joey.joeylet.castShadow = true;

  joey.joeylet.receiveShadow = true;

  joey.scene.add(joey.joeylet);

  joey.joeylet.position.set(0, 0, 1);

  joey.ground = new THREE.Mesh(new THREE.CubeGeometry(30, 40, 0.1), new THREE.MeshLambertMaterial({
    color: 0xc2b5ab,
    ambient: 0x555555
  }));

  joey.ground.rotation.set(3 * Math.PI / 2, 0, 0);

  joey.ground.position.set(0, 0, 0);

  joey.ground.castShadow = true;

  joey.ground.receiveShadow = true;

  joey.scene.add(joey.ground);

  joey.x = function(t) {
    return 0.05 * t ^ 2;
  };

  joey.y = function(t) {
    return 2 - Math.cos(t);
  };

  joey.z = function(t) {
    return t;
  };

  joey.calc = function(t) {
    t = t / 300 % 15;
    joey.joey.position.set(joey.x(t), joey.y(t), joey.z(t));
    return joey.joeylet.position.set(joey.x(t - 0.5), joey.y(t - 0.5), joey.z(t - 0.5));
  };

  mathmodels = [joey];

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
