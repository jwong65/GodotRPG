class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var state: String = 'idle'

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var idle = $Idle
@onready var walk = $Walk


func _ready():
	idle.visible = true
	walk.visible = false

#Delta is the elapsed time since previous frame
func _process(delta):
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	
	if SetState() == true || SetDirection() == true:
		UpdateAnimation()
	pass

func _physics_process(delta):
	move_and_slide()

func SetDirection() -> bool: 
	var new_direct : Vector2 = cardinal_direction
	if direction == Vector2.ZERO: 
		return false
	if direction.y == 0:
		new_direct = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direct = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direct == cardinal_direction:
		return false
	cardinal_direction = new_direct
	return true	

	
func SetState()-> bool:
	var new_state : String = 'idle' if direction == Vector2.ZERO else 'walk'
	if new_state == state:
		return false
	else:
		state = new_state
		return true

func UpdateAnimation() -> void:
	# Play the animation based on current state and direction
	animation_player.play(state + "_" + AnimationDirection())

	if state == "idle":
		idle.visible = true
		walk.visible = false
	else:
		idle.visible = false
		walk.visible = true

	var flip = cardinal_direction == Vector2.LEFT
	idle.scale.x = -1 if flip else 1
	walk.scale.x = -1 if flip else 1


func AnimationDirection() -> String: 
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
