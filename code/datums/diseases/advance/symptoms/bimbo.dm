/*Bimbo II: Electric Boogaloo.
 *...okay, sorry. "Hormonal disruption, but a disease."
 *Are ya fuckin' satisfied? I'm not.
 *
 * Reduces stealth
 * Increases resistance
 * No effect to stage speed
 * Tremendously increases transmission
 * Bonus: Oh hey, an X3-P ripoff! (I don't expect you to understand the reference.)
*/
/datum/symptom/bimbo
	name = "Hormonal disruption"
	desc = "The virus causes significant and extreme hormonal disruptions in its host, causing arousal spikes and inhibiting ability to speak."
	illness = "3D3N Retrovirus"
	stealth = -2
	resistance = 2
	stage_speed = 0
	transmittable = 4
	level = 1
	severity = 1
	symptom_delay_min = 5
	symptom_delay_max = 35
	threshold_descs = list(
		"Stealth 3" = "The symptom remains hidden until active.",
	)
	naturally_occuring = FALSE
	var/erp_pref_datum = /datum/preference/toggle/erp/bimbofication

/datum/symptom/bimbo/Start(datum/disease/advance/active_disease)
	. = ..()
	if(!.)
		return
	if(active_disease.totalStealth() >= 3)
		suppress_warning = TRUE

/datum/symptom/bimbo/on_stage_change(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return
	var/mob/living/affected_mob = advanced_disease.affected_mob
	if(!affected_mob.client?.prefs.read_preference(erp_pref_datum) || !ishuman(affected_mob))
		return
	var/obj/item/organ/brain/affected_brain = affected_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
	switch(advanced_disease.stage && affected_brain)
		if(1, 2, 3)
			if(HAS_TRAIT_FROM(affected_mob, TRAIT_BIMBO, TRAIT_LEWDCHEM_RETROVIRUS))
				affected_brain.cure_trauma_type(/datum/brain_trauma/very_special/bimbo/retrovirus, TRAUMA_RESILIENCE_ABSOLUTE)
				to_chat(affected_mob, span_notice("Your mind is free. Your thoughts are pure and innocent once more."))
			else if(!suppress_warning)
				affected_mob.emote("twitch_s", forced = TRUE)
			return
		else
			if(!HAS_TRAIT_FROM(affected_mob, TRAIT_BIMBO, TRAIT_LEWDCHEM_RETROVIRUS))
				affected_brain.gain_trauma(/datum/brain_trauma/very_special/bimbo/retrovirus, TRAUMA_RESILIENCE_ABSOLUTE)
