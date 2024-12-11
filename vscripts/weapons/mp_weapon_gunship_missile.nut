
#if SERVER
global function OnWeaponNpcPrimaryAttack_gunship_missile
#endif // SERVER


#if SERVER
var function OnWeaponNpcPrimaryAttack_gunship_missile( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	//self.EmitWeaponSound( "Weapon_ARL.Single" )
	weapon.EmitWeaponSound( "weapon_softball_fire_3p_enemy" )

	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

	entity owner = weapon.GetWeaponOwner()

	WeaponFireMissileParams fireGrenadeParams
	fireGrenadeParams.pos = attackParams.pos
	fireGrenadeParams.dir = attackParams.dir
	fireGrenadeParams.speed = 1
	fireGrenadeParams.scriptTouchDamageType = damageTypes.explosive // when a grenade "bonks" something, that shouldn't count as explosive.explosive
	fireGrenadeParams.scriptExplosionDamageType = damageTypes.explosive
	fireGrenadeParams.doRandomVelocAndThinkVars = false
	fireGrenadeParams.clientPredicted = PROJECTILE_NOT_PREDICTED

	#if SERVER
		entity missile = weapon.FireWeaponMissile( fireGrenadeParams )
		if ( missile )
		{
			TraceResults result = TraceLine( owner.EyePosition(), owner.EyePosition() + attackParams.dir*50000, [ owner ], TRACE_MASK_SHOT, TRACE_COLLISION_GROUP_BLOCK_WEAPONS )

			EmitSoundOnEntity( missile, "Gibraltar_DefensiveBombardment_Projectile" )
			missile.InitMissileForRandomDriftFromWeaponSettings( attackParams.pos, attackParams.dir )

			thread function () : ( missile , weapon)
			{
                while( IsValid( missile ) )
				{
					if( IsValid( missile ) && LengthSqr( missile.GetSmoothedVelocity() ) <= 6000 )
					{
						if( IsValid( missile ) && LengthSqr( missile.GetSmoothedVelocity() ) <= 6000 )
						    break
					}

                    WaitFrame()
				}

				if ( IsValid( missile ) && IsValid( weapon ) )
				{
					array<entity> entities
                    float radius = weapon.GetWeaponSettingFloat( eWeaponVar.explosionradius )
					int damage = weapon.GetWeaponSettingInt( eWeaponVar.explosion_damage )
					vector origin = missile.GetOrigin()


					entity ent = Entities_FindInSphere( null, origin,  radius)

					for ( ;; )
					{
						if ( !IsValid( ent ) )
							break

						if( IsAlive( ent )  && missile.GetTeam() != ent.GetTeam() )
						    entities.append( ent )

						ent = Entities_FindInSphere( ent, origin, radius)
					}

                    foreach(entity victim in entities)
						victim.TakeDamage( damage, missile.GetOwner(), missile.GetOwner(), { damageSourceId = eDamageSourceId.mp_weapon_gunship_missile } )

				}

			}()

		}
	#endif
}

#endif // #if SERVER