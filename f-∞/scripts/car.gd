extends RigidBody3D

@export var engine_force := 50.0
@export var brake_force := 25.0
@export var steer_angle := 0.5

func _physics_process(delta):
	# Get forward direction
	var forward := -transform.basis.z
	var right := transform.basis.x

	# Movement
	if Input.is_action_pressed("accelerate"):
		apply_central_force(forward * engine_force)
	elif Input.is_action_pressed("reverse"):
		apply_central_force(-forward * brake_force)

	# Steering (only while moving) 
	#for some reason dir needs to be flipped vs how it is in car.gd 
	if linear_velocity.length() > 1.0:
		if Input.is_action_pressed("turn left"):
			apply_torque_impulse(Vector3.UP * steer_angle) 
		elif Input.is_action_pressed("turn right"):
			apply_torque_impulse(Vector3.UP * -steer_angle)
