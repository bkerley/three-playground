jQuery ($)->
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera 75, window.innerWidth / window.innerHeight, 0.1, 1000
  renderer = new THREE.WebGLRenderer()
  
  renderer.setSize window.innerWidth, window.innerHeight
  renderer.shadowMapEnabled = true
  renderer.shadowMapCullFace = THREE.CullFaceBack
  document.body.appendChild renderer.domElement

  ground = new Ground scene

  cube = new Cube scene

  dirLight = new DirLight scene
  
  skyLight = new SkyLight scene  

  camera.position.z = 5

  render = ()->
    requestAnimationFrame render
    cube.render()
    renderer.render scene, camera

  render()

class Ground
  constructor: (@scene)->
    @geo = new THREE.PlaneBufferGeometry 10000, 10000
    @mat = new THREE.MeshPhongMaterial ambient: 0xffffff, color: 0xffffff, specular: 0x050505
    @mat.color.setHSL 0.095, 1, 0.75

    @mesh = new THREE.Mesh @geo, @mat
    @mesh.rotation.x = -Math.PI/2
    @mesh.position.y = -2
    @mesh.receiveShadow = true
    @scene.add @mesh

class Cube
  constructor: (@scene)->
    @geo = new THREE.BoxGeometry 1, 1, 1
    @mat = new THREE.MeshPhongMaterial
      color: 0x00ff44
      specular: 0x448844
      shininess: 20
      vertexColors: THREE.FaceColors
      shading: THREE.FlatShading

    @mesh = new THREE.Mesh @geo, @mat
    @mesh.castShadow = true
    @scene.add @mesh
  render: ()->
    @mesh.rotation.x += 0.02
    @mesh.rotation.y += 0.021

class DirLight
  constructor: (@scene)->
    @light = new THREE.DirectionalLight 0xffffff, 0.5
    @light.position.set -10, 75, 100
    @light.castShadow = true
    @light.shadowMapWidth = 2048
    @light.shadowMapHeight = 2048

    @light.shadowCameraLeft = -50
    @light.shadowCameraRight = 50
    @light.shadowCameraTop = 50
    @light.shadowCameraBottom = -50

    @light.shadowCameraFar = 3500
    @light.shadowBias = -0.0001
    @light.shadowDarkness = 0.35
  
    @scene.add @light

class SkyLight
  constructor: (@scene)->
    @skyLight = new THREE.HemisphereLight 0xaaaaff, 0x88aa88, 0.5
    @skyLight.position.set 0, 500, 0
    @scene.add @skyLight