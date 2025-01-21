extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -400.0

@onready var animPlayer : AnimationPlayer = get_node("AnimationPlayer")
@onready var animSprite : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction < 0:
		animSprite.flip_h = true
	elif direction > 0:
		animSprite.flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animPlayer.play("Idle")
			
	if velocity.y > 0:
		animPlayer.play("Fall")

	move_and_slide()
	
	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
