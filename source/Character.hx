package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var nonanimated:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-exe':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/exe_gf_assets');
				frames = tex;
				animation.addByIndices('sad', 'gf miss', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'gf dance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'gf dance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -9, -20);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'gf-pixel':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/Pixel_gf');
				frames = tex;
				animation.addByIndices('sad', 'Pixel gf miss', [0, 1, 2, 3, 4], "", 24, false);
				animation.addByIndices('danceLeft', 'Pixel gf dance', [0, 1, 2, 3], "", 24, false);
				animation.addByIndices('danceRight', 'Pixel gf dance', [4, 5, 6, 7], "", 24, false);

				addOffset('sad', -9, -20);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * 10));
				updateHitbox();

				antialiasing = false;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('dodge');

				playAnim('idle');

				flipX = true;

			case 'bf-flipped-for-cam':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);
				addOffset('dodge');

				playAnim('idle');

				flipX = true;

			case 'bf-perspective':
				var tex = Paths.getSparrowAtlas('characters/BFPhase3_Perspective', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Sing_Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing_Left', 24, false);
				animation.addByPrefix('singLEFT', 'Sing_Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing_Down', 24, false);
				animation.addByPrefix('singUPmiss', 'Up_Miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Left_Miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Miss_Right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Down_Miss', 24, false);

				addOffset('idle', 5, 4);
				addOffset("singUP", 23, 63);
				addOffset("singLEFT", 31, 9);
				addOffset("singRIGHT", -75, -15);
				addOffset("singDOWN", -51, -1);
				addOffset("singUPmiss", 20, 135);
				addOffset("singLEFTmiss", 10, 92);
				addOffset("singRIGHTmiss", -70, 85);
				addOffset("singDOWNmiss", -53, 10);

				playAnim('idle');

				flipX = true;

			case 'bf-perspective-flipped':
				var tex = Paths.getSparrowAtlas('characters/BFPhase3_Perspective_Flipped', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'Idle_Flip', 24, false);
				animation.addByPrefix('singUP', 'Sing_Up_Flip', 24, false);
				animation.addByPrefix('singLEFT', 'Sing_Left_Flip', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing_Right_Flip', 24, false);
				animation.addByPrefix('singDOWN', 'Sing_Down_Flip', 24, false);
				animation.addByPrefix('singUPmiss', 'Up_Miss_Flip', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Left_Miss_Flip', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Right_Miss_Flip', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Down_Miss_Flip', 24, false);

				addOffset('idle', 46, -12);
				addOffset("singUP", -22, 41);
				addOffset("singRIGHT", 29, 9);
				addOffset("singLEFT", 96, -12);
				addOffset("singDOWN", 74, -14);
				addOffset("singUPmiss", -22, 133);
				addOffset("singRIGHTmiss", 106, 75);
				addOffset("singLEFTmiss", 106, 75);
				addOffset("singDOWNmiss", 105, 1);

				playAnim('idle');

				flipX = true;

			case 'bf-blue':
				var tex = Paths.getSparrowAtlas('characters/endless_bf', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('premajin', 'Majin Reveal Windup', 24, false);
				animation.addByPrefix('majin', 'Majin BF Reveal', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset('premajin');
				addOffset('majin');

				playAnim('idle');

				flipX = true;

			case 'bf-pixel':
				var tex = Paths.getSparrowAtlas('characters/BF', 'shared');
				frames = tex;

				trace(tex.frames.length);

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);

				addOffset('idle', -10, 4);
				addOffset("singUP", -14, 3);
				addOffset("singRIGHT", -10, 3);
				addOffset("singLEFT", -11, 4);
				addOffset("singDOWN", -11, 4);
				addOffset("singUPmiss", -11, 4);
				addOffset("singRIGHTmiss", -11, 4);
				addOffset("singLEFTmiss", -14, 3);
				addOffset("singDOWNmiss", -11, 4);
				addOffset('firstDeath', -8, 0);
				playAnim('idle');

				flipX = true;

				setGraphicSize(Std.int(width * 10));
				updateHitbox();

				antialiasing = false;

			case 'sonic':
				tex = Paths.getSparrowAtlas('characters/Sonic_EXE_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICmoveIDLE', 24);
				animation.addByPrefix('singUP', 'SONICmoveUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICmoveRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICmoveDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICmoveLEFT', 24);
				animation.addByPrefix('iamgod', 'sonicImmagetya', 24, false);

				animation.addByPrefix('singDOWN-alt', 'SONIClaugh', 24);

				animation.addByPrefix('singLAUGH', 'SONIClaugh', 24);

				addOffset('idle');
				addOffset('iamgod', 127, 10);
				addOffset("singUP", 14, 47);
				addOffset("singRIGHT", 16, 14);
				addOffset("singLEFT", 152, -15);
				addOffset("singDOWN", 77, -12);
				addOffset("singLAUGH", 50, -10);

				addOffset("singDOWN-alt", 50, -10);

				playAnim('idle');
			case 'sonicfun':
				tex = Paths.getSparrowAtlas('characters/SonicFunAssets');
				frames = tex;
				animation.addByPrefix('idle', 'SONICFUNIDLE', 24);
				animation.addByPrefix('singUP', 'SONICFUNUP', 24);
				animation.addByPrefix('singRIGHT', 'SONICFUNRIGHT', 24);
				animation.addByPrefix('singDOWN', 'SONICFUNDOWN', 24);
				animation.addByPrefix('singLEFT', 'SONICFUNLEFT', 24);

				addOffset('idle', -21, 66);
				addOffset("singUP", 21, 70);
				addOffset("singRIGHT", -86, 15);
				addOffset("singLEFT", 393, -60);
				addOffset("singDOWN", 46, -80);

				playAnim('idle');

			case 'sonicLordX':
				frames = Paths.getSparrowAtlas('characters/SONIC_X');
				animation.addByPrefix('idle', 'X_Idle', 24, false);
				animation.addByPrefix('singUP', 'X_Up', 24, false);
				animation.addByPrefix('singDOWN', 'X_Down', 24, false);
				animation.addByPrefix('singLEFT', 'X_Left', 24, false);
				animation.addByPrefix('singRIGHT', 'X_Right', 24, false);

				addOffset('idle', -18, 0);
				addOffset("singUP", 34, 121);
				addOffset("singRIGHT", -86, 40);
				addOffset("singLEFT", 17, 20);
				addOffset("singDOWN", 77, -21);

				setGraphicSize(Std.int(width * 1.2));

				updateHitbox();
			case 'sunky':
				tex = Paths.getSparrowAtlas('characters/Sunky');
				frames = tex;
				animation.addByPrefix('idle', 'sunkyIDLE instance 1', 24);
				animation.addByPrefix('singUP', 'sunkyUP instance 1', 24);
				animation.addByPrefix('singRIGHT', 'sunkyRIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'sunkyDOWN instance 1', 24);
				animation.addByPrefix('singLEFT', 'sunkyLEFT instance 1', 24);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

			case 'TDoll':
				tex = Paths.getSparrowAtlas('characters/Tails_Doll');
				frames = tex;
				animation.addByPrefix('idle', 'TailsDoll IDLE instance 1', 24);
				animation.addByPrefix('singUP', 'TailsDoll UP instance 1', 24);
				animation.addByPrefix('singRIGHT', 'TailsDoll RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'TailsDoll DOWN instance 1', 24);
				animation.addByPrefix('singLEFT', 'TailsDoll LEFT instance 1', 24);

				addOffset('idle', -21, 189);
				addOffset("singUP", 0, 297);
				addOffset("singRIGHT", -164, 187);
				addOffset("singLEFT", 80, 156);
				addOffset("singDOWN", -34, 70);

				playAnim('idle');

			case 'TDollAlt':
				tex = Paths.getSparrowAtlas('characters/Tails_Doll_Alt');
				frames = tex;
				animation.addByPrefix('idle', 'TailsDoll IDLE instance', 24);
				animation.addByPrefix('singUP', 'TailsDoll UP instance', 24);
				animation.addByPrefix('singRIGHT', 'TailsDoll RIGHT instance', 24);
				animation.addByPrefix('singDOWN', 'TailsDoll DOWN instance', 24);
				animation.addByPrefix('singLEFT', 'TailsDoll LEFT instance', 24);

				addOffset('idle', -21, 189);
				addOffset("singUP", 0, 297);
				addOffset("singRIGHT", -164, 187);
				addOffset("singLEFT", 80, 156);
				addOffset("singDOWN", -34, 70);

				playAnim('idle');

			case 'bf-SS':
				tex = Paths.getSparrowAtlas('characters/SSBF_Assets');
				frames = tex;

				animation.addByPrefix('idle', 'SSBF IDLE instance 1', 24);
				animation.addByPrefix('singUP', 'SSBF UP instance 1', 24);
				animation.addByPrefix('singLEFT', 'SSBF LEFT instance 1', 24);
				animation.addByPrefix('singRIGHT', 'SSBF RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'SSBF DOWN instance 1', 24);
				animation.addByPrefix('singUPmiss', 'SSBF UPmiss instance 1', 24);
				animation.addByPrefix('singLEFTmiss', 'SSBF LEFTmiss instance 1', 24);
				animation.addByPrefix('singRIGHTmiss', 'SSBF RIGHTmiss instance 1', 24);
				animation.addByPrefix('singDOWNmiss', 'SSBF DOWNmiss instance 1', 24);

				addOffset('idle', -5);
				addOffset("singUP", -5, 6);
				addOffset("singRIGHT", -12, -1);
				addOffset("singLEFT", 18, 12);
				addOffset("singDOWN", -2, -9);
				addOffset("singUPmiss", -11, 6);
				addOffset("singRIGHTmiss", 3, 11);
				addOffset("singLEFTmiss", 14, 0);
				addOffset("singDOWNmiss", 13, 17);

				playAnim('idle');

				flipX = true;

			case 'bf-super':
				tex = Paths.getSparrowAtlas('characters/Super_BoyFriend_Assets');
				frames = tex;

				animation.addByPrefix('idle', 'BF Super idle dance instance 1', 24);
				animation.addByPrefix('singUP', 'BF NOTE UP instance 1', 24);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT instance 1', 24);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN instance 1', 24);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS instance 1', 24);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS instance 1', 24);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS instance 1', 24);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS instance 1', 24);

				addOffset('idle', 56, 11);
				addOffset("singUP", 51, 40);
				addOffset("singRIGHT", 13, 9);
				addOffset("singLEFT", 64, 14);
				addOffset("singDOWN", 60, -71);
				addOffset("singUPmiss", 48, 36);
				addOffset("singRIGHTmiss", 3, 11);
				addOffset("singLEFTmiss", 55, 13);
				addOffset("singDOWNmiss", 56, -72);

				playAnim('idle');

				flipX = true;

			case 'sonic.exe':
				frames = Paths.getSparrowAtlas('characters/P2Sonic_Assets');
				animation.addByPrefix('idle', 'NewPhase2Sonic Idle instance 1', 24, false);
				animation.addByPrefix('singUP', 'NewPhase2Sonic Up instance 1', 24, false);
				animation.addByPrefix('singDOWN', 'NewPhase2Sonic Down instance 1', 24, false);
				animation.addByPrefix('singLEFT', 'NewPhase2Sonic Left instance 1', 24, false);
				animation.addByPrefix('singRIGHT', 'NewPhase2Sonic Right instance 1', 24, false);
				animation.addByPrefix('laugh', 'NewPhase2Sonic Laugh instance 1', 24, false);

				addOffset('idle', -18, 70);
				addOffset("singUP", -4, 60);
				addOffset("singRIGHT", 42, -127);
				addOffset("singLEFT", 159, -105);
				addOffset("singDOWN", -15, -57);
				addOffset("laugh", 0, 0);

				antialiasing = true;

				playAnim('idle');

			case 'sonic.exe alt':
				frames = Paths.getSparrowAtlas('characters/Sonic_EXE_Pixel');
				animation.addByPrefix('idle', 'Sonic_EXE_Pixel idle', 24, false);
				animation.addByPrefix('singUP', 'Sonic_EXE_Pixel NOTE UP', 24, false);
				animation.addByPrefix('singDOWN', 'Sonic_EXE_Pixel Sonic_EXE_Pixel NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Sonic_EXE_Pixel Sonic_EXE_Pixel NOTE LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Sonic_EXE_Pixel NOTE RIGHT', 24, false);

				addOffset('idle', -18, 70);
				addOffset("singUP", -17, 65);
				addOffset("singRIGHT", 0, 68);
				addOffset("singLEFT", 0, 72);
				addOffset("singDOWN", -20, 64);

				antialiasing = false;

				playAnim('idle');

				setGraphicSize(Std.int(width * 12));
				updateHitbox();

			case 'beast':
				frames = Paths.getSparrowAtlas('characters/Beast');
				animation.addByPrefix('idle', 'Beast_IDLE', 24, false);
				animation.addByPrefix('singUP', 'Beast_UP', 24, false);
				animation.addByPrefix('singDOWN', 'Beast_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Beast_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Beast_RIGHT', 24, false);
				animation.addByPrefix('laugh', 'Beast_LAUGH', 24, false);

				addOffset('idle', -18, 70);
				addOffset("singUP", 22, 143);
				addOffset("singRIGHT", -260, 11);
				addOffset("singLEFT", 177, -24);
				addOffset("singDOWN", -15, -57);
				addOffset("laugh", -78, -128);

				antialiasing = true;

				playAnim('idle');

			case 'beast-cam-fix':
				frames = Paths.getSparrowAtlas('characters/Beast');
				animation.addByPrefix('idle', 'Beast_IDLE', 24, false);
				animation.addByPrefix('singUP', 'Beast_UP', 24, false);
				animation.addByPrefix('singDOWN', 'Beast_DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Beast_LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'Beast_RIGHT', 24, false);
				animation.addByPrefix('laugh', 'Beast_LAUGH', 24, false);

				addOffset('idle', -18, 70);
				addOffset("singUP", 22, 143);
				addOffset("singRIGHT", -260, 11);
				addOffset("singLEFT", 177, -24);
				addOffset("singDOWN", -15, -57);
				addOffset("laugh", -78, -128);

				antialiasing = true;

				playAnim('idle');

			case 'faker':
				tex = Paths.getSparrowAtlas('characters/Faker_EXE_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'FAKER IDLE instance 1', 24);
				animation.addByPrefix('singUP', 'FAKER UP instance 1', 24);
				animation.addByPrefix('singRIGHT', 'FAKER RIGHT instance 1', 24);
				animation.addByPrefix('singDOWN', 'FAKER DOWN instance 1', 24);
				animation.addByPrefix('singLEFT', 'FAKER LEFT instance 1', 24);

				addOffset('idle');
				addOffset("singUP", 0, 67);
				addOffset("singRIGHT", 24, 32);
				addOffset("singLEFT", 177, 29);
				addOffset("singDOWN", -50, -36);
			case 'exe':
				tex = Paths.getSparrowAtlas('characters/Exe_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'Exe Idle', 24);
				animation.addByPrefix('singUP', 'Exe Up', 24);
				animation.addByPrefix('singRIGHT', 'Exe Right', 24);
				animation.addByPrefix('singDOWN', 'Exe Down', 24);
				animation.addByPrefix('singLEFT', 'Exe left', 24);

				addOffset('idle', 0, 248);
				addOffset("singUP", 95, 290);
				addOffset("singRIGHT", 31, 217);
				addOffset("singLEFT", 236, 243);
				addOffset("singDOWN", 185, 44);
			case 'sanic':
				tex = Paths.getSparrowAtlas('characters/sanic');
				frames = tex;
				animation.addByPrefix('idle', 'sanic idle', 24);
				animation.addByPrefix('singUP', 'sanic up', 24);
				animation.addByPrefix('singRIGHT', 'sanic right', 24);
				animation.addByPrefix('singDOWN', 'sanic down', 24);
				animation.addByPrefix('singLEFT', 'sanic left', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 0, 0);
				addOffset("singRIGHT", 0, 0);
				addOffset("singLEFT", 0, 0);
				addOffset("singDOWN", 0, 0);

				setGraphicSize(Std.int(width * 0.3));
				updateHitbox();
			case 'knucks':
				tex = Paths.getSparrowAtlas('characters/KnucklesEXE');
				frames = tex;
				animation.addByPrefix('idle', 'Knux Idle', 24);
				animation.addByPrefix('singUP', 'Knux Up', 24);
				animation.addByPrefix('singRIGHT', 'Knux Left', 24);
				animation.addByPrefix('singDOWN', 'Knux Down', 24);
				animation.addByPrefix('singLEFT', 'Knux Right', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 29, 49);
				addOffset("singRIGHT", 124, -59);
				addOffset("singLEFT", -59, -65);
				addOffset("singDOWN", 26, -95);

				flipX = true;

			case 'tails':
				tex = Paths.getSparrowAtlas('characters/Tails');
				frames = tex;
				animation.addByPrefix('idle', 'Tails IDLE', 24);
				animation.addByPrefix('singUP', 'Tails UP', 24);
				animation.addByPrefix('singRIGHT', 'Tails RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Tails DOWN', 24);
				animation.addByPrefix('singLEFT', 'Tails LEFT', 24);

				addOffset('idle', 0, 0);
				addOffset("singUP", 29, 49);
				addOffset("singRIGHT", 14, -16);
				addOffset("singLEFT", 158, -14);
				addOffset("singDOWN", 33, -60);
				setGraphicSize(Std.int(width * 1.2));

				updateHitbox();

			case 'eggdickface':
				tex = Paths.getSparrowAtlas('characters/eggman_soul');
				frames = tex;
				animation.addByPrefix('idle', 'Eggman_Idle', 24);
				animation.addByPrefix('singUP', 'Eggman_Up', 24);
				animation.addByPrefix('singRIGHT', 'Eggman_Right', 24);
				animation.addByPrefix('singDOWN', 'Eggman_Down', 24);
				animation.addByPrefix('singLEFT', 'Eggman_Left', 24);
				animation.addByPrefix('laugh', 'Eggman_Laugh', 35, false);

				addOffset('idle', -5, 5);
				addOffset("singUP", 110, 231);
				addOffset("singRIGHT", 40, 174);
				addOffset("singLEFT", 237, 97);
				addOffset("singDOWN", 49, -95);
				addOffset('laugh', -10, 210);

				updateHitbox();

			case 'fleetway':
				tex = Paths.getSparrowAtlas('characters/Fleetway_Super_Sonic');
				frames = tex;
				animation.addByPrefix('idle', 'Fleetway Idle', 24);
				animation.addByPrefix('singUP', 'Fleetway Up', 24);
				animation.addByPrefix('singRIGHT', 'Fleetway Right', 24);
				animation.addByPrefix('singDOWN', 'Fleetway Down', 24);
				animation.addByPrefix('singLEFT', 'Fleetway Left', 24);
				animation.addByPrefix('fastanim', 'Fleetway HowFast', 24, false);

				addOffset('idle', 0, 0);
				addOffset("singUP", 0, 36);
				addOffset("singRIGHT", -62, -64);
				addOffset("singLEFT", 221, -129);
				addOffset("singDOWN", 0, -168);
				addOffset("fastanim", 0, 0);

				updateHitbox();

			case 'fleetway-extras':
				tex = Paths.getSparrowAtlas('characters/fleetway1');
				frames = tex;
				animation.addByPrefix('a', 'Fleetway StepItUp', 24, false);
				animation.addByPrefix('b', 'Fleetway Laugh', 24, false);
				animation.addByPrefix('c', 'Fleetway Too Slow', 24, false);
				animation.addByPrefix('d', 'Fleetway YoureFinished', 24, false);
				animation.addByPrefix('e', 'Fleetway WHAT?!', 24, false);
				animation.addByPrefix('f', 'Fleetway Grrr', 24, false);

				addOffset('a', 0, 0);
				addOffset("b", 0, 0);
				addOffset("c", 0, 0);
				addOffset("d", 0, 0);
				addOffset("e", 0, 0);
				addOffset("f", 0, 0);

				updateHitbox();

				playAnim('a', true);
				playAnim('b', true);
				playAnim('c', true);
				playAnim('d', true);
				playAnim('e', true);
				playAnim('f', true);

			case 'fleetway-extras2':
				tex = Paths.getSparrowAtlas('characters/fleetway2');
				frames = tex;
				animation.addByPrefix('a', 'Fleetway Show You', 24, false);
				animation.addByPrefix('b', 'Fleetway Scream', 24, false);
				animation.addByPrefix('c', 'Fleetway Growl', 24, false);
				animation.addByPrefix('d', 'Fleetway Shut Up', 24, false);
				animation.addByPrefix('e', 'Fleetway Right Alt', 24, true);

				addOffset('a', 0, 0);
				addOffset("b", 0, 0);
				addOffset("c", 0, 0);
				addOffset("d", 0, 0);
				addOffset("e", 0, 0);

				updateHitbox();

				playAnim('a', true);
				playAnim('b', true);
				playAnim('c', true);
				playAnim('d', true);
				playAnim('e', true);

			case 'fleetway-extras3':
				tex = Paths.getSparrowAtlas('characters/fleetway3');
				frames = tex;
				animation.addByPrefix('a', 'Fleetway Laser Blas', 24, false);

				addOffset('a', 0, 0);

				updateHitbox();

				playAnim('a', true);
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf') && !curCharacter.startsWith('gf-') && !curCharacter.contains('-extras'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode && !nonanimated)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-exe':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');

				case 'gf-pixel':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');

				case 'fleetway-extras', 'fleetway-extras2', 'fleetway-extras3':

				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (!nonanimated)
		{
			animation.play(AnimName, Force, Reversed, Frame);

			var daOffset = animOffsets.get(AnimName);
			if (animOffsets.exists(AnimName))
			{
				offset.set(daOffset[0], daOffset[1]);
			}
			else
				offset.set(0, 0);

			if (curCharacter == 'gf')
			{
				if (AnimName == 'singLEFT')
				{
					danced = true;
				}
				else if (AnimName == 'singRIGHT')
				{
					danced = false;
				}

				if (AnimName == 'singUP' || AnimName == 'singDOWN')
				{
					danced = !danced;
				}
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
