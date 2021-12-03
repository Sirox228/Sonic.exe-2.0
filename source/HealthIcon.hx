package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		// antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('bf-flipped-for-cam', [0, 1], 0, false, isPlayer);
		animation.add('bf-blue', [0, 1], 0, false, isPlayer);
		animation.add('bf-super', [0, 1], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('sonic', [25, 24], 0, false, isPlayer);
		animation.add('sonic.exe', [46, 47], 0, false, isPlayer);
		animation.add('sonic.exe alt', [42, 43], 0, false, isPlayer);
		animation.add('beast', [54, 55], 0, false, isPlayer);
		animation.add('beast-cam-fix', [54, 55], 0, false, isPlayer);
		animation.add('TDoll', [33], 0, false, isPlayer);
		animation.add('bf-SS', [32], 0, false, isPlayer);
		animation.add('sunky', [30, 31], 0, false, isPlayer);
		animation.add('sonicfun', [26, 27], 0, false, isPlayer);
		animation.add('duo', [26, 26], 0, false, isPlayer);
		animation.add('sonicLordX', [28, 29], 0, false, isPlayer);
		animation.add('faker', [34, 35], 0, false, isPlayer);
		animation.add('exe', [36, 37], 0, false, isPlayer);
		animation.add('sanic', [38, 39], 0, false, isPlayer);
		animation.add('tails', [48, 49], 0, false, isPlayer);
		animation.add('knucks', [50, 51], 0, false, isPlayer);
		animation.add('eggdickface', [52, 53], 0, false, isPlayer);
		animation.add('fleetway', [40, 41], 0, false, isPlayer);
		animation.add('bf-perspective', [0, 1], 0, false, isPlayer);
		animation.add('bf-perspective-flipped', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [44, 45], 0, false, isPlayer);
		animation.add('bf-flipped', [0, 1], 0, false, isPlayer);
		animation.play(char);

		switch (char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
