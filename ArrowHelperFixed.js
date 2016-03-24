/**
 * @author WestLangley / http://github.com/WestLangley
 * @author zz85 / https://github.com/zz85
 *
 * Creates an arrow for visualizing directions
 *
 * Parameters:
 *  dir - Vector3
 *  origin - Vector3
 *  length - Number
 *  hex - color in hex value
 */

THREE.ArrowHelper = function ( dir, origin, length, hex ) {

    THREE.Object3D.call( this );

    if ( hex === undefined ) hex = 0xffff00;
    if ( length === undefined ) length = 20;

    var lineGeometry = new THREE.Geometry();
    lineGeometry.vertices.push( new THREE.Vector3( 0, 0, 0 ) );
    lineGeometry.vertices.push( new THREE.Vector3( 0, 1, 0 ) );

    this.line = new THREE.Line( lineGeometry, new THREE.LineBasicMaterial( { color: hex } ) );
    this.add( this.line );

    var coneGeometry = new THREE.CylinderGeometry( 0, 0.05, 0.25, 5, 1 );

    this.cone = new THREE.Mesh( coneGeometry, new THREE.MeshBasicMaterial( { color: hex } ) );
    this.cone.position.set( 0, 0.88, 0 );
    this.add( this.cone );

    if ( origin instanceof THREE.Vector3 ) this.position = origin;

//    this.direction = new THREE.Vector3(dir.x, dir.y, dir.z).normalize();

    this.setDirection( dir );
    this.setLength( length );

};

THREE.ArrowHelper.prototype = Object.create( THREE.Object3D.prototype );

THREE.ArrowHelper.prototype.setDirection = function ( dir ) {

    var axis = new THREE.Vector3( 0, 1, 0 ).crossSelf( dir );

    var radians = Math.acos( new THREE.Vector3( 0, 1, 0 ).dot( dir.clone().normalize() ) );

    this.matrix = new THREE.Matrix4().makeRotationAxis( axis.normalize(), radians );

    this.rotation.setEulerFromRotationMatrix( this.matrix, this.eulerOrder );

};

THREE.ArrowHelper.prototype.setLength = function ( length ) {

    this.scale.set( length, length, length );

    var ver0 = this.line.geometry.vertices[0];
    var ver1 = this.line.geometry.vertices[1];
    var direction = new THREE.Vector3(ver1.x-ver0.x, ver1.y-ver0.y, ver1.z-ver0.z).normalize().multiplyScalar(0.12);

    var dir = new THREE.Vector3(ver1.x - 0.12 * direction.x,
                                ver1.y - 0.12 * direction.y,
                                ver1.z - 0.12 * direction.z);


    var cone_adjuster = 1.0;
    if (length != 0){
       cone_adjuster = 1.0 / length;
    }

    this.cone.scale.set(cone_adjuster, cone_adjuster, cone_adjuster);

    this.cone.position.set(dir.x, dir.y, dir.z);

    //this.cone.applyMatrix(new THREE.Matrix4().makeTranslation(that.direction));
};

THREE.ArrowHelper.prototype.setColor = function ( hex ) {

    this.line.material.color.setHex( hex );
    this.cone.material.color.setHex( hex );

};