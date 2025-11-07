/datum/id_trim/phoenixcollective
	trim_icon = 'modular_nova/master_files/icons/obj/card.dmi'
	assignment = "Phoenix Collective"
	trim_state = "trim_phoenix"
	department_color = COLOR_SECURITY_RED
	subdepartment_color = LIGHT_COLOR_INTENSE_RED
	sechud_icon_state = SECHUD_SOLFED
	threat_modifier = -5 // Yes, Phoenix doesn't count as police force, but neither does SolFed in the Exobytech universe. --Niko

/// Lets be real if the ERT variant of these guys are coming, ya'll are (beyond) cooked
/datum/id_trim/phoenixcollective/ert
	assignment = "Phoenix Collective Martial"
	threat_modifier = -10 // This counts as military intervention
	sechud_icon_state = SECHUD_DEATH_COMMANDO

/datum/id_trim/phoenixcollective/ert/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/// Not a soft ERT variant, this is CentCom lol
/datum/id_trim/phoenixcollective/official
	assignment = "Phoenix Collective CentCom"
	sechud_icon_state = SECHUD_SOLFED_LIASON
	threat_modifier = -10 // CentCom are 'legally' allowed to do whatever the fuck they want. Allegedly

/datum/id_trim/phoenixcollective/official/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))
