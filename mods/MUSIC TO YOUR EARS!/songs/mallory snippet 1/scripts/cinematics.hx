// Cinematic song practice
// Let's hope this turns out well

/*
Look into optimizing the code later(?)
Don't get me wrong, it's pretty good, but I feel like I should be able to change the properties of things
without having to like... make statements one at a time.
Also the array can easily get confusing; take notes from Swag, assign every character to a key
*/

/*
Also look into adding a shader maybe before release
You never know what a little bloom can do
*/

public var bfs:Array<Character> = [dad, strumLines.members[0].characters[1], strumLines.members[0].characters[2]];

// At some point, I want to move BF to the center of the stage and change the camera offset to center on him
function postCreate() {
            camGame.zoom = 0.9;

            darkScreen = new FlxSprite(0, 0).makeGraphic(FlxG.width*4, FlxG.height*5, FlxColor.BLACK);
            darkScreen.alpha = 0;
            darkScreen.cameras = [camGame];
            add(darkScreen);

            backgroundDim = new FlxSprite(-500, 0).makeGraphic(FlxG.width*4, FlxG.height*5, FlxColor.WHITE);
            backgroundDim.alpha = 0;
            backgroundDim.cameras = [camGame];
            insert(members.indexOf(bfs[0]) - 1, backgroundDim);

            // Probably a way to just clone these from darkScreen instead of recreating them
            pinkScreen = new FlxSprite(0, FlxG.height).makeGraphic(FlxG.width/3.5, FlxG.height, FlxColor.PINK);
            pinkScreen.alpha = 0;
            pinkScreen.cameras = [camHUD];

            blueScreen = new FlxSprite(0, -FlxG.height).makeGraphic(FlxG.width/3.5, FlxG.height, FlxColor.BLUE);
            blueScreen.x = FlxG.width - blueScreen.width;
            blueScreen.alpha = 0;
            blueScreen.cameras = [camHUD];

            bfs[0].x = 500;

            // BFs setup
            bfs[1].x = bfs[0].x;
            bfs[2].x = bfs[0].x;
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 2:
            // Just throwing this in here
            backgroundDim.color = FlxColor.BLACK;

            // Make UI stuff fade away in 1 beat
            var uiStuff = [healthBar, healthBarBG, iconP1, iconP2, accuracyTxt, scoreTxt, missesTxt];
            for (stuff in uiStuff) FlxTween.tween(stuff, {alpha: 0}, Conductor.crochet/1000, {ease: FlxEase.linear});

            // Move notes to middlescroll in 1 beat
            strumLines.members[0].forEach(function(spr:FlxSprite) {
                var noteSpacing:Float = 112;
                var targetX:Float = (FlxG.width/2) - (noteSpacing * 2) + (spr.ID * noteSpacing);
                FlxTween.tween(spr, {x: targetX}, (Conductor.crochet/1000)*2, {ease: FlxEase.quadInOut});
            });

            for (strum in strumLines.members[0].members) {
                FlxTween.tween(strum, {angle: -360}, (Conductor.crochet/1000)*2, {ease: FlxEase.backInOut});
                strum.noteAngle = 0;
            }

        case 4:
            // Move BFs for little tween
            bfs[1].alpha = 0.75;
            bfs[1].color = FlxColor.RED;
            bfs[1].colorTransform.redOffset = 255;
            FlxTween.tween(bfs[1], {x: bfs[0].x - 15}, (Conductor.crochet/1000)*4, {ease: FlxEase.cubeOut});


        case 16:
            // Cool little blue part
            bfs[1].color = FlxColor.BLUE;
            bfs[1].colorTransform.redOffset = 0;
            bfs[1].colorTransform.blueOffset = 255;
            FlxTween.tween(bfs[1], {x: bfs[0].x + 150}, (Conductor.crochet/1000)*2, {
                ease: FlxEase.cubeOut,
                onUpdate: function(twn:FlxTween) {
                    if (bfs[1].x = bfs[0].x) {
                        bfs[1].color = FlxColor.BLUE;
                        bfs[1].colorTransform.redOffset = 0;
                        bfs[1].colorTransform.blueOffset = 255;
                    }
                }});
            // FlxTween.tween(camGame, {angle: 5}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});

        case 18:
            // Turns into purple
            FlxTween.tween(bfs[1], {x: bfs[0].x}, (Conductor.crochet/1000)*2, {
                ease: FlxEase.expoIn,
                onComplete: function(twn2:FlxTween) {
                    bfs[0].color = FlxColor.BLUE;
                    bfs[0].colorTransform.redOffset = 0;
                    bfs[0].colorTransform.blueOffset = 255;
                    FlxTween.tween(bfs[0], {x: bfs[0].x + 50}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
                    
                    bfs[1].color = FlxColor.RED;
                    bfs[1].colorTransform.redOffset = 255;
                    bfs[1].colorTransform.blueOffset = 0;
                    FlxTween.tween(bfs[1], {x: bfs[0].x - 20}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
                }});
            // FlxTween.tween(camGame, {angle: -15}, (Conductor.crochet/1000)*2, {ease: FlxEase.expoIn});

            FlxTween.tween(bfs[1].colorTransform, {redOffset: 255}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
            FlxTween.color(bfs[1], (Conductor.crochet/1000)*2, FlxColor.BLUE, FlxColor.PURPLE, {ease: FlxEase.quadInOut});

        case 20:
            // FlxTween.tween(camGame, {angle: 0}, (Conductor.crochet/1000)*2, {ease: FlxEase.quadInOut});

        case 35:
            FlxTween.tween(darkScreen, {alpha: 1}, (Conductor.crochet/1000), {ease: FlxEase.cubeOut});

        case 36:
            // Turn screen black, Boyfriend completely white and [todo] activate ripple effect
            // MAYBE add VHS shader? Idk, I'll try different shaders
            backgroundDim.cameras = [camHUD];
            remove(backgroundDim);
            insert(0, backgroundDim);
            backgroundDim.alpha = 1;
            darkScreen.alpha = 0;

            // Boyfriend setup (bfs[0] == bf here due to the 1 strumline)
            bfs[0].cameras = [camHUD];
            bfs[0].color = FlxColor.BLACK;
            bfs[0].colorTransform.blueOffset = 0;
            bfs[0].scale.set(0.7, 0.7);
            bfs[0].setPosition(FlxG.width/3, FlxG.height/1.5);

        case 41:
            // Tween in pink bar on the left, have boyfriend already placed there and stuff
            insert(members.indexOf(backgroundDim) + 1, pinkScreen);
            pinkScreen.alpha = 1;
            FlxTween.tween(pinkScreen, {y: 0}, (Conductor.crochet/1000)*3, {ease: FlxEase.cubeOut});

            bfs[1].cameras = [camHUD];
            bfs[1].scale.set(0.7, 0.7);
            bfs[1].color = FlxColor.BLACK;
            bfs[1].colorTransform.redOffset = 0;
            bfs[1].setPosition(0, FlxG.height/1.5);

        case 49:
            // Tween in blue bar on right, same as above
            insert(members.indexOf(pinkScreen) + 1, blueScreen);
            blueScreen.alpha = 1;
            FlxTween.tween(blueScreen, {y: 0}, (Conductor.crochet/1000)*3, {ease: FlxEase.cubeOut});

            bfs[2].cameras = [camHUD];
            bfs[2].scale.set(0.7, 0.7);
            bfs[2].color = FlxColor.BLACK;
            bfs[2].setPosition(bfs[0].x + 425, FlxG.height/1.5);

        case 59:
            // Color interpolate background to white
            // ALSO ADD VIGNETTE
            // Have text slide in and stuff
            FlxTween.color(backgroundDim, (Conductor.crochet/1000)*3, FlxColor.BLACK, FlxColor.WHITE, {ease: FlxEase.quadInOut});
            FlxTween.tween(pinkScreen, {alpha: 0}, (Conductor.crochet/1000)*3, {ease: FlxEase.cubeOut});
            FlxTween.tween(blueScreen, {alpha: 0}, (Conductor.crochet/1000)*3, {ease: FlxEase.cubeOut});
            for (dude in bfs) {
                FlxTween.tween(dude, {x: bfs[2].x}, (Conductor.crochet/1000)*8, {ease: FlxEase.quadInOut});
            }

        case 66:
            FlxTween.color(backgroundDim, (Conductor.crochet/1000)*1.5, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.quadInOut});
            
        case 68:
            // Get rid of backgroundDim and other things
            // Bring BF back to camGame
            backgroundDim.alpha = 0;
            darkScreen.alpha = 0;

            for (dude in bfs) {
                dude.cameras = [camGame];
                dude.scale.set(1, 1);
                dude.x = 450;
                dude.y = 100;
            }

            bfs[2].color = FlxColor.WHITE;

            bfs[0].color = FlxColor.BLUE;
            bfs[0].colorTransform.redOffset = 0;
            bfs[0].colorTransform.blueOffset = 255;
            FlxTween.tween(bfs[0], {x: bfs[2].x + 35}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
            
            bfs[1].color = FlxColor.RED;
            bfs[1].colorTransform.redOffset = 255;
            bfs[1].colorTransform.blueOffset = 0;
            FlxTween.tween(bfs[1], {x: bfs[2].x - 35}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});

        case 74:
            FlxTween.tween(bfs[0], {x: bfs[2].x + 15}, (Conductor.crochet/1000)*2, {ease: FlxEase.expoIn});
            FlxTween.tween(bfs[1], {x: bfs[2].x - 15}, (Conductor.crochet/1000)*2, {ease: FlxEase.expoIn});
        case 76:
            FlxTween.tween(bfs[0], {x: bfs[2].x + 45}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
            FlxTween.tween(bfs[1], {x: bfs[2].x - 45}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
        case 80:
            FlxTween.tween(bfs[0], {x: bfs[2].x + 15}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
            FlxTween.tween(bfs[1], {x: bfs[2].x - 15}, (Conductor.crochet/1000)*2, {ease: FlxEase.cubeOut});
    }
}