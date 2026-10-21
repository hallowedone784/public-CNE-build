// miscellaneous stuff that i didn't designate to functions

function onNoteHit(e:NoteHitEvent) {
    // change the following to run on e.noteType == "Shake Note" or something like that.
    if (curBeat < 67) camGame.shake(0.01, 0.05);
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 65:
            marqueeBars(85, 1);
            var stuffToFade = [healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt, iconP1, iconP2];
            for (item in stuffToFade) {
                FlxTween.tween(item, {alpha: 0}, (Conductor.crochet/1000), {ease: FlxEase.cubeOut});
            }

        // specific overrides since it won't work in-game
        case 83:
            marqueeLyrics("[see, they really really wanna pop me]");

        case 98:
            marqueeLyrics("[every time i come, a nigga gotta set it]");

        case 101:
            marqueeLyrics("[then i gotta go, and then i gotta get it]");

        case 104:
            marqueeLyrics("[then i gotta blow, and then i gotta show that]");

        case 110:
            marqueeLyrics("['cause it doesn't matter, 'cause i'm gonna]");

        case 117:
            marqueeLyrics("[a ba-da-boom, a ba-da-bing, i gotta do a lotta things]");

        case 133:
            marqueeLyrics("[and now i move a little foul, a nigga better call a ref]");

        // the following ones will be adjusted later, they should be by step and not by beat since they're at midpoints
        case 165:
            marqueeLyrics("[and you know we gotta go, don't try to keep up with the pace]");
        
        case 173:
            marqueeLyrics("[and we always gotta do it, take it to another place]");
    }
}