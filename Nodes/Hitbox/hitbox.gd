class_name Hitbox extends Area2D

signal Damaged( hurtbox: Hurtbox)

func TakeDamage( hurtbox: Hurtbox)-> void:
	#print("TakeDamage: ", damage)
	Damaged.emit(hurtbox )
