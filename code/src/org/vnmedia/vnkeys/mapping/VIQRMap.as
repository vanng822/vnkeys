/**
 *  vnkeys - support typing Vietnamese in flash input without preinstalled software
 *  Copyright (C) 2009  Nguyen Van Nhu
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */
package org.vnmedia.vnkeys.mapping
{
	public class VIQRMap extends Abstract
	{
	
		public static const NAME:String = "VIQR";
		public static const LONG_NAME:String = "VIQR";	
	
		public function VIQRMap()
		{
			super();
		}
		
		override protected function initMarkKeyCodes():void
		{
			this._markKeyCodes = new Array(219,219*16,187*16,186*18,190,186*16,191,56*16,68);
		}
		
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
			if (this._keyEvent.altKey) {
				return this._keyEvent.keyCode * 18;
			} else if (this._keyEvent.shiftKey) {
				return this._keyEvent.keyCode * 16;
			}
			return this._keyEvent.keyCode;
		}
	}

}