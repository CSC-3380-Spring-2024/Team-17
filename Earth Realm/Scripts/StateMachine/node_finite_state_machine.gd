class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state : NodeState

var node_states : Dictionary = {} #node state in dic
var current_node_state : NodeState #hold current node state the state machine is active with
var current_node_state_name : String

func _ready(): # getting children (states) from state machine
	for child in get_children():
		if child is NodeState: # if child is that type
			node_states[child.name.to_lower()] = child #pop in dic
			
	if initial_node_state:
		initial_node_state.enter() #enter method in idle
		current_node_state = initial_node_state
		
	
func _process(delta : float):
	if current_node_state: 
		current_node_state.on_process(delta) #will call the idle func on process
		
	
func _physics_process(delta : float):
	if current_node_state: 
		current_node_state.on_physics_process(delta) #will call the idle func on physics
	#print("Current State:", current_node_state.name.to_lower())
	
func transition_to(node_state_name):
	if node_state_name == current_node_state.name.to_lower():
		return # all ready got the node dont return it again
		
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return 
		
	if current_node_state:
		current_node_state.exit()
	
	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	
