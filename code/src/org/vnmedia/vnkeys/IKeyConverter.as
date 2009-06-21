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