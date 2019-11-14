extends Spatial

func _ready():
	pass

const SPEED = 1

func _physics_process(delta):
	if Input.is_action_pressed('ui_up'): rotate_x(SPEED * delta)
	if Input.is_action_pressed('ui_down'): rotate_x(-SPEED * delta)
	if Input.is_action_pressed('ui_left'): rotate_y(-SPEED * delta)
	if Input.is_action_pressed('ui_right'): rotate_y(SPEED * delta)