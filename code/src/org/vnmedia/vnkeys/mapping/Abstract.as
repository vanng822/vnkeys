package org.vnmedia.vnkeys.mapping
{
	import org.vnmedia.vnkeys.vnm_vnkeys;
	import org.vnmedia.vnkeys.mapping.IKeyMap;
	import flash.events.KeyboardEvent;
	use namespace vnm_vnkeys;
	
	public class Abstract implements IKeyMap
	{
		private var _map:Array;
		protected var _markKeyCodes:Array;
		protected var _name:String;
		
		protected var _keyEvent:KeyboardEvent;
		protected var _lastKeyEvent:KeyboardEvent;
		
		public function Abstract()
		{
			this.init();
		}
		
		protected function init():void
		{
			this.initMap();
			this.initMarkKeyCodes();
		}
		
		/**
		 * This is a short name that will used to select the mapping technics.
		 * May also used for indexing, i.e. as a key-value
		 * 
		 */
		public function get name():String
		{
			throw new Error("Implement this method");
		}
		
		/**
		 * A name that describes this mapping
		 * Possibly used to display as option for select
		 */
		public function get longName():String
		{
			throw new Error("implement this method");
		}
		
		/**
		 * 
		 * An array of all marks
		 * 
		 */
		protected function initMap():void
		{
			// make sure that subclass must initiate the character map
			throw new Error("Initiate this.map");
		}
		
		/**
		 * The keycodes or combinations based on KeyboardEvent
		 * Each keycode must stay in the same position as the corresponding mark in this.map
		 * 
		 */
		protected function initMarkKeyCodes():void
		{
			throw new Error("Initiate this._markKeyCodes");
		}
		
		/**
		 * Return the keycode from user input
		 * Simplest case: this._keyEvent.keyCode
		 * This will be used to determine which mark will be returned in getMark()
		 */
		protected function getMarkKeyCode():int
		{
			throw new Error("Implement this method");
		}
		
		public function get map():Array
		{
			return this._map;
		}
	
		public function set map(oMap:Array):void
		{
			this._map = oMap;
		}
		
		public function get markKeyCodes():Array
		{
			return this._markKeyCodes;
		}
		
		public function isValidKey():Boolean
		{
			return this.markKeyCodes.indexOf(this.getMarkKeyCode()) != -1;
		}
		
		final public function getMark():String
		{
			return this.map[this._markKeyCodes.indexOf(this.getMarkKeyCode())] as String;
		}

		final public function registerKey(e:KeyboardEvent):void
		{
			this._keyEvent = e;
		}
	}
}
