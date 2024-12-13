global function OnWeaponPrimaryAttack_weapon_softball
global function OnProjectileCollision_weapon_softball

#if SERVER
global function OnWeaponNpcPrimaryAttack_weapon_softball
#endif // #if SERVER

const FUSE_TIME = 1.75 //Applies once the grenade has stuck to a surface.

var function OnWeaponPrimaryAttack_weapon_softball( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	//vector bulletVec = ApplyVectorSpread( attackParams.dir, weapon.GetAttackSpreadAngle() * 2.0 )
	//attackParams.dir = bulletVec

	if ( IsServer() || weapon.ShouldPredictProjectiles() )
	{
		vector offset = <30,6,-4>
		if ( weapon.IsWeaponInAds() )
			offset = <30,0,-3>

		entity player = weapon.GetWeaponOwner()
		vector attackPos = player.OffsetPositionFromView( attackParams[ "pos" ], offset )	// forward, right, up
		FireGrenade( weapon, attackParams )
	}
}

#if SERVER
var function OnWeaponNpcPrimaryAttack_weapon_softball( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )
	FireGrenade( weapon, attackParams, true )
}
#endif // #if SERVER

void function FireGrenade( entity weapon, WeaponPrimaryAttackParams attackParams, bool isNPCFiring = false )
{
	vector angularVelocity = <RandomFloatRange( -1200, 1200 ), 100, 0>

	int damageType = DF_RAGDOLL | DF_EXPLOSION

	WeaponFireGrenadeParams fireGrenadeParams
	fireGrenadeParams.pos = attackParams.pos
	fireGrenadeParams.vel = attackParams.dir
	fireGrenadeParams.angVel = angularVelocity
	fireGrenadeParams.fuseTime = 0.0
	fireGrenadeParams.scriptTouchDamageType = damageType
	fireGrenadeParams.scriptExplosionDamageType = damageType
	fireGrenadeParams.clientPredicted = !isNPCFiring
	fireGrenadeParams.lagCompensated = true
	fireGrenadeParams.useScriptOnDamage = false
	entity nade = weapon.FireWeaponGrenade( fireGrenadeParams )

	if ( nade )
	{
		#if SERVER
			EmitSoundOnEntity( nade, "Weapon_softball_Grenade_Emitter" )
			Grenade_Init( nade, weapon )
		#else
			entity weaponOwner = weapon.GetWeaponOwner()
			SetTeam( nade, weaponOwner.GetTeam() )
		#endif
	}
}

void function OnProjectileCollision_weapon_softball( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
{
	bool didStick = PlantSuperStickyGrenade( projectile, pos, normal, hitEnt, hitbox )
	if ( !didStick )
		return

	#if SERVER
		if ( IsAlive( hitEnt ) && hitEnt.IsPlayer() )
		{
			EmitSoundOnEntityOnlyToPlayer( projectile, hitEnt, "weapon_softball_grenade_attached_1P" )
			EmitSoundOnEntityExceptToPlayer( projectile, hitEnt, "weapon_softball_grenade_attached_3P" )
		}
		else
		{
			EmitSoundOnEntity( projectile, "weapon_softball_grenade_attached_3P" )
		}
		thread DetonateStickyAfterTime( projectile, FUSE_TIME, normal )
	#endif
}

#if SERVER
// need this so grenade can use the normal to explode
void function DetonateStickyAfterTime( entity projectile, float delay, vector normal )
{
	wait delay
	if ( IsValid( projectile ) )
		projectile.GrenadeExplode( normal )
}
#endif