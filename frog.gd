extends CharacterBody2D


const SPEED := 50
var player : CharacterBody2D
var chase := false

var death := false

func _ready() -> void:
	get_node("AnimatedSprite2D").play("Idle")
	player = %Player


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if !death:
		if chase:
			get_node("AnimatedSprite2D").play("Jump")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			elif direction.x < 0:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
		else:
			get_node("AnimatedSprite2D").play("Idle")
			velocity.x = 0
		move_and_slide()


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		## Disable colission with Player
		player.set_collision_mask_value(3, false)
		get_node("AnimatedSprite2D").play("Death")
		print("Death")
		death = true


func _on_animated_sprite_2d_animation_finished() -> void:
	print("animation_finished")
	if death:
		print("Death after await")
		self.queue_free()
