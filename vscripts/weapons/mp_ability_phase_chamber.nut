//Made by CafeFPS
untyped

global function OnProjectileCollision_phase_chamber
global function OnProjectileIgnite_phase_chamber
global function OnWeaponTossRelease_phase_chamber
global function MpUltimatePhaseChamber_Init

#if CLIENT
global function ServerCallback_SonarPhaseChamber
global function StartPhaseChamberTimer
#endif

///CONFIGS///
const float TOTALRADIUS = 256 //hardcoded don't change until props are resized properly
const float DELAY_TIME = 2.0
const float INVOID_TIME = 3.0
const float DAMAGE_TO_DEAL_ON_EXPLOSION = 10
global const float MAX_TIME_IN_REWIND_OR_VOID = 3.11

const float TOTALRADIUS_SQR = TOTALRADIUS*TOTALRADIUS
const float SPHEREHEIGHT = TOTALRADIUS/2
///////////
const asset FX = $"P_ar_holopilot_trail"

void function MpUltimatePhaseChamber_Init()
{
	RegisterSignal("EndPhaseChamberHighlight")
	PrecacheModel($"mdl/fx/plasma_sphere_01.rmdl")
	PrecacheModel($"mdl/fx/ar_edge_sphere_512.rmdl")
	PrecacheParticleSystem(FX)
	PrecacheParticleSystem($"Rocket_Smoke_SMALL_Titan_2")
	PrecacheParticleSystem($"P_arc_blue")
}

var function OnWeaponTossRelease_phase_chamber( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	#if SERVER
	var result = OnWeaponToss_phase_chamber( weapon, attackParams, 1.0 )
	return result
	#endif
}

