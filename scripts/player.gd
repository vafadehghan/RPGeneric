extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var current_dir = "none"
var enemy_in_attack_range = false;
var enemy_attack_cooldown = true;
var health = 100
var alive = true;
signal hit
var target

func _ready():
	target = position

func _input(event: InputEvent):
	if event.is_action_pressed(&"click"):
		target = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	player_movement(delta)
		
func player_movement(delta):
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		current_dir = "down"
		play_anim(0)
		
	#print("x: %s" % str(position - target))
	var x_dir = position.x - target.x
	var y_dir = position.y - target.y
	if abs(x_dir) > abs(y_dir):
		print("x_dir")
		if  x_dir > 0:
			current_dir = "left"
			play_anim(1)
		elif x_dir < 0:
			current_dir = "right"
			play_anim(1)
			
	elif abs(y_dir) > abs(x_dir):
		print("y_dir")
		if(y_dir > 0):
			current_dir = "up"
			play_anim(1)
		elif(y_dir <0):
			current_dir = "down"
			play_anim(1)

func play_anim(movement):
	var anim = $AnimatedSprite2D
	match current_dir:
		"right":
			anim.flip_h = false;
			if(movement ==1):
				anim.play("base_walk_side")
			else:
				anim.play("base_idle_side")
		"left":
			anim.flip_h = true;
			anim.play("base_walk_side")
			if(movement ==1):
				anim.play("base_walk_side")
			else:
				anim.play("base_idle_side")
		"up":
			if(movement ==1):
				anim.play("base_walk_up")
			else:
				anim.play("base_idle_up")
		"down":
			if(movement ==1):
				anim.play("base_walk_down")
			else:
				anim.play("base_idle_down")
		"attack":
			anim.play("base_pierce_side")

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
