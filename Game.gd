extends Node

export (NodePath) var player_node_path
export (NodePath) var enemy_node_path

var player_node
var enemy_node

func _ready():
	player_node = get_node(player_node_path)
	enemy_node = get_node(enemy_node_path)

func _on_GUI_attack():
	player_node.attack('right')

func _on_PlayerCard_attack_complete():
	enemy_node.take_hit()
	player_node.return_base('left')

func _on_PlayerCard_return_complete():
	$EnemyAttackDelayTimer.start()

func _on_EnemyCard_attack_complete():
	player_node.take_hit()
	enemy_node.return_base('right')

func _on_EnemyCard_return_complete():
	$CanvasLayer/GUI.can_attack()

func _on_EnemyAttackDelayTimer_timeout():
	enemy_node.attack('left')