int function OnWeaponToss_phase_chamber( entity weapon, WeaponPrimaryAttackParams attackParams, float directionScale )
{
	weapon.EmitWeaponSound_1p3p( GetGrenadeThrowSound_1p( weapon ), GetGrenadeThrowSound_3p( weapon ) )
	bool projectilePredicted = PROJECTILE_PREDICTED
	bool projectileLagCompensated = PROJECTILE_LAG_COMPENSATED
	
	#if SERVER
	if ( weapon.IsForceReleaseFromServer() )
	{
		projectilePredicted = false
		projectileLagCompensated = false
	}
	#endif
	
	entity grenade = PhaseChamberGrenade_Launch( weapon, attackParams.pos, (attackParams.dir * directionScale), projectilePredicted, projectileLagCompensated )
	entity weaponOwner = weapon.GetWeaponOwner()
	weaponOwner.Signal( "ThrowGrenade" )

	PlayerUsedOffhand( weaponOwner, weapon, true, grenade ) // intentionally here and in Hack_DropGrenadeOnDeath - accurate for when cooldown actually begins

	if ( IsValid( grenade ) )
		grenade.proj.savedDir = weaponOwner.GetViewForward()

	#if SERVER
	#if BATTLECHATTER_ENABLED
		TryPlayWeaponBattleChatterLine( weaponOwner, weapon )
	#endif
	#endif

	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

entity function PhaseChamberGrenade_Launch( entity weapon, vector attackPos, vector throwVelocity, bool isPredicted, bool isLagCompensated )
{
	//TEMP FIX while Deploy anim is added to sprint
	float currentTime = Time()
	if ( weapon.w.startChargeTime == 0.0 )
		weapon.w.startChargeTime = currentTime

	// Note that fuse time of 0 means the grenade won't explode on its own, instead it depends on OnProjectileCollision() functions to be defined and explode there.
	float fuseTime = weapon.GetGrenadeFuseTime()
	bool startFuseOnLaunch = bool( weapon.GetWeaponInfoFileKeyField( "start_fuse_on_launch" ) )

	if ( fuseTime > 0 && !startFuseOnLaunch )
	{
		fuseTime = fuseTime - ( currentTime - weapon.w.startChargeTime )
		if ( fuseTime <= 0 )
			fuseTime = 0.001
	}

	// NOTE: DO NOT apply randomness to angularVelocity, it messes up lag compensation
	// KNOWN ISSUE: angularVelocity is applied relative to the world, so currently the projectile spins differently based on facing angle
	vector angularVelocity = <10, -1600, 10>

	int damageFlags = weapon.GetWeaponDamageFlags()
	WeaponFireGrenadeParams fireGrenadeParams
	fireGrenadeParams.pos = attackPos
	fireGrenadeParams.vel = throwVelocity
	fireGrenadeParams.angVel = angularVelocity
	fireGrenadeParams.fuseTime = fuseTime
	fireGrenadeParams.scriptTouchDamageType = (damageFlags & ~DF_EXPLOSION) // when a grenade "bonks" something, that shouldn't count as explosive.explosive
	fireGrenadeParams.scriptExplosionDamageType = damageFlags
	fireGrenadeParams.clientPredicted = isPredicted
	fireGrenadeParams.lagCompensated = isLagCompensated
	fireGrenadeParams.useScriptOnDamage = true
	entity frag = weapon.FireWeaponGrenade( fireGrenadeParams )
	if ( frag == null )
		return null

	#if SERVER
		entity owner = weapon.GetWeaponOwner()
		if ( IsValid( owner ) )
		{
			if ( IsWeaponOffhand( weapon ) )
			{
				AddToUltimateRealm( owner, frag )
			}
			else
			{
				frag.RemoveFromAllRealms()
				frag.AddToOtherEntitysRealms( owner )
			}
		}
	#endif

	OnPlayerNPCTossGrenade_phase_chamber_Common( weapon, frag )

	return frag
}

void function OnPlayerNPCTossGrenade_phase_chamber_Common( entity weapon, entity frag )
{
	PhaseChamberThrow_Init( frag, weapon )
	
	#if SERVER
		thread TrapExplodeOnDamage( frag, 20, 0.0, 0.0 )
		
		string projectileSound = GetGrenadeProjectileSound( weapon )
		if ( projectileSound != "" )
			EmitSoundOnEntity( frag, projectileSound )

		entity fxID = StartParticleEffectOnEntity_ReturnEntity( frag, GetParticleSystemIndex( $"P_ar_holopilot_trail" ), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )
		entity fxID2 = StartParticleEffectOnEntity_ReturnEntity( frag, GetParticleSystemIndex( $"P_ar_holopilot_trail" ), FX_PATTACH_ABSORIGIN_FOLLOW, -1 )

	#endif
}

void function PhaseChamberThrow_Init( entity grenade, entity weapon )
{
	entity weaponOwner = weapon.GetOwner()
	if ( IsValid( weaponOwner ) )
		SetTeam( grenade, weaponOwner.GetTeam() )
	
	entity owner = weapon.GetWeaponOwner()
	if ( IsValid( owner ) && owner.IsNPC() )
		SetTeam( grenade, owner.GetTeam() )

	#if SERVER
		bool smartPistolVisible = weapon.GetWeaponSettingBool( eWeaponVar.projectile_visible_to_smart_ammo )
		if ( smartPistolVisible )
		{
			grenade.SetDamageNotifications( true )
			grenade.SetTakeDamageType( DAMAGE_EVENTS_ONLY )
			grenade.proj.onlyAllowSmartPistolDamage = true

			if ( !grenade.GetProjectileWeaponSettingBool( eWeaponVar.projectile_damages_owner ) && !grenade.GetProjectileWeaponSettingBool( eWeaponVar.explosion_damages_owner ) )
				SetCustomSmartAmmoTarget( grenade, true ) // prevent friendly target lockon
		}
		else
		{
			grenade.SetTakeDamageType( DAMAGE_NO )
		}
	#endif
}

void function OnProjectileCollision_phase_chamber( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical )
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
	vector GoodAngles = AnglesOnSurface(normal, -AnglesToRight(player.EyeAngles()))
	projectile.proj.projectileBounceCount++
	if ( !result && projectile.proj.projectileBounceCount < 10 )
	{
		return
	}
	else if ( IsValid( hitEnt ) && ( hitEnt.IsPlayer() || hitEnt.IsTitan() || hitEnt.IsNPC() ) )
	{
		CreateBubbleForPhaseChamber(player.GetTeam(), projectile.GetOrigin(), GoodAngles, player)
		projectile.Destroy()
	}
	else
	{
		CreateBubbleForPhaseChamber(player.GetTeam(), projectile.GetOrigin(), GoodAngles, player)
		projectile.Destroy()
	}
	#endif
}
#if SERVER
entity function CreateBubbleForPhaseChamber( int team, vector origin, vector angles, entity owner = null, float duration = 9999, bool damage = true, asset effectName = EMPTY_MODEL, asset collisionModel = EMPTY_MODEL )
{
	entity bubbleShield = CreateEntity( "prop_dynamic" )
	bubbleShield.SetValueForModelKey( $"mdl/fx/plasma_sphere_01.rmdl" ) // TODO: fix this for apex
	
	bubbleShield.kv.solid = 0
    bubbleShield.kv.rendercolor = "81 130 151"
    bubbleShield.kv.contents = (int(bubbleShield.kv.contents) | CONTENTS_NOGRAPPLE)
	bubbleShield.SetOrigin( origin )
	bubbleShield.SetAngles( angles )
	bubbleShield.kv.CollisionGroup = 0
	DispatchSpawn( bubbleShield )
	bubbleShield.SetOwner(owner)
	SetTeam( bubbleShield, team )

	entity bubbleShield2 = CreateEntity( "prop_dynamic" )
	bubbleShield2.SetValueForModelKey( $"mdl/fx/ar_edge_sphere_512.rmdl" ) // TODO: fix this for apex
	bubbleShield2.kv.modelscale = 2
	bubbleShield2.kv.solid = 0
    bubbleShield2.kv.rendercolor = "81 130 151"
    bubbleShield2.kv.contents = (int(bubbleShield2.kv.contents) | CONTENTS_NOGRAPPLE)
	bubbleShield2.SetOrigin( origin )
	bubbleShield2.SetAngles( angles )
	bubbleShield2.kv.CollisionGroup = 0
	DispatchSpawn( bubbleShield2 )
	bubbleShield2.SetOwner(owner)
	SetTeam( bubbleShield2, team )
	
	
	thread CleanupPhaseChamber( bubbleShield, bubbleShield2, DELAY_TIME, owner)
	
	return bubbleShield
}


