package com.pialabs.eskimo.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	
	public class DeeboxPerformanceFps extends Sprite
	{
		private var _fpstxt:TextField;
		private var _tmpfps:Number;
		private var _fps:Number;
		private var _ms:int;
		private var _time:int;
		private var _totalMem:Number;
		private var _privateMem:Number;
		private var _memFree:Number;

		private var _playerVersion:String;
		private var _1024:Number;
		
		private const FREQ:int = 1000;
		
		private const MONITOR_MEM_MAX:uint=100;//mb
		private const MONITOR_FPS_MAX:uint=100
		
		private const MONITOR_H:uint = 50;
		private const MONITOR_W:uint = 50;
		
		private const MONITOR_TXT_COLOR:uint = 0xFFFFFF;

		public function DeeboxPerformanceFps()
		{
			super();
			setupui();
			initMonitor();
		}
		
		private function setupui():void
		{
			_fpstxt = new TextField();
			var txtf:TextFormat = new TextFormat();
			txtf.color = MONITOR_TXT_COLOR;
			txtf.font = "Verdana";
			txtf.size = 10;
			_fpstxt.defaultTextFormat = txtf;
			_fpstxt.autoSize = "left";
			_fpstxt.selectable=false;
			addChild(_fpstxt);
			_fpstxt.y = 0;
			_fpstxt.x = 0;
			
		}
		
		private function initMonitor():void
		{
			_playerVersion = "("+Capabilities.playerType+") "+Capabilities.version+" debug:"+Capabilities.isDebugger;
			_1024 = 1/1024;
			_ms=getTimer();
			_fps=0;
			_tmpfps=0;
			addEventListener(Event.ENTER_FRAME,monitorFPS);
		}
		
		private function monitorFPS(e:Event):void
		{
			_time = getTimer()- FREQ;
			if(_time>_ms){
				_fps=_tmpfps+(_tmpfps*.001*(_time-_ms));
				_ms=getTimer();
				_tmpfps=0;
			}else{
				_tmpfps++;
			}
			//The amount of memory (in bytes) currently in use that has been directly allocated by Flash Player or AIR
			_totalMem = System.totalMemory*_1024*_1024; 
			//The entire amount of memory (in bytes) used by an application. This is the amount of resident private memory for the entire process.
			//For Flash Player, this includes the memory used by the container application, such as the web browser.
			_privateMem = System.privateMemory*_1024*_1024;
			//The amount of memory (in bytes) that is allocated to Adobe® Flash® Player or Adobe® AIR® and that is not in use. 
			//This unused portion of allocated memory (System.totalMemory) fluctuates as garbage collection takes place. Use this property to monitor garbage collection. 
			_memFree = System.freeMemory*_1024*_1024;
			_fpstxt.text="\n"+_playerVersion+"\nFPS: "+_fps+"\nTOTAL MEM:    "+_totalMem.toString().substr(0,10)+" MB"+"\nPRIVATE MEM: "+_privateMem.toString().substr(0,10)+" MB"+"\nFREE MEM:      "+_memFree.toString().substr(0,10)+" MB";
		}
	}
}