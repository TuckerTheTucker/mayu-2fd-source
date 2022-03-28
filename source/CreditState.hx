package;

//yknow this is the very first state i made all on my own. feel free to use it for your credits if youre making a mod too. its a great starting point to learn.
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import lime.app.Application;
import flixel.util.FlxTimer;
import lime.utils.Assets;

using StringTools;

#if windows
import Discord.DiscordClient;
#end

class CreditState extends MusicBeatState
{	
	var movedBack:Bool = false;
	
	var curView:Int = 0;
	
	var menuBG:FlxSprite;
	var enterText:FlxText;
	var headerText:FlxText;
	var footerText:FlxText;
	var iconsL:FlxSprite; 
	var iconsR:FlxSprite;
	var icons:FlxSprite; 
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var creditH:FlxSprite;
	
	var camFollow:FlxObject;
	
	var creditArray:Array<String> = [
		'TuckerTheTucker',
		'MayuChan12',
		'Big_gamerboi',
		'Mitt0'
	];
	
	var descArray:Array<String> = [
		'Coder',
		'Artist + Animator',
		'Musician',
		'Coder #2'
	];

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing The Credits", null);
		#end
		
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
		
		super.create();
		
		FlxG.sound.playMusic(Paths.music('breakfast', 'shared'), 0);
		FlxG.sound.music.fadeIn(2, 0, 0.7);
		
		menuBG = new FlxSprite(-202, -44);
		menuBG.scrollFactor.set(0.10, 0);
		menuBG.frames = Paths.getSparrowAtlas('BG');
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.2));
		menuBG.animation.addByPrefix('idle', "Title screen", 24);
		menuBG.antialiasing = true;
		menuBG.animation.play('idle');
		menuBG.updateHitbox();
		add(menuBG);
		
		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		
		enterText = new FlxText(10, FlxG.height - 25, 0, "Press ENTER to view Twitter Acc.", 16);
		enterText.setFormat(Paths.font("pm.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		enterText.scrollFactor.set();
		add(enterText);
		
		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');
		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		
		leftArrow = new FlxSprite(400, 270);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.scrollFactor.set();
		add(leftArrow);
		
		rightArrow = new FlxSprite(leftArrow.x + 460, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.scrollFactor.set();
		add(rightArrow);
		
		headerText = new FlxText(0, 130, 16384, 'TuckerTheTucker', 36);
		headerText.screenCenter(X);
		headerText.setFormat(Paths.font("pm.ttf"), 36, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		headerText.wordWrap = false;
		headerText.autoSize = false;
		headerText.alignment = CENTER;
		headerText.scrollFactor.set();
		add(headerText);
		
		footerText = new FlxText(0, 440, 16384, 'Coder', 24); //fieldWidth cant be 0 -_-
		footerText.screenCenter(X);
		footerText.setFormat(Paths.font("pm.ttf"), 24, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		footerText.wordWrap = false;
		footerText.autoSize = false;
		footerText.alignment = CENTER;
		footerText.scrollFactor.set();
		add(footerText);
		
		iconsL = new FlxSprite(leftArrow.x - 250, 230);
		iconsL.loadGraphic(Paths.image('creditGrid', 'shared'), true, 150, 150);
		iconsL.setGraphicSize(Std.int(iconsL.width * 1.5));
		iconsL.antialiasing = true;
		iconsL.alpha = 0.4;
		iconsL.scrollFactor.set();
		iconsL.updateHitbox();
		iconsL.animation.add('thegang', [0, 1, 2, 3], 0);
		iconsL.animation.play('thegang');
		add(iconsL);
		
		iconsR = new FlxSprite(rightArrow.x + 100, 230);
		iconsR.loadGraphic(Paths.image('creditGrid', 'shared'), true, 150, 150);
		iconsR.setGraphicSize(Std.int(iconsR.width * 1.5));
		iconsR.antialiasing = true;
		iconsR.alpha = 0.4;
		iconsR.scrollFactor.set();
		iconsR.updateHitbox();
		iconsR.animation.add('thegang', [0, 1, 2, 3], 0);
		iconsR.animation.play('thegang');
		add(iconsR);
		
		icons = new FlxSprite(570, 230);
		icons.loadGraphic(Paths.image('creditGrid', 'shared'), true, 150, 150);
		icons.setGraphicSize(Std.int(icons.width * 2));
		icons.antialiasing = true;
		icons.scrollFactor.set();
		iconsR.updateHitbox();
		icons.animation.add('thegang', [0, 1, 2, 3], 0);
		icons.animation.play('thegang');
		add(icons);
		
		creditH = new FlxSprite(0, 500);
		creditH.frames = tex;
		creditH.animation.addByPrefix('idle', "donate basic", 24);
		creditH.animation.play('idle');
		creditH.screenCenter(X);
		creditH.scrollFactor.set();
		creditH.antialiasing = true;
		add(creditH);
		
		changePerson(0);
		
		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		
	};
	
	var mm:Int = 1;
	
	override function update(elapsed:Float)
	{
		//i shouldnt need to do this but i gotta get this demo out in the morning aaaaaa
		if (curView == 0)
			iconsL.animation.curAnim.curFrame = 3;
		else if (curView == 1)
			iconsL.animation.curAnim.curFrame = 0;
		else if (curView == 2)
			iconsL.animation.curAnim.curFrame = 1;
		else if (curView == 3)
			iconsL.animation.curAnim.curFrame = 2;
			
		if (camFollow.x > 200)
			camFollow.x = 200;
			
		if (camFollow.x < -200)
			camFollow.x = -200;
		
		if (controls.LEFT_P)
		{
			camFollow.x -= 50;
			changePerson( -1);
		}
			
		if (controls.RIGHT_P)
		{
			camFollow.x += 50;
			changePerson(1);
		}
			
		if (controls.LEFT)
			leftArrow.animation.play('press');
		else
			leftArrow.animation.play('idle');
			
		if (controls.RIGHT)
			rightArrow.animation.play('press');
		else
			rightArrow.animation.play('idle');
			
		if (controls.BACK && !movedBack)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}
		
		if (controls.ACCEPT && !movedBack)
			goToTwitter();
		
		super.update(elapsed);
	}
	
	var camTracker:Int = 0;
	
	function changePerson(cbt:Int)
	{
		curView += cbt;
		
		if (curView > 3)
			curView = 0;
		if (curView < 0)
			curView = 3;
			
		FlxG.sound.play(Paths.sound('scrollMenu'));
		
		if (creditArray != null)
			headerText.text = creditArray[curView];
		
		if (descArray != null)
			footerText.text = descArray[curView];
			
		icons.animation.curAnim.curFrame = curView;
		iconsR.animation.curAnim.curFrame = (curView + 1);
		
		if (iconsR.animation.curAnim.curFrame > 3)
			iconsR.animation.curAnim.curFrame = 0;
		if (iconsR.animation.curAnim.curFrame < 0)
			iconsR.animation.curAnim.curFrame = 3;
	}
	
	function goToTwitter():Void
	{
		var daChoice:String = creditArray[curView];
		
		switch (daChoice.toLowerCase())
		{
			case 'tuckerthetucker':
				fancyOpenURL("https://twitter.com/TuckerTheTucker");
			case 'mayuchan12':
				fancyOpenURL("https://twitter.com/MeganeStudio102");
			case 'big_gamerboi':
				fancyOpenURL("https://twitter.com/GamerboiBig");
			case 'mitt0':
				fancyOpenURL("https://twitter.com/RHeating5");
		}
	}
}	