void function CleanupPhaseChamber( entity bubbleShield, entity bubbleShield2, float fadeTime, entity owner)
{
	bubbleShield.EndSignal( "OnDestroy" )

	OnThreadEnd(
		function () : ( bubbleShield, bubbleShield2, owner)
		{
			thread PhaseChamberTrigger( bubbleShield, owner )
			
			bubbleShield.Dissolve(ENTITY_DISSOLVE_CORE, <0,0,0>, 200)
			bubbleShield2.Dissolve(ENTITY_DISSOLVE_CORE, <0,0,0>, 200)
		}
	)
	thread resizeProp1(bubbleShield)
	thread resizeProp2(bubbleShield2)
	EmitSoundOnEntity( bubbleShield, "Char11_UltimateA_C_3p" )

	
	wait fadeTime
}

void function resizeProp1(entity bubble1)
{
	int modelscale = 1
	while(modelscale < 23)
	{
		bubble1.kv.modelscale = modelscale
		modelscale++
		WaitFrame()
	}
}
void function resizeProp2(entity bubble2)
{
	float modelscale = 0.1
	while(modelscale < 2.1)
	{
		bubble2.kv.modelscale = modelscale
		modelscale = modelscale + 0.1
		WaitFrame()
	}
}
void function PhaseChamberTrigger( entity bubbleShield, entity bubbleShieldPlayer )
{
	if ( IsValid( bubbleShieldPlayer ) )
		bubbleShieldPlayer.EndSignal( "OnDestroy" )

	entity trigger = CreateEntity( "trigger_cylinder" )
	trigger.SetRadius( TOTALRADIUS )
	trigger.SetAboveHeight( SPHEREHEIGHT ) //Still not quite a sphere, will see if close enough
	trigger.SetBelowHeight( SPHEREHEIGHT )
	trigger.SetOrigin( bubbleShield.GetOrigin() )
	DispatchSpawn( trigger )

	trigger.SearchForNewTouchingEntity()


	OnThreadEnd(
	function() : ( trigger )
		{
			trigger.Destroy()
		}
	)

	array<entity> touchingEnts = trigger.GetTouchingEntities()
	array<entity> targetEnts
	array<entity> ignoreEnts = []
		
	foreach ( entity touchingEnt in touchingEnts )
		{
			if (!touchingEnt.IsPlayer() && !touchingEnt.IsNPC()) continue
			
			// if ( touchingEnt.GetTeam() != bubbleShieldPlayer.GetTeam() )
				targetEnts.append( touchingEnt )
			// else
				// ignoreEnts.append( touchingEnt )
		}
		
	foreach( touchingEnt in targetEnts  )
	{
		  printt("touching ent sent to void" + touchingEnt)
		  		  
		  if(touchingEnt != bubbleShieldPlayer) {
			  touchingEnt.TakeDamage( DAMAGE_TO_DEAL_ON_EXPLOSION, bubbleShieldPlayer, null, { scriptType = DF_BYPASS_SHIELD | DF_DOOMED_HEALTH_LOSS, damageSourceId = eDamageSourceId.deathField } )
		  }
		  Remote_CallFunction_Replay( bubbleShieldPlayer, "ServerCallback_SonarPhaseChamber", touchingEnt, bubbleShieldPlayer, INVOID_TIME)
		  PhaseShift( touchingEnt, 0.0, 10 )
		  if(touchingEnt.IsPlayer()) {
			  // StatusEffect_AddTimed( touchingEnt, eStatusEffect.rewindTimerChamber, 1.0, MAX_TIME_IN_REWIND_OR_VOID, 0.0 )
			  EmitSoundOnEntityOnlyToPlayer( touchingEnt, touchingEnt, "PhaseGate_Enter_1p" )
			  EmitSoundOnEntityExceptToPlayer( touchingEnt, touchingEnt, "PhaseGate_Enter_3p" )
		  }
		  thread CancelPSAndDoFXs(touchingEnt, bubbleShieldPlayer)
	}
}

