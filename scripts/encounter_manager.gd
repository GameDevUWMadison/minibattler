extends Node

# this array holds all the enemies in the game
var enemies : Array = []

# this is a sprite that can be positioned to tell us which one is currently targeted
var targeting_indicator = null


enum BattleState {AWAIT_PLAYER_INPUT, RUNNING_PLAYERMOVES, RUNNING_ENEMYMOVES}
var current_battlestate


var currently_targeted = null

# This method is called at the start
func _ready() -> void:
	enemies = get_tree().get_nodes_in_group("Enemy")
	targeting_indicator = get_tree().get_nodes_in_group("TargetUI")[0]
	
	current_battlestate = BattleState.AWAIT_PLAYER_INPUT

func process_player_action(action):
	match(action):
		"attack":
			pass
		"defend":
			pass

func set_targeted(enemy : Node2D) -> void:
	currently_targeted = enemy
	
	if enemy != null:
		targeting_indicator.position = enemy.position
		targeting_indicator.visible = true
	else:
		targeting_indicator.visible = false

func enemy_turn():
	# Each enemy (if it contains a method called "take_turn()") will take a turn
	current_battlestate = BattleState.RUNNING_ENEMYMOVES
	
	for enemy in enemies:
		if enemy.has_method("take_turn"):
			enemy.take_turn()
	

func _on_melee() -> void:
	# this is received when the "melee" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		
func _on_fireball() -> void:
	# this is received when the "fireball" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		
func _on_defend() -> void:
	# this is received when the "defend" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		
