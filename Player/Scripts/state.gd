class_name State extends Node

static var player: Player

# Function for when the player enters this state
func Enter()-> void:
	pass
# Function for when player exits the state
func Exit()-> void: 
	pass

func Process (_delta : float) -> State:
	return null

func Physics(_delta: float)-> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
