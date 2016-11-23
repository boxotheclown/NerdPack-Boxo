local GUI = {
	{type = 'header', text = 'Keybinds:'},
	{type = 'text', text = 'Alt: Pause'},
	{type = 'text', text = 'Ctrl: Heroic Leap'},
	{type = 'text', text = 'Middle Mouse: WarStorm'},
	{type = 'checkbox', text = 'Check for Battle Cry in standard Rotation', key = 'BC_Standard', default= false},
}

function exeOnLoad()
	NeP.Interface:AddToggle({
        key = 'WarStorm',
        name = 'WarStorm',
        text = 'Adds Warbreaker + Bladestorm to AOE rotation',
        icon = 'Interface\\Icons\\ability_warrior_bladestorm', 
	})
	
	NeP.Interface:AddToggle({
        key = 'STWarbreaker',
        name = 'STWarbreaker',
        text = 'Turn on to add Warbreaker to ST, turn off to save for AoE',
        icon = 'Interface\\Icons\\inv_sword_2h_artifactarathor_d_01', 
	})

end

local Survival = {
	{'Victory Rush', 'player.health<=70'},
}

local Cooldowns = {
	{'Blood Fury', 'player.buff(Battle Cry)'},											-- racial during battle cry
	{'Berserking', 'player.buff(Battle Cry)'},											-- racial during battle cry
	{'Battle Cry', 'player.buff(Bloodlust)'},											-- battle cry during bloodlust
	{'Battle Cry', 'player.buff(Shattered Defenses)'},									-- battle cry during shattered defenses
	{'Battle Cry', 'spell(Colossus Smash).cooldown>gcd'},								-- battle cry when colossus smashes are on cooldown
	{'Avatar', 'talent(3,3)'},															-- avatar
}	

local AoE = {
	{'&Focused Rage', 'talent(5,3)&player.buff(Battle Cry)&player.buff(Focused Rage).stack<3'}, 		-- Focused Rage in battle cry
	{'&Focused Rage', 'talent(5,3)&player.rage>75&player.buff(Focused Rage).stack<3'},					-- Focused Rage Dump
	{'Warbreaker', 'spell(Bladestorm).cooldown<gcd&toggle(WarStorm)'}, 									-- Warbreaker (if Bladestorm is off Cooldown)
	{'Bladestorm', 'spell(Warbreaker).cooldown&toggle(WarStorm)'}, 										-- Bladestorm after warbreaker
	{'Cleave', 'player.area(6).enemies>=7'},															-- Cleave spam with tonnes of adds
	{'Whirlwind', 'player.area(6).enemies>=7'},															-- Whirlwind spam with tonnes of adds
	{'Colossus Smash', '!player.buff(Shattered Defenses)'}, 											-- Colossus Smash
	{'&Focused Rage', 'player.buff(Shattered Defenses)&player.buff(Focused Rage).stack<3'}, 			-- Focused Rage for shattered defenses mortal strike
	{'Execute', 'player.buff(Shattered Defenses)&target.health<=20'},									-- Execute (if Shattered Defense is up)
	{'Mortal Strike', 'player.buff(Shattered Defenses)'}, 												-- Mortal Strike (if Shattered Defense is up)
	{'Whirlwind', 'player.buff(Cleave)'},																-- Whirlwind with Cleave Buff
	{'Cleave', '!player.buff(Cleave)'}, 																-- Cleave
	{'Whirlwind'}, 																						-- Whirlwind
}

