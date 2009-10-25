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
package org.vnmedia.vnkeys
{
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import org.vnmedia.vnkeys.mapping.IKeyMap;
	import org.vnmedia.vnkeys.mapping.ReplacedWord;
	import org.vnmedia.vnkeys.mapping.VNIMap;
	public class KeyConverter implements IKeyConverter
	{
		protected var _field:TextField;
		
		protected var _wordStartIndex:int;
		protected var _wordEndIndex:int;
		
		protected var _keyMapping:KeyMapping;
		
		protected var _word:ReplacedWord;
		
		public function KeyConverter(fieldObject:Object = null, mapType:String = "")
		{
			if (fieldObject !== null) {
				this.setField(fieldObject);
			}
			this.setMapType(mapType);
			this.init();
		}
		
		protected function init():void
		{
			this._word = new ReplacedWord("",false,false);
		}
		
		private function getKeyMapping():KeyMapping
		{
			if (this._keyMapping == null) {
				this._keyMapping = new KeyMapping();
			}
			return this._keyMapping;
		}
		
		public function setMapType(type:String):void
		{
			this.getKeyMapping().type = type;
		}
		
		public function setField(fieldObject:Object):void
		{
			var oField:TextField;
			// check if the input is a TextField
			if (fieldObject is TextField) {
				oField = fieldObject as TextField;
			} else if (typeof fieldObject.textField != undefined
				&& fieldObject.textField is TextField) {
				oField = fieldObject.textField as TextField;
			} else {
				trace("The object must be an instance of TextField or fieldObject.textField must return a TextField instance");
				throw new KeyError(KeyError.TEXT_FIELD_INVALID,KeyError.ERRNO_TEXT_FIELD_INVALID);
			}
			// release listeners first if there is a textfield
			this.removeEventHandlers();
			this._field = oField;
			this.setEventHandlers();
		}
		
		public function getField():TextField
		{
			return this._field;
		}
		
		public function setEventHandlers():void
		{
			if (!(this._field is TextField)) {
				trace("Please set the text field to listen first before calling this method");
				throw new KeyError(KeyError.TEXT_FIELD_INVALID,KeyError.ERRNO_TEXT_FIELD_INVALID);
			}
			// listen to the keyboard
			this._field.addEventListener(KeyboardEvent.KEY_DOWN,this.convert);
			this._field.addEventListener(TextEvent.TEXT_INPUT,this.replaceWord);
		}
		
		public function removeEventHandlers():void
		{
			if (!(this._field is TextField)) {
				return;
			}
			this._field.removeEventListener(KeyboardEvent.KEY_DOWN,this.convert);
			this._field.removeEventListener(TextEvent.TEXT_INPUT,this.replaceWord);
		}
		
		public function convert(e:KeyboardEvent):void
		{
			var wordToConvert:String;
			this.getKeyMapping().getCurrentKeyMap().registerKey(e);
			if (!this.getKeyMapping().getCurrentKeyMap().isValidKey()) {
				return; //if the key we are listening for, continue
			}
			// run the converting only if we found a ord to convert
			try {
				if ((wordToConvert = this.getWordToConvert())) {
					trace("start converting");
					this._word = this.getKeyMapping().convert(wordToConvert);
				}
			} catch(e:Error) {
				trace("KeyConverter.convert: " + e);
			}
		}
		
		public function replaceWord(e:TextEvent):void
		{
			// if nothing to replace, return
			// The standard input will take over
			if (!this._word.isReplaced) {
				return;
			}
			trace("KeyConverter.replaceWord()");
			this._field.replaceText(this.wordStartIndex, this.wordEndIndex,this._word.word);
			if (!this._word.isReversed) {
				e.preventDefault();
				e.stopImmediatePropagation();
				e.stopPropagation();
			}
			// reset to default status
			this._word.reset();
			// Move the cursor to the current position
			this._field.setSelection(this._field.caretIndex,this._field.caretIndex);
		}
		
		public function getReplacedWord():ReplacedWord {
			return this._word.clone();
		}
		
		private function getWordToConvert():String
		{
			var word:String = "",char:String, fieldLength:int;
			var caretIndex:int = this._field.caretIndex - 1;
			var startIndex:int, endIndex:int;
			// simple match pattern for none words
			var numbers:String = "0123456789";
			// left of the cursor
			while(!(char = this._field.text.substr(caretIndex,1)).match(/\s/) && caretIndex > -1) {
				if (numbers.indexOf(char) != -1) {
					return "";
				}
				word = char + word;
				caretIndex--;
			}
			startIndex = ++caretIndex;
			// right of the cursor
			caretIndex = this._field.caretIndex;
			fieldLength = this._field.length;
			while((char = this._field.text.substr(caretIndex,1)).match(/\s/) && caretIndex < fieldLength) {
				if (numbers.indexOf(char) != -1) {
					return "";
				}
				word += char;
				caretIndex++;
			}
			endIndex = caretIndex++;
			this.wordStartIndex = startIndex;
			this.wordEndIndex = endIndex;
			return word;
		}
		
		private function set wordStartIndex(index:int):void
		{
			this._wordStartIndex = index;
		}
		
		private function get wordStartIndex():int
		{
			return this._wordStartIndex;
		}
		
		private function set wordEndIndex(index:int):void
		{
			this._wordEndIndex = index;
		}
		
		private function get wordEndIndex():int
		{
			return this._wordEndIndex;
		}
		
		public function getKeyMapOptions():Array
		{
			var options:Array = new Array;
			var keyMaps:Array = this.getKeyMapping().getKeyMaps();
			for each (var keyMap:IKeyMap in keyMaps) {
				options.push({"data":keyMap.name,"label":keyMap.longName});
			}
			return options;
		}
	}
}
