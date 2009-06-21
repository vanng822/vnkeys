package org.vnmedia.vnkeys
{
	import org.vnmedia.vnkeys.mapping.IKeyMap;
	import org.vnmedia.vnkeys.mapping.KeyOff;
	import org.vnmedia.vnkeys.mapping.ReplacedWord;
	import org.vnmedia.vnkeys.mapping.VIQRMap;
	import org.vnmedia.vnkeys.mapping.VNIMap;
	import org.vnmedia.vnkeys.mapping.Vietnamese;
	
	public class KeyMapping
	{
		// keep instances of mapping technics
		protected var _maps:Array;
		// keep the name of mapping technics for fast checking
		private var _availableTypes:Array;
		// the name of the current mapping technics
		protected var _type:String;
		
		public function KeyMapping(oType:String = null)
		{
			this.init();
			if (oType == null) {
				oType = this._availableTypes[0];
			}
			this.type = oType;
		}
		
		public function init():void
		{
			this._availableTypes = new Array();
			this._maps = new Array();
			this.addKeyMap(new KeyOff());
			this.addKeyMap(new VNIMap());
			this.addKeyMap(new VIQRMap());
		}
		
		public function set type(oType:String):void
		{
			if (!this.isAvailable(oType)) {
				throw new KeyError(KeyError.MAPPING_TYPE_NOT_AVAILABLE,KeyError.ERRNO_MAPPING_TYPE_NOT_AVAILABLE);
			}
			this._type = oType;
		}
		
		public function get type():String
		{
			return this._type;
		}
		
		public function isAvailable(oType:String):Boolean
		{
			return this._availableTypes.indexOf(oType) != -1;
		}
		
		public function addKeyMap(map:IKeyMap):void
		{
			if (this.isAvailable(map.name)) {
				return;
			}
			this._maps.push(map);
			this._availableTypes.push(map.name);
		}
		
		public function getKeyMap(name:String):IKeyMap
		{
			var map:IKeyMap;
			for (var i:int = 0; i < this._maps.length; i++) {
				map = this._maps[i] as IKeyMap;
				if (map.name == name) {
					return map;
				}
			}
			return null;
		}
		
		/**
		 * @return an array of IkeyMap
		 */
		public function getKeyMaps():Array
		{
			return this._maps;
		}
		
		public function getCurrentKeyMap():IKeyMap
		{
			return this.getKeyMap(this._type);
		}
		
		public function convert(word:String):ReplacedWord
		{
			return Vietnamese.getInstance().setMark(word,this.getCurrentKeyMap().getMark());
		}
	}
}
