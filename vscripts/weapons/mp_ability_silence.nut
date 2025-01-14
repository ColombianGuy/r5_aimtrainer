global function MpAbilitySilence_Init
global function OnProjectileCollision_ability_silence
global function OnWeaponReadyToFire_ability_silence
global function OnWeaponTossReleaseAnimEvent_ability_silence
global function OnWeaponDeactivate_ability_silence

global function Silence_GetEffectDuration

#if SERVER
global function Hack_HandleSilenceDamage
#endif

//SILENCE AREA VARS
const float SILENCE_AREA_DURATION = 10.0
const float SILENCE_AREA_RADIUS = 175.0 //should match damageDef value

//SILENCE FX
const asset FX_SILENCE_READY_1P = $"P_wpn_bSilence_glow_FP"
const asset FX_SILENCE_READY_3P = $"P_wpn_bSilence_glow_3P"

const asset FX_SILENCE_SMOKE_CENTER = $"P_bSilent_orb"
const asset FX_SILENCE_SMOKE = $"P_bSilent_fill"
const vector FX_SILENCE_SMOKE_OFFSET = <0,0,-20>

const asset FX_SILENCE_REV_VICTIM_3P = $"P_bSilent_body"

//const string SILENCE_SOUND_VICTIM = "Bangalore_DoubleTime_Activate"

global const string SILENCE_MOVER_SCRIPTNAME = "silence_mover"
global const string SILENCE_TRACE_SCRIPTNAME = "silence_trace_blocker"

const float SILENCE_BOUNCE_DOT_MAX = 0.5

const bool SILENCE_DEBUG = false
const bool SILENCE_DEBUG_STATUSEFFECT = false
const bool SILENCE_DEBUG_WEAPONEFFECT = false

struct
{
	float effectDuration
} file

void function MpAbilitySilence_Init()
{
	PrecacheParticleSystem( FX_SILENCE_READY_1P )
	PrecacheParticleSystem( FX_SILENCE_READY_3P )
	PrecacheParticleSystem( FX_SILENCE_SMOKE )
	PrecacheParticleSystem( FX_SILENCE_SMOKE_CENTER )

	RegisterSignal( "hasBeenSilenced" )

	file.effectDuration = GetCurrentPlaylistVarFloat( "revenant_silence_effect_duration", 15.0 )

	#if SERVER
	RegisterDynamicEntCleanupItem_Parented_Scriptname( SILENCE_MOVER_SCRIPTNAME )
	//RegisterDynamicEntCleanupItem_Area_Scriptname( SILENCE_MOVER_SCRIPTNAME )
	AddDamageCallbackSourceID( eDamageSourceId.damagedef_loot_drone_explosion, ApplySilence )
	//Bleedout_AddCallback_OnPlayerStartBleedout( OnPlayerStartBleedout_Silence )
	RegisterSignal( "StopSilence")
	#endif
}

void function OnWeaponReadyToFire_ability_silence( entity weapon )
{
	if ( SILENCE_DEBUG_WEAPONEFFECT )
		printt( "WEAPON: READY TO FIRE")

	weapon.PlayWeaponEffect( FX_SILENCE_READY_1P, FX_SILENCE_READY_3P, "muzzle_flash" )

	#if CLIENT
		thread PROTO_FadeModelIntensityOverTime( weapon, 1.0, 0, 255)
	#endif

}

void function OnWeaponDeactivate_ability_silence( entity weapon )
{
	if ( SILENCE_DEBUG_WEAPONEFFECT )
		printt( "WEAPON: DEACTIVATE")

	weapon.StopWeaponEffect( FX_SILENCE_READY_1P, FX_SILENCE_READY_3P )

	#if CLIENT
		thread PROTO_FadeModelIntensityOverTime( weapon, 0.25, 255, 0)
	#endif

	Grenade_OnWeaponDeactivate( weapon )
}

