local mType = Game.createMonsterType("Higher Dwarf")
local monster = {}

monster.description = "a Higher Dwarf"
monster.experience = 0
monster.outfit = {
	lookType = 143,
	lookHead = 114,
	lookBody = 124,
	lookLegs = 105,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0,
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "blood"
monster.corpse = 111
monster.speed = 600
monster.manaCost = 450

monster.changeTarget = {
	interval = 4000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 20,
	damage = 10,
}

monster.flags = {
	summonable = true,
	attackable = true,
	hostile = true,
	convinceable = true,
	pushable = false,
	rewardBoss = false,
	illusionable = true,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = true,
	canWalkOnFire = true,
	canWalkOnPoison = true,
	pet = false,
}

monster.light = {
	level = 50,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Die!", yell = false },
	{ text = "Feel the hand of death!", yell = false },
	{ text = "You are on my deathlist!", yell = false },
}

monster.loot = {
	{ id = 3035, chance = 83210, maxCount = 100 }, -- gold coin
	{ id = 3035, chance = 7250, maxCount = 80 } -- gold coin
}

monster.attacks = {
	{ name = "melee", interval = 1000, chance = 100, minDamage = -1200, maxDamage = -1600 },
}

monster.defenses = {
	defense = 15,
	armor = 15,
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
	{ type = "paralyze", condition = false },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
