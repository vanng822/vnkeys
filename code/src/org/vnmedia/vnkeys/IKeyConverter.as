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
package org.vnmedia.vnkeys
{
	import flash.text.TextField;
	
	public interface IKeyConverter
	{
		function setMapType(type:String):void;
		function setField(fieldObject:Object):void;
		function getField():TextField;
		function setEventHandlers():void;
		function removeEventHandlers():void
		/**
		 * @return Array
		 *  this will return an array of objects which contain key,value pair
		 * 	ie [{key:some-key,value:some-value},...]
		 * 	This may be used to display options which the user can use to turn on or off
		 *  or switch the mapping technics
		 */
		function getKeyMapOptions():Array;
	}
}