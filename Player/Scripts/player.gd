class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var idle = $Idle
@onready var walk = $Walk
@onready var idle: Sprite2D = $Idle
@onready var attack: Sprite2D = $Attack

@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction: Vector2)

func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	idle.visible = true
	walk.visible = false
	attack.visible = false
	

#Delta is the elapsed time since previous frame
func _process(_delta):
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	#direction = direction.normalized()
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(_delta):
	move_and_slide()

func SetDirection() -> bool: 
	if direction == Vector2.ZERO: 
		return false
	var direction_id : int = int(round((direction +cardinal_direction*0.1).angle()/TAU *DIR_4.size()))
	#if direction.y == 0:
		#new_direct = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	#elif direction.x == 0:
		#new_direct = Vector2.UP if direction.y < 0 else Vector2.DOWN
	var new_direct = DIR_4[direction_id]
	if new_direct == cardinal_direction:
		return false
	cardinal_direction = new_direct
	DirectionChanged.emit(new_direct)
	return true	

#func UpdateAnimation(state: String) -> void:
	## Play the animation based on current state and direction
	#animation_player.play(state + "_" + AnimationDirection())
#
	#if state == "idle":
		#idle.visible = true
		#walk.visible = false
	#else:
		#idle.visible = false
		#walk.visible = true
#
	#var flip = cardinal_direction == Vector2.LEFT
	#idle.scale.x = -1 if flip else 1
	#walk.scale.x = -1 if flip else 1
	
func UpdateAnimation(state: String) -> void:
	# Play the animation based on current state and direction
	animation_player.play(state + "_" + AnimationDirection())

	if state == "walk":
		idle.visible = false
		walk.visible = true 
		attack.visible = false
	elif state == 'idle':
		# For both 'idle' and 'attack', show the IdleAttack sprite
		idle.visible = true
		walk.visible = false
		attack.visible = false
	else:
		idle.visible = false
		walk.visible = false
		attack.visible = true

	var flip = cardinal_direction == Vector2.LEFT
	idle.scale.x = -1 if flip else 1
	walk.scale.x = -1 if flip else 1
	attack.scale.x = -1 if flip else 1



func AnimationDirection() -> String: 
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
