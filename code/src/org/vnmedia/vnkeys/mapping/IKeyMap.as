package org.vnmedia.vnkeys.mapping
{
	import flash.events.KeyboardEvent;
	public interface IKeyMap
	{
		function get name():String;
		function get longName():String;
		function get map():Array;
		function set map(oMap:Array):void;
		function get markKeyCodes():Array;
		function isValidKey():Boolean;
		function getMark():String;
		function registerKey(e:KeyboardEvent):void;
	}
}
