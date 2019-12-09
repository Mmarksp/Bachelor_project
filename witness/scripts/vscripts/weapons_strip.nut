/*
weapon_strip.nut
author: Lee Pumphret
http://www.leeland.net

Removes specified weapons from survivors
*/

Msg("weapon_strip.nut=================\n");

// Even with wrong names, works for both survivor sets
survivors <-{
   coach = null
   ellis = null
   nick = null
   rochelle = null
};


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
        weapon_upgradepack_incendiary = 0
        weapon_upgradepack_explosive = 0
}


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
