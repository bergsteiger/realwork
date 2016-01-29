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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TtfwIl3CStringPackResNameGetter
 
 TkwStartsStr = class(TtfwClassLike)
  {* ����� ������� StartsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsStr >>> l_Boolean
[code]  }
  function StartsStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* ���������� ����� ������� StartsStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartsStr
 
 TkwStartsText = class(TtfwClassLike)
  {* ����� ������� StartsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsText >>> l_Boolean
[code]  }
  function StartsText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* ���������� ����� ������� StartsText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartsText
 
 TkwEndsStr = class(TtfwClassLike)
  {* ����� ������� EndsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsStr >>> l_Boolean
[code]  }
  function EndsStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* ���������� ����� ������� EndsStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEndsStr
 
 TkwEndsText = class(TtfwClassLike)
  {* ����� ������� EndsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsText >>> l_Boolean
[code]  }
  function EndsText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aSubStr: Il3CString): Boolean;
   {* ���������� ����� ������� EndsText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEndsText
 
 TkwSameStr = class(TtfwClassLike)
  {* ����� ������� SameStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameStr >>> l_Boolean
[code]  }
  function SameStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Boolean;
   {* ���������� ����� ������� SameStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSameStr
 
 TkwSameText = class(TtfwClassLike)
  {* ����� ������� SameText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameText >>> l_Boolean
[code]  }
  function SameText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Boolean;
   {* ���������� ����� ������� SameText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSameText
 
 TkwCompareStr = class(TtfwClassLike)
  {* ����� ������� CompareStr
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareStr >>> l_Integer
[code]  }
  function CompareStr(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* ���������� ����� ������� CompareStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareStr
 
 TkwCompareText = class(TtfwClassLike)
  {* ����� ������� CompareText
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareText >>> l_Integer
[code]  }
  function CompareText(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* ���������� ����� ������� CompareText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareText
 
 TkwStrToInt = class(TtfwClassLike)
  {* ����� ������� StrToInt
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString StrToInt >>> l_Integer
[code]  }
  function StrToInt(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* ���������� ����� ������� StrToInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStrToInt
 
 TkwCat = class(TtfwClassLike)
  {* ����� ������� Cat
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 anOther aString Cat >>> l_Il3CString
[code]  }
  function Cat(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Il3CString;
   {* ���������� ����� ������� Cat }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCat
 
 TkwStringConsistsOf = class(TtfwClassLike)
  {* ����� ������� string:ConsistsOf
[panel]���������, ��� ������ aString ������� ������ �� �������� ������ aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:ConsistsOf >>> l_Boolean
[code]  }
  function string_ConsistsOf(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aDelims: Il3CString): Boolean;
   {* ���������� ����� ������� string:ConsistsOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringConsistsOf
 
 TkwStringHasAnyOf = class(TtfwClassLike)
  {* ����� ������� string:HasAnyOf
[panel]���������, ��� ������ aString �������� ���� �� ���� ������ �� aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:HasAnyOf >>> l_Boolean
[code]  }
  function string_HasAnyOf(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aDelims: Il3CString): Boolean;
   {* ���������� ����� ������� string:HasAnyOf }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringHasAnyOf
 
 TkwStringPos = class(TtfwClassLike)
  {* ����� ������� string:Pos
[panel]'���� ���� ���' '��' string:Pos .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString string:Pos >>> l_Integer
[code]  }
  function string_Pos(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString): Integer;
   {* ���������� ����� ������� string:Pos }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringPos
 
 TkwStringPosEx = class(TtfwClassLike)
  {* ����� ������� string:PosEx
[panel]6 '���� ���� ����' '��' string:PosEx .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aPos anOther aString string:PosEx >>> l_Integer
[code]  }
  function string_PosEx(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString;
   aPos: Integer): Integer;
   {* ���������� ����� ������� string:PosEx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringPosEx
 
 TkwStringSplit = class(TtfwClassLike)
  {* ����� ������� string:Split
[panel]��������� ������ �� ��� �� ��������� �����������.

������:
[code]
'ABC:DEF' ':' string:Split
[code]
�������� �� �����:
'ABC' ':DEF'[panel]
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_theTail
STRING VAR l_Il3CString
 anOther aString string:Split >>> l_theTail >>> l_Il3CString
[code]  }
  function string_Split(const aCtx: TtfwContext;
   const aString: Il3CString;
   const anOther: Il3CString;
   out theTail: Il3CString): Il3CString;
   {* ���������� ����� ������� string:Split }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringSplit
 
 TkwStringReplace = class(TtfwClassLike)
  {* ����� ������� string:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:Replace >>> l_Il3CString
[code]  }
  function string_Replace(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* ���������� ����� ������� string:Replace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringReplace
 
 TkwStringReplaceFirst = class(TtfwClassLike)
  {* ����� ������� string:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:ReplaceFirst >>> l_Il3CString
[code]  }
  function string_ReplaceFirst(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* ���������� ����� ������� string:ReplaceFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringReplaceFirst
 
 TkwTextReplace = class(TtfwClassLike)
  {* ����� ������� text:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:Replace >>> l_Il3CString
[code]  }
  function text_Replace(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* ���������� ����� ������� text:Replace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextReplace
 
 TkwTextReplaceFirst = class(TtfwClassLike)
  {* ����� ������� text:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:ReplaceFirst >>> l_Il3CString
[code]  }
  function text_ReplaceFirst(const aCtx: TtfwContext;
   const aString: Il3CString;
   const aFrom: Il3CString;
   const aMain: Il3CString): Il3CString;
   {* ���������� ����� ������� text:ReplaceFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextReplaceFirst
 
 TkwStringChar = class(TtfwClassLike)
  {* ����� ������� string:[i]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 anIndex aString string:[i] >>> l_Char
[code]  }
  function string_Char(const aCtx: TtfwContext;
   const aString: Il3CString;
   anIndex: Integer): AnsiChar;
   {* ���������� ����� ������� string:[i] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringChar
 
 TkwStringCodePage = class(TtfwClassLike)
  {* ����� ������� string:CodePage
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:CodePage >>> l_Integer
[code]  }
  function string_CodePage(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* ���������� ����� ������� string:CodePage }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringCodePage
 
 TkwStringLen = class(TtfwClassLike)
  {* ����� ������� string:Len
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:Len >>> l_Integer
[code]  }
  function string_Len(const aCtx: TtfwContext;
   const aString: Il3CString): Integer;
   {* ���������� ����� ������� string:Len }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringLen
 
 TkwStringToChar = class(TtfwClassLike)
  {* ����� ������� string:ToChar
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:ToChar >>> l_Char
[code]  }
  function string_ToChar(const aCtx: TtfwContext;
   const aString: Il3CString): AnsiChar;
   {* ���������� ����� ������� string:ToChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringToChar
 
 TkwCharToString = class(TtfwRegisterableWord)
  {* ����� ������� char:ToString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aChar char:ToString >>> l_Il3CString
[code]  }
  function char_ToString(const aCtx: TtfwContext;
   aChar: AnsiChar): Il3CString;
   {* ���������� ����� ������� char:ToString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCharToString
 
 TkwCharDupe = class(TtfwClassLike)
  {* ����� ������� char:Dupe
[panel]���������� ������ ������� ���, ������� �������[panel]
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aCount aString char:Dupe >>> l_Il3CString
[code]  }
  function char_Dupe(const aCtx: TtfwContext;
   const aString: Il3CString;
   aCount: Integer): Il3CString;
   {* ���������� ����� ������� char:Dupe }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCharDupe
 
 TkwStringInc = class(TtfwClassLike)
  {* ����� ������� string:++
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:++ >>> l_Il3CString
[code]  }
  function string_Inc(const aCtx: TtfwContext;
   const aString: Il3CString): Il3CString;
   {* ���������� ����� ������� string:++ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringInc
 
 TkwStringShift = class(TtfwClassLike)
  {* ����� ������� string:+
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelta aString string:+ >>> l_Il3CString
[code]  }
  function string_Shift(const aCtx: TtfwContext;
   const aString: Il3CString;
   aDelta: Integer): Il3CString;
   {* ���������� ����� ������� string:+ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringShift
 
 TkwStringFirstChar = class(TtfwClassLike)
  {* ����� ������� string:[]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:[] >>> l_Char
[code]  }
  function string_FirstChar(const aCtx: TtfwContext;
   const aString: Il3CString): AnsiChar;
   {* ���������� ����� ������� string:[] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStringFirstChar
 
 TkwVarDecLen = class(TtfwWordWorkerEx)
  {* ����� ������� string:--Len!
*������:*
[code]
 string:--Len! aVar
[code]  }
  procedure VarDecLen(const aCtx: TtfwContext;
   aVar: TtfwWord);
   {* ���������� ����� ������� string:--Len! }
 end;//TkwVarDecLen
 
 TkwVarInc = class(TtfwWordWorkerEx)
  {* ����� ������� string:++!
*������:*
[code]
 string:++! aVar
[code]  }
  procedure VarInc(const aCtx: TtfwContext;
   aVar: TtfwWord);
   {* ���������� ����� ������� string:++! }
 end;//TkwVarInc
 
 TkwRSplitTo = class(TtfwWordWorkerEx)
  {* ����� ������� string:RSplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:RSplitTo! aVar >>> l_Il3CString
[code]  }
  function RSplitTo(const aCtx: TtfwContext;
   aVar: TtfwWord;
   const aDelim: Il3CString): Il3CString;
   {* ���������� ����� ������� string:RSplitTo! }
 end;//TkwRSplitTo
 
 TkwVarShift = class(TtfwWordWorkerEx)
  {* ����� ������� string:+!
*������:*
[code]
 aNum string:+! aVar
[code]  }
  procedure VarShift(const aCtx: TtfwContext;
   aVar: TtfwWord;
   aNum: Integer);
   {* ���������� ����� ������� string:+! }
 end;//TkwVarShift
 
 TkwSplitTo = class(TtfwWordWorkerEx)
  {* ����� ������� string:SplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:SplitTo! aVar >>> l_Il3CString
[code]  }
  function SplitTo(const aCtx: TtfwContext;
   aVar: TtfwWord;
   const aDelim: Il3CString): Il3CString;
   {* ���������� ����� ������� string:SplitTo! }
 end;//TkwSplitTo
 
 TkwVarPushCharAndInc = class(TtfwWordWorkerEx)
  {* ����� ������� string:[]++!
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 string:[]++! aVar >>> l_Char
[code]  }
  function VarPushCharAndInc(const aCtx: TtfwContext;
   aVar: TtfwWord): AnsiChar;
   {* ���������� ����� ������� string:[]++! }
 end;//TkwVarPushCharAndInc
 
end.
