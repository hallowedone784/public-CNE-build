/*
this is where all the miscellaneous code goes, stuff that doesn't pertain to specific mechanics and the like
most stuff here should be accessible by all the other scripts unless never necessary
*/
private var darkScreen:FlxSprite;
private var backgroundDim:FlxSprite; // easier to make it a clone than to keep tweening darkScreen like i did in playtime's end
private var dreamEnergy:FlxSprite; // dream energy decal

function create() {
    darkScreen = new FlxSprite(0, 0).makeGraphic(FlxG.width*4, FlxG.height*5, FlxColor.BLACK);
    darkScreen.alpha = 0;
    darkScreen.cameras = [camHUD];
    add(darkScreen);

    backgroundDim = new FlxSprite(-500, 0).makeGraphic(FlxG.width*4, FlxG.height*5, FlxColor.BLACK);
    backgroundDim.alpha = 0;
    backgroundDim.cameras = [camGame];
    insert(members.indexOf(ollie) - 1, backgroundDim);

    dreamEnergy = new FlxSprite();
    dreamEnergy.alpha = 0;
    dreamEnergy.scale.set(0.65, 0.65);
    dreamEnergy.loadGraphic(Paths.image("songs/anemaniac/dreamenergy"));
    dreamEnergy.cameras = [camGame];
    insert(members.indexOf(ollie) - 1, dreamEnergy);
}
function postCreate() {
    // quick camera reset
    camGame.zoom = 0.7;
}
function beatHit(curBeat:Int) {
    switch (curBeat) {
        // intro segment
        // ollie's notes fade away here, and bendy's move to the middle
        case 10:
            strumLines.members[0].forEach(function(spr:FlxSprite) {
                FlxTween.tween(spr, {alpha: 0}, (Conductor.crochet/1000)*3, {ease: FlxEase.cubeOut});
            });            
            new FlxTimer().start((Conductor.crochet/1000)*3, function(tmr:FlxTimer) {
                strumLines.members[0].visible = false;
            });
            

        case 18:
            strumLines.members[1].forEach(function(spr:FlxSprite) {
                var noteSpacing:Float = 112;
                var targetX:Float = (FlxG.width/2) - (noteSpacing * 2) + (spr.ID * noteSpacing);
                FlxTween.tween(spr, {x: targetX}, (Conductor.crochet/1000)*3, {ease: FlxEase.quadInOut});
            });


        case 21:
            FlxTween.tween(darkScreen, {alpha: 1}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});

        case 24:
            darkScreen.alpha = 0;

        case 56:
            characterFocus("bendy");

        case 68:
            FlxTween.tween(darkScreen, {alpha: 1}, Conductor.crochet/1000, {ease: FlxEase.circOut});
        
        case 75:
            darkScreen.alpha = 0;
            characterFocus("restore");
    }
}

function measureHit(curMeasure:Int) {
    if (curMeasure >= 26 && curMeasure % 2 == 0 && curMeasure < 74) dreamPulse(1.1);
    if (curMeasure >= 80 && curMeasure <= 112) dreamPulse(0.5);
}

public function dreamPulse(time:Int) {
    dreamEnergy.x = ollie.x;
    dreamEnergy.y = ollie.y + 375;
    dreamEnergy.alpha = 1;
    var speed:Float = 250;
    var randomAngle:Float = FlxG.random.float(0, 360);
    dreamEnergy.velocity.setPolarDegrees(speed, randomAngle);
    dreamEnergy.angularVelocity = 90;
    FlxTween.tween(dreamEnergy, {alpha: 0}, time, {ease: FlxEase.backIn});
}

public function characterFocus(char:FlxString) {
    // tween backgroundDim behind character
    // tween other character to be somewhat transparent
    if (char == "ollie") {
        FlxTween.tween(backgroundDim, {alpha: 0.75}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(bendy, {alpha: 0.25}, 0.5, {ease: FlxEase.circOut});
    } else if (char == "bendy") {
        FlxTween.tween(backgroundDim, {alpha: 0.75}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(ollie, {alpha: 0.25}, 0.5, {ease: FlxEase.circOut});
    } else if (char == "restore") {
        FlxTween.tween(backgroundDim, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(ollie, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        FlxTween.tween(bendy, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    }
} 

/*
todo:
- code notes floating around idly during first section, bopping aggressively in second section
- MAYBE code in a now playing module?
- fix zooms prolly
*/