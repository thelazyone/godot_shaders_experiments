extends SubViewport

var imprint_done = false
var drawn_area : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a new Sprite2D
	drawn_area = TextureRect.new()
	add_child(drawn_area)
	
	# Set an image texture to the sprite
	var img = Image.create(500, 500, false, Image.FORMAT_RGBA8) 
	for x in range(500):
		for y in range(500):
			var random_color = Color(randf(), 0, 0, 1.0)
			img.set_pixel(x, y, random_color)
	
	var texture = ImageTexture.create_from_image(img)

	drawn_area.texture = texture
	drawn_area.position = Vector2(256, 256)  # Center the sprite in the viewport
	drawn_area.visible = true
	
	# Debugging outputs
	print("Sprite setup complete. Texture size: ", texture.get_width(), "x", texture.get_height())
	print("Viewport size: ", self.size)
	print("Sprite position: ", drawn_area.position)
	print("Is sprite visible? ", drawn_area.visible)
	
	# Setting the size for the colorRect
	$ColorRect.material.set_shader_parameter("viewport_size", get_viewport().size)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if drawn_area and not imprint_done:
		print ("showing once")
		await get_tree().create_timer(.1).timeout
		imprint_done = true;
		
	if drawn_area and imprint_done:
		print ("now deleting")
		drawn_area.visible = false  # Make the sprite invisible
		drawn_area.queue_free()  # Optional: Remove the sprite from the scene tree
