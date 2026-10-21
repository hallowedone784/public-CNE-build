var topScreen:FlxSprite;
var bottomScreen:FlxSprite;
var screenText:FlxText;

function create() {
    // Housekeeping
    dad.alpha = 0;
    dad.x = (FlxG.width / 3.5);
    dad.y = (FlxG.height / 2.5);

    // Can I somehow set all 3 offsets at once?
    dad.color = FlxColor.WHITE;
    dad.colorTransform.redOffset = 255;
    dad.colorTransform.greenOffset = 255;
    dad.colorTransform.blueOffset = 255;

    dad.cameras = [camHUD];
    dad.scale.set(0.6, 0.6);
    dad.updateHitbox();
    bf.visible = false;

    // Make the boxes and stuff
    topScreen = new FlxSprite(-500, -FlxG.height/2).makeGraphic(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    topScreen.scrollFactor.set(0,0);
    insert(members.indexOf(dad), topScreen);

    bottomScreen = new FlxSprite(-500, FlxG.height/2).makeGraphic(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    bottomScreen.scrollFactor.set(0,0);
    insert(members.indexOf(dad), bottomScreen);

    screenText = new FlxText();
    screenText.x = (FlxG.width / 6);
    screenText.y = (FlxG.height / 2.5);
    screenText.scrollFactor.set(0,0);
    screenText.setFormat(Paths.font("adultswim.ttf"), 100, FlxColor.WHITE, "center");
    add(screenText);
}

function postCreate() {
    // Make the strums invisible
    cpuStrums.forEach(function(arrow:FlxSprite) {FlxTween.globalManager.cancelTweensOf(arrow);});
    playerStrums.forEach(function(arrow:FlxSprite) {FlxTween.globalManager.cancelTweensOf(arrow);});
    cpuStrums.forEach(function(arrow:FlxSprite) {arrow.alpha = 0;});
    playerStrums.forEach(function(arrow:FlxSprite) {arrow.alpha = 0;});
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 4:
            cpuStrums.forEach(function(arrow:FlxSprite) {
                var i:Int = cpuStrums.members.indexOf(arrow);
                FlxTween.tween(arrow, {alpha: 1}, 1.5, {ease: FlxEase.linear, startDelay:i*0.05});
            });
        case 5:
            playerStrums.forEach(function(arrow:FlxSprite) {
                var i:Int = playerStrums.members.indexOf(arrow);
                FlxTween.tween(arrow, {alpha: 1}, 1.5, {ease: FlxEase.linear, startDelay:i*0.05});
            });
        case 10:
            screenText.text = "[good";
            FlxTween.tween(dad, {alpha: 1}, 5, {ease: FlxEase.linear});
        case 11:
            screenText.text = "[good morning,";
        case 13:
            screenText.text = "[good morning, USA!]";
        case 77:
            topScreen.y = -FlxG.height;
            bottomScreen.y = FlxG.height;
            screenText.alpha = 0;
        // Following ones are for bad morning
        case 406:
            screenText.text = "";
        case 407:
            screenText.text = "[bad ";
        case 408:
            screenText.text = "[bad morn";
        case 409:
            screenText.text = "[bad morning]";
    }   
}

function cleanUp() {
    dad.visible = false;
    dad.cameras = [camGame];
    dad.x = 300;
    dad.y = 550;

    add(topScreen);
    add(bottomScreen);
    FlxTween.tween(topScreen, {y: -FlxG.height*1.5}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween) {remove(topScreen);}});
    FlxTween.tween(bottomScreen, {y: FlxG.height*1.5}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween) {bf.visible = true; remove(bottomScreen); dad.visible = true;}});
    screenText.alpha = 0;
}

function americanRace() {
    add(topScreen);
    add(bottomScreen);
    topScreen.cameras = [camHUD];
    bottomScreen.cameras = [camHUD];
    screenText.cameras = [camHUD];
    FlxTween.tween(topScreen, {y: -FlxG.height + 100}, 0.5, {ease: FlxEase.backOut});
    FlxTween.tween(bottomScreen, {y: FlxG.height - 100}, 0.5, {ease: FlxEase.backOut});
    FlxTween.tween(screenText, {alpha: 1}, 1, {ease: FlxEase.cubeOut});

    screenText.y = 10;
    trace(screenText.y);
    screenText.size = 40;
    screenText.text = "[and he's shining a salute to the american race!]";
    insert(members.indexOf(bottomScreen) + 1, screenText);
}

function badMorning() {
    add(topScreen);
    add(bottomScreen);
    screenText.alpha = 1;
    topScreen.y = -FlxG.height/2;
    bottomScreen.y = FlxG.height/2;

    screenText.x = (FlxG.width / 3.5);
    screenText.y = (FlxG.height / 2.5);
    screenText.setFormat(Paths.font("adultswim.ttf"), 100, FlxColor.WHITE, "center");
}

function cleanUp2() {
    add(topScreen);
    add(bottomScreen);
    FlxTween.tween(topScreen, {y: -FlxG.height*1.5}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween) {remove(topScreen);}});
    FlxTween.tween(bottomScreen, {y: FlxG.height*1.5}, 0.5, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween) {remove(bottomScreen);}});
    screenText.alpha = 0;
}