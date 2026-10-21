// healthbar code
// made by orgablorg
var tweenTime = (Conductor.crochet / 1000) * 3;

function postUpdate() {
    if (curMeasure >= 8) {
        updateIconPositions = true;
        iconP1.alpha = 1;
        iconP2.alpha = 1;
        iconP1.x = FlxG.width - iconP1.width - 20;
        iconP2.x = 20;
    }
}

function measureHit(curMeasure:Int) {
    switch (curMeasure) {
        case 6:
            updateIconPositions = null;
            FlxTween.tween(healthBar, {alpha: 0}, tweenTime, {ease: FlxEase.cubeOut});
            FlxTween.tween(healthBarBG, {alpha: 0}, tweenTime, {ease: FlxEase.cubeOut});
        case 7:
            FlxTween.tween(iconP1, {x: FlxG.width - iconP1.width - 20}, tweenTime, {ease: FlxEase.expoIn});
            FlxTween.tween(iconP2, {x: 20}, tweenTime, {ease: FlxEase.expoIn});

    }
}