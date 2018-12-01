extends Area2D

signal damage_complete
signal attack_complete
signal return_complete

export (int) var max_health = 10

export (Color) var color

var health

func _ready():
	health = max_health
	
	$healthbar.max_value = max_health
	$healthbar.value = health
	
	if color:
		$Sprite.modulate = color

func attack(dir):
	$AnimationPlayer.play('attack_' + dir)
	
func return_base(dir):
	$AnimationPlayer.play('return_' + dir)

func take_hit():
	$AnimationPlayer.play('take_damage')
	health = health - 1 if health > 0 else 0
	
	$healthbar.value = health

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'take_damage':
		$Sprite.modulate = color
		emit_signal('damage_complete')
	elif anim_name == 'attack_right' or anim_name == 'attack_left':
		emit_signal('attack_complete')
	elif anim_name == 'return_left' or anim_name == 'return_right':
		emit_signal('return_complete')