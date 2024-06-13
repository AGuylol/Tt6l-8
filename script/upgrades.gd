extends Node


var health_upgrade1 = false
var melee_upgrade1 = false
var gun_damage_upgrade1 = false
var gun_cooldown_upgrade1 = false
var melee_upgrade2 = false
var gun_upgrade = false
	
func apply_upgrades():
	
	if "health_upgrade1" in global.player_inventory:
		if health_upgrade1 == false: 
			global.player_max_health = global.player_max_health + 50
			global.player_health = global.player_health + 50
			print("Health upgraded to:", global.player_max_health)
			health_upgrade1 = true
			
			
	elif "weapon_upgrade1" in global.player_inventory:
		if gun_damage_upgrade1 == false:
			global.player_sword_damage = global.player_sword_damage + 10
			gun_damage_upgrade1 = true
			
			
	elif "arquebus" in global.player_inventory:
		if gun_damage_upgrade1 == false:
			global.gun_cooldown -= 3
			gun_damage_upgrade1 = false
			
			
	elif "flintlock" in global.player_inventory:
		if gun_cooldown_upgrade1 == false:
			global.gun_cooldown -= 3
			gun_cooldown_upgrade1 == true
		
	elif "melee_upgrade2" in global.player_inventory:
		if melee_upgrade2 == false:
			global.player_sword_damage += 5
			melee_upgrade2 = true
			
	elif "istinggar" in global.player_inventory:
		if gun_upgrade == false:
			global.player_gun_damage += 10
		
		
	
func _physics_process(delta):
	apply_upgrades()
