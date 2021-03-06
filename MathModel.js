// Generated by CoffeeScript 1.4.0
(function() {
  var MathModel;

  MathModel = (function() {

    function MathModel(containerName) {
      if (containerName != null) {
        this.container = document.getElementById(containerName);
        this.populate();
      }
    }

    MathModel.statustext = null;

    MathModel.models = 0;

    MathModel.loadedModels = 0;

    MathModel.prototype.ready = false;

    MathModel.prototype.button = null;

    MathModel.prototype.geometries = [];

    MathModel.prototype.live = false;

    MathModel.prototype.HEIGHT = 400;

    MathModel.prototype.WIDTH = 700;

    MathModel.prototype.scene = null;

    MathModel.prototype.camera = null;

    MathModel.prototype.cameraControls = null;

    MathModel.prototype.renderer = null;

    MathModel.prototype.pointLight = null;

    MathModel.prototype.shadow = false;

    MathModel.prototype.animated = true;

    MathModel.invertNormals = function(geo) {
      var face, foose, _i, _len, _ref;
      _ref = geo.faces;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        face = _ref[_i];
        foose = new THREE.Face3(face.a, face.b, face.c);
        face.a = foose.c;
        face.c = foose.a;
      }
      geo.computeFaceNormals();
      geo.computeVertexNormals();
      return null;
    };

    MathModel.prototype.preImplant = function() {};

    MathModel.prototype.getgeometry = function(i) {
      return this.geometries[i];
    };

    MathModel.prototype.setrenderer = function() {
      var self;
      self = this;
      if (Detector.webgl) {
        return self.renderer = new THREE.WebGLRenderer({
          preserveDrawingBuffer: true,
          antialias: true
        });
      } else {
        return self.renderer = new THREE.CanvasRenderer();
      }
    };

    MathModel.prototype.loader = new THREE.JSONLoader(true);

    MathModel.prototype.populate = function() {
      var self;
      self = this;
      self.scene = new THREE.Scene();
      self.scene.add(new THREE.AmbientLight(0xffffff));
      if (!self.camera) {
        self.camera = new THREE.PerspectiveCamera(45, self.WIDTH / self.HEIGHT);
        self.camera.position.set(3, 3, 3);
      }
      if (self.shadow) {
        self.renderer.shadowMapEnabled = true;
        self.renderer.shadowMapSoft = true;
        self.renderer.shadowCameraNear = 3;
        self.renderer.shadowCameraFar = self.camera.far;
        self.renderer.shadowCameraFov = 50;
        self.renderer.shadowMapBias = 0.0039;
        self.renderer.shadowMapDarkness = 1.0;
        self.renderer.shadowMapWidth = 1024;
        self.renderer.shadowMapHeight = 1024;
        self.pointLight = new THREE.SpotLight(0xffffff);
        self.pointLight.castShadow = true;
      } else {
        self.pointLight = new THREE.PointLight(0xffffff);
      }
      self.pointLight.intensity = 1;
      self.pointLight.position.set(0, 0, 100);
      self.scene.add(self.pointLight);
      self.cameraControls = new THREE.TrackballControls(self.camera, self.container);
      self.cameraControls.target.set(0, 0, 0);
      self.scene.add(self.camera);
      self.setrenderer();
      self.renderer.setSize(self.WIDTH, self.HEIGHT);
      self.renderer.domElement.style.position = "relative";
      self.container.appendChild(self.renderer.domElement);
      self.renderer.clear();
      return null;
    };

    MathModel.prototype.mathUp = function() {
      var self;
      self = this;
      return self.camera.up = new THREE.Vector3(0, 0, 1);
    };

    MathModel.prototype.addaxes = function(length) {
      var self;
      self = this;
      self.scene.add(new THREE.AxisHelper(length));
      return null;
    };

    MathModel.prototype.embed = function(file, material, doubleSide, reskin, position, rotation, shadow) {
      var doubles, implant, invertNormals, meshIndex, meshes, resk, self, shad;
      self = this;
      meshes = [];
      meshIndex = 0;
      doubles = doubleSide != null ? doubleSide : true;
      resk = reskin != null ? reskin : false;
      shad = shadow != null ? shadow : false;
      if (shad) {
        self.renderer.shadowMapEnabled = true;
      }
      invertNormals = function(geo) {
        var face, foose, _i, _len, _ref;
        _ref = geo.faces;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          face = _ref[_i];
          foose = new THREE.Face3(face.a, face.b, face.c);
          face.a = foose.c;
          face.c = foose.a;
        }
        geo.computeFaceNormals();
        geo.computeVertexNormals();
        return null;
      };
      implant = function(geometry) {
        var geo, mat, materials, _i, _len;
        self.ready = false;
        self.geometries.push(geometry);
        self.preImplant(geometry);
        if (doubles) {
          geo = geometry.clone();
          invertNormals(geo);
          THREE.GeometryUtils.merge(geometry, geo);
        }
        materials = [];
        if (resk && (geometry.materials != null)) {
          materials = geometry.materials;
        } else {
          materials = [material];
        }
        for (_i = 0, _len = materials.length; _i < _len; _i++) {
          mat = materials[_i];
          meshes[meshIndex] = new THREE.Mesh(geometry, mat);
          meshes[meshIndex].position = position != null ? position : new THREE.Vector3(0, 0, 0);
          meshes[meshIndex].rotation = rotation != null ? rotation : new THREE.Vector3(0, 0, 0);
          if (shad) {
            meshes[meshIndex].castShadow = meshes[meshIndex].receiveShadow = true;
          }
          self.scene.add(meshes[meshIndex]);
          meshIndex++;
        }
        self.init();
        return null;
      };
      return self.loader.load(file, implant);
    };

    MathModel.prototype.render = function() {
      var self;
      self = this;
      if (self.animated) {
        self.cameraControls.update();
        self.pointLight.position = self.camera.position;
      }
      self.renderer.render(self.scene, self.camera);
      return null;
    };

    MathModel.prototype.calc = function(t) {};

    MathModel.prototype.animate = function() {
      var framing, self;
      self = this;
      framing = function(t) {
        self.calc(t);
        self.render();
        if (self.live) {
          requestAnimationFrame(framing, self.container);
        }
        return null;
      };
      framing(new Date().getTime());
      return null;
    };

    MathModel.prototype.initTime = 3000;

    MathModel.prototype.renderloop = function() {
      var self;
      self = this;
      self.live = true;
      return self.animate();
    };

    MathModel.prototype.init = function() {
      var T, draw, self;
      T = new Date().getTime();
      self = this;
      draw = function(t) {
        self.render();
//        if (t < (T + self.initTime)) {
 //         requestAnimationFrame(draw, self.container);
 //       }
        return null;
      };
      draw(new Date().getTime());
      self.ready = true;
      self.live = false;
      MathModel.loadedModels += 1;
      return null;
    };

    MathModel.prototype.go = function() {
      var self;
      self = this;
      self.init();
      return null;
    };

    return MathModel;

  })();

  window.MathModel = MathModel;

}).call(this);
