package org.vnmedia.vnkeys
{
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import mx.controls.TextInput;
	
	import org.vnmedia.vnkeys.mapping.ReplacedWord;
	import org.vnmedia.vnkeys.mapping.VNIMap;
	
	public class FlexTextInput extends TextInput
	{
		private var converter:KeyConverter;
		private var cpField:TextField;
		
		private var eTextEvent:TextEvent;
		
		public function FlexTextInput() {
			super();
			this.initKeyConveter();
			this.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
			this.addEventListener(TextEvent.TEXT_INPUT,this.onTextEvent);
						
		}
		
		private function initKeyConveter():void {
			this.cpField = new TextField();
			this.converter = new KeyConverter(this.cpField, VNIMap.NAME);
		}
		
		private function onKeyUp(e:KeyboardEvent):void {
			this.cpField.text = this.text;
			this.cpField.setSelection(this.textField.caretIndex - 1,this.textField.caretIndex-1);
			this.converter.convert(e);
			var word:ReplacedWord = this.converter.getReplacedWord();
			this.converter.replaceWord(this.eTextEvent);
			if (!word.isReversed && word.isReplaced) {
				this.cpField.replaceText(cpField.caretIndex,cpField.caretIndex+1,'');
			}
			this.text = this.cpField.text;
		}
		
		private function onTextEvent(e:TextEvent):void {
			this.eTextEvent = e;// fire earlier; save and wait
		}
	}
}