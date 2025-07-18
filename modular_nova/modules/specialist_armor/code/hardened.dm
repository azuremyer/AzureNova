// Hardened armor negates any and all projectile armor penetration, in exchange for a mediocre armor profile

// vests

/datum/armor/armor_sf_hardened
	melee = ARMOR_LEVEL_WEAK
	bullet = ARMOR_LEVEL_MID
	laser = ARMOR_LEVEL_WEAK
	energy = ARMOR_LEVEL_TINY
	bomb = ARMOR_LEVEL_WEAK
	fire = ARMOR_LEVEL_MID
	acid = ARMOR_LEVEL_WEAK
	wound = WOUND_ARMOR_WEAK

/obj/item/clothing/suit/armor/sf_hardened
	name = "'Muur' hardened armor vest"
	desc = "A large white breastplate, and a semi-flexible mail of dense panels that cover the torso. \
		While not so incredible at directly stopping bullets, the vest is uniquely suited to cause bullets \
		to lose much of their armor penetrating energy before any damage can be done."
	icon = 'modular_nova/modules/specialist_armor/icons/armor.dmi'
	icon_state = "hardened_standard"
	worn_icon = 'modular_nova/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_sf_hardened
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/sf_hardened/equipped(mob/living/carbon/human/wearer, slot)
	. = ..()
	if(!(istype(wearer) && (slot & ITEM_SLOT_OCLOTHING)))
		return
	RegisterSignal(wearer, COMSIG_PROJECTILE_PREHIT, PROC_REF(on_wearer_hit_by_projectile))

/obj/item/clothing/suit/armor/sf_hardened/dropped(mob/living/carbon/human/wearer)
	. = ..()
	if(!(src == wearer.wear_suit))
		return
	UnregisterSignal(wearer, COMSIG_PROJECTILE_PREHIT)

/obj/item/clothing/suit/armor/sf_hardened/proc/on_wearer_hit_by_projectile(mob/living/source, obj/projectile/incoming_projectile)
	SIGNAL_HANDLER

	if(incoming_projectile.def_zone != BODY_ZONE_CHEST)
		return

	incoming_projectile.armour_penetration = 0
	playsound(src, SFX_RICOCHET, BLOCK_SOUND_VOLUME, vary = TRUE)
	return NONE

/obj/item/clothing/suit/armor/sf_hardened/examine_more(mob/user)
	. = ..()

	. += "What do you do in an age where armor penetration technology keeps getting better and better, \
		and you're quite fond of not being a corpse? The 'Muur' type armor was a pretty successful attempt at an answer \
		to the question. Using some advanced materials, micro-scale projectile dampener fields, and a whole \
		host of other technologies that some poor SolFed procurement general had to talked to death about, \
		it offers a unique advantage over many armor piercing bullets. Why stop the bullet from piercing the armor \
		with more armor, when you could simply force the bullet to penetrate less and get away with less protection? \
		Some people would rather the bullet just be stopped, of course, but when you have to make choices, many choose \
		this one."

	return .

/obj/item/clothing/suit/armor/sf_hardened/emt // google "perfidy"
	name = "'Archangel' hardened armor vest"
	desc = "A large white breastplate with a lone red stripe, and a semi-flexible mail of dense panels that cover the torso. \
		While not so incredible at directly stopping bullets, the vest is uniquely suited to cause bullets \
		to lose much of their armor penetrating energy before any damage can be done."
	icon_state = "hardened_emt"

// helmets

/obj/item/clothing/head/helmet/toggleable/sf_hardened
	name = "'Muur' enclosed helmet"
	desc = "A thick-fronted helmet with extendable visor for whole face protection. The materials and geometry of the helmet \
		combine in such a way that bullets lose much of their armor penetrating energy before any damage can be done, rather than penetrate into it."
	icon = 'modular_nova/modules/specialist_armor/icons/armor.dmi'
	icon_state = "enclosed_standard"
	worn_icon = 'modular_nova/modules/specialist_armor/icons/armor_worn.dmi'
	inhand_icon_state = "helmet"
	armor_type = /datum/armor/armor_sf_hardened
	toggle_message = "You extend the visor on"
	alt_toggle_message = "You retract the visor on"
	actions_types = list(/datum/action/item_action/toggle)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/toggleable/sf_hardened/equipped(mob/living/carbon/human/wearer, slot)
	. = ..()
	if(!(istype(wearer) && (slot & ITEM_SLOT_HEAD)))
		return
	RegisterSignal(wearer, COMSIG_PROJECTILE_PREHIT, PROC_REF(on_wearer_hit_by_projectile))

/obj/item/clothing/head/helmet/toggleable/sf_hardened/dropped(mob/living/carbon/human/wearer)
	. = ..()
	if(!(src == wearer.head))
		return
	UnregisterSignal(wearer, COMSIG_PROJECTILE_PREHIT)

/obj/item/clothing/head/helmet/toggleable/sf_hardened/proc/on_wearer_hit_by_projectile(mob/living/source, obj/projectile/incoming_projectile)
	SIGNAL_HANDLER

	// dynamic pen-reduction coverage with respect to visor state
	if((up && (incoming_projectile.def_zone != BODY_ZONE_HEAD)) || !(incoming_projectile.def_zone in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH)) )
		return

	incoming_projectile.armour_penetration = 0
	playsound(src, SFX_RICOCHET, BLOCK_SOUND_VOLUME, vary = TRUE)
	return NONE

/obj/item/clothing/head/helmet/toggleable/sf_hardened/examine_more(mob/user)
	. = ..()

	. += "What do you do in an age where armor penetration technology keeps getting better and better, \
		and you're quite fond of not being a corpse? The 'Muur' type armor was a pretty successful attempt at an answer \
		to the question. Using some advanced materials, micro-scale projectile dampener fields, and a whole \
		host of other technologies that some poor SolFed procurement general had to talked to death about, \
		it offers a unique advantage over many armor piercing bullets. Why stop the bullet from piercing the armor \
		with more armor, when you could simply force the bullet to penetrate less and get away with less protection? \
		Some people would rather the bullet just be stopped, of course, but when you have to make choices, many choose \
		this one."

	return .

/obj/item/clothing/head/helmet/toggleable/sf_hardened/emt
	name = "'Archangel' enclosed helmet"
	desc = "A thick-fronted helmet with extendable visor for whole face protection. The materials and geometry of the helmet \
		combine in such a way that bullets lose much of their armor penetrating energy before any damage can be done, rather than penetrate into it. \
		This one has a red stripe down the front."
	icon_state = "enclosed_emt"
