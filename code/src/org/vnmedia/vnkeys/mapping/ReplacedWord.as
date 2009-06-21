package org.vnmedia.vnkeys.mapping
{
	public class ReplacedWord
	{
		private var _word:String;
		private var _isReplaced:Boolean;
		private var _isReversed:Boolean;
		
		public function ReplacedWord(oWord:String,oIsReplaced:Boolean, oIsReversed:Boolean)
		{
			this.word = oWord;
			this.isReplaced = oIsReplaced;
			this.isReversed = oIsReversed;
		}
		
		public function set isReversed(flag:Boolean):void
		{
			this._isReversed = flag;
		}
		
		public function get isReversed():Boolean
		{
			return this._isReversed;
		}
		
		public function set isReplaced(flag:Boolean):void
		{
			this._isReplaced = flag;
		}
		
		public function get isReplaced():Boolean
		{
			return this._isReplaced;
		}
		
		public function set word(oWord:String):void
		{
			this._word = oWord;
		}
		
		public function get word():String
		{
			return this._word;
		}
		public function reset():void
		{
			this.word = '';
			this.isReplaced = false;
			this.isReversed = false;
		}
	}
}