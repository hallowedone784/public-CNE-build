var screenDark:FlxSprite;
function create() {
    gf.alpha = 0;
    // Steve positioning code cuz he won't position properly for some reason.   
    gf.x = 1350;
    gf.y = 650;
    remove(gf);
    insert(members.indexOf(bf), gf); // Make sure they're added on the layer behind bf

    // steve arrow code
    strumLines.members[2].visible = false;
    strumLines.members[2].forEach(function(i) {i.alpha = 0;});

    // dark screen code
    screenDark = new FlxSprite(-500, 0).makeGraphic(FlxG.width*2, FlxG.height*2, FlxColor.BLACK);
    screenDark.alpha = 0;
    screenDark.cameras = [camHUD];
    add(screenDark);
}

function screenDim(amount:Float) { // Point of this code is to dim the screen
    screenDark.cameras = [camHUD];
    screenDark.x = -500;
    screenDark.y = 0;
    add(screenDark);
    screenDark.alpha = amount;
    trace(screenDark.alpha);
}

function screenEndDim() { // yes i could have consolidated this with screenDim. sue me
    screenDark.cameras = [camHUD];
    screenDark.x = -500;
    screenDark.y = 0;
    add(screenDark);
    screenDark.alpha = 0;
    FlxTween.tween(screenDark, {alpha: 1}, 3, {ease: FlxEase.cubeIn});

    // Fade out cpu notes
    cpuStrums.forEach(function(arrow:FlxSprite) {
                var i:Int = cpuStrums.members.indexOf(arrow);
                FlxTween.tween(arrow, {alpha: 0}, 1.5, {ease: FlxEase.linear, startDelay:i*0.05});
            });
    
    // Fade out player notes
    playerStrums.forEach(function(arrow:FlxSprite) {
                var i:Int = playerStrums.members.indexOf(arrow);
                FlxTween.tween(arrow, {alpha: 0}, 1.5, {ease: FlxEase.linear, startDelay:i*0.05});
            });
}

// Add code to make Steve visible at that one part I was going to code in, where it fades to black with bf being white as Steve slowly fades in next to bf.
function steveSummon(clean:String) {
    if (clean == "true") {
        remove(screenDark);
        bf.colorTransform.redOffset = 0;
        bf.colorTransform.greenOffset = 0;
        bf.colorTransform.blueOffset = 0;

        gf.colorTransform.redOffset = 0;
        gf.colorTransform.greenOffset = 0;
        gf.colorTransform.blueOffset = 0;
    }
    else {
        screenDark.cameras = [camGame];
        screenDark.x = 400;
        screenDark.y = 375;
        remove(screenDark);
        insert(members.indexOf(gf), screenDark);
        screenDark.width = FlxG.width*4;
        screenDark.updateHitbox();
        FlxTween.tween(screenDark, {alpha: 1}, 0.5, {ease: FlxEase.cubeOut});

        bf.color = FlxColor.WHITE;
        FlxTween.tween(bf.colorTransform, {redOffset: 255}, 0.5, {ease: FlxEase.cubeOut});
        FlxTween.tween(bf.colorTransform, {greenOffset: 255}, 0.5, {ease: FlxEase.cubeOut});
        FlxTween.tween(bf.colorTransform, {blueOffset: 255}, 0.5, {ease: FlxEase.cubeOut});

        gf.color = FlxColor.WHITE;
        gf.colorTransform.redOffset = 255;
        gf.colorTransform.greenOffset = 255;
        gf.colorTransform.blueOffset = 255;

        FlxTween.tween(gf, {alpha: 1}, 7, {ease: FlxEase.sineIn});    
        strumLines.members[2].camera = camGame;
        strumLines.members[2].visible = true;
        for (i in strumLines.members[2]){
            i.alpha = 0;
            i.x = i.x + 500; // Can't make this relative cuz otherwise they'll stack
            i.y = gf.y - 175;
            i.scrollFactor.set(1,1);
            FlxTween.tween(i, {alpha: 0.8}, 7, {ease: FlxEase.sineIn});
        }
    }
}

function postUpdate(Elapsed:Float) {
    strumLines.members[2].notes.forEach(function(note) {
        if (note.y < gf.y + 75) {
            FlxTween.tween(note, {alpha: 0.8}, 0.2, {ease: FlxEase.cubeOut});
        } else {
            note.alpha = 0;
        }
    });
}

// I might tween the notes so they reach the strumline with a different tween (cubic or something)?
// Regardless, only one more thing left to code and then I just have to chart the rest of this