extends CharacterBody2D

var SPEED = 100

var PLAYER_STATE

@export var inventory: Inventory

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://scene/arrow.tscn")
var mouse_loc_from_player = null

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("right", "left", "up", "down")
	
	mouse_loc_from_player = get_global_mouse_position() - self.position
	print(mouse_loc_from_player)
	
	if Input.is_action_just_pressed("1"):
		bow_equiped = !bow_equiped

	if direction.x == 0 and direction.y == 0:
		PLAYER_STATE = "idle"
	elif direction.x != 0 or direction.y != 0:
		PLAYER_STATE = "walking"
	
	velocity = direction * SPEED
	move_and_slide()
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.3).timeout
		bow_cooldown = true
	
	play_anim(direction)
	
	
func play_anim(dir):
	if !bow_equiped:
		if PLAYER_STATE == "idle":
			$AnimatedSprite2D.play("idle")
		if PLAYER_STATE == "walking":
			if dir.y == -1:
				$AnimatedSprite2D.play("north_walk")
			if dir.y == 1:
				$AnimatedSprite2D.play("south_walk")
			if dir.x == 1:
				$AnimatedSprite2D.play("east_walk")
			if dir.x == -1:
				$AnimatedSprite2D.play("west_walk")
			if dir.x > .5 and dir.y < -.5:
				$AnimatedSprite2D.play("north_east_walk")
			if dir.x > .5 and dir.y > .5:
				$AnimatedSprite2D.play("south_east_walk")
			if dir.x < -.5 and dir.y > .5:
				$AnimatedSprite2D.play("south_west_walk")
			if dir.x < -.5 and dir.y < -.5:
				$AnimatedSprite2D.play("north_west_walk")
	else:
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y <= 0:
				$AnimatedSprite2D.play("north_bow_attack")
		if mouse_loc_from_player.x >= -25 and mouse_loc_from_player.x <= 25 and mouse_loc_from_player.y >= 0:
				$AnimatedSprite2D.play("south_bow_attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x <= 0:
				$AnimatedSprite2D.play("west_bow_attack")
		if mouse_loc_from_player.y >= -25 and mouse_loc_from_player.y <= 25 and mouse_loc_from_player.x >= 0:
				$AnimatedSprite2D.play("east_bow_attack")
		
		if mouse_loc_from_player.x <= -25 and mouse_loc_from_player.y <= -25:
				$AnimatedSprite2D.play("north_west_bow_attack")
		if mouse_loc_from_player.x >= .5 and mouse_loc_from_player.y >= 25:
				$AnimatedSprite2D.play("south_east_bow_attack")
		if mouse_loc_from_player.x <= -.5 and mouse_loc_from_player.y >= 25:
				$AnimatedSprite2D.play("south_west_bow_attack")
		if mouse_loc_from_player.x >= 25 and mouse_loc_from_player.y <= -25:
				$AnimatedSprite2D.play("north_east_bow_attack")		
		

func player():
	pass
	
func collect(item):
	inventory.insert(item)
