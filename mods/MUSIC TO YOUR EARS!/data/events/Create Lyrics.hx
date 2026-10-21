var lyricsGroup:Array<FlxText> = [];
var iconsGroup:Array<FlxSprite> = [];

function onEvent(event) {
    var charName = event.event.params[0];
    var textContent = event.event.params[1];
    var isLeft = event.event.params[2];

    if (event.event.name == "Create Lyrics") {  
        // Logic to clear text
        if (charName == "clear") {
            for (text in lyricsGroup) text.kill();
            for (icon in iconsGroup) icon.kill();
            lyricsGroup = [];
            iconsGroup = [];
            trace("all clear!");
            return; // end function
        }

        // -- Handling old lyrics --
        var lineSpacing:Float = 45; // spacing
        var i:Int = lyricsGroup.length - 1;
        while (i >= 0) {
            var oldText = lyricsGroup[i];
            var oldIcon = iconsGroup[i];

            // If text super faded, kill it and remove from array
            if (oldText.alpha <= 0.35) {
                oldText.kill();
                oldIcon.kill();
                lyricsGroup.splice(i, 1);
                iconsGroup.splice(i, 1);
            } else {
                // Otherwise, move up and fade it. 
                // Cancel old tweens (fixes issue of tweens not working when sung by the same character)
                FlxTween.cancelTweensOf(oldText);
                FlxTween.cancelTweensOf(oldIcon);

                oldText.alpha -= 0.34;
                oldIcon.alpha -= 0.34;
                FlxTween.tween(oldText, {y:oldText.y + lineSpacing}, 1, {ease:FlxEase.cubeOut});
                FlxTween.tween(oldIcon, {y:oldIcon.y + lineSpacing}, 1, {ease:FlxEase.cubeOut});
            }
            i--;
        }

        var newLyrics:FlxText = new FlxText(0, 0, 0);
        var textCol:FlxColor = FlxColor.WHITE;
        if (charName == "big") textCol = FlxColor.PURPLE;
        else if (charName == "small") textCol = FlxColor.ORANGE;
        else if (charName == "big-small") textCol = (FlxG.random.bool(50) ? FlxColor.PURPLE : FlxColor.ORANGE);

        newLyrics.setFormat(null, 28, textCol, "center"); 
        newLyrics.text = textContent;
        newLyrics.scrollFactor.set(0,0);
        newLyrics.alpha = 0;        
        add(newLyrics);
        newLyrics.camera = camHUD;

        newLyrics.updateHitbox();
        newLyrics.x = (FlxG.width / 2) - (newLyrics.width / 2);
        
        // positioning logic
        var targetY:Float = (FlxG.y/2) + 150;
        newLyrics.y = targetY - 30;

        // Make the new icon
        var newIcon:FlxSprite = new FlxSprite(0, 0);
        newIcon.loadGraphic("assets/images/icons/" + charName + "/icon.png");
        newIcon.scrollFactor.set(0,0);
        newIcon.alpha = 0;
        var graphicSize:Int = (charName == "big-small" ? 150: 100);
        newIcon.setGraphicSize(graphicSize, graphicSize);
        newIcon.updateHitbox();

        // Icon snapping code
        if (isLeft) newIcon.x = newLyrics.x - newIcon.width - 15;
        else newIcon.x = newLyrics.x + newLyrics.width + 15;

        newIcon.y = newLyrics.y + (newLyrics.height / 2) - (newIcon.height / 2);
        add(newIcon);
        newIcon.camera = camHUD;
            
        // Animation stuff
        FlxTween.tween(newLyrics, {alpha: 1, y: targetY}, 1.5, {ease:FlxEase.cubeOut});
        FlxTween.tween(newIcon, {alpha: 1, y: targetY - 35}, 1.5, {ease:FlxEase.cubeOut}); // y should always be 50 pixels less than lyrics Y

        // Add to arrays
        lyricsGroup.push(newLyrics);
        iconsGroup.push(newIcon); 
        // trace("Current lyricsGroup length: " + lyricsGroup.length);
    }
}
