untyped

const SPEC_CHARGE_FX = $"P_wpn_sspectre_charge"
const EPG_MUZZLE_FX = $"P_wpn_muzzleflash_epg"

global function MpWeaponDronePlasma_Init

#if SERVER
global function OnWeaponNpcPrimaryAttack_DronePlasma
global function OnWeaponNpcPreAttack_DronePlasma
#endif // SERVER

function MpWeaponDronePlasma_Init()
{
	PrecacheParticleSystem( SPEC_CHARGE_FX )
	PrecacheParticleSystem( EPG_MUZZLE_FX )
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_DronePlasma( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	float missileSpeed	= 600.0

	entity weaponOwner 	= weapon.GetWeaponOwner()
	entity target 		= weaponOwner.GetEnemy()
	
	bool isPredicted = PROJECTILE_PREDICTED
	if ( weaponOwner.IsNPC() )
		isPredicted = PROJECTILE_NOT_PREDICTED
	
	WeaponFireMissileParams fireMissileParams
	fireMissileParams.pos = attackParams.pos
	fireMissileParams.dir = attackParams.dir
	fireMissileParams.speed = missileSpeed
	fireMissileParams.scriptTouchDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.scriptExplosionDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.doRandomVelocAndThinkVars = false
	fireMissileParams.clientPredicted = isPredicted
	entity missile = weapon.FireWeaponMissile( fireMissileParams )

	if ( missile )
	{
		weapon.EmitWeaponSound( "Drone_Plasma_Fire" )
		weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

		//missile.SetMissileTarget( target, Vector( 0, 0, 0 ) )
		//missile.SetHomingSpeeds( homingSpeed, 0.0 )
		missile.kv.lifetime = 16.0

		if ( weaponOwner.IsSecondaryAttack() )
			missile.SetProjectilTrailEffectIndex( 1 );

		weapon.PlayWeaponEffect( EPG_MUZZLE_FX, EPG_MUZZLE_FX, "muzzle_flash" )
	}
}

void function OnWeaponNpcPreAttack_DronePlasma( entity weapon )
{
	thread DoPreAttackFX( weapon )
}

function DoPreAttackFX( entity weapon )
{
	weapon.EndSignal( "OnDestroy" )

	entity weaponOwner 		= weapon.GetWeaponOwner()
	entity fx 				= PlayLoopFXOnEntity( SPEC_CHARGE_FX, weaponOwner, "muzzle_flash" )

	fx.SetStopType( "destroyImmediately" )

	weaponOwner.EndSignal( "OnDestroy" )

	OnThreadEnd(
		function() : ( fx )
		{
			if ( IsValid(fx) )
				fx.Destroy()
		}
	)

	// Make sure this matches or is greater than npc_pre_fire_delay_secondary
	wait 1.5
}

#endif // SERVER