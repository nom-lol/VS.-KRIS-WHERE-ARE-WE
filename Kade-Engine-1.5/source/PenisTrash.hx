import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.FlxSubState;
import flixel.addons.ui.FlxUIInputText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import lime.system.System;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.ui.FlxBar;

class PenisTrash extends MusicBeatSubstate
{
    var bg:FlxSprite;
    var isCutscene:Bool = false;
    var trash:FlxSprite;
    var trashopen:FlxSprite;
    var fate:FlxText = new FlxText(0, 50, 0, "Use your mouse!", 72);
    var spamtext:FlxText = new FlxText(0, 300, 0, "coming soon!", 72);
    
    override function create()
        {
            FlxG.mouse.visible = true;
            bg = new FlxSprite().loadGraphic(Paths.image('trash can/bg', 'preload'));
            bg.setGraphicSize(FlxG.width);
            bg.antialiasing = true;
            bg.updateHitbox();
            bg.screenCenter();
            bg.scrollFactor.set();
            add(bg);

            trash = new FlxSprite(0,0).loadGraphic(Paths.image('trash can/trashcan', 'preload'));
            trash.updateHitbox(); 
            trash.screenCenter();
            trash.antialiasing = true;
            trash.scale.set(0.5, 0.5);
            add(trash);

            trashopen = new FlxSprite(0,0).loadGraphic(Paths.image('trash can/trashopen', 'preload'));
            trashopen.updateHitbox(); 
            trashopen.screenCenter();
            trashopen.antialiasing = true;
            trashopen.scale.set(0.5, 0.5);
            add(trashopen);

			fate.setFormat(Paths.font("vcr.ttf"), 72, FlxColor.WHITE);
			fate.screenCenter(X);
			add(fate);

            spamtext.setFormat(Paths.font("vcr.ttf"), 72, FlxColor.WHITE);
            spamtext.screenCenter(X);
            spamtext.visible = false;
			add(spamtext);
        }
    override function update(elapsed:Float)
    {
        if (FlxG.sound.music != null)
            Conductor.songPosition = FlxG.sound.music.time;

        if (FlxG.keys.justPressed.ESCAPE)
        {
            if(!isCutscene)
            FlxG.mouse.visible = false;
            FlxG.switchState(new MainMenuState());
            FlxG.mouse.enabled = true;
        }

        if (FlxG.mouse.overlaps(trash))
        {
                trashopen.visible = true;
                trashopen.scale.set(0.7, 0.7);
                trash.visible = false;
            } else {
                trash.scale.set(0.5, 0.5);
                trashopen.visible = false;
                trash.visible = true;
            }
        if (FlxG.mouse.overlaps(trash))
            {
            if (FlxG.mouse.justPressed)
                {
                FlxG.sound.play(Paths.sound('confirmMenu'));
                spamtext.visible = true;
            }
        }
        super.update(elapsed);
    }
    public function fancyOpenURL(penisssss:String)
		{
			#if linux
			Sys.command('/usr/bin/xdg-open', [penisssss, "&"]);
			#else
			FlxG.openURL(penisssss);
			#end
		}
}