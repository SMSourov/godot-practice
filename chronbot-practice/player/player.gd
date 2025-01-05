extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
const SPEED = 300

enum State { Idle, Run }

var current_state: State

func _ready():
	current_state = State.Idle

func print_state(state: State) -> void:
	print("State: ", State.keys()[current_state])

func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle(delta)
	player_run()
	move_and_slide()
	player_animation()


func player_falling(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta


func player_idle(delta: float) -> void:
	if is_on_floor():
		current_state = State.Idle
		print_state(current_state)


func player_run() -> void:
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if direction != 0:
		current_state = State.Run
		print_state(current_state)


func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
