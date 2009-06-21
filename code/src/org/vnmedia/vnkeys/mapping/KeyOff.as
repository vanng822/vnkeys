package org.vnmedia.vnkeys.mapping
{
	public class KeyOff extends Abstract
	{
		public static const NAME:String = "OFF";
		public static const LONG_NAME:String = "OFF";	
		
		public function KeyOff()
		{
			super();
		}
		override public function get name():String
		{
			return NAME;
		}
		override public function get longName():String
		{
			return LONG_NAME;
		}
		override protected function initMap():void
		{
			this.map = new Array();
		}
		
		override protected function initMarkKeyCodes():void
		{
			this._markKeyCodes = new Array();
		}
		
		override protected function getMarkKeyCode():int
		{
			return -1;
		}
		
		override public function isValidKey():Boolean
		{
			return false;
		}
	}
}