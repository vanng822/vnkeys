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