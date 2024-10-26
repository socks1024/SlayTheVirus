class_name TermScreen
extends BaseScreen

func _on_termleft_pressed():
	$back1.show()
	$back2.hide()


func _on_termright_pressed():
	$back1.hide()
	$back2.show()


func _on_return_pressed():
	main.switch_screen(main.settings_screen)
