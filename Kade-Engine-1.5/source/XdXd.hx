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

class XdXd extends MusicBeatSubstate
{
    var bg:FlxSprite;
    var isCutscene:Bool = false;
    var susie:FlxSprite;
    
    override function create()
        {
            var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
            add(bg);
        }
    override function update(elapsed:Float)
    {
        if (FlxG.sound.music != null)
            Conductor.songPosition = FlxG.sound.music.time;

        if (FlxG.keys.justPressed.ESCAPE)
        {
            if(!isCutscene)
            FlxG.switchState(new MainMenuState());
            FlxG.mouse.enabled = true;
        }

        if (FlxG.keys.justPressed.ENTER)
            {
                if(!isCutscene)
                FlxG.switchState(new MainMenuState());
                FlxG.mouse.enabled = true;
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