doRockHover = false;

function onCreate()
	-- -- background shit
	makeLuaSprite('ground', 'entity/agoti/floor', -830, -720);
	setScrollFactor('ground', 1, 1);
	
	setProperty("ground.scale.x", 1.2);
	setProperty("ground.scale.y", 1.2);
	
	makeLuaSprite('back','entity/agoti/bg',-400, -400)
    addLuaSprite('back',false)
    scaleObject('back', 2.3, 2.3)
    setLuaSpriteScrollFactor('back', 1, 1);
addLuaSprite('ground',false)
	-- close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end