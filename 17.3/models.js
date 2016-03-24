// Generated by CoffeeScript 1.6.3
(function() {
  var DIRNAME, egg, mathmodels, startmodels;

  DIRNAME = 17.3;

  egg = new MathModel();

  egg.WIDTH = 500;

  egg.container = document.getElementById("eggcontainer");

  egg.populate();

  egg.mathUp();

  egg.embed(DIRNAME + "/oneegg.js", new THREE.MeshNormalMaterial());

  egg.camera.position.set(5, 0, 3);

  egg.cameraControls.target.set(1, 0, 0);

  mathmodels = [egg];

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
