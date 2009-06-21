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