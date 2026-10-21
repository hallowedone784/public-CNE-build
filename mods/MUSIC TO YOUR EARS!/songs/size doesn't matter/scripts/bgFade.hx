var blackScreen:FlxSprite;
var screenText:FlxText;
function create() {
    blackScreen = new FlxSprite(-500, -500).makeGraphic(FlxG.width*2, FlxG.height*2, FlxColor.BLACK);
    blackScreen.scrollFactor.set(0,0);
    blackScreen.alpha = 0;
    add(blackScreen);

    screenText = new FlxText();
    screenText.text = "[not yet.]";
    screenText.scrollFactor.set(0,0);
    screenText.setFormat(Paths.font("adultswim.ttf"), 100, FlxColor.WHITE, "center");
    screenText.alpha = 0;

    screenText.x = (FlxG.width / 2) - (screenText.width / 2);
    screenText.y = (FlxG.height / 2) - (screenText.height / 2);
    add(screenText);
    player.cpu = true;
}
function beatHit(curBeat:Int) {
     // trace('Current beat: ' + curBeat);
    if (curBeat == 0) FlxTween.tween(blackScreen, {alpha: 0.75}, 1, {ease: FlxEase.cubeOut});
    else if (curBeat == 32) FlxTween.tween(blackScreen, {alpha: 0.4}, 1, {ease: FlxEase.cubeOut});
    else if (curBeat == 62) {
        screenText.alpha = 1;
        blackScreen.alpha = 1;
    } else if (curBeat == 64) {
        screenText.kill();
        FlxTween.tween(blackScreen, {alpha: 0.7}, 1.5, {ease: FlxEase.cubeOut});
    }
}