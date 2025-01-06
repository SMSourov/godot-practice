extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
const SPEED = 300
const JUMP = -300
const JUMP_HORIZONTAL = 100

enum State { Idle, Run, Jump }

var current_state: State

func _ready():
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
		velocity.y += GRAVITY * delta


func player_idle() -> void:
	if is_on_floor():
		current_state = State.Idle



func player_run() -> void:
	if !is_on_floor():
		return
	
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


func player_jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y += JUMP
		current_state = State.Jump
	
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * JUMP_HORIZONTAL * delta


func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif  current_state == State.Jump:
		animated_sprite_2d.play("jump")
