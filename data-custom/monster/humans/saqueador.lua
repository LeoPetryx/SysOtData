local mType = Game.createMonsterType("Saqueador")
local monster = {}

monster.description = "Saqueador"
monster.experience = 120000
monster.outfit = {
	lookType = 152,
	lookHead = 114,
	lookBody = 124,
	lookLegs = 105,
	lookFeet = 86,
	lookAddons = 3,
	lookMount = 0,
}

monster.raceId = 3
monster.Bestiary = {
	class = "Human",
	race = BESTY_RACE_HUMAN,
	toKill = 1000,
	FirstUnlock = 100,
	SecondUnlock = 500,
	CharmsPoints = 80,
	Stars = 3,
	Occurrence = 1,
	Locations = "Invasores de Carlin.",
}

monster.health = 15000
monster.maxHealth = 15000
monster.race = "blood"
monster.corpse = 18046
monster.speed = 300
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
	level = 0,
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
	{ name = "melee", interval = 1000, chance = 100, minDamage = -200, maxDamage = -300 },
	{ name = "combat", interval = 1000, chance = 100, type = COMBAT_PHYSICALDAMAGE, minDamage = -300, maxDamage = -600, range = 7, shootEffect = CONST_ANI_THROWINGSTAR, target = false },
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
