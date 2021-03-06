// Generated by CoffeeScript 1.6.3
(function() {
  var ellipsoid, heart, mathmodels, sphere, startmodels, trefoil;

  MathModel.statustext = $("#modelstatus");

  trefoil = new MathModel();

  trefoil.container = document.getElementById('trefoilcontainer');

  trefoil.populate();

  trefoil.camera.position.set(2.2, 2.2, 3.3);

  trefoil.trefoilFunc = function(t) {
    var t2, t3;
    t2 = t + t;
    t3 = t2 + t;
    return 41 * Math.cos(t) - 18 * Math.sin(t) - 83 * Math.cos(t2) - 83 * Math.sin(t2) - 11 * Math.cos(t3) + 27 * Math.sin(t3);
  };

  trefoil.trefoilPoint = function(t) {
    var kScale, x, y, z;
    kScale = 0.01;
    x = trefoil.trefoilFunc(t);
    y = trefoil.trefoilFunc(6.283185 - t);
    z = trefoil.trefoilFunc(t - 1.828453);
    return new THREE.Vector3(kScale * x, kScale * y, kScale * z);
  };

  trefoil.drawPath = function(T) {
    var points, t;
    points = [];
    t = 0;
    while (t <= T) {
      points.push(trefoil.trefoilPoint(t));
      t += 0.01;
    }
    return points;
  };

  trefoil.trefoilcurve = new THREE.SplineCurve3(trefoil.drawPath(6.28));

  trefoil.trefoilgeom = new THREE.Geometry();

  trefoil.trefoilgeom.vertices = trefoil.drawPath(6.28);

  trefoil.line = new THREE.Line(trefoil.trefoilgeom);

  trefoil.line.position.set(0, 0, 0);

  trefoil.line.rotation.set(0, 0, 0);

  trefoil.line.scale.set(1, 1, 1);

  trefoil.scene.add(trefoil.line);

  trefoil.sphere = new THREE.Mesh(new THREE.SphereGeometry(0.05, 0.1, 0.1), new THREE.MeshNormalMaterial());

  trefoil.scene.add(trefoil.sphere);

  trefoil.calc = function(t) {
    return trefoil.sphere.position = trefoil.trefoilcurve.getPoint(new Date().getTime() / 6280.0 % 1);
  };

  heart = new MathModel();

  heart.container = document.getElementById('heartcontainer');

  heart.populate();

  heart.camera.position.set(2, 2, 3);

  heart.embed("1.1/heart.json", new THREE.MeshNormalMaterial());

  heart.preImplant = function(geometry) {
    var face, faces, i, point, _i;
    geometry.computeFaceNormals;
    faces = geometry.faces;
    for (i = _i = 0; _i <= 100; i = ++_i) {
      face = faces[76453 * i % faces.length];
      point = THREE.GeometryUtils.randomPointInFace(face, geometry);
      heart.scene.add(new THREE.ArrowHelper(face.normal, point, 0.3, 0xff0000));
    }
    return null;
  };

  sphere = new MathModel();

  sphere.container = document.getElementById('spherecontainer');

  sphere.populate();

  sphere.camera.position.set(2, 2, 3);

  sphere.embed("1.1/sphere.json", new THREE.MeshNormalMaterial());

  ellipsoid = new MathModel();

  ellipsoid.container = document.getElementById('ellipsoidcontainer');

  ellipsoid.populate();

  ellipsoid.camera.position.set(2, 2, 3);

  ellipsoid.embed("1.1/ellipsoid.json", new THREE.MeshNormalMaterial());

  mathmodels = [trefoil, heart, sphere, ellipsoid];

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
