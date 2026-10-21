public var ollie = strumLines.members[0].characters[0];
public var bendy = strumLines.members[1].characters[0];
private var curArrow:FlxSprite;

function create() {
    curArrow = new FlxSprite(ollie.x + 75, ollie.y + 150);
    curArrow.frames = Paths.getSparrowAtlas("game/notes/default");

    curArrow.animation.addByPrefix("left", "arrowLEFT", 0, false);
    curArrow.animation.addByPrefix("down", "arrowDOWN", 0, false);
    curArrow.animation.addByPrefix("up", "arrowUP", 0, false);
    curArrow.animation.addByPrefix("right", "arrowRIGHT", 0, false);

    curArrow.antialiasing = false;
    curArrow.color = FlxColor.WHITE;
    curArrow.alpha = 0;
    add(curArrow);
}

function update() {
    curArrow.alpha = 0;
    switch (ollie.animation.curAnim.name) {
        case "singLEFT":
            curArrow.alpha = 1;
            curArrow.animation.play("left", true);
            curArrow.color = 0xFFFF7CFF;
        case "singDOWN":
            curArrow.alpha = 1;
            curArrow.animation.play("down", true);
            curArrow.color = 0xFF00FFFF;
        case "singUP":
            curArrow.alpha = 1;
            curArrow.animation.play("up", true);
            curArrow.color = 0xFF78FF78;
        case "singRIGHT":
            curArrow.alpha = 1;
            curArrow.animation.play("right", true);
            curArrow.color = 0xFFFF6464;
        case "idle":
            curArrow.alpha = 0;
    }
}

/*
i want to figure out how to modify this at some point so that the arrows pulse when they appear above ollie
as if they've actually been pressed
i also need to learn how to actually read atlas files because a lot of this was cross-referenced and i have
no idea how atlas files work in the first place
*/
/*
idea:
can i make it so that when multiple notes are hit, they appear side-by-side?
*/
