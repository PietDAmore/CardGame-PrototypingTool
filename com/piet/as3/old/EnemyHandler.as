// EnemyHandler

function createEnemies(): void {

	//

}

function createEnemy(enem_x, enem_y, distance): void  {

	var mc_enemy: MovieClip = new Enemy();
	enemy_container.addChild(mc_enemy);

	mc_enemy.x = enem_x + mc_enemy.width;
	mc_enemy.y = enem_y + mc_enemy.height;

	mc_enemy.alive = true;
	mc_enemy.direction_ = "right";

	mc_enemy.scaleX = -1;
	mc_enemy.gotoAndStop("walk");
	enemy_array.push(mc_enemy);

	var enem: MovieClip = mc_enemy;
	var enem_target: Number;
	var lock_position: Boolean;
	var walk_distance: Number = distance;
	var enem_direction: String;
	var view_delay: Number = 0;

	enem_target = mc_enemy.x + walk_distance;
	enem_direction = "right";

	// autostart
	createNewViewBullet(mc_enemy.x, mc_enemy.y, "right");

	var fMoveAlong: Function = function (e): void {

		if (e.currentTarget.parent == null) {
			e.currentTarget.removeEventListener(Event.ENTER_FRAME, fMoveAlong);
			return;
		}

		if (mc_enemy.alive == false) {

			mc_enemy.direction_ = "";
			view_delay = 0;
			mc_enemy.removeEventListener(Event.ENTER_FRAME, fMoveAlong);

			return;
		}

		if (enem_direction == "right") {

			if (enem.x < enem_target) {

				if (view_delay < 8) {
					view_delay++;
				} else {

					//trace("createNewViewBullet right");
					
					view_delay = 0;
					createNewViewBullet(mc_enemy.x, mc_enemy.y, "right");
				}

				var hitTestRight: Boolean = checkBlock(e, "right");

				if (hitTestRight == false) {

					enem.x += 1;

				} else {
					
					trace("switch to left because block");
					
					enem_target = e.currentTarget.x - walk_distance;
					trace("new enem_target = " + enem_target);
					
					enem_direction = "left";
					mc_enemy.scaleX = 1;
					mc_enemy.gotoAndStop("walk");

				}

			} else {

				// trace("switch to left");
				
				enem_target = e.currentTarget.x - walk_distance;
				trace("new enem_target = " + enem_target);
				
				enem_direction = "left";
				mc_enemy.scaleX = 1;
				mc_enemy.gotoAndStop("walk");

			}

		} else {

			if (enem.x > enem_target) {

				if (view_delay < 8) {
					view_delay++;
					
				} else {

					//trace("createNewViewBullet left");
					
					view_delay = 0;
					createNewViewBullet(mc_enemy.x, mc_enemy.y, "left");
				}

				var hitTestLeft: Boolean = checkBlock(e, "left");
				
				if (hitTestLeft == false) {

					enem.x -= 1;

				} else {
					
					trace("switch to right because block");
					
					enem_target = e.currentTarget.x + walk_distance;
					trace("new enem_target = " + enem_target);
					
					enem_direction = "right";
					mc_enemy.scaleX = -1;
					mc_enemy.gotoAndStop("walk");
					
				}


			} else {

				// trace("switch to right");
				
				enem_target = e.currentTarget.x + walk_distance;
				enem_direction = "right";
				mc_enemy.scaleX = -1;
				mc_enemy.gotoAndStop("walk");

			}
		}


	}

	mc_enemy.addEventListener(Event.ENTER_FRAME, fMoveAlong);

}


function enemyShoot(e): void {

	createNewBullet(e.currentTarget.x, e.currentTarget.y, "down");

}