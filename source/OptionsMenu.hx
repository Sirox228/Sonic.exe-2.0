package;

import flixel.FlxCamera;
import cpp.abi.Abi;
import flixel.util.FlxTimer;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Lib;
import Options;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class OptionsMenu extends MusicBeatState
{
	public static var instance:OptionsMenu;

	var selector:FlxText;
	var curSelected:Int = 0;
	var cheat:Bool = false;
	var canselect:Bool = true;


	var options:Array<OptionCategory> = [
		new OptionCategory("Sonic exe", [
			new JumpscareOption("Displays jumpscares in some songs (this affects the gameplay preformance by alot)"),
			new Vfx("Enables special visual effects (turning it off helps with memory and preformace)"),
			new SplashOption("Enables splattering blood on SICK! hits."),
			new CamMove("Makes the camera move to the notes you or your opponent presses."),
			new LowQuality('Removes parts of the stage in order to achieve smoother gameplay.')
		]),
		new OptionCategory("Gameplay", [
			new DFJKOption(controls),
			new DownscrollOption("Change the layout of the strumline."),
			new MiddlescrollOption("Sets the strumline to the middle of the screen and hides the opponent's."),
			new GhostTapOption("Ghost Tapping is when you tap a direction and it doesn't give you a miss."),
			new Judgement("Customize your Hit Timings (LEFT or RIGHT)"),
			new FPSCapOption("Cap your FPS"),
			new ScrollSpeedOption("Change your scroll speed (1 = Chart dependent)"),
			new AccuracyDOption("Change how accuracy is calculated. (Accurate = Simple, Complex = Milisecond Based)"),
			new ResetButtonOption("Toggle pressing R to gameover."),
			// new OffsetMenu("Get a note offset based off of your inputs!"),
			new CustomizeGameplay("Drag'n'Drop Gameplay Modules around to your preference")
		]),
		new OptionCategory("Appearance", [
			new DistractionsAndEffectsOption("Toggle stage distractions that can hinder your gameplay."),
			new CamZoomOption("Toggle the camera zoom in-game."),
			new RainbowFPSOption("Make the FPS Counter Rainbow"),
			new AccuracyOption("Display accuracy information."),
			new NPSDisplayOption("Shows your current Notes Per Second."),
			new SongPositionOption("Show the songs current position (as a bar)"),
			new CpuStrums("CPU's strumline lights up when a note hits it."),
		]),
		
		new OptionCategory("Misc", [
			new FPSOption("Toggle the FPS Counter"),
			new FlashingLightsOption("Toggle flashing lights that can cause epileptic seizures and strain."),
			new WatermarkOption("Enable and disable all watermarks from the engine."),
			new ShowInput("Display every single input in the score screen."),
			//new Optimization("No backgrounds, no characters, centered notes, no player 2.")
			new BotPlay("Showcase your charts and mods with autoplay."),
		]),
		
		new OptionCategory("TESTING, PLEASE DONT CHEAT", [
		    new RealBot('The coolest botplay'),
		]),
		
		new OptionCategory("Mobile settings", [
			new About("about android port")
		])
		
	];

	public var acceptInput:Bool = true;

	private var currentDescription:String = "";
	private var grpControls:FlxTypedGroup<Alphabet>;
	public static var versionShit:FlxText;

	var currentSelectedCat:OptionCategory;
	var blackBorder:FlxSprite;
	override function create()
	{
		instance = this;
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBGBlue"));

		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...options.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false, true);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		currentDescription = "none";

		versionShit = new FlxText(5, FlxG.height + 40, 0, "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		
		blackBorder = new FlxSprite(-30,FlxG.height + 40).makeGraphic((Std.int(versionShit.width + 900)),Std.int(versionShit.height + 600),FlxColor.BLACK);
		blackBorder.alpha = 0.5;

		add(blackBorder);

		add(versionShit);

		FlxTween.tween(versionShit,{y: FlxG.height - 18},2,{ease: FlxEase.elasticInOut});
		FlxTween.tween(blackBorder,{y: FlxG.height - 18},2, {ease: FlxEase.elasticInOut});
		
		#if mobileC
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	var isCat:Bool = false;
	

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (acceptInput)
		{
			if (controls.BACK && !isCat)
				{
				FlxG.switchState(new MainMenuState());
				trace("back to da menu");
				}
			else if (controls.BACK)
			{
				isCat = false;
				grpControls.clear();
				for (i in 0...options.length)
				{
					var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, options[i].getName(), true, false);
					controlLabel.isMenuItem = true;
					controlLabel.targetY = i;
					grpControls.add(controlLabel);
					// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
				}
				
				curSelected = 0;
				
				changeSelection(curSelected);
			}

			var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
			if (canselect)
			{
				if (gamepad != null)
				{
					if (gamepad.justPressed.DPAD_UP)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						changeSelection(-1);
					}
					if (gamepad.justPressed.DPAD_DOWN)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						changeSelection(1);
					}
				}
				
				if (controls.UP_P)
					changeSelection(-1);
				if (controls.DOWN_P)
					changeSelection(1);
			}
			
			if (isCat)
			{
				if (currentSelectedCat.getOptions()[curSelected].getAccept())
				{
					if (FlxG.keys.pressed.SHIFT)
						{
							if (controls.RIGHT)
								currentSelectedCat.getOptions()[curSelected].right();
							if (controls.LEFT)
								currentSelectedCat.getOptions()[curSelected].left();
						}
					else
					{
						if (controls.RIGHT_P)
							currentSelectedCat.getOptions()[curSelected].right();
						if (controls.LEFT_P)
							currentSelectedCat.getOptions()[curSelected].left();
					}
				}
				else
				{
					if (FlxG.keys.pressed.SHIFT)
					{
						if (controls.RIGHT_P)
							FlxG.save.data.offset += 0.1;
						else if (controls.LEFT_P)
							FlxG.save.data.offset -= 0.1;
					}
					else if (controls.RIGHT)
						FlxG.save.data.offset += 0.1;
					else if (controls.LEFT)
						FlxG.save.data.offset -= 0.1;
					
					versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;
				}
				if (currentSelectedCat.getOptions()[curSelected].getAccept())
					versionShit.text =  currentSelectedCat.getOptions()[curSelected].getValue() + " - Description - " + currentDescription;
				else
					versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;
			}
			else
			{
				if (FlxG.keys.pressed.SHIFT)
				{
					if (controls.RIGHT_P)
						FlxG.save.data.offset += 0.1;
					else if (controls.LEFT_P)
						FlxG.save.data.offset -= 0.1;
				}
				else if (controls.RIGHT)
					FlxG.save.data.offset += 0.1;
				else if (controls.LEFT)
					FlxG.save.data.offset -= 0.1;
				
				versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;
			}
		

			if (controls.RESET)
					FlxG.save.data.offset = 0;

			if (controls.ACCEPT && canselect)
			{
				if (isCat)
				{
					if (currentSelectedCat.getOptions()[curSelected].press()) {
						grpControls.members[curSelected].reType(currentSelectedCat.getOptions()[curSelected].getDisplay());
						trace(currentSelectedCat.getOptions()[curSelected].getDisplay());
						if (currentSelectedCat.getOptions()[curSelected].getDisplay().startsWith('BotPlay'))
						{
							var camera:FlxCamera;
							camera = new FlxCamera();
							FlxG.cameras.add(camera);
							canselect = false;
							FlxG.sound.music.stop();
							var nocheat:FlxSprite = new FlxSprite().loadGraphic(Paths.image('nocheating', 'exe'));
							nocheat.alpha = 0;
							nocheat.cameras = [camera];
							add(nocheat);
							new FlxTimer().start(2, function(ok:FlxTimer)
							{
								FlxTween.tween(nocheat, {alpha:1}, 1, {onComplete: function(ok:FlxTween)
								{
									cheat = true;
									FlxG.save.data.fakebotplay = false;
								}});
							});
						}
					}
				}
				else
				{
					currentSelectedCat = options[curSelected];
					isCat = true;
					grpControls.clear();
					for (i in 0...currentSelectedCat.getOptions().length)
						{
							var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, currentSelectedCat.getOptions()[i].getDisplay(), true, false);
							controlLabel.isMenuItem = true;
							controlLabel.targetY = i;
							grpControls.add(controlLabel);
							// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
						}
					curSelected = 0;
				}
				
				changeSelection();
			}
			else if (!canselect && cheat && controls.ACCEPT)
			{
				FlxG.sound.music.play();
				FlxG.switchState(new OptionsMenu());
			}
		}
		FlxG.save.flush();
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent("Fresh");
		#end
		
		FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		if (isCat)
			currentDescription = currentSelectedCat.getOptions()[curSelected].getDescription();
		else
			currentDescription = "Please select a category";
		if (isCat)
		{
			if (currentSelectedCat.getOptions()[curSelected].getAccept())
				versionShit.text =  currentSelectedCat.getOptions()[curSelected].getValue() + " - Description - " + currentDescription;
			else
				versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;
		}
		else
			versionShit.text = "Offset (Left, Right, Shift for slow): " + HelperFunctions.truncateFloat(FlxG.save.data.offset,2) + " - Description - " + currentDescription;
		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
