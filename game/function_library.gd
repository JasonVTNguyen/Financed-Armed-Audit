extends Node

func bait_multiplier_func(f_damage):
	return GameController.total_bait * f_damage

func shot_based_damage(p_damage, num_shots, modifier):
	if fmod(GameController.number_of_shots,num_shots) == 0.0:
		return p_damage * modifier
	return p_damage 
