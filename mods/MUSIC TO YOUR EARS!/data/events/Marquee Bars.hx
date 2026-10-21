// marquee bars variables
var camBars:FlxCamera;
var barGroup:FlxSpriteGroup;
var topBar:FlxSprite;
var bottomBar:FlxSprite;

// Idea: make outside boolean false and map it to event.event.params[2];
// So then I can access it outside of its scope in update(elapsed)
// and use it for the camera bop

function onEvent(event) {
    if (event.event.name == "Marquee Bars") 
    {
        if (camBars == null) {
            camBars = new FlxCamera(0, 0, camHUD.width, camHUD.height);
            camBars.bgColor = FlxColor.TRANSPARENT;
            FlxG.cameras.insert(camBars, FlxG.cameras.list.indexOf(camHUD), false);

            barGroup = new FlxSpriteGroup();
            barGroup.cameras = [camBars];
            add(barGroup);

            topBar = new FlxSprite(-150, -FlxG.height/2).makeSolid(FlxG.width*2, FlxG.height/2, FlxColor.BLACK);
            bottomBar = new FlxSprite(-150, FlxG.height).makeSolid(FlxG.width*2, FlxG.height/2, FlxColor.BLACK);

            barGroup.add(topBar);
            barGroup.add(bottomBar);
        }
        


        // Distance calculation logic
        var targetSize:Int = Std.parseInt(event.event.params[1]);
        var topGoal:Int = -FlxG.height/2 + targetSize;
        var bottomGoal:Int = FlxG.height - targetSize;
        var duration:Float = ((Conductor.crochet / 1000) * event.event.params[4])/4;

        var baseGameZoom:Float = stage.zoom;

        // Tweening code
        var tweenCase = event.event.params[5] + event.event.params[6];
        var tweenFunc = Reflect.field(FlxEase, tweenCase); // What the FUCK is Reflect.field??
        
        FlxTween.cancelTweensOf(topBar);
        FlxTween.cancelTweensOf(bottomBar);
    
        // Come back to this later because the tween looks wonky asf
        // I gotta set the pivot point to the middle of the screen or something
        FlxTween.tween(barGroup, {angle: event.event.params[2]}, duration, {ease: tweenFunc});

        // Code isn't working properly when I try to run one consecutive tween after the other
        if (event.event.params[0]) {
            FlxTween.tween(topBar, {y: topGoal}, duration, {ease: tweenFunc});
            FlxTween.tween(bottomBar, {y: bottomGoal}, duration, {ease: tweenFunc});
        } else {
            topBar.y = topGoal;
            bottomBar.y = bottomGoal;
        }
        // Zoom calculation stuff (code later)
        // event.event.params[3] is the boolean
    }
}