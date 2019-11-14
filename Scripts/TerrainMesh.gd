extends MeshInstance

const RADIUS = 20.0
const SEGMENTS = 20.0
const HEIGHT = -1
const SCALE = 10

var x
var y
var z
var vertex
var row_min
var row_max
var dist

func _ready():
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)
	
	var verts = PoolVector3Array()
	var normals = PoolVector3Array()
	var indices = PoolIntArray()
	
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	var vertex_idx = 0
	for col in range(-SEGMENTS, SEGMENTS + 1):
		row_min = -SEGMENTS - min(col, 0)
		row_max = SEGMENTS - max(col, 0)
		for row in range(row_min, row_max + 1):
			x = sin(PI/3.0) * (RADIUS/SEGMENTS) * col
			z = ((1.0 / tan(PI/3.0)) * x) + ((RADIUS/SEGMENTS) * row)
			y = (noise.get_noise_2d(x, z) * SCALE) + HEIGHT
			vertex = Vector3(x, y, z)
			verts.append(vertex)
			normals.append(vertex.normalized())
			
			if (row != row_max) and (col != SEGMENTS):
				dist = ((SEGMENTS * 2) + 1) - floor(abs(col + 0.5))
				indices.append(vertex_idx)
				indices.append(vertex_idx + dist)
				indices.append(vertex_idx + 1)
			if (row != row_max) and (col != -SEGMENTS):
				dist = (SEGMENTS * 2) - floor(abs(col - 0.5))
				indices.append(vertex_idx + 1)
				indices.append(vertex_idx - dist)
				indices.append(vertex_idx)
			vertex_idx += 1
			
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_NORMAL] = normals
	arr[Mesh.ARRAY_INDEX] = indices
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)