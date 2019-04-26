extends RigidBody

export(Material) var colour

var bodies = []
var other
export(String) var other_path

const G = 6.674 # real life G: 6.674 * 10e-11

func _ready():
	get_node("CSGSphere").material = colour
	
	if other_path:
		other = get_node(other_path)
	set_physics_process(true)

func _physics_process(delta):
	if other:
		var direction = (other.translation - self.translation).normalized()
		var force = calculate_gravitational_force(other)
		self.add_force(delta * force * direction, Vector3.ZERO)

func calculate_gravitational_force(other_body):
	var distance_sq =  self.translation.distance_squared_to(other_body.translation)
	var force = G * self.mass * other_body.mass / distance_sq
	return force

