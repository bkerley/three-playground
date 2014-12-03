(function() {
  var Cube, DirLight, Ground, SkyLight;

  jQuery(function($) {
    var camera, cube, dirLight, ground, render, renderer, scene, skyLight;
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.shadowMapEnabled = true;
    renderer.shadowMapCullFace = THREE.CullFaceBack;
    document.body.appendChild(renderer.domElement);
    ground = new Ground(scene);
    cube = new Cube(scene);
    dirLight = new DirLight(scene);
    skyLight = new SkyLight(scene);
    camera.position.z = 5;
    render = function() {
      requestAnimationFrame(render);
      cube.render();
      return renderer.render(scene, camera);
    };
    return render();
  });

  Ground = (function() {
    function Ground(scene) {
      this.scene = scene;
      this.geo = new THREE.PlaneBufferGeometry(10000, 10000);
      this.mat = new THREE.MeshPhongMaterial({
        ambient: 0xffffff,
        color: 0xffffff,
        specular: 0x050505
      });
      this.mat.color.setHSL(0.095, 1, 0.75);
      this.mesh = new THREE.Mesh(this.geo, this.mat);
      this.mesh.rotation.x = -Math.PI / 2;
      this.mesh.position.y = -2;
      this.mesh.receiveShadow = true;
      this.scene.add(this.mesh);
    }

    return Ground;

  })();

  Cube = (function() {
    function Cube(scene) {
      this.scene = scene;
      this.geo = new THREE.BoxGeometry(1, 1, 1);
      this.mat = new THREE.MeshPhongMaterial({
        color: 0x00ff44,
        specular: 0x448844,
        shininess: 20,
        vertexColors: THREE.FaceColors,
        shading: THREE.FlatShading
      });
      this.mesh = new THREE.Mesh(this.geo, this.mat);
      this.mesh.castShadow = true;
      this.scene.add(this.mesh);
    }

    Cube.prototype.render = function() {
      this.mesh.rotation.x += 0.02;
      return this.mesh.rotation.y += 0.021;
    };

    return Cube;

  })();

  DirLight = (function() {
    function DirLight(scene) {
      this.scene = scene;
      this.light = new THREE.DirectionalLight(0xffffff, 0.5);
      this.light.position.set(-10, 75, 100);
      this.light.castShadow = true;
      this.light.shadowMapWidth = 2048;
      this.light.shadowMapHeight = 2048;
      this.light.shadowCameraLeft = -50;
      this.light.shadowCameraRight = 50;
      this.light.shadowCameraTop = 50;
      this.light.shadowCameraBottom = -50;
      this.light.shadowCameraFar = 3500;
      this.light.shadowBias = -0.0001;
      this.light.shadowDarkness = 0.35;
      this.scene.add(this.light);
    }

    return DirLight;

  })();

  SkyLight = (function() {
    function SkyLight(scene) {
      this.scene = scene;
      this.skyLight = new THREE.HemisphereLight(0xaaaaff, 0x88aa88, 0.5);
      this.skyLight.position.set(0, 500, 0);
      this.scene.add(this.skyLight);
    }

    return SkyLight;

  })();

}).call(this);
