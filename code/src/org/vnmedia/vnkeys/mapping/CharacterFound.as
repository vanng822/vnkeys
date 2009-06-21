package org.vnmedia.vnkeys.mapping
{	
	public class CharacterFound
	{
		private var _initialConsonants:String = "";
		private var _endingConsonants:String = "";
		private var _vowels:String = "";
		private var _pos:int = -1;
		private var _replacedLength:int = 0;
		
		public function set initialConsonants(cons:String):void
		{
			this._initialConsonants = cons;
		}
		
		public function set endingConsonants(cons:String):void
		{
			this._endingConsonants = cons;
		}
		
		public function set vowels(cons:String):void
		{
			this._vowels = cons;
		}
		
		public function get vowels():String
		{
			return this._vowels;
		}
		
		public function get replacedVowels():String
		{
			return this._vowels.substr(this.replacedPos, this.replacedLength);
		}
		
		public function get initialVowels():String
		{
			return this._vowels.substr(0, this.replacedPos);
		}
		public function get endingVowels():String
		{
			return this._vowels.substr(this.replacedPos + this.replacedLength,this._vowels.length - this.replacedPos - this.replacedLength);
		}
		
		public function isInitialConsonantsMarkable():Boolean
		{
			return this._initialConsonants.toLowerCase() == 'd' || this._initialConsonants.toLowerCase() == "đ";
		}
		
		public function get initialConsonants():String
		{
			return this._initialConsonants;
		}
		
		public function get endingConsonants():String
		{
			return this._endingConsonants;
		}
	
		public function set replacedPos(pos:int):void
		{
			this._pos = pos;
		}
		
		public function get replacedPos():int
		{
			return this._pos;
		}
		
		public function set replacedLength(pos:int):void
		{
			this._replacedLength = pos;
		}
		
		public function get replacedLength():int
		{
			return this._replacedLength;
		}
		
		public function reset():void
		{
			this._initialConsonants = "";
			this._endingConsonants = "";
			this._vowels = "";
			this._pos = -1;
			this._replacedLength = 0;
		}
	}
}