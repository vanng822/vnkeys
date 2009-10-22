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
		
		public function clone():ReplacedWord {
			return new ReplacedWord(this.word,this.isReplaced,this._isReversed);
		}
	}
}