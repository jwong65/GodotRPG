class_name Hurtbox extends Area2D

@export var damage : int = 1

func _ready():
	area_entered.connect(AreaEntered)
	pass
	
func AreaEntered( a: Area2D )-> void:
	if a is Hitbox:
		a.TakeDamage( damage )
	pass
#

#func AreaEntered(a: Area2D) -> void:
	#print("Hurtbox entered by: ", a.name)
	#if a is Hitbox:
		#print("Hitbox detected! Applying damage:", damage)
		#a.TakeDamage(damage)
