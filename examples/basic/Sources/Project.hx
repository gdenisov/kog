package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Shaders;
import kha.Assets;

class Project {
	var scene:kog.Scene;
	var cc:CameraController;

	public function new() {
		scene = new kog.Scene();
		
		Assets.loadEverything(displayModel);

		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	private function displayModel() {
		var mesh = new kog.Mesh(Assets.blobs.model_ogex);
		var structure = mesh.structure;
		var material = new kog.Material(
			Shaders.simple_vert,
			Shaders.simple_frag,
			structure
		);
		var model = new kog.Model(mesh);
		
		var uniformR = new kog.Uniform('Float', 'redColor');
		uniformR.setFloat(1.0);
		material.addUniform(uniformR);

		var tex = new kog.Texture('ranger');
		tex.setImage(Assets.images.diffuse);
		material.addTexture(tex);
		
		cc = new CameraController();
		cc.registerCamera('camera', scene.camera);
		
		material.registerModel(model);
		scene.registerMaterial(material);
		scene.registerController(cc);
	}

	function update(): Void {
		scene.update();
	}

	function render(framebuffer: Framebuffer): Void {
		scene.render(framebuffer);		
	}
}