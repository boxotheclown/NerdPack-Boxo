local Survival = {
	{'Victory Rush', 'player.health<=70'},
}

local Cooldowns = {
	{'Blood Fury', 'player.buff(Battle Cry)'},											-- racial during battle cry
	{'Berserking', 'player.buff(Battle Cry)'},											-- racial during battle cry
	{'Battle Cry', 'player.buff(Bloodlust)'},											-- battle cry during bloodlust
	{'Battle Cry', 'player.buff(Shattered Defenses)'},									-- battle cry during shattered defenses
	{'Battle Cry', 'spell(Colossus Smash).cooldown>gcd&spell(Warbreaker).cooldown>gcd'},-- battle cry when colossus smashes are on cooldown
	{'Avatar', 'talent(3,3)'},															-- avatar
}	

local AoE = {
	{'Focused Rage', 'player.buff(Battle Cry)'}, 										-- Focused Rage in battle cry
	{'Focused Rage', 'player.rage>75'},													-- Focused Rage Dump
	{'Warbreaker', 'spell(Bladestorm).cooldown<gcd'}, 									-- Warbreaker (if Bladestorm is off Cooldown)
	{'Bladestorm', 'spell(Warbreaker).cooldown'}, 										-- Bladestorm after warbreaker
	{'Cleave'}, 																		-- Cleave
	{'Colossus Smash'}, 																-- Colossus Smash
	{'Execute', 'player.buff(Shattered Defenses)'}, 									-- Execute (if Shattered Defense is up)
	{'Mortal Strike', 'player.buff(Shattered Defenses)'}, 								-- Mortal Strike (if Shattered Defense is up)
	{'Whirlwind'}, 																		-- Whirlwind
}

local Execute = {
	{'Focused Rage', 'player.buff(Battle Cry)'}, 										-- Focused Rage in battle cry
	{'Focused Rage', 'player.rage>75'},													-- Focused Rage Dump
	{'Execute', 'player.buff(Battle Cry)&target.debuff(Colossus Smash)'}, 				-- Execute (If Battle Cry is Active, and target is debuffed by Colossus Smash)
	{'Colossus Smash'}, 																-- Colossus Smash
	{'Warbreaker', '!target.debuff(Colossus Smash)'},									-- Warbreaker (if target not debuffed by Colossus Smash Debuff)	
	{'Mortal Strike', 'player.buff(Focused Rage).stack>2'}, 							-- Mortal Strike is 3 stacks of Focused Rage
	{'Execute'}, 																		-- Execute dump
}

local ST = {
	{'Focused Rage', 'player.buff(Battle Cry)'}, 										-- focused Rage in battle cry
	{'Focused Rage', 'player.rage>75'},			 										-- Focused Rage Dump
	{'Colossus Smash'}, 																-- Colossus Smash
	{'Warbreaker', '!target.debuff(Colossus Smash)'}, 									-- Warbreaker (if target not debuffed by Colossus Smash debuff)
	{'Focused Rage', 'player.buff(Shattered Defenses)&!player.buff(Focused Rage)'}, 	-- Focused Rage for shattered defenses mortal strike
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'}, 									-- execute with legendary
	{'Mortal Strike'}, 																	-- Mortal Strike (regardless of stacks of focused rage)
	{'Overpower', 'talent(1,2)'}, 														-- overpower if talented
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<=4.5'}, 							-- rend if about to fall off
	{'Whirlwind', 'talent(3,1)&player.buff(Battle Cry)'}, 								-- whirlwind with fervor talent and battle cry
	{'Slam', 'player.buff(Battle Cry)'}, 												-- Slam with battle cry 
	{'Whirlwind', 'talent(3.1)&player.rage>32'},										-- whirlwind with fervor talent dump
	{'Slam', 'player.rage>32'}, 														-- Slam dump
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'}
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Cooldowns, 'target.range<8&toggle(cooldowns)'},
	{Survival},
	{AoE, 'target.range<8&toggle(aoe)'},
	{Execute, 'target.range<8&target.infront&target.health<=20'},
	{ST, 'target.range<8&target.infront&target.health>20'}
}


local outCombat = {
	{Keybinds},
}

NeP.CR:Add(71, 'Boxos WARRIOR - Arms', inCombat, outCombat, exeOnLoad)
