(function() {
  var MathModel;

  MathModel = (function() {

    function MathModel() {}

    MathModel.prototype.button = null;

    MathModel.prototype.container = null;

    MathModel.prototype.live = false;

    MathModel.prototype.HEIGHT = 400;

    MathModel.prototype.WIDTH = 700;

    MathModel.prototype.scene = null;

    MathModel.prototype.camera = null;

    MathModel.prototype.cameraControls = null;

    MathModel.prototype.renderer = null;

    MathModel.prototype.pointLight = null;

    MathModel.prototype.setrenderer = function() {
      var self;
      self = this;
      if (Detector.webgl) {
        return self.renderer = new THREE.WebGLRenderer();
      } else {
        return self.renderer = new THREE.CanvasRenderer();
      }
    };

    MathModel.prototype.loader = new THREE.JSONLoader();

    MathModel.prototype.populate = function() {
      var self;
      self = this;
      self.scene = new THREE.Scene();
      self.camera = new THREE.PerspectiveCamera(45, self.WIDTH / self.HEIGHT, 1, 10000);
      self.cameraControls = new THREE.TrackballControls(self.camera, self.container);
      self.scene.add(self.camera);
      self.scene.add(new THREE.AmbientLight(0xffffff));
      self.pointLight = new THREE.PointLight(0xffffff);
      self.pointLight.intensity = 1;
      self.pointLight.position.set(0, 0, 100);
      self.scene.add(self.pointLight);
      self.setrenderer();
      self.renderer.setSize(self.WIDTH, self.HEIGHT);
      self.renderer.domElement.style.position = "relative";
      self.container.appendChild(self.renderer.domElement);
      self.renderer.clear();
      return null;
    };

    MathModel.prototype.addaxes = function(length) {
      var linex, linexGeo, linexMat, liney, lineyGeo, lineyMat, linez, linezGeo, linezMat, self, v;
      self = this;
      v = function(x, y, z) {
        return new THREE.Vertex(new THREE.Vector3(x, y, z));
      };
      linexGeo = new THREE.Geometry();
      linexGeo.vertices.push(v(0, 0, 0));
      linexGeo.vertices.push(v(length, 0, 0));
      linexMat = new THREE.LineBasicMaterial({
        color: 0xff0000
      });
      linex = new THREE.Line(linexGeo, linexMat);
      linex.type = THREE.Lines;
      lineyGeo = new THREE.Geometry();
      lineyGeo.vertices.push(v(0, 0, 0));
      lineyGeo.vertices.push(v(0, length, 0));
      lineyMat = new THREE.LineBasicMaterial({
        color: 0x00ff00
      });
      liney = new THREE.Line(lineyGeo, lineyMat);
      liney.type = THREE.Lines;
      linezGeo = new THREE.Geometry();
      linezGeo.vertices.push(v(0, 0, 0));
      linezGeo.vertices.push(v(0, 0, length));
      linezMat = new THREE.LineBasicMaterial({
        color: 0x0000ff
      });
      linez = new THREE.Line(linezGeo, linezMat);
      linez.type = THREE.Lines;
      self.scene.add(linex);
      self.scene.add(liney);
      self.scene.add(linez);
      return null;
    };

    MathModel.prototype.embed = function(file, material) {
      var implant, self;
      self = this;
      implant = function(geometry) {
        var mesh;
        mesh = new THREE.Mesh(geometry, material);
        mesh.rotation.set(Math.PI / 2, 0, 0);
        mesh.position.set(0, 0, 0);
        self.scene.add(mesh);
        return null;
      };
      self.loader.load(file, implant);
      return null;
    };

    MathModel.prototype.embeddae = function(file, material) {
      var implant, loadae, self;
      self = this;
      loadae = new THREE.ColladaLoader();
      implant = function(collada) {
        var model;
        model = collada.scene;
        model.rotation.set(-Math.PI / 2, 0, 0);
        self.scene.add(model);
        return null;
      };
      loadae.load(file, implant);
      return null;
    };

    MathModel.prototype.render = function() {
      var self;
      self = this;
      self.cameraControls.update();
      self.pointLight.position = self.camera.position;
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
        if (self.live) requestAnimationFrame(framing, self.container);
        return null;
      };
      framing(new Date().getTime());
      return null;
    };

    MathModel.prototype.init = function() {
      var T, draw, self;
      T = new Date().getTime();
      self = this;
      draw = function(t) {
        self.render();
        if (t < (T + 3000)) requestAnimationFrame(draw, self.container);
        return null;
      };
      draw(new Date().getTime());
      return null;
    };

    MathModel.prototype.go = function() {
      var self;
      self = this;
      self.button.submit(function() {
        self.live = !self.live;
        if (self.live) {
          self.button.find(":submit").attr("value", "stop");
        } else {
          self.button.find(":submit").attr("value", "start");
        }
        self.animate();
        self.button.parent().parent().focus();
        return false;
      });
      $(window).keydown(function(event) {
        if (event.keyCode === 76) {
          self.live = false;
          self.button.find(":submit").attr("value", "start");
          return null;
        }
      });
      return null;
    };

    return MathModel;

  })();

  window.MathModel = MathModel;

}).call(this);