var function OnWeaponTossReleaseAnimEvent_ability_silence( entity weapon, WeaponPrimaryAttackParams attackParams )
{
	if ( SILENCE_DEBUG_WEAPONEFFECT )
		printt( "WEAPON: TOSS RELEASE")

	weapon.StopWeaponEffect( FX_SILENCE_READY_1P, FX_SILENCE_READY_3P )
	Grenade_OnWeaponTossReleaseAnimEvent( weapon, attackParams )
	return weapon.GetWeaponSettingInt( eWeaponVar.ammo_per_shot )
}

#if SERVER
bool function ShouldStickToHitEnt( entity hitEnt )
{
	if ( !IsValid( hitEnt ) )
		return false

	                     
		//if ( EntIsHoverVehicle( hitEnt ) )
			//return false
                            

	return true
}
#endif // SERVER

void function OnProjectileCollision_ability_silence( entity projectile, vector pos, vector normal, entity hitEnt, int hitbox, bool isCritical)
{
	projectile.proj.projectileBounceCount++

	if ( projectile.proj.projectileBounceCount <= projectile.GetProjectileWeaponSettingInt( eWeaponVar.projectile_ricochet_max_count )
			&& DotProduct( normal, <0, 0, 1> ) < SILENCE_BOUNCE_DOT_MAX )
	{
		return
	}


	#if SERVER
		entity player = projectile.GetOwner()
		vector projectileOrigin = projectile.GetOrigin()
		if ( IsValid( player ) )
		{
			const float CROUCH_COVER_HEIGHT_CLEARANCE = 41
			TraceResults trace = TraceLine( projectileOrigin, projectileOrigin + normal * CROUCH_COVER_HEIGHT_CLEARANCE, [projectile, hitEnt], TRACE_MASK_SOLID, TRACE_COLLISION_GROUP_BLOCK_WEAPONS )
			vector origin = trace.endPos
			TraceResults downTrace = TraceLine( origin, origin + <0,0,-CROUCH_COVER_HEIGHT_CLEARANCE>, [projectile], TRACE_MASK_SOLID, TRACE_COLLISION_GROUP_BLOCK_WEAPONS )
			if ( downTrace.fraction < 1.0 )
			{
				float upFraction = 1.0 - downTrace.fraction
				TraceResults upTrace = TraceLine( origin, origin + <0,0,CROUCH_COVER_HEIGHT_CLEARANCE * upFraction>, [projectile], TRACE_MASK_SOLID, TRACE_COLLISION_GROUP_BLOCK_WEAPONS )
				origin = upTrace.endPos
			}

			entity mover
			if ( ShouldStickToHitEnt( hitEnt ) )
			{
				/*mover = CreateScriptMover( SILENCE_MOVER_SCRIPTNAME, origin, FlattenAngles( projectile.GetAngles() ) )

				if ( hitEnt.HasPusherAncestor() && !hitEnt.IsPlayer() )
					mover.SetParent( hitEnt ) // don't ever parent to players

				mover.RemoveFromAllRealms()
				mover.AddToOtherEntitysRealms( player )*/
			}
			thread CreateSilenceField( player, origin, mover, normal )
		}
	#endif
	projectile.GrenadeExplode( normal )
}

