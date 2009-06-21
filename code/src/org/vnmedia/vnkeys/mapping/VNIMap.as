package org.vnmedia.vnkeys.mapping
{
	public class VNIMap extends Abstract
	{		
		public static const NAME:String = "VNI";
		public static const LONG_NAME:String = "VNI";
		
		public function VNIMap()
		{
			super();
		}
		
		override protected function initMarkKeyCodes():void
		{
			this._markKeyCodes = new Array(49,50,51,52,53,54,55,56,57);
			
		}
		
		/**
		 * mapping the keycodes and the coresponding character
		 * It's not important how we are mapping
		 * more important that we return the coresponding value, according definitions in Vietnamese class 
		 */
		override protected function initMap():void
		{
			this.map = new Array(
				Vietnamese.DAU_SAC,
				Vietnamese.DAU_HUYEN,
				Vietnamese.DAU_HOI,
				Vietnamese.DAU_NGA,
				Vietnamese.DAU_NANG,
				Vietnamese.DAU_MU,
				Vietnamese.DAU_MOC,
				Vietnamese.DAU_TRANG,
				Vietnamese.DAU_GACH_NGAN
			);
		}
		
		override public function get name():String
		{
			return NAME;
		}

		override public function get longName():String
		{
			return LONG_NAME;
		}
				
		override protected function getMarkKeyCode():int
		{
			return this._keyEvent.keyCode;
		}
	}
	
}
