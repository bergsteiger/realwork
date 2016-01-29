unit tfwIl3CStringPack;

interface

uses
 l3IntfUses
 , l3Interfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwRegisterableWord
 , tfwWordWorkerEx
;

implementation

uses
 l3ImplUses
 , l3String
 , l3Types
 , l3Chars
 , l3Base
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TtfwIl3CStringPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TtfwIl3CStringPackResNameGetter
 
 TkwStartsStr = class(TtfwClassLike)
  {* Слово скрипта StartsStr
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsStr >>> l_Boolean
[code]  }
  function StartsStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* Реализация слова скрипта StartsStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartsStr
 
 TkwStartsText = class(TtfwClassLike)
  {* Слово скрипта StartsText
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsText >>> l_Boolean
[code]  }
  function StartsText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* Реализация слова скрипта StartsText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartsText
 
 TkwEndsStr = class(TtfwClassLike)
  {* Слово скрипта EndsStr
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsStr >>> l_Boolean
[code]  }
  function EndsStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* Реализация слова скрипта EndsStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEndsStr
 
 TkwEndsText = class(TtfwClassLike)
  {* Слово скрипта EndsText
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsText >>> l_Boolean
[code]  }
  function EndsText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* Реализация слова скрипта EndsText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEndsText
 
 TkwSameStr = class(TtfwClassLike)
  {* Слово скрипта SameStr
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameStr >>> l_Boolean
[code]  }
  function SameStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Boolean;
   {* Реализация слова скрипта SameStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSameStr
 
 TkwSameText = class(TtfwClassLike)
  {* Слово скрипта SameText
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameText >>> l_Boolean
[code]  }
  function SameText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Boolean;
   {* Реализация слова скрипта SameText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSameText
 
 TkwCompareStr = class(TtfwClassLike)
  {* Слово скрипта CompareStr
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareStr >>> l_Integer
[code]  }
  function CompareStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* Реализация слова скрипта CompareStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareStr
 
 TkwCompareText = class(TtfwClassLike)
  {* Слово скрипта CompareText
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareText >>> l_Integer
[code]  }
  function CompareText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* Реализация слова скрипта CompareText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareText
 
 TkwStrToInt = class(TtfwClassLike)
  {* Слово скрипта StrToInt
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aString StrToInt >>> l_Integer
[code]  }
  function StrToInt(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* Реализация слова скрипта StrToInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStrToInt
 
 TkwCat = class(TtfwClassLike)
  {* Слово скрипта Cat
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 anOther aString Cat >>> l_Il3CString
[code]  }
  function Cat(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Il3CString;
   {* Реализация слова скрипта Cat }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCat
 
 TkwStringConsistsOf = class(TtfwClassLike)
  {* Слово скрипта string:ConsistsOf
[panel]Проверяет, что строка aString состоит ТОЛЬКО из символов строки aDelims[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:ConsistsOf >>> l_Boolean
[code]  }
  function string_ConsistsOf(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aDelims: Il3CString): Boolean;
   {* Реализация слова скрипта string:ConsistsOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringConsistsOf
 
 TkwStringHasAnyOf = class(TtfwClassLike)
  {* Слово скрипта string:HasAnyOf
[panel]Проверяет, что строка aString содержит хотя бы один символ из aDelims[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:HasAnyOf >>> l_Boolean
[code]  }
  function string_HasAnyOf(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aDelims: Il3CString): Boolean;
   {* Реализация слова скрипта string:HasAnyOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringHasAnyOf
 
 TkwStringPos = class(TtfwClassLike)
  {* Слово скрипта string:Pos
[panel]'мама рыла яму' 'ры' string:Pos .[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anOther aString string:Pos >>> l_Integer
[code]  }
  function string_Pos(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* Реализация слова скрипта string:Pos }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringPos
 
 TkwStringPosEx = class(TtfwClassLike)
  {* Слово скрипта string:PosEx
[panel]6 'мама рыла рыло' 'ры' string:PosEx .[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aPos anOther aString string:PosEx >>> l_Integer
[code]  }
  function string_PosEx(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString;
   aPos: Integer): Integer;
   {* Реализация слова скрипта string:PosEx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringPosEx
 
 TkwStringSplit = class(TtfwClassLike)
  {* Слово скрипта string:Split
[panel]Разделяет строку на две по заданному разделителю.

Пример:
[code]
'ABC:DEF' ':' string:Split
[code]
Получаем на стеке:
'ABC' ':DEF'[panel]
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_theTail
STRING VAR l_Il3CString
 anOther aString string:Split >>> l_theTail >>> l_Il3CString
[code]  }
  function string_Split(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString;
   out theTail: Il3CString): Il3CString;
   {* Реализация слова скрипта string:Split }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringSplit
 
 TkwStringReplace = class(TtfwClassLike)
  {* Слово скрипта string:Replace
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:Replace >>> l_Il3CString
[code]  }
  function string_Replace(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* Реализация слова скрипта string:Replace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringReplace
 
 TkwStringReplaceFirst = class(TtfwClassLike)
  {* Слово скрипта string:ReplaceFirst
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:ReplaceFirst >>> l_Il3CString
[code]  }
  function string_ReplaceFirst(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* Реализация слова скрипта string:ReplaceFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringReplaceFirst
 
 TkwTextReplace = class(TtfwClassLike)
  {* Слово скрипта text:Replace
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:Replace >>> l_Il3CString
[code]  }
  function text_Replace(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* Реализация слова скрипта text:Replace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextReplace
 
 TkwTextReplaceFirst = class(TtfwClassLike)
  {* Слово скрипта text:ReplaceFirst
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:ReplaceFirst >>> l_Il3CString
[code]  }
  function text_ReplaceFirst(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* Реализация слова скрипта text:ReplaceFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextReplaceFirst
 
 TkwStringChar = class(TtfwClassLike)
  {* Слово скрипта string:[i]
*Тип результата:* Char
*Пример:*
[code]
CHAR VAR l_Char
 anIndex aString string:[i] >>> l_Char
[code]  }
  function string_Char(const aCtx: TtfwContext;
   const aString: Il3CString;
   anIndex: Integer): AnsiChar;
   {* Реализация слова скрипта string:[i] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringChar
 
 TkwStringCodePage = class(TtfwClassLike)
  {* Слово скрипта string:CodePage
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aString string:CodePage >>> l_Integer
[code]  }
  function string_CodePage(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* Реализация слова скрипта string:CodePage }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringCodePage
 
 TkwStringLen = class(TtfwClassLike)
  {* Слово скрипта string:Len
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aString string:Len >>> l_Integer
[code]  }
  function string_Len(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* Реализация слова скрипта string:Len }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringLen
 
 TkwStringToChar = class(TtfwClassLike)
  {* Слово скрипта string:ToChar
*Тип результата:* Char
*Пример:*
[code]
CHAR VAR l_Char
 aString string:ToChar >>> l_Char
[code]  }
  function string_ToChar(const aCtx: TtfwContext;
   const aString: Il3CString): AnsiChar;
   {* Реализация слова скрипта string:ToChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringToChar
 
 TkwCharToString = class(TtfwRegisterableWord)
  {* Слово скрипта char:ToString
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aChar char:ToString >>> l_Il3CString
[code]  }
  function char_ToString(const aCtx: TtfwContext;
   aChar: AnsiChar): Il3CString;
   {* Реализация слова скрипта char:ToString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCharToString
 
 TkwCharDupe = class(TtfwClassLike)
  {* Слово скрипта char:Dupe
[panel]Размножаем символ столько раз, сколько указано[panel]
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aCount aString char:Dupe >>> l_Il3CString
[code]  }
  function char_Dupe(const aCtx: TtfwContext;
   const aString: Il3CString;
   aCount: Integer): Il3CString;
   {* Реализация слова скрипта char:Dupe }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCharDupe
 
 TkwStringInc = class(TtfwClassLike)
  {* Слово скрипта string:++
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aString string:++ >>> l_Il3CString
[code]  }
  function string_Inc(const aCtx: TtfwContext;
   const aString: Il3CString): Il3CString;
   {* Реализация слова скрипта string:++ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringInc
 
 TkwStringShift = class(TtfwClassLike)
  {* Слово скрипта string:+
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aDelta aString string:+ >>> l_Il3CString
[code]  }
  function string_Shift(const aCtx: TtfwContext;
   const aString: Il3CString;
   aDelta: Integer): Il3CString;
   {* Реализация слова скрипта string:+ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringShift
 
 TkwStringFirstChar = class(TtfwClassLike)
  {* Слово скрипта string:[]
*Тип результата:* Char
*Пример:*
[code]
CHAR VAR l_Char
 aString string:[] >>> l_Char
[code]  }
  function string_FirstChar(const aCtx: TtfwContext;
   const aString: Il3CString): AnsiChar;
   {* Реализация слова скрипта string:[] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringFirstChar
 
 TkwVarDecLen = class(TtfwWordWorkerEx)
  {* Слово скрипта string:--Len!
*Пример:*
[code]
 string:--Len! aVar
[code]  }
  procedure VarDecLen(const aCtx: TtfwContext;
   aVar: TtfwWord);
   {* Реализация слова скрипта string:--Len! }
 end;//TkwVarDecLen
 
 TkwVarInc = class(TtfwWordWorkerEx)
  {* Слово скрипта string:++!
*Пример:*
[code]
 string:++! aVar
[code]  }
  procedure VarInc(const aCtx: TtfwContext;
   aVar: TtfwWord);
   {* Реализация слова скрипта string:++! }
 end;//TkwVarInc
 
 TkwRSplitTo = class(TtfwWordWorkerEx)
  {* Слово скрипта string:RSplitTo!
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aDelim string:RSplitTo! aVar >>> l_Il3CString
[code]  }
  function RSplitTo(const aCtx: TtfwContext;
   aVar: TtfwWord;
   const aDelim: Il3CString): Il3CString;
   {* Реализация слова скрипта string:RSplitTo! }
 end;//TkwRSplitTo
 
 TkwVarShift = class(TtfwWordWorkerEx)
  {* Слово скрипта string:+!
*Пример:*
[code]
 aNum string:+! aVar
[code]  }
  procedure VarShift(const aCtx: TtfwContext;
   aVar: TtfwWord;
   aNum: Integer);
   {* Реализация слова скрипта string:+! }
 end;//TkwVarShift
 
 TkwSplitTo = class(TtfwWordWorkerEx)
  {* Слово скрипта string:SplitTo!
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aDelim string:SplitTo! aVar >>> l_Il3CString
[code]  }
  function SplitTo(const aCtx: TtfwContext;
   aVar: TtfwWord;
   const aDelim: Il3CString): Il3CString;
   {* Реализация слова скрипта string:SplitTo! }
 end;//TkwSplitTo
 
 TkwVarPushCharAndInc = class(TtfwWordWorkerEx)
  {* Слово скрипта string:[]++!
*Тип результата:* Char
*Пример:*
[code]
CHAR VAR l_Char
 string:[]++! aVar >>> l_Char
[code]  }
  function VarPushCharAndInc(const aCtx: TtfwContext;
   aVar: TtfwWord): AnsiChar;
   {* Реализация слова скрипта string:[]++! }
 end;//TkwVarPushCharAndInc
 
end.
