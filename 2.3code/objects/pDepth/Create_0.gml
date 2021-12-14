/// @description
z = 0;

if (!instance_exists(oDepthDrawer)) instance_create_layer(x,y,layer,oDepthDrawer);

with oDepthDrawer {
	if (depth_grid != -1) { // increase grid size
		var height = ds_grid_height(depth_grid);
		ds_grid_resize(depth_grid, 2, height+1);
		depth_grid[# 0, height] = other.id;
		depth_grid[# 1, height] = other.y;
		
	} else {  // if grid doesnt exist create first row
		var height = 1;
		depth_grid = ds_grid_create(2, 1);
		depth_grid[# 0, 0] = other.id;
		depth_grid[# 1, 0] = other.y;
	}		
}

visible = false; // we dont want the object drawing itself