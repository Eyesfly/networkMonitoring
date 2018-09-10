
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <style>
    body {
        font-family: Monospace;
        background-color: #000;
        color: #fff;
        margin: 0px;
        overflow: hidden;
    }
    #info {
        color: #fff;
        position: absolute;
        top: 10px;
        width: 100%;
        text-align: center;
        z-index: 100;
        display:block;
    }
    #info a, .button { color: #f00; font-weight: bold; text-decoration: underline; cursor: pointer }
    </style>


<script src="${request.contextPath}/js/three.js"></script>
<script src="${request.contextPath}/js/OBJLoader.js"></script>
    <div id="3d" name="3d" style="width: 100%; height: 400px;"></div>
<script>

    var container;

    var camera, scene, renderer;

    var mouseX = 281, mouseY = 91;
    container = document.getElementById('3d');
    var windowHalfX = window.innerWidth / 2;
    var windowHalfY = container.clientHeight / 2;


    init();
    animate();


    function init() {

//        container = document.createElement( 'div' );

//        document.body.appendChild( container );

        camera = new THREE.PerspectiveCamera( 105, container.clientWidth / container.clientHeight, 1, 2000 );
        camera.position.z = 250;
//        camera.position.x = -250;

        // scene

        scene = new THREE.Scene();

        var ambientLight = new THREE.AmbientLight( 0xcccccc, 0.4 );
        scene.add( ambientLight );

        var pointLight = new THREE.PointLight( 0xffffff, 0.8 );
        camera.add( pointLight );
        scene.add( camera );

        // texture

        var manager = new THREE.LoadingManager();
        manager.onProgress = function ( item, loaded, total ) {

            console.log( item, loaded, total );

        };

        var textureLoader = new THREE.TextureLoader( manager );
//        var texture = textureLoader.load( 'textures/UV_Grid_Sm.jpg' );

        // model

        var onProgress = function ( xhr ) {
            if ( xhr.lengthComputable ) {
                var percentComplete = xhr.loaded / xhr.total * 100;
                console.log( Math.round(percentComplete, 2) + '% downloaded' );
            }
        };

        var onError = function ( xhr ) {
        };

        var loader = new THREE.OBJLoader( manager );
        loader.load( '${request.contextPath}/images/WDS.obj', function ( object ) {

           /* object.traverse( function ( child ) {

                if ( child instanceof THREE.Mesh ) {

                    child.material.map = texture;

                }
            } );*/

            object.position.y = - 55;
            scene.add( object );

        }, onProgress, onError );

        //

        renderer = new THREE.WebGLRenderer();
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, container.clientHeight );
        renderer.setClearColor( 0x154E90 );
//        renderer.setViewport ( 20, 20, window.innerWidth-40, window.innerHeight-40 );
        container.appendChild( renderer.domElement );

        container.addEventListener( 'mousemove', onDocumentMouseMove, false );

        //

        window.addEventListener( 'resize', onWindowResize, false );

    }

    function onWindowResize() {

        windowHalfX = window.innerWidth / 2;
        windowHalfY = window.innerHeight / 2;

        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();

        renderer.setSize( window.innerWidth, window.innerHeight );

    }

    function onDocumentMouseMove( event ) {

        mouseX = ( event.clientX - windowHalfX ) / 2;
        mouseY = ( event.clientY - windowHalfY ) / 2;
    }

    //

    function animate() {

        requestAnimationFrame( animate );
        render();

    }

    function render() {

        camera.position.x += ( mouseX - camera.position.x ) * .05;
        camera.position.y += ( - mouseY - camera.position.y ) * .05;

        camera.lookAt( scene.position );

        renderer.render( scene, camera );

    }

</script>
