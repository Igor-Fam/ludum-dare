extends Node2D

var selected = false
var in_inventory = false
var mouse_offset = Vector2(0, 0)

@export var size = Vector2(0, 0)
@export var module: Resource

@onready var inventory_area = $InventoryArea
@onready var item_area = $ItemArea
@onready var world = get_parent()

func _init():
	add_to_group("Items")

func _process(delta):
	z_index = 20 if selected or in_inventory else 7
	
	if selected:
		followMouse()
	
	if(Input.is_action_just_released("ui_left_click") and selected):
		change_inventory()
		SoundPlayer.play(SoundPlayer.ITEM_DROP)
		selected = false

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if(in_inventory):
				remove_item_from_slot()
			mouse_offset = position - get_global_mouse_position()
			selected = true

func followMouse():
	position = get_global_mouse_position() + mouse_offset

func change_inventory():
	var areas = inventory_area.get_overlapping_areas()
	if(areas.size() == 1):
		var slot = areas[0].get_parent()
		if slot.pos_in_grid.x + size.x > 3 or slot.pos_in_grid.y + size.y > 3:
			return
		var collided_items = item_area.get_overlapping_areas()
		if collided_items.any(is_in_inventory):
			return
		add_item_to_slot(slot)
	
	if(areas.size() != 1 && in_inventory):	
		remove_item_from_slot()

func add_item_to_slot(slot):
	var inventory = slot.get_parent().get_parent().get_parent()
	if inventory.modules.any(check_same_module):
		return

	get_parent().remove_child(self)
	slot.add_child(self)
	position = slot.get_child(0).get_child(0).transform.get_origin()
	position.y += 1
	
	inventory.modules.push_back(module)
	
	in_inventory = true

func remove_item_from_slot():
	var inventory = get_parent().get_parent().get_parent().get_parent()
	inventory.modules = inventory.modules.filter(check_different_module)
	
	get_parent().remove_child(self)
	world.add_child(self)
	position = get_global_mouse_position()
	in_inventory = false

func check_same_module(inv_module):
	return inv_module.name == module.name

func check_different_module(inv_module):
	return inv_module.name != module.name

func is_in_inventory(item):
	return item.get_parent().in_inventory

