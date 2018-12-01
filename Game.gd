extends Node

export (NodePath) var player_node_path
export (NodePath) var enemy_node_path

var player_node
var enemy_node

func _ready():
	player_node = get_node(player_node_path)
	enemy_node = get_node(enemy_node_path)

func player_attack():
	player_node.attack()
	player_node.z_index = 1
	enemy_node.z_index = -1
	
func enemy_attack():
	enemy_node.attack()
	enemy_node.z_index = 1
	player_node.z_index = -1

func _on_GUI_blood_sacrifice():
	player_node.take_hit(1)
	player_node.increase_damage()

func _on_GUI_attack():
	player_attack()

func _on_PlayerCard_attack_complete():
	enemy_node.take_hit(player_node.damage)
	player_node.return_base()

func _on_PlayerCard_return_complete():
	$EnemyAttackDelayTimer.start()

func _on_EnemyCard_attack_complete():
	player_node.take_hit(enemy_node.damage)
	enemy_node.return_base()

func _on_EnemyCard_return_complete():
	$PlayerAttackDelayTimer.start()

func _on_EnemyAttackDelayTimer_timeout():
	enemy_attack()

func _on_PlayerAttackDelayTimer_timeout():
	$CanvasLayer/GUI.can_attack()
	
	if player_node.damage < player_node.max_damage:
		$CanvasLayer/GUI.enable_sacrifice()

func _on_PlayerCard_damage_changed():
	if player_node.damage >= player_node.max_damage:
		$CanvasLayer/GUI.disable_sacrifice()