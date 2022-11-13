local iconSizeX = 1;
local iconSizeY = 1;

local iconSpeed = 0;

local iconP1X = 0;
local iconP1Y = 0;

local iconP2X = 0;
local iconP2Y = 0;

local funnies = false;

local stretchBumping = false; -- yknow like that one uhhhhhhhhh bave and dambi mod? idk

local fuck = 0;
local shit = 0;

-- Sword Icon System by swordcube
-- This script remakes how the icons work, and adds winning icons in the process!

-- You need to put your icons in a path like this:
-- mods/xml-icons/cool-guy/assets

-- You need: assets.png, and assets.xml, grab both files from the "dad" folder for a template.

function onCreatePost()
	-- putting semicolons because i'm too used to doing it in haxe

	-- hide og icons
	setProperty('iconP1.alpha', 0);
	setProperty('iconP2.alpha', 0);

	-- add dad and bf icon
	makeIcons();
end

function onUpdatePost(elapsed)
	if curBeat == 0 then
		if not funnies then
			iconP2X = getProperty('iconP2.x');
			iconP2Y = getProperty('iconP2.y');

			iconP1X = getProperty('iconP1.x');
			iconP1Y = getProperty('iconP1.y');
			funnies = true;
		end
	end
	
	if stretchBumping then
		iconSpeed = elapsed * 2.5;
	else
		iconSpeed = elapsed * 2;
	end

	iconSizeX = iconSizeX - iconSpeed;
	
	if stretchBumping then
		iconSizeY = iconSizeY + iconSpeed;
	else
		iconSizeY = iconSizeY - iconSpeed;
	end

	if iconSizeX < 1 then
		iconSizeX = 1;
	end

	if stretchBumping then
		if iconSizeY > 1 then
			iconSizeY = 1;
		end
	else
		if iconSizeY < 1 then
			iconSizeY = 1;
		end
	end

	scaleObject('dadIcon', iconSizeX, iconSizeY);
	scaleObject('bfIcon', iconSizeX, iconSizeY);

	positionIcons();

	playIconAnims();
end

function onBeatHit()
	if stretchBumping then
		iconSizeX = 1.2;
		iconSizeY = 0.8;
	else
		iconSizeX = 1.2;
		iconSizeY = 1.2;
	end
end

function makeIcons()
	makeAnimatedLuaSprite('dadIcon', 'xml-icons/' .. getProperty('dad.healthIcon') .. '/assets', 0, 0);
	addAnimationByPrefix('dadIcon', 'normal', 'normal0', 24, true);
	addAnimationByPrefix('dadIcon', 'dead', 'dead0', 24, true);
	addAnimationByPrefix('dadIcon', 'win', 'win0', 24, true);
	addLuaSprite('dadIcon');

	makeAnimatedLuaSprite('bfIcon', 'xml-icons/' .. getProperty('boyfriend.healthIcon') .. '/assets', 0, 0);
	addAnimationByPrefix('bfIcon', 'normal', 'normal0', 24, true);
	addAnimationByPrefix('bfIcon', 'dead', 'dead0', 24, true);
	addAnimationByPrefix('bfIcon', 'win', 'win0', 24, true);
	addLuaSprite('bfIcon');

	-- make the icons be on hud and shti
	objectPlayAnimation('dadIcon', 'normal');
	objectPlayAnimation('bfIcon', 'normal');

	setObjectCamera('dadIcon', 'hud');
	setObjectCamera('bfIcon', 'hud');

	-- make the icons go in front of health bar lmao
	setObjectOrder('dadIcon', 99999);
	setObjectOrder('bfIcon', 99999);

	-- make score text go in front of icons because i'm 99.99% sure it does that originally
	setObjectOrder('scoreTxt', 999999);

	-- flip bf icon because f o o d
	setProperty('bfIcon.flipX', true);
end

function positionIcons()
	fuck = getProperty('health') - 1;
	if fuck > 1 then
		fuck = 1;
	end
	if fuck < -1 then
		fuck = -1;
	end

	shit = fuck * 300;

	setProperty('dadIcon.x', iconP2X - getProperty('dadIcon.width') + getProperty('dadIcon.frameWidth') - shit);
	setProperty('dadIcon.y', iconP2Y);

	setProperty('bfIcon.x', iconP1X - shit);
	setProperty('bfIcon.y', iconP1Y);
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		removeIcons();
		makeIcons();
	end
end

function removeIcons()
	removeLuaSprite('dadIcon');
	removeLuaSprite('bfIcon');
end

function goodNoteHit()
	positionIcons();
end

function playIconAnims()
	if getProperty('health') < 0.4150 then
		objectPlayAnimation('bfIcon', 'dead');
		objectPlayAnimation('dadIcon', 'win');
	else
		objectPlayAnimation('bfIcon', 'normal');
		objectPlayAnimation('dadIcon', 'normal');
	end
	
	if getProperty('health') > 1.625 then
		objectPlayAnimation('bfIcon', 'win');
		objectPlayAnimation('dadIcon', 'dead');
	end
end