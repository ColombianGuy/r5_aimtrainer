global function OnWeaponPrimaryAttack_weapon_arc_launcher
const ARC_LAUNCHER_ZAP_DAMAGE = 350


var function OnWeaponPrimaryAttack_weapon_arc_launcher( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity weaponOwner = weapon.GetWeaponOwner()

	if ( weaponOwner.IsPlayer() )
	{
		float zoomFrac = weaponOwner.GetZoomFrac()
		if ( zoomFrac < 1 )
			return 0
	}

	#if SERVER
		if ( weaponOwner.IsPlayer() )
		{
			vector angles = VectorToAngles( weaponOwner.GetViewVector() )
			vector up = AnglesToUp( angles )

			//if ( weaponOwner.GetTitanSoulBeingRodeoed() != null )
				//attackParams.pos = attackParams.pos + up * 20
		}
	#endif

	bool shouldPredict = weapon.ShouldPredictProjectiles()
	#if CLIENT
		if ( !shouldPredict )
			return 1
	#endif

	float speed = 450.0

	vector attackPos = attackParams.pos
	vector attackDir = attackParams.dir

	FireArcBall( weapon, attackPos, attackDir, shouldPredict, ARC_LAUNCHER_ZAP_DAMAGE )

	weapon.EmitWeaponSound_1p3p( "Weapon_ArcLauncher_Fire_1P", "Weapon_ArcLauncher_Fire_3P" )
	weapon.EmitWeaponNpcSound( LOUD_WEAPON_AI_SOUND_RADIUS_MP, 0.2 )

	return 1
}

void function FireArcBall( entity weapon, vector pos, vector dir, bool shouldPredict, float damage = BALL_LIGHTNING_DAMAGE, bool isCharged = false )
{
	entity owner = weapon.GetWeaponOwner()

	float speed = 500.0

	if ( isCharged )
		speed = 350.0

	if ( owner.IsPlayer() )
	{
		vector myVelocity = owner.GetVelocity()

		float mySpeed = Length( myVelocity )

		myVelocity = Normalize( myVelocity )

		float dotProduct = DotProduct( myVelocity, dir )

		dotProduct = max( 0, dotProduct )

		speed = speed + ( mySpeed*dotProduct )
	}

	int team = TEAM_UNASSIGNED
	if ( IsValid( owner ) )
		team = owner.GetTeam()

	//entity bolt = weapon.FireWeaponBolt( pos, dir, speed, damageTypes.arcCannon | DF_IMPACT, damageTypes.arcCannon | DF_EXPLOSION, shouldPredict, 0 )

	int damageType = DF_IMPACT | DF_EXPLOSION
	WeaponFireBoltParams fireGrenadeParams
	fireGrenadeParams.pos = pos
	fireGrenadeParams.dir = dir
	fireGrenadeParams.speed = speed
	fireGrenadeParams.scriptTouchDamageType = damageTypes.arcCannon
	fireGrenadeParams.scriptExplosionDamageType = damageTypes.arcCannon
	fireGrenadeParams.clientPredicted = false
	entity bolt = weapon.FireWeaponBolt( fireGrenadeParams )
	if ( bolt != null )
	{
		bolt.kv.rendercolor = "0 0 0"
		bolt.kv.renderamt = 0
		bolt.kv.fadedist = 1
		bolt.kv.gravity = 5
		SetTeam( bolt, team )

		float lifetime = 8.0

		if ( isCharged )
		{
			bolt.SetProjectilTrailEffectIndex( 1 )
			lifetime = 20.0
		}

		bolt.SetProjectileLifetime( lifetime )

		#if SERVER
			AttachBallLightning( weapon, bolt )

			entity ballLightning = expect entity( bolt.ballLightning )

			ballLightning.e.ballLightningData.damage = damage

			/*{
				// HACK: bolts don't have collision so...
				entity collision = CreateEntity( "prop_script" )

				collision.SetValueForModelKey( ARC_BALL_COLL_MODEL )
				collision.kv.fadedist = -1
				collision.kv.physdamagescale = 0.1
				collision.kv.inertiaScale = 1.0
				collision.kv.renderamt = 255
				collision.kv.rendercolor = "255 255 255"
				collision.kv.rendermode = 10
				collision.kv.solid = SOLID_VPHYSICS
				collision.SetOwner( owner )
				collision.SetOrigin( bolt.GetOrigin() )
				collision.SetAngles( bolt.GetAngles() )
				SetTargetName( collision, "Arc Ball" )
				SetVisibleEntitiesInConeQueriableEnabled( collision, true )

				DispatchSpawn( collision )

				collision.SetParent( bolt )
				collision.SetMaxHealth( 250 )
				collision.SetHealth( 250 )
				AddEntityCallback_OnDamaged( collision, OnArcBallCollDamaged )

				thread TrackCollision( collision, bolt )
			}*/
		#endif
	}
}