extends Node

var items : Dictionary[int, Item] = {
	0 : Item.new("Test Item", "SHOOTING", "This is a test item.", "This item adds 8 flat damage to all weapons", 50.0, 8, 1.0, "", ""),
	1 : Item.new("Test Function Item", "SHOOTING", "This items tests the function system.", "This item add 2 damage for each bait the player has total.", 100.0, 2, 1.0, "bait_multiplier", ""),
	2 : Item.new("Critical Strike", "SHOOTING", "This is a critical hit item", "Every 3rd Bullet does 2x damage.",150.0, 0, 1.0, "", "shot_based", 3.0, 2.0),
	3 : Item.new("Golden Feed", "FISHING", "Feed but gold.", "Every caught fish's value will go up by 30%.", 50.0, 0, 0.3, "", "")
}

var weapons : Dictionary[int, Gun] = {
				# Name, Description, Icon, Damage, Capacity, Max Ammo, Mag Size, Reload Time, Fire Rate, Price, Ammo Price, Ammo Purchase Amount
	0 : Gun.new("Pistol","This is your run of the mill firearm.","res://icon.svg", 5, 5000, 50, 10, 1.0, 15.0, 200.0, 15.0, 25),
	1 : Gun.new("Shotgun","This is a stronger gun in exchange for it's slower reload","res://icon.svg", 15, 500, 20, 10, 1.0, 15.0, 750.0, 50.0, 15),
	2 : Gun.new("Sniper","Really strong gun, really low ammo reserves","res://icon.svg", 50, 150, 5, 5, 1.0, 15.0, 2000.0, 100.0, 5),
}

var weapon_upgrades : Dictionary[int, Upgrade] = {
	0 : Bullet_Upgrade.new("FLAT_DMG", "Test Bullets", 50.0, 3)
}

var hooks : Dictionary[int, Hook] = {
	0 : Hook.new("Starter Hook", 1),
	1 : Hook.new("Elite Hook", 5)
}

var rods : Dictionary[int, FishingRod] = {
	0 : FishingRod.new("Starter Rod", 0, 0.0),
	1 : FishingRod.new("Advanced Rod", 1, 250.0),
	2 : FishingRod.new("Elite Rod", 2, 1000.0),
}
