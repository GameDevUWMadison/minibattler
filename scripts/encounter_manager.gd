extends Node

# this array holds all the enemies in the game
var enemies : Array = []

# this is a sprite that is positioned to tell us which one is currently targeted
# no need to use it for this project.
var targeting_indicator = null

# this variable holds the HP data. Do not modify it directly.
# use "update_HP_to()" or "update_HP_by()", or else the UI will not match the variable
var _HP = 100

# this variable holds the ui element for the HP (the progressbar)
var HPBarUI

# this variable holds the ui element for the bottom text. you can call
# battletext.scroll_text() to place text there.
var battletext

# this defines the possible states for the battle to be in.
enum BattleState {AWAIT_PLAYER_INPUT, RUNNING_PLAYERMOVES, RUNNING_ENEMYMOVES, DEATH}
var current_battlestate

# this variable holds the currently targeted enemy.
# Do not modify this directly.
var currently_targeted = null

# This method is called at the start
func _ready() -> void:
	############ YOU DO NOT NEED TO TOUCH THIS ############
	enemies = get_tree().get_nodes_in_group("Enemy")
	targeting_indicator = get_tree().get_nodes_in_group("TargetUI")[0]
	HPBarUI = get_tree().get_nodes_in_group("hpbar")[0]
	battletext = get_tree().get_nodes_in_group("battletext")[0]
	
	current_battlestate = BattleState.AWAIT_PLAYER_INPUT
	
	var meleebutton = get_tree().get_nodes_in_group("meleebutton")[0]
	var fireballbutton = get_tree().get_nodes_in_group("fireballbutton")[0]
	var defendbutton = get_tree().get_nodes_in_group("defendbutton")[0]
	
	meleebutton.pressed.connect(_on_melee)
	fireballbutton.pressed.connect(_on_fireball)
	defendbutton.pressed.connect(_on_defend)
	############ NO NEED TO EDIT ABOVE THIS LINE ############
	
	# You can add more things to the _ready function if needed below:
	
	#

############ YOU DO NOT NEED TO TOUCH THIS ############
func set_targeted(enemy : Node2D) -> void:
	
	currently_targeted = enemy
	
	if enemy != null:
		targeting_indicator.position = enemy.position
		targeting_indicator.visible = true
	else:
		targeting_indicator.visible = false

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

func enemy_turn():
	# Each enemy (if it contains a method called "take_turn()") will take a turn
	current_battlestate = BattleState.RUNNING_ENEMYMOVES
	
	for enemy in enemies:
		if enemy.has_method("take_turn"):
			enemy.take_turn()
#######################################################

func _on_melee() -> void:
	# this is received when the "melee" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		print("the player used a melee attack")
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		current_battlestate = BattleState.AWAIT_PLAYER_INPUT
		
func _on_fireball() -> void:
	# this is received when the "fireball" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		print("the player cast fireball")
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		current_battlestate = BattleState.AWAIT_PLAYER_INPUT

func _on_defend() -> void:
	# this is received when the "defend" option is clicked
	if current_battlestate == BattleState.AWAIT_PLAYER_INPUT:
		current_battlestate = BattleState.RUNNING_PLAYERMOVES
		
		# await get_tree().create_timer(3.0).timeout
		print("done WAITING!")
		# What does this move do? Write code here.
		
		# then do the enemy turn!
		enemy_turn()
		
		# finally, we are now waiting for another move to be selected by the player
		current_battlestate = BattleState.AWAIT_PLAYER_INPUT
		
func _on_death() -> void:
	print("the player died!")
	battletext.scroll_text("Your HP reached 0. You died!")
	
	# Currently, the game softlocks (there is no code for) 
	# when you reach a death state.
	# you could add something here to make it more interesting!
	current_battlestate = BattleState.DEATH
