extends CharacterBody2D

const GRAVITY = 1000

enum State { Idle, Run }

var current_state: State

func _ready():
	current_state = State.Idle


func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	
	move_and_slide()


func player_falling(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta


func player_idle(delta: float) -> void:
	if !is_on_floor():
		current_state = State.Idle