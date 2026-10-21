// this is gonna be the code for the blitz section
// ideas: have ai american eagle showing up at random parts of the screen. slightly transparent so it doesn't obstruct the player
// also have his face be covered by a black box when he starts spazzing out
// maybe conveyor belts on the sides of the screen with [#litfam] going opposite directions on both (im going with this idea)
var normalStage = stage.getSprite('bg1');
var evilStage = stage.getSprite('bg2');
var leftSidebar:FlxSprite;
var rightSidebar:FlxSprite;
var leftText:FlxText;
var rightText:FlxText;
var quotes:Array<String> = [
    "#litfam",
    "#maga",
    "#merica",
    "#grindset",
    "#thelight",
    "#folded",
    "#pibby",
    "#mogged",
    "#freedom",
    "staywoke"
];

var signalScreen:FlxSprite;
var signalText:FlxText;


function blitzSetup() {
    evilStage.alpha = 1; // Show blue stage
    
    // Setup conveyor stuff
    conveyorGroup = new FlxTypedGroup();
    add(conveyorGroup);
    conveyorGroup.cameras = [camHUD];
    
    // Left sidebar stuff
    leftSidebar = new FlxSprite(0, 0).makeGraphic(FlxG.width/10, FlxG.height, FlxColor.BLACK);
    leftSidebar.scrollFactor.set(0,0);
    leftSidebar.cameras = [camHUD];
    add(leftSidebar);

    // Now right sidebar
    rightSidebar = new FlxSprite(0, 0).makeGraphic(FlxG.width/10, FlxG.height, FlxColor.BLACK);
    rightSidebar.x = FlxG.width - rightSidebar.width;
    rightSidebar.scrollFactor.set(0,0);
    rightSidebar.cameras = [camHUD];
    add(rightSidebar);

    // Text mechanic setup (left side)
    blitzTimer = new FlxTimer().start(0.5, function(tmr:FlxTimer) {
        // Left side
        var randomQuote = FlxG.random.getObject(quotes);
        var leftGroup = new FlxSpriteGroup();
        leftGroup.x = 0;
        leftGroup.y = FlxG.height;
        add(leftGroup);
        leftGroup.cameras = [camHUD];

        var leftText = new FlxText(5, 0, FlxG.width/10, randomQuote, 32);
        leftText.setFormat(Paths.font("adultswim.ttf"), leftSidebar.width/4, FlxColor.WHITE);
        leftGroup.add(leftText);
        leftText.cameras = [camHUD];

        conveyorGroup.add(leftGroup);
        FlxTween.tween(leftGroup, {y: -FlxG.height - 50}, 5, {ease: FlxEase.linear});

        // Right side
        var randomQuote2 = FlxG.random.getObject(quotes);
        var rightGroup = new FlxSpriteGroup();
        rightGroup.x = rightSidebar.x/2 - 60; // This positioning is so janky lmao. Manual offsets are doing the heavy lifting
        rightGroup.y = -50;
        add(rightGroup);
        rightGroup.cameras = [camHUD];

        var rightText = new FlxText(FlxG.width/2, 0, FlxG.width/10, randomQuote2, 32);
        rightText.setFormat(Paths.font("adultswim.ttf"), rightSidebar.width/4, FlxColor.WHITE);
        rightGroup.add(rightText);
        rightText.cameras = [camHUD];
        trace(rightText.y);

        conveyorGroup.add(rightGroup);
        FlxTween.tween(rightGroup, {y: FlxG.height + 500}, 5, {ease: FlxEase.linear}); // No idea why the offset is so different, by the way. Figured this out via trial and error
    }, 0);
}

function lostSignal() {
    // Make box over whole screen on topmost layer
    // Add [lost signal] in the middle of it
    // Make it go away on blitzExit()

    // Make the strums invisible
    player.cpu = true;
    cpuStrums.visible = false;
    playerStrums.visible = false;

    // Can I somehow make the conveyor text invisible?

    var signalScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    var signalText = new FlxText(FlxG.width / 3, (FlxG.height / 2) - 50);
    signalText.scrollFactor.set(0, 0);
    signalText.setFormat(Paths.font("adultswim.ttf"), 100, FlxColor.WHITE, "center");
    signalScreen.cameras = [camHUD];
    signalText.cameras = [camHUD];
    conveyorGroup.add(signalScreen);
    conveyorGroup.add(signalText);
    signalText.text = "[no signal]";

    leftSidebar.destroy();
    rightSidebar.destroy();
}

function blitzExit() {
    blitzTimer.cancel();
    evilStage.alpha = 0;

    conveyorGroup.destroy();
    cpuStrums.visible = true;
    playerStrums.visible = true;
    player.cpu = false;
}

// Code works for the most part. I could optimize it somewhat
// I also need to figure out how the hell I can get the conveyor stuff to maybe disappear with [no signal], though I might just keep it there because it looks cool.