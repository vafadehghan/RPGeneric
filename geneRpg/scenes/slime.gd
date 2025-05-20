extends CharacterBody2D


const SPEED = 50.0
var chase = false
var player = null
var attack_timeout = false;
signal player_damaged

func _physics_process(delta: float) -> void:
	if chase :
		var relative_position = player.position - position
		position += relative_position/SPEED
		if relative_position.x > 0:
			$AnimatedSprite2D.flip_h = false;
			$AnimatedSprite2D.play("side_chase")
		elif relative_position.x < 0:
			$AnimatedSprite2D.flip_h = true;
			$AnimatedSprite2D.play("side_chase")
	else:
		$AnimatedSprite2D.play("front_idle")
		

	move_and_slide()

func attack():
	print("First Attack")
	player_damaged.emit()
	$Attack_cooldown.start()

func stop_attack():
	$Attack_cooldown.stop()

	
func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	chase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	chase = false


func _on_attack_cooldown_timeout() -> void:
	player_damaged.emit()
	print("Attacking")
