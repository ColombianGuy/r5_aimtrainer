global function MpWeaponDroneRocket_Init

#if SERVER
global function OnWeaponNpcPrimaryAttack_dronerocket
global function OnWeaponNpcPreAttack_dronerocket
#endif // SERVER

void function MpWeaponDroneRocket_Init()
{
	PrecacheParticleSystem( $"P_wpn_drone_charge" )
}

/*
function SetMissileTarget( missile, target, weaponOwner )
{
	if ( !IsAlive( target ) )
		return

	if ( !target.IsPlayer() && !target.IsNPC() )
		return

	if ( target.GetTeam() == weaponOwner.GetTeam() )
		return

	missile.SetMissileTarget( target, Vector( 0, 0, 0 ) )
	missile.SetHomingSpeeds( 500, 0 )
}
*/

#if SERVER
var function OnWeaponNpcPrimaryAttack_dronerocket( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	//self.EmitWeaponSound( "Weapon_ARL.Single" )
	weapon.EmitWeaponSound( "ShoulderRocket_Salvo_Fire_3P" )
	weapon.PlayWeaponEffect( $"P_wpn_muzzleflash_smr", $"P_wpn_muzzleflash_smr", "muzzle_flash" )

	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	
	entity weaponOwner 	= weapon.GetWeaponOwner()
	
	bool isPredicted = PROJECTILE_PREDICTED
	if ( weaponOwner.IsNPC() )
		isPredicted = PROJECTILE_NOT_PREDICTED
	
	WeaponFireMissileParams fireMissileParams
	fireMissileParams.pos = attackParams.pos
	fireMissileParams.dir = attackParams.dir
	fireMissileParams.speed = 1
	fireMissileParams.scriptTouchDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.scriptExplosionDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.doRandomVelocAndThinkVars = false
	fireMissileParams.clientPredicted = isPredicted
	entity missile = weapon.FireWeaponMissile( fireMissileParams )
	
	if ( missile )
	{
		EmitSoundOnEntity( missile, "Weapon_Sidwinder_Projectile" )
		missile.InitMissileForRandomDriftFromWeaponSettings( attackParams.pos, attackParams.dir )
	}
}

void function OnWeaponNpcPreAttack_dronerocket( entity weapon )
{
	thread DoPreAttackFX( weapon )
}

void function DoPreAttackFX( entity weapon )
{
	weapon.EndSignal( "OnDestroy" )
	entity weaponOwner = weapon.GetWeaponOwner()
	weaponOwner.EndSignal( "OnDestroy" )

	entity fx = PlayLoopFXOnEntity( $"P_wpn_drone_charge", weaponOwner, "FX_EYE" )

	fx.SetStopType( "destroyImmediately" )

	OnThreadEnd(
		function() : ( weapon, fx )
		{
			if ( IsValid( fx ) )
				fx.Destroy()
			weapon.StopWeaponSound( "Drone_Weapon_Prefire" )
		}
	)

	weapon.EmitWeaponSound( "Drone_Weapon_Prefire" )

	wait 0.6 // Make sure this matches or is greater than npc_pre_fire_delay
}

#endif // #if SERVER
