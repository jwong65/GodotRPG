class_name State_Idle extends State
@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

# Function for when the player enters this state
func Enter()-> void:
	player.UpdateAnimation('idle')
	pass
# Function for when player exits the state
func Exit()-> void: 
	pass

func Process (_delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
#	This will make the player velocity zero while at idle.
	return null

func Physics(_delta: float)-> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
