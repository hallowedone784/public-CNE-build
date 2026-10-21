// cinema bars variables
var camBars:FlxCamera;
var barGroup:FlxSpriteGroup;
var topBar:FlxSprite;
var bottomBar:FlxSprite;

// lyrics variables
var lyricText:FlxText;
var lyrics:Array<String> = [];
var currentIndex:Int = 0;
var stepInterval:Int = 1;
var isLyricActive:Bool = false;

var stepCounter:Int = 0;

function stepHit(curStep:Int) {
    if (!isLyricActive) return;

    stepCounter++;

    // Check if current step matches interval spacing
    if (stepCounter >= stepInterval) {
        if (currentIndex < lyrics.length) {
            // Add next word
            lyricText.text += lyrics[currentIndex];
            currentIndex++;
            stepCounter = 0;
        } else {
            isLyricActive = false;
            // Add a transition out here, maybe, and a transition in at the top of this statement
        }
    }
}

public function marqueeLyrics(phrase:String, ?textSize:Int, ?font:String, ?breakTime:Int) // working title
{
    textSize ??= 50;
    font ??= "adultswim.ttf";
    breakTime ??= 1;

    // Split string into words
    var formattedPhrase:String = StringTools.replace(phrase, "-", " -"); // handles dashes in the phrase
    lyrics = formattedPhrase.split(" "); 
    
    // add space at the beginning of every entry past the first one in words
    for (i in 1...lyrics.length) {
        if (!StringTools.startsWith(lyrics[i], "-")) {
            lyrics[i] = " " + lyrics[i];
        }
    }
    
    if (lyricText == null) {
        lyricText = new FlxText(0, FlxG.height - 80, FlxG.width, "", textSize);
        lyricText.alignment = "center";
        lyricText.cameras = [camBars ?? camHUD];
        add(lyricText);
    }
    
    lyricText?.font = Paths.font(font);
    lyricText.size = textSize;
    lyricText.text = lyrics[0] ?? "";

    currentIndex = 1;
    stepInterval = breakTime;
    stepCounter = 0;
    isLyricActive = (lyrics.length > 0);
}

public function marqueeBars(distFromCenter:Int, numOfBeats:Int) // placeholder parameters, change later
{
    camBars ??= new FlxCamera(0, 0, camHUD.width, camHUD.height);
    camBars.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.insert(camBars, FlxG.cameras.list.indexOf(camHUD), false);

    barGroup ??= new FlxSpriteGroup();
    barGroup.cameras = [camBars];
    add(barGroup);

    // Cancels the tweens of the last bar movement. That way, they don't overlap.
    topBar?.cancelTween();
    bottomBar?.cancelTween();

    topBar ??= new FlxSprite(-150, -FlxG.height/2).makeSolid(FlxG.width*2, FlxG.height/2, FlxColor.BLACK);
    bottomBar ??= new FlxSprite(-150, FlxG.height).makeSolid(FlxG.width*2, FlxG.height/2, FlxColor.BLACK);

    barGroup.add(topBar);
    barGroup.add(bottomBar);

    // Distance calculation logic
    var topGoal:Int = -FlxG.height/2 + Std.parseInt(distFromCenter);
    var bottomGoal:Int = FlxG.height - Std.parseInt(distFromCenter);
    var duration:Float = (Conductor.crochet / 1000) * numOfBeats;
    
    // Maybe add tweening case logic later if we decide to use that?
    FlxTween.tween(topBar, {y: topGoal}, duration, {ease: FlxEase.circOut});
    FlxTween.tween(bottomBar, {y: bottomGoal}, duration, {ease: FlxEase.circOut});
}


/*
To-do:
1. Add secondary lyric mechanic, where if a lyric is identified as secondary, it's grayer and more transparent!
2. Probably polish this a bit so it looks better. I like it being centered, but it's hard to read, so maybe I can make it left-to-right while also being centered?
3. Definitely add more lyric stuff like rich text capability and all that.
*/