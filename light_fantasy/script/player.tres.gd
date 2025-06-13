extends CharacterBody2D

var SPEED = 100

var PLAYER_STATE

@export var inventory: Inventory

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("right", "left", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		PLAYER_STATE = "idle"
	elif direction.x != 0 or direction.y != 0:
		PLAYER_STATE = "walking"
	
	velocity = direction * SPEED
	move_and_slide()
	
	play_anim(direction)
	
func play_anim(dir):
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

func player():
	pass
