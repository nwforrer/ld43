extends MarginContainer

signal attack
signal blood_sacrifice

func can_attack():
	$VBoxContainer/HBoxContainer/AttackButton.disabled = false
	
func enable_sacrifice():
	$VBoxContainer/HBoxContainer/SacrificeButton.disabled = false
	
func disable_sacrifice():
	$VBoxContainer/HBoxContainer/SacrificeButton.disabled = true

func _on_AttackButton_pressed():
	emit_signal('attack')
	$VBoxContainer/HBoxContainer/AttackButton.disabled = true


func _on_SacrificeButton_pressed():
	emit_signal('blood_sacrifice')
