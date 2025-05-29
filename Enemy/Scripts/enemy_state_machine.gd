class_name EnemyStateMachine extends Node

var states : Array[EnemyState]
var prev_state :EnemyState
var current_state : EnemyState

func _ready ():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass
	
func _process(delta: float) -> void:
	pass
func initalize(_enemy: Enemy)-> void:
	states = []
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	for j in states: 
		j.enemy = _enemy
		j.state_machine = self
		j.init()
	
	if states.size()>0:
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func ChangeState(new_state: EnemyState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
		
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
