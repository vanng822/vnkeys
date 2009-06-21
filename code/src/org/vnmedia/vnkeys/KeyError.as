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
 
 /**
 * Error code start at 4500
 * 
 */
package org.vnmedia.vnkeys
{
	public class KeyError extends Error
	{
		public static const TEXT_FIELD_INVALID:String = "Object is null or not an instance of TextField";
		public static const ERRNO_TEXT_FIELD_INVALID:int = 4500;
		
		public static const MAPPING_TYPE_NOT_AVAILABLE:String = "Mapping type is not available";
		public static const ERRNO_MAPPING_TYPE_NOT_AVAILABLE:int = 4501;
		
		public function KeyError(message:String="", id:int=0)
		{
			super(message, id);
		}
	}
}