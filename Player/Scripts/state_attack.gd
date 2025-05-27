class_name State_Attack extends State

@export var attack_sound : AudioStream

@onready var walk: State = $"../Walk"
@onready var attack: State = $"."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Attack/AttackSprite01/AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

var attacking : bool = false

# Function for when the player enters this state
func Enter()-> void:
	player.UpdateAnimation('attack')
	attack_anim.play("attack_" + player.AnimationDirection())
	animation_player.animation_finished.connect(EndAttack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	pass
# Function for when player exits the state
func Exit()-> void: 
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass

func Process (_delta : float) -> State:
	
	player.velocity = Vector2.ZERO
#	This will make the player velocity zero while at idle.
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func Physics(_delta: float)-> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
func EndAttack( _newAnimName : String)-> void:
	attacking = false
