package com.pialabs.eskimo.utils
{
	import flash.display.BlendMode;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class DeeboxPerformanceMonitor extends UIComponent
	{
		private var _isDragging:Boolean=false;
		private var _fps:DeeboxPerformanceFps;
		
		public function DeeboxPerformanceMonitor()
		{
			super();
			_fps = new DeeboxPerformanceFps();
			_fps.blendMode = BlendMode.INVERT;
			this.addChild(_fps);
			this.addEventListener(MouseEvent.MOUSE_DOWN,_startDrag);
			this.addEventListener(MouseEvent.MOUSE_UP,_stopDrag);
		}
		
		private function _startDrag(e:MouseEvent):void
		{
			if(!_isDragging){
				this.startDrag();
				_isDragging=true;
			}
		}
		
		private function _stopDrag(e:MouseEvent):void
		{
			if(_isDragging){
				this.stopDrag();
				_isDragging=false;
			}
		}
		
	}
}