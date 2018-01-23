import flash.display.Sprite;

// BulletHandler

var bullets: Array = new Array;
var view_bullets: Array = new Array;
var view_bullet: Boolean = false;
var vbullet_container: Sprite = new Sprite();

/*
for (var index: int = 0; index < bullet_container.numChildren; index++) {
	var bullet: MovieClip = bullet_container.getChildAt(index) as MovieClip;
	bullets.push(bullet);
}
*/

function createNewBullet(shooter_x, shooter_y, direction): void {

	var mc_bullet: MovieClip = new Bullet();
	tiles_container.addChild(mc_bullet);

	var randi: Number = randomRange(-7, 7);

	// starting point
	mc_bullet.x = shooter_x + randi;
	mc_bullet.y = shooter_y + randi / 2;
	
	mc_bullet.shoot_direction = direction;
	
	if (mc_bullet.shoot_direction == "left" || mc_bullet.shoot_direction == "right") {
		mc_bullet.y = shooter_y + 32 + randi;
	}
	

	mc_bullet.addEventListener(Event.ENTER_FRAME, bulletUpdate);

}

function bulletUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, bulletUpdate);
		return;
	}

	trace("e.currentTarget.shoot_direction: " + e.currentTarget.shoot_direction);

	// bulletdestroy
	if (e.currentTarget.shoot_direction == "top" && e.currentTarget.y < e.currentTarget.height) {
		bulletDestroy(e);

		return;
	}
	if (e.currentTarget.shoot_direction == "right" && e.currentTarget.x > screenend_right) {
		bulletDestroy(e);

		return;
	}
	if (e.currentTarget.shoot_direction == "left" && e.currentTarget.x < screenend_left) {
		bulletDestroy(e);

		return;
	}

	// bullet vs enemy
	for (var c = 0; c < enemy_array.length; c++) {

		if (e.currentTarget.hitTestObject(enemy_array[c])) {

			if (enemy_array[c].alive == true) {

				enemy_array[c].gotoAndPlay("die");
				enemy_array[c].alive = false;
				
				if (enemy_array[c].blood == true) {
					enemy_array[c].blood = false;
					createBloodStain(e);
				}
				createBloodStain(e);
				bulletDestroy(e);

				var scream_or_not_scream = randomRange(1, 20);

				if (scream_or_not_scream == 10) {
					mc_sound.gotoAndPlay("scream");
				}
				return;
			}

		}

	}

	// bullet vs wall
	for (var i = 0; i < wallarray.length; i++) {
		if (e.currentTarget.hitTestObject(wallarray[i])) {

			e.currentTarget.y += e.currentTarget.height / 2;
			bulletDestroy(e);

			return;
		}

	}

	if (e.currentTarget.shoot_direction == "top") {
		e.currentTarget.y -= bullet_speed;
	}

	if (e.currentTarget.shoot_direction == "right") {
		trace("bullet flight right");
		e.currentTarget.x += bullet_speed;
	}

	if (e.currentTarget.shoot_direction == "left") {
		trace("bullet flight left");
		e.currentTarget.x -= bullet_speed;
	}


}

function createBloodStain(e): void {

	var mc_blood = new Blood();
	tiles_container.addChild(mc_blood);

	mc_blood.x = e.currentTarget.x;
	mc_blood.y = e.currentTarget.y;

	var random_bloodsprite = randomRange(1, mc_blood.totalFrames);
	mc_blood.gotoAndStop(random_bloodsprite);

	var blood_distance: Number = randomRange(1, 32);

	if (player_move_direction == "top") {

		e.currentTarget.y -= blood_distance;

	}
	
	if (player_move_direction == "left") {
		
		trace("throw blood to the left");
		e.currentTarget.x -= blood_distance - 10;		


	}
	
	if (player_move_direction == "right") {
		 
		trace("throw blood to the right");
		e.currentTarget.x += blood_distance + 10;

	}	
	
	mc_blood.addEventListener(Event.ENTER_FRAME, bloodUpdate);
}

function bulletDestroy(e): void {

	ShowBulletDestroyAnim(e);

	e.currentTarget.removeEventListener(Event.ENTER_FRAME, bulletUpdate);
	e.currentTarget.parent.removeChild(e.currentTarget);

}

function ShowBulletDestroyAnim(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, ShowBulletDestroyAnim);
		return;
	}

	var mc_bullet_destroy: MovieClip = new animBullet();
	e.currentTarget.parent.addChild(mc_bullet_destroy);
	mc_bullet_destroy.x = e.currentTarget.x;
	mc_bullet_destroy.y = e.currentTarget.y;

	mc_bullet_destroy.addEventListener(Event.ENTER_FRAME, RemoveThisAtEnd);
	//RemoveThisAtEnd(e, target)

}

function createNewViewBullet(shooter_x, shooter_y, direction): void {

	//trace("createNewViewBullet, from x:" + shooter_x + " y:" + shooter_y + ", direction: " + direction);

	count_viewBullets++;

	var mc_viewBullet: MovieClip = new ViewBullet();
	addChild(mc_viewBullet);

	// starting point
	mc_viewBullet.x = shooter_x;
	mc_viewBullet.y = shooter_y + 11;

	if (direction == "right") {
		mc_viewBullet.direction_ = "right";
	}
	if (direction == "left") {
		mc_viewBullet.direction_ = "left";
	}

	mc_viewBullet.addEventListener(Event.ENTER_FRAME, viewBulletUpdate);

}

function viewBulletUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, viewBulletUpdate);
		return;
	}

	var count;

	if (e.currentTarget.hitTestObject(player)) {

		if (cheat_invisible == false || player_action == "roll") {

			playerDie();
			count_viewBullets--;

			destroyViewBullet(e);
			return;
		}

	}

	for (var i = 0; i < wallarray.length; i++) {

		if (e.currentTarget.hitTestObject(wallarray[i])) {

			destroyViewBullet(e);
			return;
		}

	}


	if (e.currentTarget.direction_ == "right") {

		//trace("e.currentTarget.direction_ = " + e.currentTarget.direction_ + " and I know it.");

		if (e.currentTarget.x > screenend_right) {

			count_viewBullets--;

			destroyViewBullet(e);
			return;
		}

		e.currentTarget.x += e.currentTarget.width;
	}


	if (e.currentTarget.direction_ == "left") {

		if (e.currentTarget.x < screenend_left) {

			destroyViewBullet(e);
			return;
		}

		e.currentTarget.x -= e.currentTarget.width;
	}


}

function destroyViewBullet(e): void {

	//trace("e.currentTarget. name while removing = " + e.currentTarget);

	e.currentTarget.removeEventListener(Event.ENTER_FRAME, viewBulletUpdate);

	//e.currentTarget.removeChildAt(0);
	e.currentTarget.parent.removeChild(e.currentTarget);


}