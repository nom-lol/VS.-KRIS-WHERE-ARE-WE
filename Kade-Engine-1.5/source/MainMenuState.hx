package;

import flixel.input.gamepad.FlxGamepad;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'options', 'freeplay', 'spamton'];
	#else
	var optionShit:Array<String> = ['story mode', 'spamton'];
	#end

	var select:FlxSprite;

	var selectyy:Float;

	var options:Array<FlxSprite>;

	var newGaming:FlxText;
	var newGaming2:FlxText;
	public static var firstStart:Bool = true;

	public static var nightly:String = "";


	public static var kadeEngineVer:String = "69" + nightly;
	public static var gameVer:String = "0.2.7.1";

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var finishedFunnyMove:Bool = false;

	var defaultCamZoom:Float = 1.05;
	

	override function create()
		{

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Majora's Mask Menu", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		FlxG.camera.zoom = defaultCamZoom;

		persistentUpdate = persistentDraw = true;


		var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('menuBG', 'preload'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuBGMagenta'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.10;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var menuItem:FlxSprite = new FlxSprite();

		select = new FlxSprite().loadGraphic(Paths.image('menu/select', 'preload'));
		select.scrollFactor.set();
		select.setGraphicSize(Std.int(FlxG.width / FlxG.camera.zoom), Std.int(FlxG.height / FlxG.camera.zoom));
		select.updateHitbox();
		select.screenCenter();
		select.antialiasing = true;
		selectyy = select.y;
		add(select);

		options = [];

		for (i in 0...optionShit.length)
			{
				var num:Int = i + 1;
		{
				menuItem = new FlxSprite().loadGraphic(Paths.image('menu/item' + num, 'preload'));
		}
		menuItem.setGraphicSize(Std.int(FlxG.width / FlxG.camera.zoom), Std.int(FlxG.height / FlxG.camera.zoom));
		add(menuItem);
		options.push(menuItem);
		menuItem.scrollFactor.set();
		menuItem.antialiasing = true;
		menuItem.updateHitbox();
		menuItem.screenCenter();
		
	}

	firstStart = false;

	FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));

	// NG.core.calls.event.logEvent('swag').send();


	if (FlxG.save.data.dfjk)
		controls.setKeyboardScheme(KeyboardScheme.Solo, true);
	else
		controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

	changeItem();

	super.create();
}

var selectedSomethin:Bool = false;

override function update(elapsed:Float)
{
	if (FlxG.sound.music.volume < 0.8)
	{
		FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
	}
	
	if (FlxG.sound.music != null)
		Conductor.songPosition = FlxG.sound.music.time;

	select.alpha = 1 + Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 2.0) * 0.1;

	if (!selectedSomethin)
			{
				if (controls.UP_P)
				{
					changeItem(-1);
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);
				}
	
				if (controls.DOWN_P)
				{
					changeItem(1);
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);
				}
	
				if (controls.ACCEPT)
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
	
					for (i in 0...options.length)
					{
						if (curSelected != i)
						{
							FlxTween.tween(options[i], {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									options[i].kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(options[i], 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									goToState();
								});
							}
						}
					}
				}
			}
	
			super.update(elapsed);
		}
	
		function goToState()
		{
			var daChoice:String = optionShit[curSelected];
	
			//FlxFlicker.flicker(options[curSelected], 1.1, 0.15, false);
	
			switch (daChoice)
			{
				case 'story mode':
					FlxG.switchState(new Selectweek());
				case 'freeplay':
					FlxG.switchState(new XdXd());
				case 'options':
					FlxG.switchState(new OptionsMenu());
				case 'spamton':
					FlxG.switchState(new PenisTrash());
			}
		}
		
			function changeItem(huh:Int = 0)
			{
				curSelected += huh;
		
				if (curSelected >= options.length)
					curSelected = 0;
				if (curSelected < 0)
					curSelected = options.length - 1;
		
				select.y = selectyy + (curSelected * 78.25);
		
				for (i in 0...options.length)
				{
					options[i].alpha = 1;
					options[i].color = FlxColor.WHITE;
					if (i == curSelected)
					{
						options[i].alpha = 1;
						options[i].color = FlxColor.YELLOW;
					}
				}
			}
		}