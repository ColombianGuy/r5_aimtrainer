global function OnWeaponPrimaryAttack_weapon_smr
global function OnWeaponActivate_weapon_smr

#if SERVER
global function OnWeaponNpcPrimaryAttack_weapon_smr
#endif // #if SERVER

#if CLIENT
global function OnClientAnimEvent_weapon_smr
#endif // #if CLIENT

void function OnWeaponActivate_weapon_smr( entity weapon )
{
#if CLIENT
	UpdateViewmodelAmmo( false, weapon )
#endif // #if CLIENT
}

var function OnWeaponPrimaryAttack_weapon_smr( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

	vector bulletVec = ApplyVectorSpread( attackParams.dir, weapon.GetAttackSpreadAngle() - 1.0 )
	attackParams.dir = bulletVec

	if ( IsServer() || weapon.ShouldPredictProjectiles() )
	{
		WeaponFireMissileParams fireMissileParams
		fireMissileParams.pos = attackParams.pos
		fireMissileParams.dir = attackParams.dir
		fireMissileParams.speed = 1.0
		fireMissileParams.scriptTouchDamageType = weapon.GetWeaponDamageFlags()
		fireMissileParams.scriptExplosionDamageType = weapon.GetWeaponDamageFlags()
		fireMissileParams.doRandomVelocAndThinkVars = false
		fireMissileParams.clientPredicted = true
		entity missile = weapon.FireWeaponMissile( fireMissileParams )
		if ( missile )
		{
			#if SERVER
				EmitSoundOnEntity( missile, "Weapon_Sidwinder_Projectile" )
			#endif

			missile.InitMissileForRandomDriftFromWeaponSettings( attackParams.pos, attackParams.dir )
			//InitMissileForRandomDrift( missile, attackParams.pos, attackParams.dir )
		}
	}
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_weapon_smr( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

	WeaponFireMissileParams fireMissileParams
	fireMissileParams.pos = attackParams.pos
	fireMissileParams.dir = attackParams.dir
	fireMissileParams.speed = 1.0
	fireMissileParams.scriptTouchDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.scriptExplosionDamageType = weapon.GetWeaponDamageFlags()
	fireMissileParams.doRandomVelocAndThinkVars = true
	fireMissileParams.clientPredicted = false
	entity missile = weapon.FireWeaponMissile( fireMissileParams )
	if ( missile )
	{
		EmitSoundOnEntity( missile, "Weapon_Sidwinder_Projectile" )
		missile.InitMissileForRandomDriftFromWeaponSettings( attackParams.pos, attackParams.dir )
	}
}
#endif // #if SERVER

#if CLIENT
void function OnClientAnimEvent_weapon_smr( entity weapon, string name )
{
	GlobalClientEventHandler( weapon, name )
}
#endif // #if CLIENT

