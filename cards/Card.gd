extends Area2D

signal damage_complete
signal attack_complete
signal return_complete

signal damage_changed

export (int) var max_health = 10
export (int) var base_damage = 1
export (int) var max_damage = 3

export (String) var facing_dir = 'right'

export (Color) var color

var health setget set_health
var damage setget set_damage

func _ready():
	health = max_health
	$healthbar.max_value = max_health
	$healthbar.value = health
	
	damage = base_damage
	$damagebar.max_value = max_damage
	$damagebar.value = damage
	
	if color:
		$Sprite.modulate = color

func attack():
	$AnimationPlayer.play('attack_' + facing_dir)
	
func return_base():
	$AnimationPlayer.play('return_' + facing_dir)
	
	set_damage(damage - 1)

func take_hit(damage):
	$AnimationPlayer.play('take_damage_' + facing_dir)
	
	set_health(health - damage)
	
func set_health(new_val):
	health = new_val
	if health < 0:
		health = 0
	
	$healthbar.value = health
	
func set_damage(new_val):
	damage = new_val
	if damage > max_damage:
		damage = max_damage
	elif damage < base_damage:
		damage = base_damage
	
	$damagebar.value = damage
	
	emit_signal('damage_changed')

func increase_damage():
	set_damage(damage + 1)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'take_damage_left' or anim_name == 'take_damage_right':
		$Sprite.modulate = color
		emit_signal('damage_complete')
	elif anim_name == 'attack_right' or anim_name == 'attack_left':
		emit_signal('attack_complete')
	elif anim_name == 'return_left' or anim_name == 'return_right':
		emit_signal('return_complete')