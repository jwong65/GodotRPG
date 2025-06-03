extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Hurtbox = $Hurtbox

var hp: int = 3
var invulnerable := false

func _ready():
	animated_sprite_2d.play("Idle")
