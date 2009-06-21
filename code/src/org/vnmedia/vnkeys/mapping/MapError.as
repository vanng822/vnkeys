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
 * Error code start at 4000
 * 
 */
 
package org.vnmedia.vnkeys.mapping
{
	import org.vnmedia.vnkeys.KeyError;
	
	public class MapError extends KeyError
	{
		public static const ERRNO_INVALID_MARK:int = 4000;
		public static const INVALID_MARK:String = "Invalid mark";
		
		public function MapError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}