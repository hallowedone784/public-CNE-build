// I had help with this code because I'm not good with arrays and data tables
// Hopefully my college class helps me out with this since we're focusing on tables right now but damn
// Didn't realize how much I sucked with arrays and tables and keys and all that lmfao

var words:Array<FlxText> = [];
var wordTexts:Array<String> = ["if", "only", "you", "knew", "how"];
var yOffsets:Array<Float> = [100, 275, 400, 525, 650];

function postCreate() {
    for (i in 0...wordTexts.length) {
        var word = new FlxText(0, FlxG.height - yOffsets[i], 0, wordTexts[i], 80);
        word.x = FlxG.width + 100;
        word.color = FlxColor.BLACK;
        word.font = Paths.font("adultswim.ttf");
        word.cameras = [camHUD];
        word.setBorderStyle(Type.resolveEnum("flixel.text.FlxTextBorderStyle").OUTLINE, FlxColor.WHITE, 1);
        add(word);
        words.push(word);
    }
}

var tweenData:Array<Dynamic> = [
    {beat: 59, index: 0, mult: 1},
    {beat: 60, index: 1, mult: 3},
    {beat: 63, index: 2, mult: 1},
    {beat: 64, index: 3, mult: 2},
    {beat: 66, index: 4, mult: 1}
];

function beatHit(curBeat:Int) {
    for (data in tweenData) {
        if (curBeat == data.beat) {
            var duration = (Conductor.crochet / 1000)*data.mult;
            FlxTween.tween(words[data.index], {x: FlxG.width - words[data.index].width - 50}, duration, {ease: FlxEase.cubeOut});
            trace("Tween " + (data.index + 1) + " done!");
        }

        if (curBeat == 68) {
            // Change this logic later to exclude the first word so we can use it for something
            words[data.index].alpha = 0;
        }
    }
}

/*
Just writing this down for reference,
but there's this bug sometimes where the screen won't clear after the text part and it'll just stay black.
I'm not sure what causes this, nor how to fix it.
But I'll find out. Not too important.
*/