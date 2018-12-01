extends MarginContainer

signal attack

func can_attack():
	$VBoxContainer/HBoxContainer/AttackButton.disabled = false

func _on_AttackButton_pressed():
	emit_signal('attack')
	$VBoxContainer/HBoxContainer/AttackButton.disabled = true
