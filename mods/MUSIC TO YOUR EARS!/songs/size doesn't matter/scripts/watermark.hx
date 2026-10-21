var watermark:FlxText;
var camWatermark:FlxCamera;

function create() {
    watermark = new FlxText(10, 0, 0, "[orgablorg]", 50);
    watermark.setFormat(Paths.font("adultswim.ttf"), 50, FlxColor.BLACK, "left");
    watermark.x = 10;
    watermark.y = FlxG.height - watermark.height - 10;
    watermark.scrollFactor.set(0,0);
    watermark.blend = 10;
    add(watermark);
}

function postCreate() {
    camWatermark = new FlxCamera();
    camWatermark.bgColor = 0;
    FlxG.cameras.add(camWatermark, false); // not default camera
    watermark.camera = camWatermark;
}

function stepHit(curStep:Int) {
    if (curStep >= 248 && curStep <= 255) watermark.color = FlxColor.WHITE;
    else watermark.color = FlxColor.BLACK;
}