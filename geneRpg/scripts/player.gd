extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var current_dir = "none"
var enemy_in_attack_range = false;
var enemy_attack_cooldown = true;
var health = 100
var alive = true;
signal hit

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_accept"):
		current_dir = "attack"
		play_anim(0)
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED;
		velocity.y = 0;
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED;
		velocity.y = 0;
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0;
		velocity.y = -SPEED;
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0;
		velocity.y = SPEED;
	else:
		velocity = Vector2.ZERO
		play_anim(0)
		
	move_and_slide()
	
func play_anim(movement):
	var anim = $AnimatedSprite2D
	match current_dir:
		"right":
			anim.flip_h = false;
			if(movement ==1):
				anim.play("side_walk")
			else:
				anim.play("side_idle")
		"left":
			anim.flip_h = true;
			anim.play("side_walk")
			if(movement ==1):
				anim.play("side_walk")
			else:
				anim.play("side_idle")
		"up":
			if(movement ==1):
				anim.play("back_walk")
			else:
				anim.play("back_idle")
		"down":
			if(movement ==1):
				anim.play("front_walk")
			else:
				anim.play("front_idle")
		"attack":
			anim.play("attack")

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	enemy_in_attack_range = true
	if(body.has_method("attack")):
		body.attack()
	
func _on_player_hitbox_body_exited(body: Node2D) -> void:
	enemy_in_attack_range = false
	if(body.has_method("stop_attack")):
		body.stop_attack()
	
func enemy_attack():
	print("Damage!")
	hit.emit()
	$enemy_cooldown_timer.start()


func _on_enemy_cooldown_timer_timeout() -> void:
	enemy_attack_cooldown = false
