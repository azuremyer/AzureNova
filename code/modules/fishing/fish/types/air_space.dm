/obj/item/fish/sand_surfer
	name = "sand surfer"
	desc = "A bronze alien \"fish\" living and swimming underneath faraway sandy places."
	icon_state = "sand_surfer"
	sprite_height = 6
	sprite_width = 6
	stable_population = 5
	average_size = 65
	average_weight = 1100
	weight_size_deviation = 0.35
	random_case_rarity = FISH_RARITY_RARE
	required_fluid_type = AQUARIUM_FLUID_AIR
	required_temperature_min = MIN_AQUARIUM_TEMP+25
	required_temperature_max = MIN_AQUARIUM_TEMP+60
	fish_movement_type = /datum/fish_movement/plunger
	fishing_difficulty_modifier = 5
	fish_traits = list(/datum/fish_trait/shiny_lover)
	beauty = FISH_BEAUTY_GOOD

/obj/item/fish/sand_crab
	name = "burrower crab"
	desc = "A sand-dwelling crustacean. It looks like a crab and tastes like a crab, but waddles like a fish."
	icon_state = "crab"
	dedicated_in_aquarium_icon_state = "crab_small"
	sprite_height = 6
	sprite_width = 10
	average_size = 60
	average_weight = 1000
	weight_size_deviation = 0.1
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+40
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_traits = list(/datum/fish_trait/amphibious, /datum/fish_trait/shiny_lover, /datum/fish_trait/carnivore)
	fish_movement_type = /datum/fish_movement/slow
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = SEAFOOD,
		),
	)

/obj/item/fish/sand_crab/get_fish_taste()
	return list("raw crab" = 2)

/obj/item/fish/sand_crab/get_fish_taste_cooked()
	return list("cooked crab" = 2)

/obj/item/fish/bumpy
	name = "bump-fish"
	desc = "An misshapen fish-thing all covered in stubby little tendrils"
	icon_state = "bumpy"
	sprite_height = 4
	sprite_width = 5
	stable_population = 4
	required_fluid_type = AQUARIUM_FLUID_ANY_WATER
	required_temperature_min = MIN_AQUARIUM_TEMP+15
	required_temperature_max = MIN_AQUARIUM_TEMP+40
	beauty = FISH_BEAUTY_BAD
	fish_traits = list(/datum/fish_trait/amphibious, /datum/fish_trait/vegan)
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = VEGETABLES,
		),
	)

/obj/item/fish/starfish
	name = "cosmostarfish"
	desc = "A peculiar, gravity-defying, echinoderm-looking critter from hyperspace."
	icon_state = "starfish"
	icon_state_dead = "starfish_dead"
	sprite_height = 3
	sprite_width = 4
	average_size = 30
	average_weight = 300
	stable_population = 3
	required_fluid_type = AQUARIUM_FLUID_AIR
	random_case_rarity = FISH_RARITY_NOPE
	required_temperature_min = 0
	required_temperature_max = INFINITY
	safe_air_limits = null
	min_pressure = 0
	max_pressure = INFINITY
	grind_results = list(/datum/reagent/bluespace = 10)
	fillet_type = null
	fish_traits = list(/datum/fish_trait/antigrav, /datum/fish_trait/mixotroph)
	beauty = FISH_BEAUTY_GREAT

/obj/item/fish/starfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/fish/starfish/update_overlays()
	. = ..()
	if(status == FISH_ALIVE)
		. += emissive_appearance(icon, "starfish_emissive", src)

///It spins, and dimly glows in the dark.
/obj/item/fish/starfish/flop_animation()
	DO_FLOATING_ANIM(src)

/obj/item/fish/baby_carp
	name = "baby space carp"
	desc = "A juvenile spawn of the dreaded space carp. Don't let the innocent looks fool you, they're aggressive little bastards."
	icon_state = "baby_carp"
	sprite_height = 3
	sprite_width = 5
	average_size = 35
	average_weight = 550
	stable_population = 7
	required_fluid_type = AQUARIUM_FLUID_ANY_WATER
	random_case_rarity = FISH_RARITY_VERY_RARE
	required_temperature_min = 0
	required_temperature_max = MIN_AQUARIUM_TEMP+200
	safe_air_limits = null
	fillet_type = /obj/item/food/fishmeat/carp/no_tox
	fish_traits = list(
		/datum/fish_trait/carnivore,
		/datum/fish_trait/aggressive,
		/datum/fish_trait/predator,
		/datum/fish_trait/necrophage,
		/datum/fish_trait/no_mating,
		/datum/fish_trait/toxic/carpotoxin,
	)
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = MEAT,
		),
	)
	disliked_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = GRAIN|DAIRY,
		),
	)
	beauty = FISH_BEAUTY_GREAT

/obj/item/fish/baby_carp/Initialize(mapload, apply_qualities = TRUE)
	color = pick_weight(GLOB.carp_colors)
	. = ..()
	RegisterSignal(src, COMSIG_FISH_BEFORE_GROWING, PROC_REF(growth_checks))
	RegisterSignal(src, COMSIG_FISH_FINISH_GROWING, PROC_REF(on_growth))
	update_appearance(UPDATE_OVERLAYS)

/obj/item/fish/baby_carp/update_overlays()
	. = ..()
	var/mutable_appearance/eyes = mutable_appearance(icon, "baby_carp_eyes")
	if(status == FISH_DEAD)
		eyes.icon_state += "_dead"
	else
		eyes.appearance_flags = RESET_COLOR
	. += eyes

///Determines the speed at which the carp grows based on how big it's
/obj/item/fish/baby_carp/update_size_and_weight(new_size = average_size, new_weight = average_weight)
	. = ..()
	var/growth_rate = 4.5 MINUTES
	growth_rate *= clamp(size/average_size, 0.5, 2)
	growth_rate *= clamp(weight/average_weight, 0.5, 2)

	AddComponent(/datum/component/fish_growth, /mob/living/basic/carp/advanced, growth_rate)

/obj/item/fish/baby_carp/proc/growth_checks(datum/source, seconds_per_tick)
	SIGNAL_HANDLER
	var/hunger = CLAMP01((world.time - last_feeding) / feeding_frequency)
	if(health <= initial(health) * 0.6 || hunger >= 0.6) //if too hurt or hungry, don't grow.
		return COMPONENT_DONT_GROW

	if(!isaquarium(loc))
		return

	var/obj/structure/aquarium/aquarium = loc
	if(!aquarium.reproduction_and_growth) //the aquarium has breeding disabled
		return COMPONENT_DONT_GROW
	if(length(aquarium.get_fishes()) > AQUARIUM_MAX_BREEDING_POPULATION * 0.5) //check if there's enough room to maturate.
		return COMPONENT_DONT_GROW

/obj/item/fish/baby_carp/proc/on_growth(datum/source, mob/living/basic/carp/result)
	SIGNAL_HANDLER
	//yes, this means that if we use a spraycan on the fish, the resulting space carp will be of spraycan color
	result.set_greyscale(colors = list(color))