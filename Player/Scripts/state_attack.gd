class_name State_Attack extends State

var attacking: bool = false

@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle: State = $"../Idle"

# Function for when the player enters this state
func Enter()-> void:
	player.UpdateAnimation('attack')
	animation_player.animation_finished.connect(EndAttack)
	attacking = true
	pass
# Function for when player exits the state
func Exit()-> void: 
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
	return null

func EndAttack( _newAnimName : String)-> void:
	attacking = false
