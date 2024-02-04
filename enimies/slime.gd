extends CharacterBody2D

var startPosition
var endPosition

@export var speed = 20
@export var limit = 0.5
@export var loopPoint: Marker2D
@onready var animations = $AnimatedSprite2D

func _ready():
	startPosition = position
	endPosition = loopPoint.global_position
	
func changeDirection():
	var tmpPosition = startPosition
	startPosition = endPosition
	endPosition = tmpPosition
	
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed
	
func updateAnimation():
	var animationString = "moveUp"
	if velocity.y > 0:
		animationString = "moveDown"
	elif velocity.x < 0:
		animationString = "moveLeft"
	elif velocity.x > 0:
		animationString = "moveRight"
	
	animations.play(animationString)

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
