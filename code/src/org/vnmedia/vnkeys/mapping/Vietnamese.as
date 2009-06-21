package org.vnmedia.vnkeys.mapping
{
	import vnmedia.controls.Input;
	

	final public class Vietnamese
	{
		
		/**
		 * Details of vietnamese alphabet at
		 * http://en.wikipedia.org/wiki/Vietnamese_alphabet
		 * 
		 */
		protected var _alphabet:String;
		
		/**
		 * Be aware that this is not really collation chart of vietnamese alphabet
		 * http://vietunicode.sourceforge.net/charset/v3.htm for the real one
		 * 
		 */
		protected var _collationChart:Array;
		
		protected var _collationChartReplaces:Array;
		protected var _replaces:String;
		
		/**
		 * 
		 */
		public static const DAU_HUYEN:String = "`";
		public static const DAU_HOI:String = "?";
		public static const DAU_NGA:String = "~";
		public static const DAU_SAC:String = "´";
		public static const DAU_NANG:String = ".";
		public static const DAU_GACH_NGAN:String = "d";
		public static const DAU_MU:String = "^";
		public static const DAU_MOC:String = "'";
		public static const DAU_TRANG:String = "(";
		
		public static const DAU_HUYEN_POS:int = 1;
		public static const DAU_HOI_POS:int = 2;
		public static const DAU_NGA_POS:int = 3;
		public static const DAU_SAC_POS:int = 4;
		public static const DAU_NANG_POS:int = 5;
		public static const DAU_TRANG_POS:int = 6;
		public static const DAU_MU_POS:int = 7;
		public static const DAU_MOC_POS:int = 8;
		public static const DAU_GACH_NGAN_POS:int = 9;
		
		protected var _markableLetters:String;
		
		private static var _instance:Vietnamese;
		private static var _allowNewInstance:Boolean = false;
		
		/**
		 * Those are including accent vowels
		 * Create for checking spell, make decision where the tone mark should be placed
		 * 
		 */
		protected var _monophthongs:Array;
		protected var _diphthong1s:Array;
		protected var _diphthong2s:Array;
		protected var _triphthong2s:Array;
		protected var _triphthong3s:Array;
		protected var _consonants:Array;
		protected var _doubleMarkable:Array;
		
		protected var _characterFound:CharacterFound;
		
		public function Vietnamese()
		{
			if (!_allowNewInstance) {
				throw new MapError("Not allowed new instance. Please use getInstance");
			}
			this.init();
		}
		
		/**
		* @return Vietnamese
		*/
		public static function getInstance():Vietnamese
		{
			if (null === _instance) {
				_allowNewInstance = true;
				_instance = new Vietnamese();
				_allowNewInstance = false;
			}
			return _instance;
		}
		
		private function initAlphabets():void
		{
			// vietnamese alphabet, including f since it may be replaced (shortened version) for ph
			this._alphabet = new String("aăâbcdđeêfghiklmnoôơpqrstuưvxy");
			// Combining Diacritical Marks
			// Complete Set in Alphabetical Order
			//this._replaces = new String("aàảãáạăằẳẵắặâầẩẫấậbcdđeèẻẽéẹêềểễếệfghiìỉĩíịjklmnoòỏõóọôồổỗốộơờởỡớợpqrstuùủũúụưừửữứựvwxyỳỷỹýỵz");
			//  vowels (and đ) that 
			this._replaces = new String("àảãáạăằẳẵắặâầẩẫấậđèẻẽéẹêềểễếệìỉĩíịòỏõóọôồổỗốộơờởỡớợùủũúụưừửữứựỳỷỹýỵ");
			// vowels + dd; !important that those are in this order
			this._markableLetters = new String("aăâeêioôơuưyd");
			//  monoph thongs in vietnamese, including accent mark
			this._monophthongs = new String("aeiouyàảãáạăằẳẵắặâầẩẫấậèẻẽéẹêềểễếệìỉĩíịòỏõóọôồổỗốộơờởỡớợùủũúụưừửữứựỳỷỹýỵ").split("");
			// diph thongs, where the tone mark is placed on the first letter
			this._diphthong1s = new String("eu,ua,ùa,úa,ủa,ũa," + 
					"ui,ôi,oi,ơi,ây,ai,ay,ưi,ia,ya,ưa,iu,êu,eo,ơu,âu,ao,au,ưu" + 
					"úi,ối,ói,ới,ấy,ái,áy,ứi,ía,ýa,ứa,íu,ếu,éo,ớu,ấu,áo,áu,ứu" + 
					"ùi,ồi,òi,ời,ầy,ài,ày,ừi,ìa,ỳa,ừa,ìu,ều,èo,ờu,ầu,ào,àu,ừu" + 
					"ủi,ổi,ỏi,ởi,ẩy,ải,ảy,ửi,ỉa,ỷa,ửa,ỉu,ểu,ẻo,ởu,ẩu,ảo,ảu,ửu" + 
					"ũi,ỗi,õi,ỡi,ẫy,ãi,ãy,ữi,ĩa,ỹa,ữa,ĩu,ễu,ẽo,ỡu,ẫu,ão,ãu,ữu" + 
					"ụi,ội,ọi,ợi,ậy,ại,ạy,ựi,ịa,ỵa,ựa,ịu,ệu,ẹo,ợu,ậu,ạo,ạu,ựu").split(",");
			// the tone mark is placed on the second letter
			this._diphthong2s = new String("ie,ye,uo,uo,uy," + 
					"iê,yê,ươ,uô,uy," + 
					"iế,yế,ướ,uố,uý," + 
					"iề,yề,ườ,uồ,uỳ," + 
					"iể,yể,ưở,uổ,uỷ," + 
					"iễ,yễ,ưỡ,uỗ,uỹ," + 
					"iệ,yệ,ượ,uộ,uỵ").split(",");
			// triph thongs where the tone mark is placed on the second letter
			// it may be possible to join this and _diphthong2s to minimize search time
			this._triphthong2s = new String("" + 
					"ieu,yeu,uoi,uou,uya,ueu,oay,oai,uay,uyu,oao," + 
					"iêu,yêu,ươi,uôi,ươu,uya,uêu,oay,oai,uây," + 
					"iếu,yếu,ưới,uối,ướu,uýa,uếu,oáy,oái,uấy,uýu,oáo," + 
					"iều,yều,ười,uồi,ườu,uỳa,uều,oày,oài,uầy,uỳu,oào," + 
					"iểu,yểu,ưởi,uổi,ưởu,uỷa,uểu,oảy,oải,uẩy,uỷu,oảo," + 
					"iễu,yễu,ưỡi,uỗi,ưỡu,uỹa,uễu,oãy,oãi,uẫy,uỹu,oão," + 
					"iệu,yệu,ượi,uội,ượu,uỵa,uệu,oạy,oại,uậy,uỵu,oạo").split(",");
			// triph thongs where the tone mark is placed on the third letter
			this._triphthong3s = new String("uye,uyê,uyế,uyề,uyể,uyễ,uyệ").split(",");
			// available consonants are taken into account since this for splitting the word and not for checking spelling
			// letter f is actually not used in Vietnamese, ph is used instead
			this._consonants = new String("ngh,ch,gh,gi,kh,nh,ng,ph,th,tr,qu,b,c,d,đ,f,g,h,k,l,m,n,p,q,r,s,t,v,x").split(",");
			this._doubleMarkable = new String("uo,ươ,uó,ướ,uò,ườ,uỏ,ưở,uõ,ưỡ,uọ,ượ").split(",");
		}
		
		private function init():void
		{
			this._characterFound = new CharacterFound();
			this.initAlphabets();
			this._collationChart = new Array(this._alphabet.length);
			this._collationChartReplaces = new Array(this._replaces.length);
			var i:int;
			for (i = 0; i < this._alphabet.length; i++) {
				this._collationChart[i] = "";
			}
			for (i = 0; i < this._replaces.length; i++) {
				this._collationChartReplaces[i] = "";
			}
			// it is possible and better to set upp intervals and calculate the char position
			// This way is easier to follow what hapens
			// Lost of memory but may possibly be faster			
			this._collationChart[this.getPos("a")] = new String("aàảãáạ   ");
			this._collationChart[this.getPos("ă")] = new String("ăằẳẵắặ   ");
			this._collationChart[this.getPos("â")] = new String("âầẩẫấậ   ");
			this._collationChart[this.getPos("e")] = new String("eèẻẽéẹ   ");
			this._collationChart[this.getPos("ê")] = new String("êềểễếệ   ");
			this._collationChart[this.getPos("i")] = new String("iìỉĩíị   ");
			this._collationChart[this.getPos("o")] = new String("oòỏõóọ   ");
			this._collationChart[this.getPos("ô")] = new String("ôồổỗốộ   ");
			this._collationChart[this.getPos("ơ")] = new String("ơờởỡớợ   ");
			this._collationChart[this.getPos("u")] = new String("uùủũúụ   ");
			this._collationChart[this.getPos("ư")] = new String("ưừửữứự   ");
			this._collationChart[this.getPos("y")] = new String("yỳỷỹýỵ   ");
			this._collationChart[this.getPos("d")] = new String("d        đ");
			
			var letter:String;
			var posMarkable:int;
			var str:String;
			var j:int, rpPos:int,mLength:int, length:int, letterTmp:String;
			mLength = this._markableLetters.length - 1;// not including d
			for (j = 0; j < mLength; j++) {
				letter = this._markableLetters.substr(j,1);
				posMarkable = this.getPos(letter);
				str = this._collationChart[posMarkable];
				length = 6;
				for (i = 1; i < length;i++) {
					letterTmp = str.substr(i,1);
					rpPos= this.getReplacePos(letterTmp);
					if (rpPos == -1){
						continue;
					}
					this._collationChartReplaces[rpPos] = this._collationChart[posMarkable];
				}
			}
			// for đ
			this._collationChartReplaces[this.getReplacePos("đ")] = this._collationChart[this.getPos("d")];
		}
		
		/**
		 * Return the character that user want to type
		 * isReversed is true if we unmark a character
		 * This parameter is used later to decide if the input should be displayed or canceled
		 * 
		 */
		private function getLetter(fallbackLetter:String, myPos:int, mark:String):Object
		{
			var shift:int = 0;
			var collation:String;
			var isReversed:Boolean = false;
			trace("fall back letter: " + fallbackLetter);
			switch(fallbackLetter.toLowerCase()) {
				case 'a':
					if (DAU_MU == mark) {
						shift = 2;
					} else if (DAU_TRANG == mark){
						shift = 1;
					} else {
						isReversed = true;
					}
				break;
				case 'ă':
					if (DAU_TRANG == mark) {
						shift = -1;
						isReversed = true;
					} else if (DAU_MU == mark) {
						shift = 1;
						isReversed = false;
					} else {
						isReversed = true;
					}
				break;
				case 'â':
					if (DAU_MU == mark) {
						shift = -2;
						isReversed = true;
					} else if (DAU_TRANG == mark) {
						shift = -1;
						isReversed = false;
					} else {
						isReversed = true;
					}
				break;
				case 'ê': 
					if (DAU_MU == mark) {
						shift = -1;
						isReversed = true;
					} else {
						isReversed = true;
					}
					break;
				case 'e': 
					if (DAU_MU == mark) {
						shift = 1;
					} else {
						isReversed = true;
					}
				break;				
				case 'o': 
					if (DAU_MOC == mark) {
						shift = 2;
					} else if (DAU_MU == mark){
						shift = 1;
					} else {
						isReversed = true;
					}
				break;
				case 'ơ':
					if (DAU_MU == mark){
						 shift =-1;
					} else if (DAU_MOC == mark) {
						 shift = -2;
						 isReversed = true;						 
					} else {
						isReversed = true;
					}
				break;
				case 'ô':
					if (DAU_MOC == mark){
						shift = 1;
					} else if(DAU_MU == mark) {
						shift = -1;
						isReversed = true;
					} else {
						isReversed = true;
					}
				break;
				case 'u':
					if (DAU_MOC == mark) {
						shift = 1;
					} else {
						isReversed = true;
					}
				break;
				case 'ư':
					if (DAU_MOC == mark) {
						shift = -1;
						isReversed = true;
					} else {
						isReversed = true;
					}
				break;
				case 'd':
					shift = 0;
					isReversed = true;
					myPos = 0;
				break;
				default:
					isReversed = true;
					shift = 0;
				
			}
			// get the collation of the alphabet
			collation = this.getCollationAt(this.getPos(fallbackLetter) + shift);
			trace("fall back collation: " + collation);
			// ge the character at the given position
			return {"isReversed":isReversed,"char": collation.charAt(myPos)};
		}
		
		private function findCharacters(word:String, mark:String):Boolean
		{
			trace("find characters");
			// reset characterFound object to make sure that we start at the beginning
			this._characterFound.reset();
			var i:int = 0,letter:String = "", lastLetter:String = "";
			var wordLength:int = word.length;
			// run and get all consonants in the beginning
			while (letter = word.substr(i,1)) {
				if (lastLetter == "q") {// qu-consonant;
					if (letter == "u") {
						this._characterFound.initialConsonants += letter;
						lastLetter = letter;
						i++;
						continue;
					}
				} else if (lastLetter == "g") {
					if (letter == "i" && this._monophthongs.indexOf(word.substr(i+1,1)) != -1) {
						this._characterFound.initialConsonants += letter;
						lastLetter = letter;
						i++;
						continue;
					}
				}
				if (this._consonants.indexOf(letter.toLowerCase()) == -1) {
					break;
				}
				this._characterFound.initialConsonants += letter;
				lastLetter = letter;
				i++;
			}
			// Get all vowels
			while (letter = word.substr(i,1)) {
				if (this._monophthongs.indexOf(letter.toLowerCase()) == -1) {
					break;
				}
				trace("letter: "+letter);
				this._characterFound.vowels += letter;
				i++;
			}
			// And get all consonants at the end of the word
			// For a more correct way we should check if they are really consonants
			while (letter = word.substr(i,1)) {
				this._characterFound.endingConsonants += letter;
				i++;
			}
			this.findReplacedPos(mark);
			
			return this._characterFound.replacedPos != -1 || this._characterFound.isInitialConsonantsMarkable();
		}
		
		/**
		 * Calculate the start position and number of characters to mark
		 * 
		 * 
		 */
		private function findReplacedPos(mark:String):void
		{
			var pos:int, length:int = 1,vowels:String;
			vowels = this._characterFound.vowels.toLowerCase();
			if (this._triphthong3s.indexOf(vowels) > -1 ) {
				pos =  2;
			} else if (this._triphthong2s.indexOf(vowels) > -1
				|| this._diphthong2s.indexOf(vowels) > -1) {
				pos = 1;
			} else if (this._diphthong1s.indexOf(vowels) > -1
				|| this._monophthongs.indexOf(vowels) > -1) {
				pos = 0;
			} else {
				pos = -1;
			}
			if (mark == DAU_MOC) {
				if (this.isDoubleMarkable(vowels)) {
					pos = 0;
					length = 2;
				}
			}
			trace("replace pos: " + pos);
			trace("replace length: " + length);
			this._characterFound.replacedPos = pos;
			this._characterFound.replacedLength = length;
		}
		
		private function isDoubleMarkable(vowels:String):Boolean
		{
			if (vowels.length < 2) {
				return false;
			}
			trace("Double markable");
			// only uo
			return this._doubleMarkable.indexOf(vowels.substr(0,2)) != -1;
		}
		
		private function replaceWord(word:String, mark:String):ReplacedWord
		{
			var returnedChar:String = "",letter:String = "", newLetter:String = "";
			var isReplaced:Boolean = false, isReversed:Boolean = false, isUpperCase:Boolean = false;
			var letters:Array = word.split("");
			var collation:String, obj:Object;
			letters.reverse();
			while (letter = letters.shift()) {
				isUpperCase = (letter == letter.toUpperCase())? true:false;
				letter = letter.toLowerCase();
				if (this.isMarkable(letter)) {
					trace("markable letter: " + letter);
					try {
						collation =  this.getCollationAt(this._alphabet.indexOf(letter));
						if ((newLetter = collation.charAt(this.getMarkPos(letter,mark))).length > 0) {
							if (newLetter != letter && newLetter != " ") {	
								isReplaced = true;
							} else {
								if (newLetter == " ") {
									isReversed = true;
								} else {
									isReversed = false;
								}
								isReplaced = true;
								if (this.isMark(mark)) {
									newLetter = collation.charAt(0);
								} else {
									obj = this.getLetter(collation.charAt(0),collation.indexOf(letter),mark);
									if (newLetter == letter) {
										isReversed = true;
									} else {
										isReversed = obj.isReversed;
									}
									newLetter = obj.char;
								}
							}
							returnedChar = ((isUpperCase)? newLetter.toUpperCase(): newLetter) + returnedChar;
							break;
						}
					} catch (e:Error) {
						trace(e);
					}
				} else if (this._replaces.indexOf(letter) != -1) {
					trace("replaceable letter: " + letter);
					try {
						collation = this.getReplaceAt(this.getReplacePos(letter));
						trace("replace collation: " + collation);
						if ((newLetter = collation.charAt(this.getMarkPos(letter,mark))).length > 0) {
							trace("new letter: "+newLetter);
							if (newLetter != letter && newLetter != " ") {	
								isReplaced = true;
							} else {
								isReplaced = true;
								if (this.isMark(mark)) {
									isReversed = true;
									newLetter = collation.charAt(0);
								} else {
									trace("call _getLetter");
									obj = this.getLetter(collation.charAt(0), collation.indexOf(letter),mark);
									if (newLetter == letter) {
										isReversed = true;
									} else {
										isReversed = obj.isReversed;
									}
									newLetter = obj.char;
								}
							}							
							returnedChar = ((isUpperCase)? newLetter.toUpperCase():newLetter) + returnedChar;
							break;
						}
					} catch (e:Error) {
						trace(e);
					}
				}
				
				returnedChar = ((isUpperCase)? letter.toUpperCase():letter) + returnedChar;
			}
			
			while (letter = letters.shift()) {
				returnedChar = letter + returnedChar;
			}
			
			return new ReplacedWord(returnedChar,isReplaced, isReversed);
		}
		
		public function setMark(word:String,mark:String):ReplacedWord
		{
			trace("Vietnamese.setMark@word: " + word);
			trace("Vietnamese.setMark@mark: " + mark);
			var replacedWord:ReplacedWord, vowel:String = "",vowels:String="",i:int= 0;
			if (this.findCharacters(word,mark) !== false) {
				// if dd
				if (this._characterFound.isInitialConsonantsMarkable()) {
					// If the mark is DAU_GACH_NGAN; for dd
					if (mark == DAU_GACH_NGAN) {
						replacedWord = this.replaceWord(this._characterFound.initialConsonants,mark);
						replacedWord.word += this._characterFound.vowels;
						replacedWord.word += this._characterFound.endingConsonants;
						return replacedWord;
					}
				}
				// It is important that this part is a fallback of the ast if case since we can have a dd/d but marking for other characters instead
				// we start to collecting vowels
				while(vowel = this._characterFound.replacedVowels.substr(i,1)) {
					replacedWord = this.replaceWord(vowel, mark);
					vowels += replacedWord.word;			
					i++;
				}
				replacedWord.word = this._characterFound.initialConsonants 
									+ this._characterFound.initialVowels
									+ vowels
									+ this._characterFound.endingVowels
									+ this._characterFound.endingConsonants;
				return replacedWord;
			}
			// important, this is a kind of fallback
			return this.replaceWord(word,mark);
		}
		
		public function isMarkable(letter:String):Boolean
		{
			return this._markableLetters.indexOf(letter) != -1;
		}
		
		/**
		 *
		 * Check what kind of mark it is
		 * Return true if it is a "tone mark"
		 * 
		 */
		public function isMark(mark:String):Boolean
		{
			switch(mark) {
				case DAU_HUYEN:
				case DAU_HOI:
				case DAU_NGA:
				case DAU_SAC:
				case DAU_NANG:
					return true;
				break;
				case DAU_GACH_NGAN:
				case DAU_MU:
				case DAU_MOC:
				case DAU_TRANG:
					return false;
				break;
				default:
					throw new MapError(MapError.INVALID_MARK,MapError.ERRNO_INVALID_MARK);
			}
		}
		
		public function getMarkPos(char:String,mark:String):int
		{
			var pos:int = -1;
			char = char.toLowerCase();
			switch(mark) {
				case DAU_HUYEN:
					pos = DAU_HUYEN_POS;
				break;
				case DAU_HOI:
					pos = DAU_HOI_POS;
				break;
				case DAU_NGA:
					pos = DAU_NGA_POS;
				break;
				case DAU_SAC:
					pos = DAU_SAC_POS;
				break;
				case DAU_NANG:
					pos = DAU_NANG_POS;
				break;
				case DAU_GACH_NGAN:
					pos = DAU_GACH_NGAN_POS;
				break;
				case DAU_MU:
					pos = DAU_MU_POS;
				break;
				case DAU_MOC:
					pos = DAU_MOC_POS;
				break;
				case DAU_TRANG:
					pos = DAU_TRANG_POS;
				break;
				default:
					throw new MapError(MapError.INVALID_MARK,MapError.ERRNO_INVALID_MARK);
			}
			return pos;
		}
		
		public function getCollationAt(pos:int):String
		{
			return this._collationChart[pos] as String;
		}
		
		public function getPos(char:String):int
		{
			return this._alphabet.lastIndexOf(char);
		}
		
		public function get alphabet():String
		{
			return this._alphabet;
		}
		
		public function getReplaceAt(pos:int):String
		{
			return this._collationChartReplaces[pos] as String;
		}
		
		public function getReplacePos(char:String):int
		{
			return this._replaces.lastIndexOf(char);
		}
	}
}
