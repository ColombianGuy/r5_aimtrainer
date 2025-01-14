//Made by @CafeFPS

global function MpWeaponRingFlare_Init
// global function MpWeaponGrenadeDefensiveBombardment_Init
global function OnProjectileCollision_ringflare
global function OnWeaponTossReleaseAnimEvent_ringflare
global function OnWeaponOwnerChanged_ringflare

#if CLIENT
global function EnterTriggerRF
global function ExitTriggerRF
#endif

float RINGFLARE_RADIUS = 500
float FRAC_OF_HEALTH_DAMAGE = 0.2
bool DAMAGEOWNER = false
int GROWTH_SPEED = 10
int REDUCESIZESPEED = 5
// int HOWMANYRINGS = 50

struct{
	int currentRadius
	int colorcorrection
	int fxonscreen
	bool applycolorcorrection = false
}file

const string DEFENSIVE_BOMBARDMENT_MISSILE_WEAPON = "mp_weapon_defensive_bombardment_weapon"

//Gibraltar Ult / Mortar FX
const asset FX_BOMBARDMENT_MARKER = $"P_ar_artillery_marker"

const float DEFENSIVE_BOMBARDMENT_RADIUS 		 	= 1024 //The radius of the bombardment area.
const int	DEFENSIVE_BOMBARDMENT_DENSITY			= 6	//The density of the distributed shell randomness.
const float DEFENSIVE_BOMBARDMENT_DURATION			= 6.0 //The duration the bombardment will last.
const float DEFENSIVE_BOMBARDMENT_DELAY 			= 2.0 //The bombardment will wait 2.0 seconds before firing the first shell.

const float DEFENSIVE_BOMBARDMENT_SHELLSHOCK_DURATION = 4.0

const asset FX_DEFENSIVE_BOMBARDMENT_SCAN = $"P_artillery_marker_scan"

// void function MpWeaponGrenadeDefensiveBombardment_Init()
// {
	// PrecacheWeapon( DEFENSIVE_BOMBARDMENT_MISSILE_WEAPON )

	// PrecacheParticleSystem( FX_DEFENSIVE_BOMBARDMENT_SCAN )
	// PrecacheParticleSystem( FX_BOMBARDMENT_MARKER )

	// #if SERVER
		// AddDamageCallbackSourceID( eDamageSourceId.damagedef_defensive_bombardment, DefensiveBombardment_DamagedTarget )
	// #endif //SERVER
// }

void function OnWeaponOwnerChanged_ringflare( entity weapon, WeaponOwnerChangedParams changeParams )
{
	#if SERVER
	if ( IsValid( changeParams.oldOwner ) )
	{
		if ( changeParams.oldOwner.IsPlayer() )
		{
			changeParams.oldOwner.TakeOffhandWeapon( OFFHAND_RIGHT )
		}
	}

	if ( IsValid( changeParams.newOwner ) )
	{
		if ( changeParams.newOwner.IsPlayer() )
		{
			changeParams.newOwner.GiveOffhandWeapon( DEFENSIVE_BOMBARDMENT_MISSILE_WEAPON, OFFHAND_RIGHT, [] )
		}
	}
	#endif
}

