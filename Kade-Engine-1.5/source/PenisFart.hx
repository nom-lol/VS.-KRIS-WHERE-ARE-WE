package;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class PenisFart extends MusicBeatState
{

    var bgbgbg:FlxSprite;

    override function create()
    {
        bgbgbg = new FlxSprite().loadGraphic(Paths.image('penismogus', 'shared'));
        bgbgbg.alpha = 0;
        bgbgbg.screenCenter();
        add(bgbgbg);

        new FlxTimer().start(2, function(xd:FlxTimer)
        {
            FlxTween.tween(bgbgbg, {alpha: 1}, 1);
        });

        super.create();
    }

    override function update(elapsed:Float)
    {
        if (controls.ACCEPT)
        {
            LoadingState.loadAndSwitchState(new MainMenuState());
        }
        
        super.update(elapsed);
    }
}