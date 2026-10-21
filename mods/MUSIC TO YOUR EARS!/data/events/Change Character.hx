import haxe.ds.StringMap;

var charMap:Array<Array<StringMap<Character>>> = [];

// partially stole from gorefield lol
function postCreate() {
	for (event in events) {
		if (event.name == 'Change Character') {
			for (strumLane in strumLines) {
				var strumIndex:Int = strumLines.members.indexOf(strumLane);
				if (charMap[strumIndex] == null) charMap[strumIndex] = [];
				trace('Strum Index: ' + strumIndex);
				
				for (char in strumLane.characters) {
					var charIndex:Int = strumLane.characters.indexOf(char);
					if (charMap[strumIndex][charIndex] == null) charMap[strumIndex][charIndex] = new StringMap();
					trace('Character Index: ' + charIndex);

					var charName:String = event.params[1];
					if (char.curCharacter == charName) {
						trace('Old Character: ' + char.curCharacter);
						charMap[strumIndex][charIndex].set(char.curCharacter, char);
					}
					if (!charMap[strumIndex][charIndex].exists(charName)) {
						var newChar:Character = new Character(char.x, char.y, charName, char.isPlayer);
						trace('New Character: ' + newChar.curCharacter);
						charMap[strumIndex][charIndex].set(newChar.curCharacter, newChar);
						newChar.active = newChar.visible = false;
						newChar.drawComplex(FlxG.camera);
					}
				}
			}
		}
	}
}

function onEvent(event) {
	if (event.event.name == 'Change Character') {
		trace('Change Character Event Called');
		var params = {
			strumIndex: event.event.params[0],
			charName: event.event.params[1],
			charIndex: event.event.params[2]
		};
		trace(params);
		var oldChar:Character = strumLines.members[params.strumIndex].characters[params.charIndex];
		var newChar:Character = charMap[params.strumIndex][params.charIndex].get(params.charName);
		if (oldChar.curCharacter == newChar.curCharacter) return;

		if (params.charIndex == 0) {
			if (params.strumIndex == 0) iconP2.setIcon(newChar.getIcon());
			else if (params.strumIndex == 1) iconP1.setIcon(newChar.getIcon());
		}
		insert(members.indexOf(oldChar), newChar);
		newChar.active = newChar.visible = true;
		remove(oldChar);
		
		newChar.setPosition(oldChar.x, oldChar.y);
		newChar.playAnim(oldChar.animation.name);
		newChar.animation?.curAnim?.curFrame = oldChar.animation?.curAnim?.curFrame;
		strumLines.members[params.strumIndex].characters[params.charIndex] = newChar;
	}
}