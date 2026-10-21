/**
 * The global camera offset intensity when the characters sing.
 */
public var camOffsetAmount:Float = 75;


/**
 * If you want to remove the camera offset movement, set this to `true`.
 */
public var disableCameraOffset:Bool = false;


/**
 * This is only for the HScript Call event. Change `camOffsetAmount` for script use.
 */
public function setCameraOffsetAmount(newAmount:String) {
	camOffsetAmount = Std.parseFloat(newAmount) ?? 0;
}


/**
 * If you have a custom character that you want to track, run this.
 *
 *	@param	camTargetID				The ID that curCameraTarget has to be on in order to move the camera.
 *	@param	character				The character object to check animations. If this function is ran again
 *									with the same character, it will override the original camera data.
 *	@param	uniqueCamOffsetAmount	Set a custom camOffsetAmount when this character sings. If you don't want
 *									the character to have a unique amount, set this to `null`.
 */
public function registerCameraCharacter(camTargetID:Int, character:Character, ?uniqueCamOffsetAmount:Null<Float>) {
	registeredCharacters.set(character, {id: camTargetID, camOffset: uniqueCamOffsetAmount ?? null});
}

/* Backend */

/*
function postCreate() {
	registerCameraCharacter(0, dad, 50);
	registerCameraCharacter(1, boyfriend, 10);
	registerCameraCharacter(2, gf, 20);
}
*/

function _updateCamOffset(character:Character, camIntensity:Float) {
	//TODO: Add support for custom animation checks
	switch (character?.animation?.curAnim?.name) {
		case 'singLEFT' | 'singLEFT-alt': camFollow.x -= camIntensity;
		case 'singRIGHT' | 'singRIGHT-alt': camFollow.x += camIntensity;
		case 'singUP' | 'singUP-alt': camFollow.y -= camIntensity;
		case 'singDOWN' | 'singDOWN-alt': camFollow.y += camIntensity;
		default: //nothing
	}
}

var registeredCharacters:Map<Character, Dynamic> = [];
function postUpdate(elapsed:Float) {
	if(disableCameraOffset) return;

	switch (curCameraTarget) {
		case CameraTarget.OPPONENT: _updateCamOffset(dad, camOffsetAmount);
		case CameraTarget.BOYFRIEND: _updateCamOffset(boyfriend, camOffsetAmount);
		case CameraTarget.GIRLFRIEND: _updateCamOffset(gf, camOffsetAmount);
		default: 
			for(char => camTar in registeredCharacters) {
				if(camTar.id == curCameraTarget) {
					_updateCamOffset(char, camTar.camOffset ?? camOffsetAmount);
					break;
				}
			}
	}
}

/* Fake Abstract */
final CameraTarget = {
	BOYFRIEND: 1,
	OPPONENT: 0,
	GIRLFRIEND: 2
}