void function CancelPSAndDoFXs(entity touchingEnt, entity owner)
{
	int attachID            = touchingEnt.LookupAttachment( "CHESTFOCUS" )
	entity holoPilotTrailFX = StartParticleEffectOnEntity_ReturnEntity( touchingEnt, GetParticleSystemIndex( FX ), FX_PATTACH_POINT_FOLLOW, attachID )
	
	wait INVOID_TIME
	if(IsValid(holoPilotTrailFX)) holoPilotTrailFX.Destroy()
	CancelPhaseShift( touchingEnt )

	if(touchingEnt.IsPlayer()) {
	EmitSoundOnEntityOnlyToPlayer( touchingEnt, touchingEnt, "PhaseGate_Exit_1p" )
	EmitSoundOnEntityExceptToPlayer( touchingEnt, touchingEnt, "PhaseGate_Exit_3p" )
	}
	
	StartParticleEffectInWorld( GetParticleSystemIndex( $"P_impact_shieldbreaker_sparks" ), touchingEnt.GetOrigin(), touchingEnt.GetAngles() )
	//do fx here
}
#endif

#if CLIENT
void function ServerCallback_SonarPhaseChamber( entity sonarTarget, entity owner, float duration)
{
	#if CLIENT
	if(sonarTarget.IsPlayer()) sonarTarget.p.lasttime = MAX_TIME_IN_REWIND_OR_VOID + 0.5
	#endif
	thread CreatePhaseChamberCloneForEnt( sonarTarget, owner )
	thread HighlightWatcher(duration, owner)
}

void function HighlightWatcher(float duration, entity owner)
{
	wait duration
	Signal(owner, "EndPhaseChamberHighlight")
}

void function CreatePhaseChamberCloneForEnt( entity sonarTarget, entity owner )
{
	entity entClone	
	owner.EndSignal("EndPhaseChamberHighlight")
	EndSignal(owner, "EndPhaseChamberHighlight")
	
	OnThreadEnd(
		function() : ( entClone )
		{
				if(IsValid(entClone)) entClone.Destroy()
		}
	)
	
	while(true)
	{
		entClone = CreateClientSidePropDynamicClone( sonarTarget, sonarTarget.GetModelName() )
		if ( !IsValid( entClone ) ) //JFS - Could further investigate why this particular function can return null. Code comment was referring to TF1 stuff.
			return

		PhaseChamberCloneHighlight( entClone )
		thread delayedDestroyBecauseYes(entClone)
		WaitFrame()
		if(IsValid(entClone)) entClone.Destroy()
	}
}

void function delayedDestroyBecauseYes(entity entClone)
{
	WaitFrame()
	if(IsValid(entClone)) entClone.Destroy()
}

void function PhaseChamberCloneHighlight( entity ent, vector highlightColor = <255,0,0>/100 )
{
	int highlightId = ent.Highlight_GetState( HIGHLIGHT_CONTEXT_NEUTRAL )
	ent.Highlight_SetVisibilityType( HIGHLIGHT_VIS_ALWAYS )
	ent.Highlight_SetCurrentContext( HIGHLIGHT_CONTEXT_NEUTRAL )
	ent.Highlight_SetFunctions( HIGHLIGHT_CONTEXT_NEUTRAL, 0, false, 169, 2.0, highlightId, true )
	ent.Highlight_SetParam( HIGHLIGHT_CONTEXT_NEUTRAL, 0, highlightColor )
	ent.Highlight_SetFlag( HIGHLIGHT_FLAG_CHECK_OFTEN, true )
	ent.Highlight_StartOn()
	ent.Highlight_SetLifeTime( 0.1 )
}

string function StartPhaseChamberTimer(var rui, entity player, float maxtime) //this timer is ass
{
	string message 
        if(maxtime < 0.01)
		{
			message = "Exit Void in 0.00" 
			return message
		}
		player.p.lasttime = player.p.lasttime-0.01
		message = "Exit Void in " + ClientLocalizeAndShortenNumber_Float(player.p.lasttime, 1, 2)
	return message
}

#endif
void function OnProjectileIgnite_phase_chamber( entity projectile )
{

}