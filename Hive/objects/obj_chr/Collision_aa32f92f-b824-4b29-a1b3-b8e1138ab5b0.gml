// 룸 이동
if (other.isOpen) {
	scr_room_inst_save();
	
	global.previousIndex = global.currentIndex;
	global.currentIndex = other.targetIndex;
	global.previousPos = other.pos;
	
	instance_create_layer(0, 0, "layer_system", obj_transition_slide);
	scr_world_room_goto(global.currentIndex);
}