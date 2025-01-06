extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var gravity: int = 1000
@export var speed: int = 300
@export var jump: int = -300
@export var jump_horizontal: int = 300


enum State { Idle, Run, Jump }

var current_state: State


func _ready() -> void:
	current_state = State.Idle


func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_idle()
	player_run()
	player_jump(delta)
	
	move_and_slide()
	player_animation()
	print("State: ", State.keys()[current_state])


func player_falling(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta


func player_idle() -> void:
	if is_on_floor():
		current_state = State.Idle


func player_run() -> void:
	if !is_on_floor():
		return
	
	var direction: float = input_movement()
	
	# If any direction input is registered
	if direction:
		velocity.x = direction * speed
	else:
		# velocity.x = 0
		velocity.x = move_toward(velocity.x, 0, speed)


	if direction != 0:
		current_state = State.Run
		if direction > 0:
			animated_sprite_2d.flip_h = false
		elif direction < 0:
			animated_sprite_2d.flip_h = true



func player_jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump
		current_state = State.Jump


	if !is_on_floor() and current_state == State.Jump:
		var direction: float = input_movement()
		velocity.x += direction * jump_horizontal * delta


func input_movement() -> float:
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction


func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif  current_state == State.Jump:
		animated_sprite_2d.play("jump")
