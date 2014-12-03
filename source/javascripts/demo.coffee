jQuery ($)->
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 0.1, 1000
  renderer = new THREE.WebGLRenderer()
  
  renderer.setSize window.innerWidth, window.innerHeight
  renderer.shadowMapEnabled = true
  renderer.shadowMapCullFace = THREE.CullFaceBack
  document.body.appendChild renderer.domElement

  groundGeo = new THREE.PlaneBufferGeometry 10000, 10000
  groundMat = new THREE.MeshPhongMaterial ambient: 0xffffff, color: 0xffffff, specular: 0x050505
  groundMat.color.setHSL 0.095, 1, 0.75

  ground = new THREE.Mesh groundGeo, groundMat
  ground.rotation.x = -Math.PI/2
  ground.position.y = -5
  ground.receiveShadow = true
  scene.add ground

  geometry = new THREE.BoxGeometry 1, 1, 1
  material = new THREE.MeshPhongMaterial
    color: 0x00ff44
    specular: 0x448844
    shininess: 20
    vertexColors: THREE.FaceColors
    shading: THREE.FlatShading

  cube = new THREE.Mesh geometry, material
  cube.castShadow = true
  cube.receiveShadow = true
  scene.add cube

  dirLight = new THREE.DirectionalLight 0xffffff, 0.5
  dirLight.position.set -10, 75, 100
  dirLight.castShadow = true
  dirLight.shadowMapWidth = 2048
  dirLight.shadowMapHeight = 2048

  dirLight.shadowCameraLeft = -50
  dirLight.shadowCameraRight = 50
  dirLight.shadowCameraTop = 50
  dirLight.shadowCameraBottom = -50

  dirLight.shadowCameraFar = 3500
  dirLight.shadowBias = -0.0001
  dirLight.shadowDarkness = 0.35
  
  scene.add dirLight
  
  skyLight = new THREE.HemisphereLight 0xaaaaff, 0x88aa88, 0.5
  skyLight.position.set 0, 500, 0
  scene.add skyLight

  camera.position.z = 5

  render = ()->
    requestAnimationFrame render
    cube.rotation.x += 0.1
    cube.rotation.y += 0.01
    renderer.render scene, camera

  render()