#if SERVER
void function CreateSilenceField( entity player, vector origin, entity mover, vector normal )
{
	player.EndSignal( "OnDestroy" )
	wait 0.25
	if ( !IsValid( player ) )	//Defensive fix - shouldn't be necessary R5DEV-123707
		return

	entity inflictor = CreateDamageInflictorHelper( SILENCE_AREA_DURATION )
	inflictor.EndSignal( "OnDestroy" )
	inflictor.RemoveFromAllRealms()
	inflictor.AddToOtherEntitysRealms( player )

	if ( SILENCE_DEBUG )
		DebugDrawSphere( origin, SILENCE_AREA_RADIUS, COLOR_RED, true, SILENCE_AREA_DURATION )

	if ( IsValid( mover ) )
	{
		EmitSoundOnEntity( mover, "Revenant_Silence_Sustain" )
	}
	else
	{
		EmitSoundAtPosition( TEAM_UNASSIGNED, origin, "Revenant_Silence_Sustain", player )
	}

	//DebugDrawSphere( origin, 100, COLOR_GREEN, true, SILENCE_AREA_DURATION )

	vector center = origin
	float radius = SILENCE_AREA_RADIUS
	//float endTime = Time() + smokescreen.lifetime

	float offset = radius / 1.5
	array<vector> offsetVectors = [
	MapAngleToRadius( 0, 0 ),
	MapAngleToRadius( 0, offset ),
	MapAngleToRadius( 45, offset ),
	MapAngleToRadius( 90, offset ),
	MapAngleToRadius( 135, offset ),
	MapAngleToRadius( 180, offset ),
	MapAngleToRadius( 225, offset ),
	MapAngleToRadius( 270, offset ),
	MapAngleToRadius( 315, offset )
	]

	table<int ,array<entity> > smokeFXs
	for ( int i=0; i<offsetVectors.len(); i++ )
	{
		smokeFXs[i] <- [null,null]
	}

	OnThreadEnd(
	function() : ( smokeFXs, mover, origin )
		{
			foreach ( entArray in smokeFXs )
			{
				if ( IsValid( entArray[0] ) )
				{
					entArray[0].Destroy()
				}
				if ( IsValid( entArray[1] ) )
				{
					entArray[1].Destroy()
				}
			}
			if ( IsValid( mover ) )
			{
				StopSoundOnEntity( mover, "Revenant_Silence_Sustain" )
				mover.Destroy()
			}
			else
			{
				StopSoundAtPosition( origin, "Revenant_Silence_Sustain" )
			}
		}
	)

	bool fxDestroyed = false

	//EmitSoundAtPosition( TEAM_UNASSIGNED, origin, GasGrenade_GasCloud )
	if ( IsValid( mover ) )
		mover.EndSignal( "OnDestroy" )
	int team = player.GetTeam()
	while( true )
	{
		for ( int i=0; i<offsetVectors.len(); i++ )
		{
			if ( IsValid( mover ) )
				center = mover.GetOrigin()

			#if DEV
			if ( SILENCE_DEBUG )
				DebugDrawMark( center, 15, COLOR_GREEN, true, 0.1 )
			#endif

			vector offsetVector = offsetVectors[i]
			vector offsetCenter = center + offsetVector
			vector radiusOrigin = offsetCenter
			int index = i==0?GetParticleSystemIndex( FX_SILENCE_SMOKE_CENTER ):GetParticleSystemIndex( FX_SILENCE_SMOKE )

			TraceResults trace

			trace = TraceLine( center, offsetCenter, [], TRACE_MASK_SOLID, TRACE_COLLISION_GROUP_BLOCK_WEAPONS, inflictor )

			#if DEV
			if ( SILENCE_DEBUG )
				DebugDrawLine( center, trace.endPos, COLOR_RED, true, 0.1 )
			#endif

			if ( trace.hitEnt != null && !trace.hitSky )
			{
				vector dif = ( offsetCenter - center ) * trace.fraction
				radiusOrigin = center + dif

				if ( !fxDestroyed )
				{
					if ( trace.fraction < 0.5 )
					{
						if ( offsetVector != offsetVectors[0] )
						{
							if ( IsValid( smokeFXs[i][0] ) )
								smokeFXs[i][0].Destroy()

							if ( IsValid( smokeFXs[i][1] ) )
								smokeFXs[i][1].Destroy()
						}

						continue
					}
					else
					{
						//if ( i != 0 )
						//{
							if ( !IsValid( smokeFXs[i][0] ) )
							{
								entity fx
								if ( !IsValid( mover ) )
								{
									fx = StartParticleEffectInWorld_ReturnEntity( index, offsetCenter + FX_SILENCE_SMOKE_OFFSET, <0,0,0> )
									EffectSetControlPointVector( fx, 1, center + FX_SILENCE_SMOKE_OFFSET )
								}
								else
								{
									//fx = StartParticleEffectOnEntityWithPos_ReturnEntity( mover, index, FX_PATTACH_ABSORIGIN_FOLLOW_NOROTATE, "REF", offsetVector + FX_SILENCE_SMOKE_OFFSET, <0,0,0> )
									//EffectAddTrackingForControlPoint( fx, 1, mover, FX_PATTACH_ABSORIGIN_FOLLOW_NOROTATE, mover.LookupAttachment( "REF" ) ) //probably needs and offset too
								}

								smokeFXs[i][0] = fx
								smokeFXs[i][1] = CreateTraceBlockerVolume( (offsetCenter + FX_SILENCE_SMOKE_OFFSET), (radius * 0.45), true, CONTENTS_BLOCK_PING, team, SILENCE_TRACE_SCRIPTNAME )

								if ( IsValid( mover ) )
									smokeFXs[i][1].SetParent( mover )

								if ( IsValid( player ) )
								{
									foreach ( ent in smokeFXs[ i ] )
									{
										ent.RemoveFromAllRealms()
										ent.AddToOtherEntitysRealms( player )
									}
								}
							}
							else
							{
								vector org = radiusOrigin + FX_SILENCE_SMOKE_OFFSET
								if ( !IsValid( mover ) )
								{
									if ( IsValid( smokeFXs[i][0] ) )
										smokeFXs[i][0].SetOrigin( org )
									if ( IsValid( smokeFXs[i][1] ) )
										smokeFXs[i][1].SetOrigin( org )
									if ( SILENCE_DEBUG )
										DebugDrawSphere( org, 64, COLOR_BLUE, true, 0.1 )
								}
							}
						//}
					}
				}
			}
			else if ( !fxDestroyed )
			{
				if ( !IsValid( smokeFXs[i][0] ) )
				{
					entity fx

					if ( !IsValid( mover ) )
					{
						fx = StartParticleEffectInWorld_ReturnEntity( index, offsetCenter + FX_SILENCE_SMOKE_OFFSET, <0,0,0> )
						EffectSetControlPointVector( fx, 1, center + FX_SILENCE_SMOKE_OFFSET)
					}
					else
					{
						//fx = StartParticleEffectOnEntityWithPos_ReturnEntity( mover, index, FX_PATTACH_ABSORIGIN_FOLLOW_NOROTATE, "REF", offsetVector + FX_SILENCE_SMOKE_OFFSET, <0,0,0> )
						//EffectAddTrackingForControlPoint( fx, 1, mover, FX_PATTACH_ABSORIGIN_FOLLOW_NOROTATE, mover.LookupAttachment( "REF" ) ) //probably needs and offset too
					}

					smokeFXs[i][0] = fx
					smokeFXs[i][1] = CreateTraceBlockerVolume( (offsetCenter + FX_SILENCE_SMOKE_OFFSET), (radius * 0.45), true, CONTENTS_BLOCK_PING, team, SILENCE_TRACE_SCRIPTNAME )

					if ( IsValid( mover ) )
						smokeFXs[i][1].SetParent( mover )

					if ( IsValid( player ) )
					{
						foreach ( ent in smokeFXs[ i ] )
						{
							ent.RemoveFromAllRealms()
							ent.AddToOtherEntitysRealms( player )
						}
					}
				}
				else
				{
					vector org = offsetCenter + FX_SILENCE_SMOKE_OFFSET
					if ( !IsValid( mover ) )
					{
						if ( IsValid( smokeFXs[i][0] ) )
							smokeFXs[i][0].SetOrigin( org )
						if ( IsValid( smokeFXs[i][1] ) )
							smokeFXs[i][1].SetOrigin( org )
						if ( SILENCE_DEBUG )
							DebugDrawSphere( org, 64, COLOR_BLUE, true, 0.1 )
					}
				}
			}
		}

		vector explosionOrigin = IsValid( mover ) ? mover.GetOrigin() : origin
		Explosion_DamageDefSimple( damagedef_loot_drone_explosion, explosionOrigin, player, inflictor, explosionOrigin )
		WaitFrame()
	}
}

