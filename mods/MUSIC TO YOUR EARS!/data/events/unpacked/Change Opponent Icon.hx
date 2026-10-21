function onEvent(event) {
    if (event.event.name == "Change Opponent Icon") {
        iconP2.setIcon(event.event.params[0]);
    }
}

// to-do: make icons smaller 'cuz they're too big rn (heh. big and small)