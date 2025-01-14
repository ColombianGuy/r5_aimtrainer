global function OnWeaponActivate_R101
global function OnWeaponDeactivate_R101
global function OnWeaponPrimaryAttack_R101
global function OnWeaponPrimaryAttack_Generic
global function OnProjectileCollision_Generic

//--------------------------------------------------
// R101 MAIN
//--------------------------------------------------

void function OnWeaponActivate_R101( entity weapon )
{
	OnWeaponActivate_weapon_basic_bolt( weapon )

	OnWeaponActivate_RUIColorSchemeOverrides( weapon )
	OnWeaponActivate_ReactiveKillEffects( weapon )
}

void function OnWeaponDeactivate_R101( entity weapon )
{
	OnWeaponDeactivate_ReactiveKillEffects( weapon )
}

var function OnWeaponPrimaryAttack_R101( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	if ( weapon.HasMod( "altfire_highcal" ) )
		thread PlayDelayedShellEject( weapon, RandomFloatRange( 0.03, 0.04 ) )

	weapon.FireWeapon_Default( attackParams.pos, attackParams.dir, 1.0, 1.0, false )

	// Grenade_OnWeaponTossReleaseAnimEvent_RevShell( weapon, attackParams )
	
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}


var function OnWeaponPrimaryAttack_Generic( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	weapon.FireWeapon_Default( attackParams.pos, attackParams.dir, 1.0, 1.0, false )

	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

void function OnProjectileCollision_Generic( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
{
	#if SERVER
	int bounceCount = projectile.GetProjectileWeaponSettingInt( eWeaponVar.projectile_ricochet_max_count )
	if ( projectile.proj.projectileBounceCount >= bounceCount )
		return

	projectile.proj.projectileBounceCount++
	#endif
}