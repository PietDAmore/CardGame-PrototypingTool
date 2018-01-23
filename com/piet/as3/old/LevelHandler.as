// LevelHandler

function gotoNextLevel(): void {

	if (level_nmbr < level_array.length + 1) {

		level_array.push(level_nmbr);
		level_nmbr += 1;

		trace("level = " + level_nmbr + ", level_array.length = " + level_array.length);

	}
	
	if (player_move_direction == "top") {
		player_start_x = player.x;
	}

	if (player_move_direction == "left" && player_move_direction == "right") {
		player_start_y = player.y;
	}

	restartGame();

}

function createNewLevel(): void {

	for (var i = 0; i < level1_array.length; i++) {

		var addNpc = 0;

		var next_level_array;

		if (level_nmbr == 1) {
			next_level_array = level1_array[i];
		}

		if (level_nmbr == 2) {
			next_level_array = level2_array[i];
		}

		if (level_nmbr == 3) {
			next_level_array = level3_array[i];
		}

		if (level_nmbr == 4) {
			next_level_array = level4_array[i];
		}

		if (level_nmbr == 5) {
			next_level_array = level5_array[i];
		}

		if (level_nmbr == 6) {
			next_level_array = level6_array[i];
		}
		
		if (level_nmbr >= 7) {
			next_level_array = level1_array[i];
		}		

		if (level_nmbr == level1_array.length + 1) {
			level_nmbr = 1;
			next_level_array = level1_array[i];
		}

		//trace("level_nmbr = " + level_nmbr);
		//trace("next_level_array = "+ next_level_array);

		var tile_type = next_level_array;

		// check tile for enemy mark, createEnemies

		if (tile_type > 200) {
			tile_type -= 200;
			addNpc = 2;
		}

		if (tile_type > 100) {
			tile_type -= 100;
			addNpc = 1;
		}
	
		var createdTile = createNewTile(tile_type);

		if (addNpc == 1) {
			createEnemy(createdTile.x, createdTile.y + 1, 64);
		}
		if (addNpc == 2) {
			createEnemy(createdTile.x, createdTile.y + 1, 256);
		}
	}

	createGroundPoints();

}



// -----
// TILES

function createNewTile(tile_type): Sprite {

	// check if build finished
	if (tiles_amount == tiles_amount_max - 1) {
		tiles_build_process = false;
	}

	if (tiles_amount < tiles_amount_max) {

		tiles_amount += 1;
		return createTile(tile_type);

	}

	return null;
}


function createTile(tile_type): Sprite {

	var mc_tile: MovieClip = new Tile();
	tiles_container.addChild(mc_tile);

	var new_x: Number = 0;
	var new_y: Number = 0 + new_tile_y;

	// create tiles within the grid
	if (tiles_amount_x < tiles_amount_x_max && tiles_amount_x != 0) {

		tiles_amount_x += 1;
		new_tile_x = new_tile_x + 64;
		new_x = new_tile_x;

	} else {

		tiles_amount_x = 1;
		new_tile_x = tiles_start_x;
		new_x = tiles_start_x;

		if (tiles_amount_y < tiles_amount_y_max && tiles_amount > 1) {

			tiles_amount_y += 1;
			new_tile_y = new_tile_y + 64;

		}
		if (tiles_amount_y >= tiles_amount_y_max) {
			tiles_amount_y = tiles_amount_y_max;
		}

		new_y = new_tile_y;
	}

	mc_tile.x = new_x;
	mc_tile.y = new_y;

	if (tile_type == 1) {
		mc_tile.tiletype = "wall";
		mc_tile.gotoAndStop(2);

		block_array.push(mc_tile);
		wallarray.push(mc_tile);
	}
	if (tile_type == 2) {
		mc_tile.tiletype = "cover";
		mc_tile.gotoAndStop(3);

		block_array.push(mc_tile);
		wallarray.push(mc_tile);
	}
	if (tile_type == 3) {
		mc_tile.tiletype = "half_cover";
		mc_tile.gotoAndStop(4);

		ground_array.push(mc_tile);
		cover_array.push(mc_tile);
	}
	if (tile_type == 4) {
		mc_tile.tiletype = "endwall";
		mc_tile.gotoAndStop(5);

		block_array.push(mc_tile);
		wallarray.push(mc_tile);
	}
	if (tile_type == 5) {
		mc_tile.tiletype = "door";
		mc_tile.gotoAndStop(6);
		mc_tile.door = true;

		block_array.push(mc_tile);
		wallarray.push(mc_tile);
	}

	if (tile_type == 6) {
		mc_tile.tiletype = "ground";
		mc_tile.gotoAndStop(1);

		ground_array.push(mc_tile);
	}

	if (tile_type == 7) {
		mc_tile.tiletype = "arrow";
		mc_tile.gotoAndStop(7);

		ground_array.push(mc_tile);
		northwalk_array.push(mc_tile);
	}

	if (tile_type >= 8) {
		mc_tile.tiletype = "empty";
		mc_tile.gotoAndStop("empty");

		block_array.push(mc_tile);
		wallarray.push(mc_tile);
	}


	mc_tile.pos = tiles_amount_x + tiles_amount_y;
	mc_tile.addEventListener(Event.ENTER_FRAME, tileUpdate);

	return mc_tile;
}

function tileUpdate(e): void {

	// Feedback on hit
	if (e.currentTarget.alpha < 1) {
		e.currentTarget.alpha += 0.1;
	}

}