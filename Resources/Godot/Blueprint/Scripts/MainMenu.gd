extends Node3D

#Add new ones for elements you want to hide or show
@onready var options = $UI/Options
@onready var menu = $UI/MainMenu
@onready var menu_fade_anim: AnimationPlayer = $AnimationPlayer

func _ready():
	options.hide()
	$UI/MainMenu/MenuBtn/VBoxContainer/PlayBtn.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func show_and_hide(first, second):
	first.show()
	second.hide()

func _on_play_btn_pressed():
	menu_fade_anim.play("Main_Menu_Fade_Out")
	ChangeScene.changeScene(ChangeScene.tutorial)

func _on_options_btn_pressed():
	menu_fade_anim.play("Main_Menu_Fade_Out")
	show_and_hide(options, menu)

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_back_btn_pressed():
	menu_fade_anim.play_backwards("Main_Menu_Fade_Out")
	show_and_hide(menu, options)


func _on_discord_btn_pressed():
	OS.shell_open("https://discord.gg/bQTPTc5Qrt")


func _on_fish_btn_pressed() -> void:
	%ExplosionAnim.play("Explosion")
	$FishBtn.disabled = true