// HACK - Push into damageSourceIDCallbacks after R5DEV-124266 is finished
void function Hack_HandleSilenceDamage( entity ent, var damageInfo )
{
	int damageSourceID = DamageInfo_GetDamageSourceIdentifier( damageInfo )

	if ( damageSourceID == eDamageSourceId.damagedef_loot_drone_explosion )
	{
                                             
		if ( !IsFlyer( ent ) /*&& !IsSpiderEgg( ent ) */)
       
                        
        
		{
			DamageInfo_SetDamage( damageInfo, 0.0 )
			return
		}
	}
}

void function ApplySilence( entity ent, var damageInfo )
{
	if ( !IsValid( ent ) ) // defensive check for R5DEV-133937
		return

	if ( IsValid( ent ) && ent.GetScriptName() == GIBRALTAR_GUN_SHIELD_NAME )
		ent = ent.GetOwner()

	if ( IsValid( ent ) && !ent.IsPlayer() )
		return

	bool heightCheck = false
	vector damagePos = DamageInfo_GetDamagePosition( damageInfo )
	if ( damagePos.z >= ent.GetWorldSpaceCenter().z )
	{
		if ( damagePos.z - ent.GetOrigin().z < 100 ) //Tune with debug circles to match FX size
			heightCheck = true
	}
	else
	{
		if ( ent.EyePosition().z - damagePos.z < 100 ) //Tune with debug circles to match FX size
			heightCheck = true
	}
	//if ( heightCheck )
	{
		entity silenceOwner = DamageInfo_GetAttacker( damageInfo )
		float effectDuration = Silence_GetEffectDuration()
		thread SilenceThink( ent, silenceOwner, SILENCE_AREA_DURATION, effectDuration )
	}
	/*else
	{
		DamageInfo_SetDamage( damageInfo, 0.0 )
		entity inflictor = DamageInfo_GetInflictor( damageInfo )
		if ( IsValid( inflictor ) )
			inflictor.e.damagedEntities.fastremovebyvalue( ent )
	}*/

	ent.Signal( "hasBeenSilenced" )
}

