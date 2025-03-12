extends Node2D

# you may change this if you like
const STARTING_HP = 100

############ YOU DO NOT NEED TO TOUCH THIS ############
var _HP
@onready var HPBarUI = $healthbarAnchor/ProgressBar
@onready var animationPlayer = $AnimationPlayer

func _ready():
	_HP = STARTING_HP

func change_HP_by(value):
	_HP += value
	if _HP <= 0:
		_HP = 0
		_on_death()
		
	HPBarUI.value = _HP

func update_HP_to(value):
	_HP = value
	if _HP <= 0:
		_HP = 0
		_on_death()
	
	HPBarUI.value = _HP

func _on_death():
	# This will "free" it from the tree, effectively
	# deleting the node
	queue_free()
#######################################################

func take_turn():
	# you can write your own code here.
	# example: Manager.change_HP_by(-10) to attack player
	pass
