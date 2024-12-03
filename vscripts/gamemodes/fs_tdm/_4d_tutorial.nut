untyped
globalize_all_functions

bool function IsIn4DTutorial( entity player )
{
	return "tutorial" in player.s
}

int curRealm = 0
void function SetIn4DTutorial( entity player, bool inTutorial )
{
	try
	{
		if (inTutorial)
        {
            player.RemoveFromAllRealms()
            player.AddToRealm(curRealm)
            curRealm++
            if (curRealm >= 32)
                curRealm = 0
			player.s.tutorial <- true
            player.s.tutorialPhase <- 1
            EmitSoundOnEntityOnlyToPlayer( player, player, "Music_Training" )
        }
		else
        {
			delete player.s.tutorial
            delete player.s.tutorialPhase
        }
	}
	catch (e419)
	{

	}
}

int function Get4DTutorialPhase( entity player )
{
    if (!IsIn4DTutorial(player))
        return -1

    return expect int(player.s.tutorialPhase)
}

void function Set4DTutorialPhase( entity player, int phase )
{
    if (!IsIn4DTutorial(player))
        return

    printt("Set tutorial phase", phase)
    player.s.tutorialPhase = phase
}

vector function GetOffsetForRealm( int realmId )
{
    switch (realmId)
    {
        case 0:
            return < -15000, 0, 0 >
        case 1:
            return < 15000, 0, 0 >
    }

    return <0,0,0>
}

void function Tutorial4D_JumpPad(entity player)
{
    if (Get4DTutorialPhase(player) < 3)
    {
        Remote_CallFunction_NonReplay( player, "DM_HintCatalog", 4, 0 )
        return
    }

    thread void function() : (player)
    {
        StopSoundOnEntity( player, "Music_Training" )
        EmitSoundOnEntityOnlyToPlayer( player, player, "Music_Jump" )
        player.SetVelocity( < -50, -990, 3550> )
        player.kv.gravity = 0.5
        player.ForceStand()
        player.PlayerCone_SetLerpTime(0.0)
        player.PlayerCone_SetMinYaw( -0 )
        player.PlayerCone_SetSpecific(<0,-90,0>)
        player.PlayerCone_SetMinYaw( -15 )
        player.PlayerCone_SetMaxYaw( 15 )
        player.PlayerCone_SetMinPitch( 0 )
        player.PlayerCone_SetMaxPitch( 90 )
        player.SetAngles(<0,90,0>)
        //player.FreezeControlsOnServer()
        player.SetAngles(<45, -90, 0>)
        Remote_CallFunction_ByRef( player, "FS4DIntroSequence" )
        wait 18.5

        player.AddToAllRealms()
        Tutorial4D_CompletedTutorial(player)
        EmitSoundOnEntityOnlyToPlayer( player, player, "Pilot_PhaseShift_End_1P" )

        StopSoundOnEntity( player, "Music_Jump" )
        player.kv.gravity = 0.0 // resets gravity to normal
        ScreenFade( player, 255, 255, 255, 255, 0.3, 0.0, FFADE_IN | FFADE_PURGE )

        LocPair loc = _GetAppropriateSpawnLocation(player)

        player.SetVelocity(<0,0,0>)
        player.SetOrigin(loc.origin)
        player.SetAngles(loc.angles)
        player.PlayerCone_Disable()
        wait 0.001
        player.UnforceStand()
        //player.UnfreezeControlsOnServer()
    }()
}

bool function Tutorial4D_HasCompletedTutorial(entity player)
{
    return "tutorialComplete" in player.s
}

void function Tutorial4D_CompletedTutorial(entity player)
{
    player.s.tutorialComplete <- true
}

void function Tutorial4D_Phase2(entity player)
{
    if (Get4DTutorialPhase(player) >= 2)
        return
    
    Set4DTutorialPhase( player, 2 )

    player.s["dummy1"] <- _4DTutorial_CreateDummy( player, < -15032, 18112, 16 >, < 0, 135, 0 > )
    player.s["dummy2"] <- _4DTutorial_CreateDummy( player, < 15032, 18048, 16 >, < 0, 135, 0 > )

    thread _4DTutorial_Dummy( player, false )
    thread _4DTutorial_Dummy( player, true )
}

entity function _4DTutorial_CreateDummy( entity player, vector origin, vector angles )
{
    entity dummy = CreateDummy( 99, origin, angles )
    SetSpawnOption_AISettings( dummy, "npc_training_dummy" )
    DispatchSpawn( dummy )

    dummy.SetOrigin( origin )
	dummy.SetShieldHealthMax( 10 )
	dummy.SetShieldHealth( 10 )
	dummy.SetMaxHealth( 1 )
	dummy.SetHealth( 1 )

    array<string> weapons = ["npc_weapon_hemlok", "npc_weapon_energy_shotgun", "npc_weapon_lstar"]
    string randomWeapon = weapons[RandomInt(weapons.len())]
    dummy.GiveWeapon(randomWeapon, WEAPON_INVENTORY_SLOT_ANY)

    return dummy
}

void function _4DTutorial_Dummy( entity player, bool is2ndDummy )
{
    
    while (true)
    {
        string dummyIndex = is2ndDummy ? "dummy2" : "dummy1"
        string dummyIndex2 = is2ndDummy ? "dummy1" : "dummy2"

        entity dummy = expect entity(player.s[dummyIndex])

        dummy.WaitSignal( "OnDeath" )

        entity otherDummy = expect entity(player.s[dummyIndex2])

        wait 0.001

        if (IsAlive(otherDummy))
        {
	        player.s[dummyIndex] = _4DTutorial_CreateDummy( player, dummy.GetOrigin(), dummy.GetAngles() )
            // reset cooldown so player doesnt have to wait 15 seconds
            entity ult = player.GetOffhandWeapon(OFFHAND_ULTIMATE)
            ult.SetWeaponPrimaryClipCount(ult.GetWeaponPrimaryClipCountMax())
        }
        else
        {
            Set4DTutorialPhase( player, 3 ) // player passed this section.
            break
        }
    }
}