local Execute = {
	{'&Focused Rage', 'talent(5,3)&player.buff(Battle Cry)&player.buff(Focused Rage).stack<3'},			-- Focused Rage in battle cry
	{'&Focused Rage', 'talent(5,3)&player.rage>75&player.buff(Focused Rage).stack<3'},					-- Focused Rage Dump
	{'&Focused Rage', 'talent(5,3)&spell(Battle Cry).cooldown<3&player.buff(Focused Rage).stack<3'},	-- Focused rage dump before battle cry
	{'Colossus Smash', 'player.buff(Battle Cry)&!target.debuff(Colossus Smash)'},						-- Colossus Smash when no debuff on target
	{'Mortal Strike', 'player.buff(Battle Cry)&player.buff(Focused Rage).stack>2'},						-- Mortal Strike with 3 Focused Rage
	{'Execute', 'player.buff(Battle Cry)'},																-- Execute during Battle Cry
	{'Colossus Smash', '!player.buff(Shattered Defenses)'}, 											-- Colossus Smash
	{'Warbreaker', '!target.debuff(Colossus Smash)&toggle(STWarbreaker)'},								-- Warbreaker (if target not debuffed by Colossus Smash Debuff)	
--	{'Mortal Strike', 'player.buff(Focused Rage).stack>2'}, 											-- Mortal Strike is 3 stacks of Focused Rage
	{'Execute'}, 																						-- Execute dump
}

local ST = {
	{'&Focused Rage', 'talent(5,3)&player.buff(Battle Cry)&player.buff(Focused Rage).stack<3'}, 		-- focused Rage in battle cry
	{'&Focused Rage', 'talent(5,3)&player.rage>75&player.buff(Focused Rage).stack<3'},			 		-- Focused Rage Dump
	{'&Focused Rage', 'talent(5,3)&spell(Battle Cry).cooldown<3&player.buff(Focused Rage).stack<3'},	-- Focused rage dump before battle cry
	{'Colossus Smash', '!player.buff(Shattered Defenses)'}, 											-- Colossus Smash
	{'Warbreaker', '!target.debuff(Colossus Smash)&toggle(STWarbreaker)'}, 								-- Warbreaker (if target not debuffed by Colossus Smash debuff)
	{'&Focused Rage', 'player.buff(Shattered Defenses)&player.buff(Focused Rage).stack<3'}, 			-- Focused Rage for shattered defenses mortal strike
	{'Mortal Strike', 'player.buff(Focused Rage).stack>2)'},											-- Mortal Strike with 3 Focused Rage
	{'Execute', 'player.buff(Ayala\'s Stone Heart)'}, 													-- execute with legendary
	{'Mortal Strike'}, 																					-- Mortal Strike (regardless of stacks of focused rage)
	{'Overpower', 'talent(1,2)'}, 																		-- overpower if talented
	{'Rend', 'talent(3,2)&target.debuff(Rend).remains<=4.5'}, 											-- rend if about to fall off
	{'Whirlwind', 'talent(3,1)&player.buff(Battle Cry)'}, 												-- whirlwind with fervor talent and battle cry
	{'Slam', 'player.buff(Battle Cry)'}, 																-- Slam with battle cry 
	{'Whirlwind', 'talent(3,1)&player.rage>32'},														-- whirlwind with fervor talent dump
	{'Slam', 'player.rage>32'}, 																		-- Slam dump
}

local Keybinds = {
	-- Pause
	{'%pause', 'keybind(alt)'},
	{'Heroic Leap', 'keybind(lcontrol)' , 'cursor.ground'},
}

local Interrupts = {
	{'Pummel'},
	{'Arcane Torrent', 'target.range<=8&spell(Pummel).cooldown>gcd&!prev_gcd(Pummel)'},
}

local inCombat = {
	{Keybinds},
	{Interrupts, 'target.interruptAt(50)&toggle(interrupts)&target.infront&target.range<=8'},
	{Cooldowns, 'target.range<8&toggle(cooldowns)&target.infront'},
	{Survival},
	{AoE, 'target.range<8&toggle(aoe)'},
	{Execute, 'target.range<8&target.infront&target.health<=20'},
	{ST, 'target.range<8&target.infront&target.health>20'}
}


local outCombat = {
	{Keybinds},
}

NeP.CR:Add(71, 'Boxos WARRIOR - Arms', inCombat, outCombat, exeOnLoad, GUI)
