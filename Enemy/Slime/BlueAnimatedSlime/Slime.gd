extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Hurtbox = $Hurtbox

var hp: int = 3
var invulnerable := false

func _ready():
	animated_sprite_2d.play("Idle")
	pass
	
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if invulnerable:
		return

	if area.has_method("get_damage"):
		var damage = area.get_damage()
		_take_damage(damage)

func _take_damage(amount: int) -> void:
	hp -= amount
	invulnerable = true
	animated_sprite_2d.play("Hurt")

	if hp <= 0:
		_die()
	else:
		await get_tree().create_timer(0.5).timeout
		invulnerable = false
		animated_sprite_2d.play("Idle")

func _die() -> void:
	animated_sprite_2d.play("Death")
	await animated_sprite_2d.animation_finished
	queue_free()
