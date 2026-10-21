// recoded split screen mechanic
// persistent variables
// all credits go to orgablorg, all code was written by him
// made originally with Playtime's End in mind
var camEnemy:FlxCamera = null;
var camPlayer:FlxCamera = null;
var enemyTarget:FlxSprite = null;
var playerTarget:FlxSprite = null;

function onEvent(event) {
    if (event.event.name != "Split Screen") return;

    // local variables & checks
    var leftLine = strumLines.members[event.event.params[0]]; // points to strumLines.members[0]
    var rightLine = strumLines.members[event.event.params[1]];
    var duration = event.event.params[2];
    var delay = event.event.params[3];
    var leftXOffset = event.event.params[4];
    var leftYOffset = event.event.params[5];
    var rightXOffset = event.event.params[6];
    var rightYOffset = event.event.params[7];
    var stopSplitscreen = event.event.params[8];
    
    if (leftLine == null || rightLine == null) return; // this is important, otherwise it throws nullObjectRefrence or nullFunctionPointer

    var leftChar = leftLine?.characters[0]; // for simplicity's sake. might make this changeable later
    var rightChar = rightLine?.characters[0];

    // handle closing
    if (stopSplitscreen)
    {
        if (camEnemy != null && camPlayer != null)
        {
            FlxTween.tween(camEnemy, {x:-FlxG.width/2}, duration, {ease: FlxEase.sineOut});
            FlxTween.tween(camPlayer, {x:FlxG.width}, duration, {
                ease: FlxEase.sineOut,
                onComplete: function(twn:FlxTween) {
                    // clean up after transitions finish (parents every character to camGame)
                    for (line in strumLines.members) {
                        for (char in line.characters) {
                            char.cameras = [camGame];
                        }
                    }

                    FlxG.cameras.remove(camEnemy);
                    FlxG.cameras.remove(camPlayer);

                    enemyTarget?.destroy();
                    playerTarget?.destroy();

                    camEnemy = null;
                    camPlayer = null;
                }
            });
        }
        return;
    }

    /* current state
        - added handling just in case you want to switch splitscreen characters on the fly
        - credits to swagaruney for the reminder
        - you da goat
    */

    // handle switching on the fly
    var isAlreadyActive = (camEnemy != null && camPlayer != null);
    if (!isAlreadyActive) {
        // camera setup
        camEnemy = new FlxCamera(-FlxG.width/2, 0, FlxG.width/2, FlxG.height);
        camPlayer = new FlxCamera(FlxG.width, 0, FlxG.width / 2, FlxG.height);
        
        FlxG.cameras.insert(camEnemy, FlxG.cameras.list.indexOf(camGame) + 1);
        FlxG.cameras.insert(camPlayer, FlxG.cameras.list.indexOf(camGame) + 1);

        enemyTarget = new FlxSprite(leftChar.getMidpoint().x - leftXOffset, leftChar.getMidpoint().y - leftYOffset);
        playerTarget = new FlxSprite(rightChar.getMidpoint().x - rightXOffset, rightChar.getMidpoint().y - rightYOffset);

        camEnemy.follow(enemyTarget, "LOCKON");
        camPlayer.follow(playerTarget, "LOCKON");
    }
    
    if (leftChar != null) leftChar.cameras = [camEnemy]; 
    if (rightChar != null) rightChar.cameras = [camPlayer];

    // make the zoom adjustable later
    camEnemy.zoom = 0.8;
    camPlayer.zoom = 0.7;
        
    // modify where the cameras are focused through offsets
    // POTENTIAL REWORK: turn the camera offsets into two sets of strings, parse through strings  and apply them

    /*
    so something i wanted to add into the code is the idea of cutting off the cameras past the image line (the 'border')
    and then i wanted to add an event that let you adjust the border mid-segment to make it seem like a character has an advantage
    gotta figure out the logic for that however
    */   

    if (isAlreadyActive) {
        FlxTween.tween(enemyTarget, {x: leftChar.getMidpoint().x - leftXOffset, y: leftChar.getMidpoint().y - leftYOffset}, duration, {ease: FlxEase.cubeOut});
        FlxTween.tween(playerTarget, {x: rightChar.getMidpoint().x - rightXOffset, y: rightChar.getMidpoint().y - rightYOffset}, duration, {ease: FlxEase.cubeOut});
    } else {
        enemyTarget.setPosition(leftChar.getMidpoint().x - leftXOffset, leftChar.getMidpoint().y - leftYOffset);
        playerTarget.setPosition(rightChar.getMidpoint().x - rightXOffset, rightChar.getMidpoint().y - rightYOffset);

        if (delay) {
            FlxTween.tween(camEnemy, {x:0}, duration, {ease: FlxEase.sineIn, onComplete: function(twn:FlxTween) {
            FlxTween.tween(camPlayer, {x:FlxG.width/2}, duration, {ease: FlxEase.sineIn});
            }}); 
        } else {
            FlxTween.tween(camEnemy, {x:0}, duration, {ease: FlxEase.circOut});
            FlxTween.tween(camPlayer, {x:FlxG.width/2}, duration, {ease: FlxEase.circOut});
        }
    }

    // debugging
    trace(FlxG.cameras.list.indexOf(camPlayer));
    trace(FlxG.cameras.list.indexOf(camEnemy));
}
