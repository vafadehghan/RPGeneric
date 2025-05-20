extends Node2D
var slime = preload("res://scenes/slime.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_slime_player_damaged() -> void:
	print("-10 health")


func _on_enemy_spawn_timer_timeout() -> void:
	#var ints = slime.instantiate()
	#ints.player_damaged.connect(_on_slime_player_damaged)
	#ints.global_position = get_viewport_rect().get_center()
	#add_child(ints)
	pass
