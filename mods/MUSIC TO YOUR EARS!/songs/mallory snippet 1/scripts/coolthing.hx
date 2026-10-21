/*
This is the code for the cool ripple effect during the black background section
Lowkey just winging it
ts kinda fowl
*/
function onPlayerHit(event) {
    if (curBeat >= 36 && curBeat < 60) {
        if (!event.note.isSustainNote) {
            var clone:Character = new Character(bfs[0].x, bfs[0].y, bfs[0].curCharacter, bfs[0].isPlayer, bfs[0].__switchAnims);
            clone.cameras = [camHUD];
            clone.visible = true;
            insert(members.indexOf(bfs[0]), clone);

            clone.scale.set(bfs[0].scale.x, bfs[0].scale.y);
            // I want to have it so that on every note hit during this section, a new character is created
            // The character is pretty much a clone of BF, tinted to be the same color as whatever note he hit
            // and then it expands, doing the animation he just hit before fading (this is the part I'm having trouble with, how would I make multiple characters at once if needed)
                
            // trace("Current noteData: " + event.note.noteData);
            switch (event.note.noteData) {
                case 0:
                    clone.playAnim("singLEFT", true);
                    clone.color = 0xFFFF7CFF;
                    clone.colorTransform.redOffset = 255;
                    clone.colorTransform.blueOffset = 255;
                    clone.colorTransform.greenOffset = 0;
                case 1:
                    clone.playAnim("singDOWN", true);
                    clone.color = 0xFF00FFFF;
                    clone.colorTransform.redOffset = 0;
                    clone.colorTransform.blueOffset = 255;
                    clone.colorTransform.greenOffset = 0;
                case 2:
                    clone.playAnim("singUP", true);
                    clone.color = 0xFF78FF78;
                    clone.colorTransform.redOffset = 0;
                    clone.colorTransform.blueOffset = 0;
                    clone.colorTransform.greenOffset = 255;
                case 3:
                    clone.playAnim("singRIGHT", true);
                    clone.color = 0xFFFF6464;
                    clone.colorTransform.redOffset = 255;
                    clone.colorTransform.blueOffset = 0;
                    clone.colorTransform.greenOffset = 0;
                }

            FlxTween.tween(clone.scale, {x: 1.15, y: 1.15}, (Conductor.crochet/1000)*0.5, {ease: FlxEase.cubeOut});
            FlxTween.tween(clone, {alpha: 0}, (Conductor.crochet/1000), {
                ease: FlxEase.cubeOut,
                onComplete: function(twn:FlxTween) {
                    remove(clone, true);
                    clone.destroy();
                }
            });
        }
    }
}