var function OnWeaponTossReleaseAnimEvent_ringflare( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	entity owner = weapon.GetWeaponOwner()

	if ( !IsValid( owner ) )
		return

	#if SERVER
	entity bombardmentWeapon = owner.GetOffhandWeapon( OFFHAND_RIGHT )
	if ( !IsValid( bombardmentWeapon ) )
		owner.GiveOffhandWeapon( DEFENSIVE_BOMBARDMENT_MISSILE_WEAPON, OFFHAND_RIGHT, [] )

		PlayBattleChatterLineToSpeakerAndTeam( owner, "bc_super" )
	#endif

	Grenade_OnWeaponTossReleaseAnimEvent( weapon, attackParams )
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

void function OnProjectileCollision_ringflare( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
{
	entity player = projectile.GetOwner()
	if ( hitEnt == player )
		return

	if ( projectile.GrenadeHasIgnited() )
		return

	table collisionParams =
	{
		pos = pos,
		normal = normal,
		hitEnt = hitEnt,
		hitbox = hitbox
	}

	bool result = PlantStickyEntityOnWorldThatBouncesOffWalls( projectile, collisionParams, 0.7 )

	#if SERVER
		if ( !result )
		{
			return
		}
		else
		{
			// for(int i = 0; i<HOWMANYRINGS; i++)
				thread RingFlareStart(projectile.GetOrigin(), Vector(0,0,0), player)
		}
	#endif
	projectile.GrenadeIgnite()
	projectile.SetDoesExplode( false )
}


void function MpWeaponRingFlare_Init()
{
	PrecacheParticleSystem($"P_player_wind_CC_trash")
	RegisterSignal("EndRingFlareThread")
	PrecacheModel($"mdl/Robots/mobile_hardpoint/mobile_hardpoint_static.rmdl")
	#if CLIENT
	PrecacheParticleSystem($"P_ring_FP_hit_01")
	
	file.colorcorrection = ColorCorrection_Register( "materials/correction/outside_ring.raw_hdr" )
	
	StatusEffect_RegisterEnabledCallback( eStatusEffect.ring_flare, OnBeginPlacingRingFlare )
	StatusEffect_RegisterDisabledCallback( eStatusEffect.ring_flare, OnEndPlacingRingFlare )
	#endif
}

void function OnWeaponActivate_ringflare( entity weapon )
{
	entity ownerPlayer = weapon.GetWeaponOwner()
	Assert( ownerPlayer.IsPlayer() )

	#if CLIENT
		if ( !InPrediction() ) //Stopgap fix for Bug 146443
			return
	#endif


	#if SERVER
		StatusEffect_AddEndless( ownerPlayer, eStatusEffect.ring_flare, 1.0 )
		//ownerPlayer.Server_TurnOffhandWeaponsDisabledOn()
	#endif
}

void function OnWeaponDeactivate_ringflare( entity weapon )
{
	entity ownerPlayer = weapon.GetWeaponOwner()
	Assert( ownerPlayer.IsPlayer() )

	#if CLIENT
		if ( !InPrediction() ) //Stopgap fix for Bug 146443
			return
	ownerPlayer.Signal( "DeployableCarePackagePlacement" )
	#endif

	#if SERVER
		StatusEffect_StopAllOfType( ownerPlayer, eStatusEffect.ring_flare )
		//ownerPlayer.Server_TurnOffhandWeaponsDisabledOff()
	#endif
}

// var function OnWeaponPrimaryAttack_ringflare( entity weapon, WeaponPrimaryAttackParams attackParams )
// {
	// entity ownerPlayer = weapon.GetWeaponOwner()
	// Assert( ownerPlayer.IsPlayer() )

	// if ( ownerPlayer.IsPhaseShifted() )
		// return 0

	// CarePackagePlacementInfo placementInfo = GetCarePackagePlacementInfo( ownerPlayer )

	// if ( placementInfo.failed )
		// return 0
	
	// vector origin = placementInfo.origin
	// vector angles = placementInfo.angles
	
	// #if SERVER
	// thread RingFlareStart(origin, angles, ownerPlayer)
	// //thread testparticle(origin, angles, ownerPlayer)

	// // entity respawn = CreatePropDynamic_NoDispatchSpawn( $"mdl/Robots/mobile_hardpoint/mobile_hardpoint_static.rmdl", origin, angles, 6)
	// // SetTargetName(respawn, "respawn_chamber")
	// // DispatchSpawn(respawn)
	// // OnRespawnChamberSpawned(respawn)
	
		// // PlayBattleChatterLineToSpeakerAndTeam( ownerPlayer, "bc_super" )

		// PlayerUsedOffhand( ownerPlayer, weapon, true, null, {pos = origin} )
	// #else
		// PlayerUsedOffhand( ownerPlayer, weapon )
		// //ownerPlayer.Signal( "DeployableringFlarePlacement" )
	// #endif
	// int ammoReq = weapon.GetAmmoPerShot()
	// return ammoReq
// }

#if SERVER
void function testparticle(vector origin, vector angles, entity player)
{
	WaitFrame()
	entity fx = StartParticleEffectInWorld_ReturnEntity( GetParticleSystemIndex( $"P_player_wind_CC_trash" ), origin, angles)
				// fx.kv.renderamt = 255
            // fx.kv.rendermode = 0
			fx.kv.rendercolor = "255 255 255 50"
			fx.kv.VisibilityFlags = ENTITY_VISIBLE_TO_EVERYONE	
}
#endif

#if SERVER
void function RingFlareStart(vector origin, vector angles, entity player)
{
	printt("test")
	//Survival ring particle
	entity circle = CreateEntity( "prop_script" )
	circle.SetValueForModelKey( $"mdl/dev/empty_model.rmdl" )
	circle.kv.fadedist = -1
	circle.kv.renderamt = 255
	circle.kv.rendercolor = "235, 110, 52"
	circle.kv.solid = 0
	circle.SetOrigin( origin )
	circle.SetAngles( <0, 0, 0> )
	circle.NotSolid()
	circle.DisableHibernation()
	SetTargetName( circle, "circle" )
	DispatchSpawn(circle)
	
	entity fx = StartParticleEffectOnEntity_ReturnEntity(circle, GetParticleSystemIndex( $"P_survival_radius_CP_1x100" ), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )
	fx.SetParent(circle)
	
	entity trigger = CreateEntity( "trigger_cylinder" )
	trigger.SetRadius( 0 )
	trigger.SetAboveHeight( 500 )
	trigger.SetBelowHeight( 500 )
	trigger.SetOrigin( origin )
	DispatchSpawn( trigger )
	trigger.EndSignal( "OnDestroy" )
	trigger.SetParent(circle)
	trigger.SetEnterCallback( DeathFieldEnter )
	trigger.SetLeaveCallback( DeathFieldExit )
	trigger.SearchForNewTouchingEntity()

	thread IncreaseSizeOverTime(fx, trigger, player)
	thread DeathFieldDamage(circle, player)
	thread AudioThread(circle, player)
}
void function AudioThread(entity circle, entity player)
{
	entity audio
	string soundToPlay = "Survival_Circle_Edge_Small_Movement"
	OnThreadEnd(
		function() : ( soundToPlay, audio)
		{
			
			if(IsValid(audio)) audio.Destroy()
		}
	)
	audio = CreateScriptMover()
	audio.SetOrigin( circle.GetOrigin() )
	audio.SetAngles( <0, 0, 0> )
	EmitSoundOnEntity( audio, soundToPlay )
	
	while(IsValid(circle)){
			vector fwdToPlayer   = Normalize( <player.GetOrigin().x, player.GetOrigin().y, 0> - <circle.GetOrigin().x, circle.GetOrigin().y, 0> )
			vector circleEdgePos = circle.GetOrigin() + (fwdToPlayer * RINGFLARE_RADIUS)
			circleEdgePos.z = player.EyePosition().z
			if ( fabs( circleEdgePos.x ) < 61000 && fabs( circleEdgePos.y ) < 61000 && fabs( circleEdgePos.z ) < 61000 )
			{
				audio.SetOrigin( circleEdgePos )
			}
		WaitFrame()
	}
	
	StopSoundOnEntity(audio, soundToPlay)
}

void function IncreaseSizeOverTime(entity fx, entity trigger, entity player)
{
	EndSignal( player, "OnDestroy" )
	EndSignal( trigger, "OnDestroy" )
	
	WaitFrame()
	
	int i = 0
	
	OnThreadEnd(
		function() : (trigger)
		{
			entity circle = trigger.GetParent()
			if(IsValid(circle))
			circle.Destroy()
		}
	)
	while(i<RINGFLARE_RADIUS)
	{
	    EffectSetControlPointVector( fx, 1, <i, 0, 0> )
		trigger.SetRadius( i )
		//printt("debug: " + i)
		file.currentRadius = i
		i=i+GROWTH_SPEED
		WaitFrame()
	}
	
	while(i>0)
	{
	    EffectSetControlPointVector( fx, 1, <i, 0, 0> )
		trigger.SetRadius( i )
		//printt("debug: " + i)
		file.currentRadius = i
		if(i==1){
		player.Signal("EndRingFlareThread")
		}
		i=i-REDUCESIZESPEED
		WaitFrame()
	}
}

void function DeathFieldDamage( entity circle, entity owner)
{
	owner.EndSignal( "OnDestroy" )
	circle.EndSignal( "OnDestroy" )
	
	WaitFrame()
	
	const float DAMAGE_CHECK_STEP_TIME = 1.5

	while ( IsValid(circle) )
	{
		int currentRadius = file.currentRadius

		foreach ( dummy in GetNPCArray() )
		{
			if ( dummy.IsPhaseShifted() )
				continue

			float playerDist = Distance2D( dummy.GetOrigin(), circle.GetOrigin() )
			if ( playerDist < currentRadius )
			{
				int damagetodeal = int( FRAC_OF_HEALTH_DAMAGE * float( dummy.GetMaxHealth() ) )
				dummy.TakeDamage( damagetodeal, owner, null, { damageSourceId = eDamageSourceId.deathField } )
			}
		}
		
		foreach ( player in GetPlayerArray_Alive() )
		{
			if(player == owner && !DAMAGEOWNER) 
				continue
			
			if ( player.IsPhaseShifted() )
				continue

			float playerDist = Distance2D( player.GetOrigin(), circle.GetOrigin() )
			if ( playerDist < currentRadius )
			{
				int damagetodeal = int( FRAC_OF_HEALTH_DAMAGE * float( player.GetMaxHealth() ) )
				Remote_CallFunction_Replay( player, "ServerCallback_PlayerTookDamage", 0, 0, 0, 0, DF_BYPASS_SHIELD | DF_DOOMED_HEALTH_LOSS, eDamageSourceId.deathField, null )
				player.TakeDamage( damagetodeal, owner, null, { damageSourceId = eDamageSourceId.deathField } )
				printt( " player took damage", damagetodeal)
			}
		}
		wait DAMAGE_CHECK_STEP_TIME
	}
}

void function DeathFieldEnter(entity trigger, entity ent)
{
	if(!ent.IsPlayer()) return
	Remote_CallFunction_NonReplay( ent, "EnterTriggerRF", ent)
}

void function DeathFieldExit(entity trigger, entity ent)
{
	if(!ent.IsPlayer()) return
	Remote_CallFunction_NonReplay( ent, "ExitTriggerRF", ent)
}
#endif

#if CLIENT
void function EnterTriggerRF(entity ent)
{
	if ( !EffectDoesExist( file.fxonscreen ) )
		{
			entity cockpit = ent.GetCockpit()
			ColorCorrection_SetWeight( file.colorcorrection, 1.0 )
			Chroma_EnteredRing()
			file.fxonscreen = StartParticleEffectOnEntity( cockpit, GetParticleSystemIndex( $"P_ring_FP_hit_01" ), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )
			EffectSetIsWithCockpit( file.fxonscreen, true )	
		}
}

void function ExitTriggerRF(entity ent)
{
	if ( EffectDoesExist( file.fxonscreen ) )
		{
			EffectStop( file.fxonscreen, true, true )
			ColorCorrection_SetWeight( file.colorcorrection, 0 )
			Chroma_LeftRing()
		}
}

void function OnBeginPlacingRingFlare( entity player, int statusEffect, bool actuallyChanged )
{
	if ( player != GetLocalViewPlayer() )
		return

	thread DeployableRingFlarePlacement( player, $"mdl/fx/ar_survival_cylinder.rmdl" )
}

void function OnEndPlacingRingFlare( entity player, int statusEffect, bool actuallyChanged )
{
	if ( player != GetLocalViewPlayer() )
		return

	//player.Signal( "DeployableringFlarePlacement" )
}

void function DeployableRingFlarePlacement( entity player, asset ringFlareModel )
{
	player.EndSignal( "DeployableCarePackagePlacement" )

	entity ringFlare = CreateRingFlareProxy( ringFlareModel )
	ringFlare.EnableRenderAlways()
	ringFlare.Show()
	DeployableModelHighlight( ringFlare )

	OnThreadEnd(
		function() : ( ringFlare )
		{
			if ( IsValid( ringFlare ) )
				thread DestroyRingFlareProxy( ringFlare )

			HidePlayerHint( "%attack% Create Ring Flare" )
		}
	)

	AddPlayerHint( 3.0, 0.25, $"", "%attack% Create Ring Flare" )

	while ( true )
	{
		CarePackagePlacementInfo placementInfo = GetCarePackagePlacementInfo( player )

		ringFlare.SetOrigin( placementInfo.origin )
		ringFlare.SetAngles( placementInfo.angles )

		if ( !placementInfo.failed )
			DeployableModelHighlight( ringFlare )
		else
			DeployableModelInvalidHighlight( ringFlare )

		if ( placementInfo.hide )
			ringFlare.Hide()
		else
			ringFlare.Show()

		WaitFrame()
	}
}

entity function CreateRingFlareProxy( asset modelName )
{
	entity ringFlare = CreateClientSidePropDynamic( <0,0,0>, <0,0,0>, modelName )
	ringFlare.kv.renderamt = 255
	ringFlare.Anim_Play( "ref" )
	ringFlare.Hide()
	ringFlare.kv.rendercolor = "235, 110, 52"
	return ringFlare
}

void function DestroyRingFlareProxy( entity ent )
{
	Assert( IsNewThread(), "Must be threaded off" )
	ent.EndSignal( "OnDestroy" )

	// if ( file.carePackageDeployed )
		// wait 0.225
	if(IsValid(ent))
	ent.Destroy()
}
#endif

