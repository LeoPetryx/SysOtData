local mType = Game.createMonsterType("Anihilator")
local monster = {}

monster.description = "Bazir"
monster.experience = 30000
monster.outfit = {
	lookType = 35,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 350000
monster.maxHealth = 350000
monster.race = "fire"
monster.corpse = 4097
monster.speed = 1000
monster.manaCost = 0

monster.changeTarget = {
	interval = 2000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 95,
	targetDistance = 1,
	runHealth = 3000,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 30,
	{ text = "ARE YOU INSANE? GET OUT OF MY SPACE!", yell = true },
	{ text = "HAHAHA! YOU WILL GONNA DIE YOU FUCKING BASTARD!", yell = true },
	{ text = "DON'T BE AFRAID! THERE IS A PLACE IN HELL FOR US!", yell = true },
}

monster.loot = {
	{ id = 3027, chance = 15000, maxCount = 15 }, -- black pearl
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, skill = 200, attack = 250 },
	{ name = "combat", interval = 1000, chance = 7, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -500, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_POFF, target = false },
	{ name = "drunk", interval = 1000, chance = 7, range = 7, shootEffect = CONST_ANI_ENERGY, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "strength", interval = 1000, chance = 9, range = 7, shootEffect = CONST_ANI_LARGEROCK, effect = CONST_ME_ENERGYAREA, target = false },
	{ name = "combat", interval = 1000, chance = 13, type = COMBAT_LIFEDRAIN, minDamage = -200, maxDamage = -500, radius = 8, effect = CONST_ME_LOSEENERGY, target = false },
	{ name = "combat", interval = 1000, chance = 10, type = COMBAT_MANADRAIN, minDamage = -200, maxDamage = -500, radius = 8, effect = CONST_ME_MAGIC_GREEN, target = false },
	{ name = "speed", interval = 1000, chance = 12, speedChange = -1900, radius = 6, effect = CONST_ME_POISONAREA, target = false, duration = 60000 },
	{ name = "strength", interval = 1000, chance = 8, radius = 5, effect = CONST_ME_HITAREA, target = false },
	{ name = "outfit", interval = 1000, chance = 2, radius = 8, effect = CONST_ME_LOSEENERGY, target = false, duration = 5000, outfitItem = 3058 },
	{ name = "combat", interval = 1000, chance = 34, type = COMBAT_FIREDAMAGE, minDamage = -200, maxDamage = -500, range = 7, radius = 7, shootEffect = CONST_ANI_FIRE, effect = CONST_ME_FIREAREA, target = true },
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_LIFEDRAIN, minDamage = -300, maxDamage = -550, length = 8, spread = 0, effect = CONST_ME_MAGIC_RED, target = false },
}

monster.defenses = {
	defense = 160,
	armor = 160,
	--	mitigation = ???,
	{ name = "combat", interval = 1000, chance = 15, type = COMBAT_HEALING, minDamage = 5000, maxDamage = 10000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "combat", interval = 1000, chance = 25, type = COMBAT_HEALING, minDamage = 2000, maxDamage = 3000, effect = CONST_ME_MAGIC_BLUE, target = false },
	{ name = "speed", interval = 1000, chance = 8, speedChange = 1901, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
	{ name = "outfit", interval = 1000, chance = 2, effect = CONST_ME_MAGIC_BLUE, target = false, duration = 7000, outfitItem = 2916 },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType.onThink = function(monster, interval) end

mType.onAppear = function(monster, creature)
	if monster:getType():isRewardBoss() then
		monster:setReward(true)
	end
end

mType.onDisappear = function(monster, creature) end

mType.onMove = function(monster, creature, fromPosition, toPosition) end

mType.onSay = function(monster, creature, type, message) end

mType:register(monster)
