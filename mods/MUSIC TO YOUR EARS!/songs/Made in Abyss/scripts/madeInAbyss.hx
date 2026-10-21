// housekeeping
// stuff
var phaseScreen:FlxSprite;
var phaseText:FlxText;
var flavorText:FlxText;
var camEnemy:FlxCamera;
var camPlayer:FlxCamera;
var sudoCamHud:FlxCamera;
// characters
var finn = strumLines.members[0].characters[0];
var jake = strumLines.members[0].characters[1];
var pibby = strumLines.members[1].characters[0];

function create() {
    jake.visible = false;
    finn.y = 250;
    pibby.x = 1000;
    pibby.y = 420;
}

// phase mechanic
function phaseMode(textOne:String, goal:String) {
    if (textOne == "clear" || goal == "clear") {
        trace("clear!");
        remove(phaseScreen);
        remove(phaseText);
        remove(flavorText);
    } else {
    phaseScreen = new FlxSprite(0,0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    phaseScreen.cameras = [camHUD];
    add(phaseScreen);

    phaseText = new FlxText(0, FlxG.height/2 - 25, FlxG.width);
    phaseText.cameras = [camHUD];
    phaseText.text = "[PHASE " + textOne + "]";
    phaseText.setFormat(Paths.font("adultswim.ttf"), 100, FlxColor.WHITE, "center");
    add(phaseText);

    flavorText = new FlxText(0, phaseText.y - 50, FlxG.width);
    flavorText.cameras = [camHUD];
    flavorText.text = "[" + goal + "]";
    flavorText.setFormat(Paths.font("adultswim.ttf"), 50, FlxColor.WHITE, "center");
    add(flavorText);
    }
}

// splitscreen mechanic
// didn't bother implementing this because it's complicated, but it's a test demo!
// it works! technically! it looks hella weird and doesn't render camHUD
// if i can get camHUD to render over it then maybe i'll implement it
function splitScreen() {
    // camera setup
    player.cpu = true;
    camEnemy = new FlxCamera(-FlxG.width/2, 0, FlxG.width/2, FlxG.height);
    camPlayer = new FlxCamera(FlxG.width, 0, FlxG.width / 2, FlxG.height);
    sudoCamHud = new FlxCamera(0, 0, FlxG.width, FlxG.height);
    camEnemy.bgColor = 0x00000000;
    camPlayer.bgColor = 0x00000000;
    sudoCamHud.bgColor = 0x00000000;
    FlxG.cameras.add(camEnemy, false);
    FlxG.cameras.add(camPlayer, false);
    FlxG.cameras.add(sudoCamHud, false);

    finn.cameras = [camEnemy];
    pibby.cameras = [camPlayer];

    // Render stage stuff on split screen
    for (obj in members) {
        if (Std.isOfType(obj, FlxSprite)) {
            // Only add to cams if it's NOT a hud element
            if (obj.cameras == null || !obj.cameras.contains(camHUD)) {
                obj.cameras = [camEnemy, camPlayer];
            } 
        }
    }

    // Render arrows on camHUD
    for (line in strumLines.members) {
        line.cameras = [sudoCamHud];
        // Make sure notes move
        line.notes.forEach(function(note:Note) {
            note.cameras = [sudoCamHud];
        });
    }

    var finnCamTarget = new FlxSprite(finn.getMidpoint().x - 50, finn.getMidpoint().y - 50);
    var pibbyCamTarget = new FlxSprite(pibby.getMidpoint().x - 150, pibby.getMidpoint().y - 279);
    add(pibbyCamTarget);
    
    camEnemy.follow(finnCamTarget, "LOCKON");
    camPlayer.follow(pibbyCamTarget, "LOCKON");

    updateStrumLineSpeed(4);

    FlxTween.tween(camEnemy, {x:0}, 0.2, {ease: FlxEase.sineOut, onComplete: function(twn:FlxTween) {
        FlxTween.tween(camPlayer, {x:FlxG.width/2}, 0.2, {ease: FlxEase.quartIn, onComplete: function(twn:FlxTween) {
            var splitBorder:FlxSprite = new FlxSprite(0, -150).makeGraphic(20, FlxG.height*1.5, FlxColor.BLACK);
            splitBorder.x = (FlxG.width / 2) - splitBorder.width;
            splitBorder.angle = 5;
            splitBorder.cameras = [sudoCamHud];
            add(splitBorder);
        }});
        trace("split screen!");
    }});
    camGame.visible = false;
}

function updateStrumLineSpeed(targetSpeed:Int) {
    for (line in strumLines.members) {
        scrollSpeed = targetSpeed;
        trace("speed updated to " + targetSpeed);
    }
}