void function SilenceThink( entity ent, entity silenceOwner, float silenceAreaDuration, float silenceEffectDuration, bool applyInterrupt=false, bool isEndless=false )
{
	ent.EndSignal( "OnDestroy" )
	ent.EndSignal( "OnDeath" )
	ent.EndSignal( "StopSilence" )

	//Play effect on player so we can see they are silenced.
	int attachmentID = ent.LookupAttachment( "CHESTFOCUS" )
	int fxID
	int silenceVisualsStatusEffect
	bool fxVisible = true
	float endTime = Time() + silenceEffectDuration

	{
		fxID                = GetParticleSystemIndex( FX_SILENCE_REV_VICTIM_3P )
		//silenceVisualsStatusEffect = eStatusEffect.silenced_rev_visuals
	}                    

	entity fx = StartParticleEffectOnEntity_ReturnEntity ( ent, fxID, FX_PATTACH_POINT_FOLLOW, attachmentID )
	fx.kv.VisibilityFlags = ENTITY_VISIBLE_TO_FRIENDLY | ENTITY_VISIBLE_TO_ENEMY
	fx.SetOwner( ent )

	//SetCanDoDamageCallout( ent, false )
	int victimTeam = ent.GetTeam() //Ent is assumed to be a player above

	//Seer's silence is short enough that we're going to turn off the battle chatter for it.  The focus is more on the interrupt than a long term disable.
	bool playBattleChatter = true//PlayerHasPassive( silenceOwner, ePassives.PAS_DEATHSTALKER )

	if ( playBattleChatter )
	{
		PlayBattleChatterLineToSpeakerAndTeam( ent, "bc_abilitiesBlocked" )
	}

	ent.Signal( "PhaseTunnel_CancelPlacement" )
	int silenceVisualsHandle
	int silenceHandle
	/*if( isEndless )
	{
		silenceVisualsHandle = StatusEffect_AddEndless( ent, silenceVisualsStatusEffect, 1.0 )
		silenceHandle = StatusEffect_AddEndless( ent, eStatusEffect.silenced, 1.0 )
	}
	else
	{
		StatusEffect_AddTimed( ent, silenceVisualsStatusEffect, 1.0, silenceEffectDuration, silenceEffectDuration )
		StatusEffect_AddTimed( ent, eStatusEffect.silenced, 1.0, silenceEffectDuration, silenceEffectDuration )
	}
*/
	string silenceLoopSound_3p = "Silence_Victim_Loop_3p"

	if ( ent.IsPlayer() )
	{
		EmitSoundOnEntityExceptToPlayer( ent, ent, silenceLoopSound_3p )
	}
	else
	{
		EmitSoundOnEntity( ent, silenceLoopSound_3p )
	}

	if( ent.IsPlayer() && silenceOwner.IsPlayer() )
	{
		AddAssistingPlayerToVictim( silenceOwner, ent, Silence_GetEffectDuration() ) //Note: Only works because we don't have things that prematurely clears status effects, e.g. no cleanse etc.
	}

	bool shouldSwap = true
	array <entity> activeWeapons = ent.GetAllActiveWeapons()
	if ( activeWeapons.len() > 0 )
	{
		entity activeWeapon = activeWeapons[0]
		if ( IsValid( activeWeapon ) )
		{
			shouldSwap = IsBitFlagSet( activeWeapon.GetWeaponTypeFlags(), WPT_TACTICAL ) || IsBitFlagSet( activeWeapon.GetWeaponTypeFlags(), WPT_ULTIMATE )
		}

		if ( activeWeapons.len() > 1 )
		{
			entity offhandWeapon = activeWeapons[1]
			if ( IsValid( offhandWeapon ) )
			{
				//if ( file.abilitiesToCancel.contains( offhandWeapon.GetWeaponClassName() ) )
					//ent.ClearOffhand( eActiveInventorySlot.altHand )
			}
		}
	}

	if ( shouldSwap )
		SwapToLastEquippedPrimary( ent )

	ent.GrappleDetach()
	//ent.DisableWeaponTypes( WPT_ULTIMATE | WPT_TACTICAL )

	if( PlayerHasPassive( ent, ePassives.PAS_CRYPTO ) )
		Drone_ExitView( ent )

                               
                               
                                           
                                         

	OnThreadEnd(
		function() : ( ent, silenceOwner, fx, silenceLoopSound_3p, isEndless, silenceVisualsHandle, silenceHandle )
		{
			if ( IsValid( ent ) )
			{
				//ent.EnableWeaponTypes( WPT_ULTIMATE | WPT_TACTICAL )

                                  
                                  
                                             
                                           

				//SetCanDoDamageCallout( ent, true )
				StopSoundOnEntity( ent, silenceLoopSound_3p )

				if( isEndless )
				{
					StatusEffect_Stop( ent, silenceVisualsHandle )
					StatusEffect_Stop( ent, silenceHandle )
				}
			}

			if ( IsValid( fx ) )
				EffectStop( fx )
		}
	)

	/*while ( StatusEffect_HasSeverity( ent, eStatusEffect.silenced ) )
	{
		if ( ent.IsPhaseShiftedOrPending() )
		{
			if ( fxVisible )
			{
				fx.kv.VisibilityFlags = ENTITY_VISIBLE_TO_NOBODY
				fxVisible = false
			}
		}
		else
		{
			if ( !fxVisible )
			{
				fx.kv.VisibilityFlags = ( ENTITY_VISIBLE_TO_FRIENDLY | ENTITY_VISIBLE_TO_ENEMY )
				fxVisible = true
			}
		}

		WaitFrame()
	}*/
}

#endif //SERVER

float function Silence_GetEffectDuration()
{
	return file.effectDuration
}