Msg("Activating Witness\n");
Msg("Made by Mmarksp\n");

SanitizeTable <-
[
	{ classname = "info_remarkable", input = "Kill"}
	{ classname = "info_target_instructor_hint", input = "Kill"}
]

MutationOptions <-
{
	ActiveChallenge = 1
	AllowCrescendoEvents = false
	MobMaxPending = 0
	MegaMobSize = 0
	NoMobSpawns = true
	cm_NoSurvivorBots = 1
	cm_DominatorLimit = 8
	cm_MaxSpecials  = 8
	cm_AggresiveSpecials = false
	cm_SpecialsRetreatToCover = true
	cm_CommonLimit = 100
	cm_ProhibitBosses = 0
	cm_WanderingZombieDensityModifier = 0.03
	cm_BaseCommonAttackDamage = 0
	cm_AutoReviveFromSpecialIncap = true

	A_CustomFinaleMusic4 = ""

	BoomerLimit  = 1
	ChargerLimit = 2
	HunterLimit  = 2
	JockeyLimit  = 0
	SpitterLimit = 0
	SmokerLimit  = 2
	TankLimit = 2

	AlwaysAllowWanderers = true
	BileMobSize = 0
	InfectedFlags = INFECTED_FLAG_CANT_SEE_SURVIVORS | INFECTED_FLAG_CANT_HEAR_SURVIVORS | INFECTED_FLAG_CANT_FEEL_SURVIVORS

	function AllowWeaponSpawn( classname )
	{
		if ( classname in g_ModeScript.weaponsToRemove )
		{
			return false;
		}
		return true;
	}
}

/*
weapon_strip.nut
author: Lee Pumphret
http://www.leeland.net

Removes specified weapons from survivors
*/
// Even with wrong names, works for both survivor sets
survivors <-
{
	 coach = null
	 ellis = null
	 nick = null
	 rochelle = null
}

// Items you want deleted from player below, add or comment out as needed...
weaponsToRemove <-
{
				weapon_pistol = 0
				weapon_pistol_magnum = 0
				weapon_smg = 0
				weapon_pumpshotgun = 0
				weapon_autoshotgun = 0
				weapon_rifle = 0
				weapon_hunting_rifle = 0
				weapon_smg_silenced = 0
				weapon_shotgun_chrome = 0
				weapon_rifle_desert = 0
				weapon_sniper_military = 0
				weapon_shotgun_spas = 0
				weapon_grenade_launcher = 0
				weapon_rifle_ak47 = 0
				weapon_smg_mp5 = 0
				weapon_rifle_sg552 = 0
				weapon_sniper_awp = 0
				weapon_sniper_scout = 0
				weapon_rifle_m60 = 0
				weapon_melee = 0
				weapon_knife = 0
				weapon_upgradepack_incendiary = 0
				weapon_upgradepack_explosive = 0
				ammo = 0
				weapon_ammo_pack = 0
				upgrade_item = 0
				weapon_firework_crate = 0
				weapon_pipe_bomb = 0
				weapon_vomitjar = 0
				weapon_molotov = 0
				weapon_oxygentank = 0
				weapon_propanetank = 0
				weapon_pain_pills = 0
				weapon_defibrillator = 0
				weapon_first_aid_kit = 0
				weapon_adrenaline = 0
				weapon_chainsaw = 0
}

function OnGameplayStart()
{
	foreach(s,v in survivors){
			printl ("looking for !"+s);
			survivor <- Entities.FindByName(null, "!"+s)
			if (survivor){
				printl(s+" found: "+survivor);
				// look at child items
				child <- survivor.FirstMoveChild()
				if (child){
					while (child){
							printl("   "+ s + " has " + child.GetClassname() );
							if ( child.GetClassname() in weaponsToRemove){
									DoEntFire("!self", "kill", "", 0, null, child );
							}
							child = child.NextMovePeer();
					}
				}
			}else{
				printl(s+" NOT FOUND!");
			}
		}

		EntFire( "info_remarkable", "KillHierarchy");
		EntFire("player", "setHUDVisibility", "false");

		printl("Modification up and running. But how will the director feel about this?")

		ScriptedMode_AddSlowPoll(ThroughoutGame);
}

function ThroughoutGame() {
	ReapplyInfectedFlags(INFECTED_FLAG_CANT_SEE_SURVIVORS | INFECTED_FLAG_CANT_HEAR_SURVIVORS | INFECTED_FLAG_CANT_FEEL_SURVIVORS, null);

	EntFire( "info_remarkable", "KillHierarchy");
	EntFire("player", "setHUDVisibility", "false");
}
