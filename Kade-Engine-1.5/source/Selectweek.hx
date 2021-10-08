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

class Selectweek extends MusicBeatSubstate
{
    var bg:FlxSprite;
    var isCutscene:Bool = false;
    var susie:FlxSprite;
    var fate:FlxText = new FlxText(0, 50, 0, "Use your mouse!", 72);
    
    override function create()
        {
            FlxG.mouse.visible = true;
            bg = new FlxSprite().loadGraphic(Paths.image('storymode/bg', 'preload'));
            bg.setGraphicSize(FlxG.width);
            bg.antialiasing = true;
            bg.updateHitbox();
            bg.screenCenter();
            bg.scrollFactor.set();
            add(bg);

            susie = new FlxSprite(0,0).loadGraphic(Paths.image('storymode/susie', 'preload'));
            susie.updateHitbox(); 
            susie.screenCenter();
            susie.antialiasing = true;
            susie.scale.set(0.5, 0.5);
            add(susie);

			fate.setFormat(Paths.font("vcr.ttf"), 72, FlxColor.WHITE);
			fate.screenCenter(X);
			add(fate);
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

        if (FlxG.mouse.overlaps(susie))
        {  
                susie.scale.set(0.7, 0.7);
            } else {
                susie.scale.set(0.5, 0.5);
            }
        if (FlxG.mouse.overlaps(susie))
            {
            if (FlxG.mouse.justPressed)
                {
                FlxG.sound.play(Paths.sound('confirmMenu'));
                PlayState.storyPlaylist = ['geolocation'];
                PlayState.isStoryMode = true;
                PlayState.storyDifficulty = 2;
                PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
                PlayState.storyWeek = 0;
                PlayState.campaignScore = 0;
                new FlxTimer().start(0.8, function(tmr:FlxTimer)
                {
                    LoadingState.loadAndSwitchState(new PlayState(), true);
                });
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