local magicknight = Combat()
magicknight:setParameter(COMBAT_PARAM_CREATEITEM, 2128)
magicknight:setArea(createCombatArea({
{1,1,1,1,1,1,1},
{1,0,0,0,0,0,1},
{1,0,0,0,0,0,1},
{1,0,0,3,0,0,1},
{1,0,0,0,0,0,1},
{1,0,0,0,0,0,1},
{1,1,1,1,1,1,1}
}))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return magicknight:execute(creature, var)
end



spell:group("attack")
spell:id(105)
spell:name("Gran Prison")
spell:words("gran prison")
spell:level(90)
spell:mana(340)
spell:isPremium(true)
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ELECTRIFY)
spell:needWeapon(false)
spell:cooldown(6 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()