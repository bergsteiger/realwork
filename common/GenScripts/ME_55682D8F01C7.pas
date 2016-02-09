unit tfwIl3CStringPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
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
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
 //#UC START# *1C3B459FC59Bci*
 //#UC END# *1C3B459FC59Bci*
 //#UC START# *1C3B459FC59Bcit*
 //#UC END# *1C3B459FC59Bcit*
 TtfwIl3CStringPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *1C3B459FC59Bpubl*
 //#UC END# *1C3B459FC59Bpubl*
 end;//TtfwIl3CStringPackResNameGetter

 TkwStartsStr = {final} class(TtfwClassLike)
  {* ����� ������� StartsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsStr >>> l_Boolean
[code]  }
  private
   function StartsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* ���������� ����� ������� StartsStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStartsStr

 TkwStartsText = {final} class(TtfwClassLike)
  {* ����� ������� StartsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString StartsText >>> l_Boolean
[code]  }
  private
   function StartsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* ���������� ����� ������� StartsText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStartsText

 TkwEndsStr = {final} class(TtfwClassLike)
  {* ����� ������� EndsStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsStr >>> l_Boolean
[code]  }
  private
   function EndsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* ���������� ����� ������� EndsStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEndsStr

 TkwEndsText = {final} class(TtfwClassLike)
  {* ����� ������� EndsText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aSubStr aString EndsText >>> l_Boolean
[code]  }
  private
   function EndsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* ���������� ����� ������� EndsText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEndsText

 TkwSameStr = {final} class(TtfwClassLike)
  {* ����� ������� SameStr
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameStr >>> l_Boolean
[code]  }
  private
   function SameStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
    {* ���������� ����� ������� SameStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSameStr

 TkwSameText = {final} class(TtfwClassLike)
  {* ����� ������� SameText
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aString SameText >>> l_Boolean
[code]  }
  private
   function SameText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
    {* ���������� ����� ������� SameText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSameText

 TkwCompareStr = {final} class(TtfwClassLike)
  {* ����� ������� CompareStr
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareStr >>> l_Integer
[code]  }
  private
   function CompareStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* ���������� ����� ������� CompareStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompareStr

 TkwCompareText = {final} class(TtfwClassLike)
  {* ����� ������� CompareText
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString CompareText >>> l_Integer
[code]  }
  private
   function CompareText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* ���������� ����� ������� CompareText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompareText

 TkwStrToInt = {final} class(TtfwClassLike)
  {* ����� ������� StrToInt
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString StrToInt >>> l_Integer
[code]  }
  private
   function StrToInt(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* ���������� ����� ������� StrToInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStrToInt

 TkwCat = {final} class(TtfwClassLike)
  {* ����� ������� Cat
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 anOther aString Cat >>> l_Il3CString
[code]  }
  private
   function Cat(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Il3CString;
    {* ���������� ����� ������� Cat }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCat

 TkwStringConsistsOf = {final} class(TtfwClassLike)
  {* ����� ������� string:ConsistsOf
[panel]���������, ��� ������ aString ������� ������ �� �������� ������ aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:ConsistsOf >>> l_Boolean
[code]  }
  private
   function string_ConsistsOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
    {* ���������� ����� ������� string:ConsistsOf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringConsistsOf

 TkwStringHasAnyOf = {final} class(TtfwClassLike)
  {* ����� ������� string:HasAnyOf
[panel]���������, ��� ������ aString �������� ���� �� ���� ������ �� aDelims[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDelims aString string:HasAnyOf >>> l_Boolean
[code]  }
  private
   function string_HasAnyOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
    {* ���������� ����� ������� string:HasAnyOf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringHasAnyOf

 TkwStringPos = {final} class(TtfwClassLike)
  {* ����� ������� string:Pos
[panel]'���� ���� ���' '��' string:Pos .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aString string:Pos >>> l_Integer
[code]  }
  private
   function string_Pos(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* ���������� ����� ������� string:Pos }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringPos

 TkwStringPosEx = {final} class(TtfwClassLike)
  {* ����� ������� string:PosEx
[panel]6 '���� ���� ����' '��' string:PosEx .[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aPos anOther aString string:PosEx >>> l_Integer
[code]  }
  private
   function string_PosEx(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    aPos: Integer): Integer;
    {* ���������� ����� ������� string:PosEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringPosEx

 TkwStringSplit = {final} class(TtfwClassLike)
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
  private
   function string_Split(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    out theTail: Il3CString): Il3CString;
    {* ���������� ����� ������� string:Split }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSplit

 TkwStringReplace = {final} class(TtfwClassLike)
  {* ����� ������� string:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:Replace >>> l_Il3CString
[code]  }
  private
   function string_Replace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* ���������� ����� ������� string:Replace }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringReplace

 TkwStringReplaceFirst = {final} class(TtfwClassLike)
  {* ����� ������� string:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString string:ReplaceFirst >>> l_Il3CString
[code]  }
  private
   function string_ReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* ���������� ����� ������� string:ReplaceFirst }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringReplaceFirst

 TkwTextReplace = {final} class(TtfwClassLike)
  {* ����� ������� text:Replace
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:Replace >>> l_Il3CString
[code]  }
  private
   function text_Replace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* ���������� ����� ������� text:Replace }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextReplace

 TkwTextReplaceFirst = {final} class(TtfwClassLike)
  {* ����� ������� text:ReplaceFirst
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aMain aFrom aString text:ReplaceFirst >>> l_Il3CString
[code]  }
  private
   function text_ReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* ���������� ����� ������� text:ReplaceFirst }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextReplaceFirst

 TkwStringChar = {final} class(TtfwClassLike)
  {* ����� ������� string:[i]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 anIndex aString string:[i] >>> l_Char
[code]  }
  private
   function string_Char(const aCtx: TtfwContext;
    const aString: Il3CString;
    anIndex: Integer): AnsiChar;
    {* ���������� ����� ������� string:[i] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringChar

 TkwStringCodePage = {final} class(TtfwClassLike)
  {* ����� ������� string:CodePage
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:CodePage >>> l_Integer
[code]  }
  private
   function string_CodePage(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* ���������� ����� ������� string:CodePage }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringCodePage

 TkwStringLen = {final} class(TtfwClassLike)
  {* ����� ������� string:Len
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aString string:Len >>> l_Integer
[code]  }
  private
   function string_Len(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* ���������� ����� ������� string:Len }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringLen

 TkwStringToChar = {final} class(TtfwClassLike)
  {* ����� ������� string:ToChar
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:ToChar >>> l_Char
[code]  }
  private
   function string_ToChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
    {* ���������� ����� ������� string:ToChar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringToChar

 TkwCharToString = {final} class(TtfwRegisterableWord)
  {* ����� ������� char:ToString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aChar char:ToString >>> l_Il3CString
[code]  }
  private
   function char_ToString(const aCtx: TtfwContext;
    aChar: AnsiChar): Il3CString;
    {* ���������� ����� ������� char:ToString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCharToString

 TkwCharDupe = {final} class(TtfwClassLike)
  {* ����� ������� char:Dupe
[panel]���������� ������ ������� ���, ������� �������[panel]
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aCount aString char:Dupe >>> l_Il3CString
[code]  }
  private
   function char_Dupe(const aCtx: TtfwContext;
    const aString: Il3CString;
    aCount: Integer): Il3CString;
    {* ���������� ����� ������� char:Dupe }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCharDupe

 TkwStringInc = {final} class(TtfwClassLike)
  {* ����� ������� string:++
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:++ >>> l_Il3CString
[code]  }
  private
   function string_Inc(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:++ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringInc

 TkwStringShift = {final} class(TtfwClassLike)
  {* ����� ������� string:+
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelta aString string:+ >>> l_Il3CString
[code]  }
  private
   function string_Shift(const aCtx: TtfwContext;
    const aString: Il3CString;
    aDelta: Integer): Il3CString;
    {* ���������� ����� ������� string:+ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringShift

 TkwStringFirstChar = {final} class(TtfwClassLike)
  {* ����� ������� string:[]
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 aString string:[] >>> l_Char
[code]  }
  private
   function string_FirstChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
    {* ���������� ����� ������� string:[] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringFirstChar

 TkwStringTrim = {final} class(TtfwClassLike)
  {* ����� ������� string:Trim
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:Trim >>> l_Il3CString
[code]  }
  private
   function string_Trim(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:Trim }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrim

 TkwStringTrimLeft = {final} class(TtfwClassLike)
  {* ����� ������� string:TrimLeft
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:TrimLeft >>> l_Il3CString
[code]  }
  private
   function string_TrimLeft(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:TrimLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrimLeft

 TkwStringTrimRight = {final} class(TtfwClassLike)
  {* ����� ������� string:TrimRight
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:TrimRight >>> l_Il3CString
[code]  }
  private
   function string_TrimRight(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:TrimRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrimRight

 TkwStringDeleteDoubleSpaces = {final} class(TtfwClassLike)
  {* ����� ������� string:DeleteDoubleSpaces
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:DeleteDoubleSpaces >>> l_Il3CString
[code]  }
  private
   function string_DeleteDoubleSpaces(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:DeleteDoubleSpaces }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringDeleteDoubleSpaces

 TkwStringDeleteDoubleChars = {final} class(TtfwClassLike)
  {* ����� ������� string:DeleteDoubleChars
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aChar aString string:DeleteDoubleChars >>> l_Il3CString
[code]  }
  private
   function string_DeleteDoubleChars(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aChar: Il3CString): Il3CString;
    {* ���������� ����� ������� string:DeleteDoubleChars }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringDeleteDoubleChars

 TkwStringSubstring = {final} class(TtfwClassLike)
  {* ����� ������� string:Substring
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aLength aPos aString string:Substring >>> l_Il3CString
[code]  }
  private
   function string_Substring(const aCtx: TtfwContext;
    const aString: Il3CString;
    aPos: Integer;
    aLength: Integer): Il3CString;
    {* ���������� ����� ������� string:Substring }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSubstring

 TkwStringLower = {final} class(TtfwClassLike)
  {* ����� ������� string:Lower
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:Lower >>> l_Il3CString
[code]  }
  private
   function string_Lower(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:Lower }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringLower

 TkwStringUpper = {final} class(TtfwClassLike)
  {* ����� ������� string:Upper
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aString string:Upper >>> l_Il3CString
[code]  }
  private
   function string_Upper(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* ���������� ����� ������� string:Upper }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringUpper

 TkwVarDecLen = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:--Len!
*������:*
[code]
 string:--Len! aVar
[code]  }
  private
   procedure VarDecLen(const aCtx: TtfwContext;
    aVar: TtfwWord);
    {* ���������� ����� ������� string:--Len! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVarDecLen

 TkwVarInc = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:++!
*������:*
[code]
 string:++! aVar
[code]  }
  private
   procedure VarInc(const aCtx: TtfwContext;
    aVar: TtfwWord);
    {* ���������� ����� ������� string:++! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVarInc

 TkwRSplitTo = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:RSplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:RSplitTo! aVar >>> l_Il3CString
[code]  }
  private
   function RSplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
    {* ���������� ����� ������� string:RSplitTo! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRSplitTo

 TkwVarShift = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:+!
*������:*
[code]
 aNum string:+! aVar
[code]  }
  private
   procedure VarShift(const aCtx: TtfwContext;
    aVar: TtfwWord;
    aNum: Integer);
    {* ���������� ����� ������� string:+! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVarShift

 TkwSplitTo = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:SplitTo!
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aDelim string:SplitTo! aVar >>> l_Il3CString
[code]  }
  private
   function SplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
    {* ���������� ����� ������� string:SplitTo! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSplitTo

 TkwVarPushCharAndInc = {final} class(TtfwWordWorkerEx)
  {* ����� ������� string:[]++!
*��� ����������:* Char
*������:*
[code]
CHAR VAR l_Char
 string:[]++! aVar >>> l_Char
[code]  }
  private
   function VarPushCharAndInc(const aCtx: TtfwContext;
    aVar: TtfwWord): AnsiChar;
    {* ���������� ����� ������� string:[]++! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVarPushCharAndInc

class function TtfwIl3CStringPackResNameGetter.ResName: AnsiString;
begin
  Result := 'tfwIl3CStringPack';
end;//TtfwIl3CStringPackResNameGetter.ResName

 {$R tfwIl3CStringPack.res}

function TkwStartsStr.StartsStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* ���������� ����� ������� StartsStr }
//#UC START# *ADBAC1D0C450_0093B3082714_var*
//#UC END# *ADBAC1D0C450_0093B3082714_var*
begin
//#UC START# *ADBAC1D0C450_0093B3082714_impl*
 Result := l3Starts(aSubStr, aString, false);
//#UC END# *ADBAC1D0C450_0093B3082714_impl*
end;//TkwStartsStr.StartsStr

procedure TkwStartsStr.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0093B3082714_var*
//#UC END# *4DAEEDE10285_0093B3082714_var*
begin
//#UC START# *4DAEEDE10285_0093B3082714_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0093B3082714_impl*
end;//TkwStartsStr.DoDoIt

class function TkwStartsStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartsStr';
end;//TkwStartsStr.GetWordNameForRegister

function TkwStartsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStartsStr.GetResultTypeInfo

function TkwStartsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStartsStr.GetAllParamsCount

function TkwStartsStr.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0093B3082714_var*
//#UC END# *5617F4D00243_0093B3082714_var*
begin
//#UC START# *5617F4D00243_0093B3082714_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0093B3082714_impl*
end;//TkwStartsStr.ParamsTypes

function TkwStartsText.StartsText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* ���������� ����� ������� StartsText }
//#UC START# *2B44D7EFA4A8_9996D7566EDE_var*
//#UC END# *2B44D7EFA4A8_9996D7566EDE_var*
begin
//#UC START# *2B44D7EFA4A8_9996D7566EDE_impl*
 Result := l3Starts(aSubStr, aString, true);
//#UC END# *2B44D7EFA4A8_9996D7566EDE_impl*
end;//TkwStartsText.StartsText

procedure TkwStartsText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9996D7566EDE_var*
//#UC END# *4DAEEDE10285_9996D7566EDE_var*
begin
//#UC START# *4DAEEDE10285_9996D7566EDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9996D7566EDE_impl*
end;//TkwStartsText.DoDoIt

class function TkwStartsText.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartsText';
end;//TkwStartsText.GetWordNameForRegister

function TkwStartsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStartsText.GetResultTypeInfo

function TkwStartsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStartsText.GetAllParamsCount

function TkwStartsText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9996D7566EDE_var*
//#UC END# *5617F4D00243_9996D7566EDE_var*
begin
//#UC START# *5617F4D00243_9996D7566EDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9996D7566EDE_impl*
end;//TkwStartsText.ParamsTypes

function TkwEndsStr.EndsStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* ���������� ����� ������� EndsStr }
//#UC START# *E58966F67546_397C461D6C30_var*
//#UC END# *E58966F67546_397C461D6C30_var*
begin
//#UC START# *E58966F67546_397C461D6C30_impl*
 Result := l3Ends(aSubStr, aString, false);
//#UC END# *E58966F67546_397C461D6C30_impl*
end;//TkwEndsStr.EndsStr

procedure TkwEndsStr.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_397C461D6C30_var*
//#UC END# *4DAEEDE10285_397C461D6C30_var*
begin
//#UC START# *4DAEEDE10285_397C461D6C30_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_397C461D6C30_impl*
end;//TkwEndsStr.DoDoIt

class function TkwEndsStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndsStr';
end;//TkwEndsStr.GetWordNameForRegister

function TkwEndsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwEndsStr.GetResultTypeInfo

function TkwEndsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwEndsStr.GetAllParamsCount

function TkwEndsStr.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_397C461D6C30_var*
//#UC END# *5617F4D00243_397C461D6C30_var*
begin
//#UC START# *5617F4D00243_397C461D6C30_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_397C461D6C30_impl*
end;//TkwEndsStr.ParamsTypes

function TkwEndsText.EndsText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* ���������� ����� ������� EndsText }
//#UC START# *187F940B5F16_8997C15C6CA8_var*
//#UC END# *187F940B5F16_8997C15C6CA8_var*
begin
//#UC START# *187F940B5F16_8997C15C6CA8_impl*
 Result := l3Ends(aSubStr, aString, true);
//#UC END# *187F940B5F16_8997C15C6CA8_impl*
end;//TkwEndsText.EndsText

procedure TkwEndsText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8997C15C6CA8_var*
//#UC END# *4DAEEDE10285_8997C15C6CA8_var*
begin
//#UC START# *4DAEEDE10285_8997C15C6CA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8997C15C6CA8_impl*
end;//TkwEndsText.DoDoIt

class function TkwEndsText.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndsText';
end;//TkwEndsText.GetWordNameForRegister

function TkwEndsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwEndsText.GetResultTypeInfo

function TkwEndsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwEndsText.GetAllParamsCount

function TkwEndsText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8997C15C6CA8_var*
//#UC END# *5617F4D00243_8997C15C6CA8_var*
begin
//#UC START# *5617F4D00243_8997C15C6CA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8997C15C6CA8_impl*
end;//TkwEndsText.ParamsTypes

function TkwSameStr.SameStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Boolean;
 {* ���������� ����� ������� SameStr }
//#UC START# *4D25C99A6BEB_2309401B7CC1_var*
//#UC END# *4D25C99A6BEB_2309401B7CC1_var*
begin
//#UC START# *4D25C99A6BEB_2309401B7CC1_impl*
 Result := l3Same(aString, anOther, false);
//#UC END# *4D25C99A6BEB_2309401B7CC1_impl*
end;//TkwSameStr.SameStr

procedure TkwSameStr.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2309401B7CC1_var*
//#UC END# *4DAEEDE10285_2309401B7CC1_var*
begin
//#UC START# *4DAEEDE10285_2309401B7CC1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2309401B7CC1_impl*
end;//TkwSameStr.DoDoIt

class function TkwSameStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'SameStr';
end;//TkwSameStr.GetWordNameForRegister

function TkwSameStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwSameStr.GetResultTypeInfo

function TkwSameStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSameStr.GetAllParamsCount

function TkwSameStr.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2309401B7CC1_var*
//#UC END# *5617F4D00243_2309401B7CC1_var*
begin
//#UC START# *5617F4D00243_2309401B7CC1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2309401B7CC1_impl*
end;//TkwSameStr.ParamsTypes

function TkwSameText.SameText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Boolean;
 {* ���������� ����� ������� SameText }
//#UC START# *883992DDC504_9FC28ACB9AA1_var*
//#UC END# *883992DDC504_9FC28ACB9AA1_var*
begin
//#UC START# *883992DDC504_9FC28ACB9AA1_impl*
 Result := l3Same(aString, anOther, true);
//#UC END# *883992DDC504_9FC28ACB9AA1_impl*
end;//TkwSameText.SameText

procedure TkwSameText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9FC28ACB9AA1_var*
//#UC END# *4DAEEDE10285_9FC28ACB9AA1_var*
begin
//#UC START# *4DAEEDE10285_9FC28ACB9AA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9FC28ACB9AA1_impl*
end;//TkwSameText.DoDoIt

class function TkwSameText.GetWordNameForRegister: AnsiString;
begin
 Result := 'SameText';
end;//TkwSameText.GetWordNameForRegister

function TkwSameText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwSameText.GetResultTypeInfo

function TkwSameText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSameText.GetAllParamsCount

function TkwSameText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9FC28ACB9AA1_var*
//#UC END# *5617F4D00243_9FC28ACB9AA1_var*
begin
//#UC START# *5617F4D00243_9FC28ACB9AA1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9FC28ACB9AA1_impl*
end;//TkwSameText.ParamsTypes

function TkwCompareStr.CompareStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* ���������� ����� ������� CompareStr }
//#UC START# *60E71D4C9014_C670925F6482_var*
//#UC END# *60E71D4C9014_C670925F6482_var*
begin
//#UC START# *60E71D4C9014_C670925F6482_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString));
//#UC END# *60E71D4C9014_C670925F6482_impl*
end;//TkwCompareStr.CompareStr

procedure TkwCompareStr.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C670925F6482_var*
//#UC END# *4DAEEDE10285_C670925F6482_var*
begin
//#UC START# *4DAEEDE10285_C670925F6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C670925F6482_impl*
end;//TkwCompareStr.DoDoIt

class function TkwCompareStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompareStr';
end;//TkwCompareStr.GetWordNameForRegister

function TkwCompareStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwCompareStr.GetResultTypeInfo

function TkwCompareStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCompareStr.GetAllParamsCount

function TkwCompareStr.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C670925F6482_var*
//#UC END# *5617F4D00243_C670925F6482_var*
begin
//#UC START# *5617F4D00243_C670925F6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C670925F6482_impl*
end;//TkwCompareStr.ParamsTypes

function TkwCompareText.CompareText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* ���������� ����� ������� CompareText }
//#UC START# *53DA3FC40405_0E02A0729BA6_var*
//#UC END# *53DA3FC40405_0E02A0729BA6_var*
begin
//#UC START# *53DA3FC40405_0E02A0729BA6_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString), l3_siCaseUnsensitive);
//#UC END# *53DA3FC40405_0E02A0729BA6_impl*
end;//TkwCompareText.CompareText

procedure TkwCompareText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0E02A0729BA6_var*
//#UC END# *4DAEEDE10285_0E02A0729BA6_var*
begin
//#UC START# *4DAEEDE10285_0E02A0729BA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0E02A0729BA6_impl*
end;//TkwCompareText.DoDoIt

class function TkwCompareText.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompareText';
end;//TkwCompareText.GetWordNameForRegister

function TkwCompareText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwCompareText.GetResultTypeInfo

function TkwCompareText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCompareText.GetAllParamsCount

function TkwCompareText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0E02A0729BA6_var*
//#UC END# *5617F4D00243_0E02A0729BA6_var*
begin
//#UC START# *5617F4D00243_0E02A0729BA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0E02A0729BA6_impl*
end;//TkwCompareText.ParamsTypes

function TkwStrToInt.StrToInt(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* ���������� ����� ������� StrToInt }
//#UC START# *108F78D959BF_09008856C703_var*
//#UC END# *108F78D959BF_09008856C703_var*
begin
//#UC START# *108F78D959BF_09008856C703_impl*
 Result := SysUtils.StrToInt(l3Str(aString));
//#UC END# *108F78D959BF_09008856C703_impl*
end;//TkwStrToInt.StrToInt

procedure TkwStrToInt.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_09008856C703_var*
//#UC END# *4DAEEDE10285_09008856C703_var*
begin
//#UC START# *4DAEEDE10285_09008856C703_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_09008856C703_impl*
end;//TkwStrToInt.DoDoIt

class function TkwStrToInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'StrToInt';
end;//TkwStrToInt.GetWordNameForRegister

function TkwStrToInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStrToInt.GetResultTypeInfo

function TkwStrToInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStrToInt.GetAllParamsCount

function TkwStrToInt.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_09008856C703_var*
//#UC END# *5617F4D00243_09008856C703_var*
begin
//#UC START# *5617F4D00243_09008856C703_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_09008856C703_impl*
end;//TkwStrToInt.ParamsTypes

function TkwCat.Cat(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Il3CString;
 {* ���������� ����� ������� Cat }
//#UC START# *0AEEC1805BCE_DD57CECF347C_var*
//#UC END# *0AEEC1805BCE_DD57CECF347C_var*
begin
//#UC START# *0AEEC1805BCE_DD57CECF347C_impl*
 Result := TtfwCStringFactory.Cat(anOther, aString);
//#UC END# *0AEEC1805BCE_DD57CECF347C_impl*
end;//TkwCat.Cat

procedure TkwCat.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD57CECF347C_var*
//#UC END# *4DAEEDE10285_DD57CECF347C_var*
begin
//#UC START# *4DAEEDE10285_DD57CECF347C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD57CECF347C_impl*
end;//TkwCat.DoDoIt

class function TkwCat.GetWordNameForRegister: AnsiString;
begin
 Result := 'Cat';
end;//TkwCat.GetWordNameForRegister

function TkwCat.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwCat.GetResultTypeInfo

function TkwCat.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCat.GetAllParamsCount

function TkwCat.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DD57CECF347C_var*
//#UC END# *5617F4D00243_DD57CECF347C_var*
begin
//#UC START# *5617F4D00243_DD57CECF347C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DD57CECF347C_impl*
end;//TkwCat.ParamsTypes

function TkwStringConsistsOf.string_ConsistsOf(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aDelims: Il3CString): Boolean;
 {* ���������� ����� ������� string:ConsistsOf }
//#UC START# *C17F9AF1604A_5F306006344B_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *C17F9AF1604A_5F306006344B_var*
begin
//#UC START# *C17F9AF1604A_5F306006344B_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := l3IsNil(l_S2)
  // - ����� �������� �� ����� �������� ������ �� �������� ������� ��������� 
 else
 if (l_S1.SLen = 1) then
  Result := l3AllCharsInCharSet(l_S2, [l_S1.S[0]])
 else
 begin
  l_C := [];
  for l_Index := 0 to Pred(l_S1.SLen) do
   l_C := l_C + [l_S1.S[l_Index]];
  Result := l3AllCharsInCharSet(l_S2, l_C);
 end;//l_S1.SLen = 1
//#UC END# *C17F9AF1604A_5F306006344B_impl*
end;//TkwStringConsistsOf.string_ConsistsOf

procedure TkwStringConsistsOf.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5F306006344B_var*
//#UC END# *4DAEEDE10285_5F306006344B_var*
begin
//#UC START# *4DAEEDE10285_5F306006344B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5F306006344B_impl*
end;//TkwStringConsistsOf.DoDoIt

class function TkwStringConsistsOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ConsistsOf';
end;//TkwStringConsistsOf.GetWordNameForRegister

function TkwStringConsistsOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringConsistsOf.GetResultTypeInfo

function TkwStringConsistsOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringConsistsOf.GetAllParamsCount

function TkwStringConsistsOf.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5F306006344B_var*
//#UC END# *5617F4D00243_5F306006344B_var*
begin
//#UC START# *5617F4D00243_5F306006344B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5F306006344B_impl*
end;//TkwStringConsistsOf.ParamsTypes

function TkwStringHasAnyOf.string_HasAnyOf(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aDelims: Il3CString): Boolean;
 {* ���������� ����� ������� string:HasAnyOf }
//#UC START# *4E5E3C364C71_2256016890B3_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *4E5E3C364C71_2256016890B3_var*
begin
//#UC START# *4E5E3C364C71_2256016890B3_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := true
  // - ����� ������ �������� ������� �� ������� ���������, ������� ���
 else
 if (l_S1.SLen = 1) then
  Result := l3CharSetPresent(l_S2, [l_S1.S[0]])
 else
 begin
  l_C := [];
  for l_Index := 0 to Pred(l_S1.SLen) do
   l_C := l_C + [l_S1.S[l_Index]];
  Result := l3CharSetPresent(l_S2, l_C);
 end;//l_S1.SLen = 1
//#UC END# *4E5E3C364C71_2256016890B3_impl*
end;//TkwStringHasAnyOf.string_HasAnyOf

procedure TkwStringHasAnyOf.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2256016890B3_var*
//#UC END# *4DAEEDE10285_2256016890B3_var*
begin
//#UC START# *4DAEEDE10285_2256016890B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2256016890B3_impl*
end;//TkwStringHasAnyOf.DoDoIt

class function TkwStringHasAnyOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:HasAnyOf';
end;//TkwStringHasAnyOf.GetWordNameForRegister

function TkwStringHasAnyOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringHasAnyOf.GetResultTypeInfo

function TkwStringHasAnyOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringHasAnyOf.GetAllParamsCount

function TkwStringHasAnyOf.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2256016890B3_var*
//#UC END# *5617F4D00243_2256016890B3_var*
begin
//#UC START# *5617F4D00243_2256016890B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2256016890B3_impl*
end;//TkwStringHasAnyOf.ParamsTypes

function TkwStringPos.string_Pos(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* ���������� ����� ������� string:Pos }
//#UC START# *A3206F78A2FD_851E99BEB53B_var*
//#UC END# *A3206F78A2FD_851E99BEB53B_var*
begin
//#UC START# *A3206F78A2FD_851E99BEB53B_impl*
 Result := l3Pos(anOther, aString);
//#UC END# *A3206F78A2FD_851E99BEB53B_impl*
end;//TkwStringPos.string_Pos

procedure TkwStringPos.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_851E99BEB53B_var*
//#UC END# *4DAEEDE10285_851E99BEB53B_var*
begin
//#UC START# *4DAEEDE10285_851E99BEB53B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_851E99BEB53B_impl*
end;//TkwStringPos.DoDoIt

class function TkwStringPos.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Pos';
end;//TkwStringPos.GetWordNameForRegister

function TkwStringPos.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringPos.GetResultTypeInfo

function TkwStringPos.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringPos.GetAllParamsCount

function TkwStringPos.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_851E99BEB53B_var*
//#UC END# *5617F4D00243_851E99BEB53B_var*
begin
//#UC START# *5617F4D00243_851E99BEB53B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_851E99BEB53B_impl*
end;//TkwStringPos.ParamsTypes

function TkwStringPosEx.string_PosEx(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString;
 aPos: Integer): Integer;
 {* ���������� ����� ������� string:PosEx }
//#UC START# *F7FE00F8B33E_24901BF384F4_var*
//#UC END# *F7FE00F8B33E_24901BF384F4_var*
begin
//#UC START# *F7FE00F8B33E_24901BF384F4_impl*
 Result := l3PosEx(anOther, aString, aPos);
//#UC END# *F7FE00F8B33E_24901BF384F4_impl*
end;//TkwStringPosEx.string_PosEx

procedure TkwStringPosEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_24901BF384F4_var*
//#UC END# *4DAEEDE10285_24901BF384F4_var*
begin
//#UC START# *4DAEEDE10285_24901BF384F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_24901BF384F4_impl*
end;//TkwStringPosEx.DoDoIt

class function TkwStringPosEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:PosEx';
end;//TkwStringPosEx.GetWordNameForRegister

function TkwStringPosEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringPosEx.GetResultTypeInfo

function TkwStringPosEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringPosEx.GetAllParamsCount

function TkwStringPosEx.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_24901BF384F4_var*
//#UC END# *5617F4D00243_24901BF384F4_var*
begin
//#UC START# *5617F4D00243_24901BF384F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_24901BF384F4_impl*
end;//TkwStringPosEx.ParamsTypes

function TkwStringSplit.string_Split(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString;
 out theTail: Il3CString): Il3CString;
 {* ���������� ����� ������� string:Split }
//#UC START# *2D11D07B402C_AA63BC1F51EC_var*
var
(* l_P : Il3CString;
 l_S : Il3CString;*)
 l_Len : Integer;
//#UC END# *2D11D07B402C_AA63BC1F51EC_var*
begin
//#UC START# *2D11D07B402C_AA63BC1F51EC_impl*
 l_Len := l3Len(aString);
 if (l_Len = 1) then
  l3Split(anOther, l3Char(aString, 0), Result, theTail)
 else
  l3Split(anOther, aString, Result, theTail);
(* if (l_Len = 1) then
  l3Split(anOther, l3Char(aString, 0), l_P, l_S)
 else
  l3Split(anOther, aString, l_P, l_S);
 aCtx.rEngine.PushString(l_P);
 aCtx.rEngine.PushString(l_S);*)
//#UC END# *2D11D07B402C_AA63BC1F51EC_impl*
end;//TkwStringSplit.string_Split

procedure TkwStringSplit.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AA63BC1F51EC_var*
//#UC END# *4DAEEDE10285_AA63BC1F51EC_var*
begin
//#UC START# *4DAEEDE10285_AA63BC1F51EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AA63BC1F51EC_impl*
end;//TkwStringSplit.DoDoIt

class function TkwStringSplit.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Split';
end;//TkwStringSplit.GetWordNameForRegister

function TkwStringSplit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringSplit.GetResultTypeInfo

function TkwStringSplit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringSplit.GetAllParamsCount

function TkwStringSplit.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AA63BC1F51EC_var*
//#UC END# *5617F4D00243_AA63BC1F51EC_var*
begin
//#UC START# *5617F4D00243_AA63BC1F51EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AA63BC1F51EC_impl*
end;//TkwStringSplit.ParamsTypes

function TkwStringReplace.string_Replace(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* ���������� ����� ������� string:Replace }
//#UC START# *DD442A0F03CD_8CA688C2805E_var*
//#UC END# *DD442A0F03CD_8CA688C2805E_var*
begin
//#UC START# *DD442A0F03CD_8CA688C2805E_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll])
//#UC END# *DD442A0F03CD_8CA688C2805E_impl*
end;//TkwStringReplace.string_Replace

procedure TkwStringReplace.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8CA688C2805E_var*
//#UC END# *4DAEEDE10285_8CA688C2805E_var*
begin
//#UC START# *4DAEEDE10285_8CA688C2805E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8CA688C2805E_impl*
end;//TkwStringReplace.DoDoIt

class function TkwStringReplace.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Replace';
end;//TkwStringReplace.GetWordNameForRegister

function TkwStringReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringReplace.GetResultTypeInfo

function TkwStringReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringReplace.GetAllParamsCount

function TkwStringReplace.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8CA688C2805E_var*
//#UC END# *5617F4D00243_8CA688C2805E_var*
begin
//#UC START# *5617F4D00243_8CA688C2805E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8CA688C2805E_impl*
end;//TkwStringReplace.ParamsTypes

function TkwStringReplaceFirst.string_ReplaceFirst(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* ���������� ����� ������� string:ReplaceFirst }
//#UC START# *9B83E2E03D3D_FF1E0A42BBEF_var*
//#UC END# *9B83E2E03D3D_FF1E0A42BBEF_var*
begin
//#UC START# *9B83E2E03D3D_FF1E0A42BBEF_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll}])
//#UC END# *9B83E2E03D3D_FF1E0A42BBEF_impl*
end;//TkwStringReplaceFirst.string_ReplaceFirst

procedure TkwStringReplaceFirst.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF1E0A42BBEF_var*
//#UC END# *4DAEEDE10285_FF1E0A42BBEF_var*
begin
//#UC START# *4DAEEDE10285_FF1E0A42BBEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF1E0A42BBEF_impl*
end;//TkwStringReplaceFirst.DoDoIt

class function TkwStringReplaceFirst.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ReplaceFirst';
end;//TkwStringReplaceFirst.GetWordNameForRegister

function TkwStringReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringReplaceFirst.GetResultTypeInfo

function TkwStringReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringReplaceFirst.GetAllParamsCount

function TkwStringReplaceFirst.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FF1E0A42BBEF_var*
//#UC END# *5617F4D00243_FF1E0A42BBEF_var*
begin
//#UC START# *5617F4D00243_FF1E0A42BBEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FF1E0A42BBEF_impl*
end;//TkwStringReplaceFirst.ParamsTypes

function TkwTextReplace.text_Replace(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* ���������� ����� ������� text:Replace }
//#UC START# *77C319AE08A3_6F240EDBC3AE_var*
//#UC END# *77C319AE08A3_6F240EDBC3AE_var*
begin
//#UC START# *77C319AE08A3_6F240EDBC3AE_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll, rfIgnoreCase])
//#UC END# *77C319AE08A3_6F240EDBC3AE_impl*
end;//TkwTextReplace.text_Replace

procedure TkwTextReplace.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6F240EDBC3AE_var*
//#UC END# *4DAEEDE10285_6F240EDBC3AE_var*
begin
//#UC START# *4DAEEDE10285_6F240EDBC3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6F240EDBC3AE_impl*
end;//TkwTextReplace.DoDoIt

class function TkwTextReplace.GetWordNameForRegister: AnsiString;
begin
 Result := 'text:Replace';
end;//TkwTextReplace.GetWordNameForRegister

function TkwTextReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwTextReplace.GetResultTypeInfo

function TkwTextReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTextReplace.GetAllParamsCount

function TkwTextReplace.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6F240EDBC3AE_var*
//#UC END# *5617F4D00243_6F240EDBC3AE_var*
begin
//#UC START# *5617F4D00243_6F240EDBC3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6F240EDBC3AE_impl*
end;//TkwTextReplace.ParamsTypes

function TkwTextReplaceFirst.text_ReplaceFirst(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* ���������� ����� ������� text:ReplaceFirst }
//#UC START# *C0B325EEBDF3_0527F8C9DF24_var*
//#UC END# *C0B325EEBDF3_0527F8C9DF24_var*
begin
//#UC START# *C0B325EEBDF3_0527F8C9DF24_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll,} rfIgnoreCase])
//#UC END# *C0B325EEBDF3_0527F8C9DF24_impl*
end;//TkwTextReplaceFirst.text_ReplaceFirst

procedure TkwTextReplaceFirst.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0527F8C9DF24_var*
//#UC END# *4DAEEDE10285_0527F8C9DF24_var*
begin
//#UC START# *4DAEEDE10285_0527F8C9DF24_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0527F8C9DF24_impl*
end;//TkwTextReplaceFirst.DoDoIt

class function TkwTextReplaceFirst.GetWordNameForRegister: AnsiString;
begin
 Result := 'text:ReplaceFirst';
end;//TkwTextReplaceFirst.GetWordNameForRegister

function TkwTextReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwTextReplaceFirst.GetResultTypeInfo

function TkwTextReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTextReplaceFirst.GetAllParamsCount

function TkwTextReplaceFirst.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0527F8C9DF24_var*
//#UC END# *5617F4D00243_0527F8C9DF24_var*
begin
//#UC START# *5617F4D00243_0527F8C9DF24_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0527F8C9DF24_impl*
end;//TkwTextReplaceFirst.ParamsTypes

function TkwStringChar.string_Char(const aCtx: TtfwContext;
 const aString: Il3CString;
 anIndex: Integer): AnsiChar;
 {* ���������� ����� ������� string:[i] }
//#UC START# *46139320DD2A_9597582C9BD4_var*
//#UC END# *46139320DD2A_9597582C9BD4_var*
begin
//#UC START# *46139320DD2A_9597582C9BD4_impl*
 Result := aString.AsWStr.S[anIndex];
//#UC END# *46139320DD2A_9597582C9BD4_impl*
end;//TkwStringChar.string_Char

procedure TkwStringChar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9597582C9BD4_var*
//#UC END# *4DAEEDE10285_9597582C9BD4_var*
begin
//#UC START# *4DAEEDE10285_9597582C9BD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9597582C9BD4_impl*
end;//TkwStringChar.DoDoIt

class function TkwStringChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[i]';
end;//TkwStringChar.GetWordNameForRegister

function TkwStringChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringChar.GetResultTypeInfo

function TkwStringChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringChar.GetAllParamsCount

function TkwStringChar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9597582C9BD4_var*
//#UC END# *5617F4D00243_9597582C9BD4_var*
begin
//#UC START# *5617F4D00243_9597582C9BD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9597582C9BD4_impl*
end;//TkwStringChar.ParamsTypes

function TkwStringCodePage.string_CodePage(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* ���������� ����� ������� string:CodePage }
//#UC START# *6C0D8D8B8728_6CAF85926E0C_var*
//#UC END# *6C0D8D8B8728_6CAF85926E0C_var*
begin
//#UC START# *6C0D8D8B8728_6CAF85926E0C_impl*
 Result := aString.AsWStr.SCodePage;
//#UC END# *6C0D8D8B8728_6CAF85926E0C_impl*
end;//TkwStringCodePage.string_CodePage

procedure TkwStringCodePage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6CAF85926E0C_var*
//#UC END# *4DAEEDE10285_6CAF85926E0C_var*
begin
//#UC START# *4DAEEDE10285_6CAF85926E0C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6CAF85926E0C_impl*
end;//TkwStringCodePage.DoDoIt

class function TkwStringCodePage.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:CodePage';
end;//TkwStringCodePage.GetWordNameForRegister

function TkwStringCodePage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringCodePage.GetResultTypeInfo

function TkwStringCodePage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringCodePage.GetAllParamsCount

function TkwStringCodePage.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6CAF85926E0C_var*
//#UC END# *5617F4D00243_6CAF85926E0C_var*
begin
//#UC START# *5617F4D00243_6CAF85926E0C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6CAF85926E0C_impl*
end;//TkwStringCodePage.ParamsTypes

function TkwStringLen.string_Len(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* ���������� ����� ������� string:Len }
//#UC START# *1D5A300A0055_0BA6E62BEF84_var*
//#UC END# *1D5A300A0055_0BA6E62BEF84_var*
begin
//#UC START# *1D5A300A0055_0BA6E62BEF84_impl*
 if (aString = nil) then
  Result := 0
 else
  Result := aString.AsWStr.SLen;
//#UC END# *1D5A300A0055_0BA6E62BEF84_impl*
end;//TkwStringLen.string_Len

procedure TkwStringLen.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0BA6E62BEF84_var*
//#UC END# *4DAEEDE10285_0BA6E62BEF84_var*
begin
//#UC START# *4DAEEDE10285_0BA6E62BEF84_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0BA6E62BEF84_impl*
end;//TkwStringLen.DoDoIt

class function TkwStringLen.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Len';
end;//TkwStringLen.GetWordNameForRegister

function TkwStringLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringLen.GetResultTypeInfo

function TkwStringLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringLen.GetAllParamsCount

function TkwStringLen.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0BA6E62BEF84_var*
//#UC END# *5617F4D00243_0BA6E62BEF84_var*
begin
//#UC START# *5617F4D00243_0BA6E62BEF84_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0BA6E62BEF84_impl*
end;//TkwStringLen.ParamsTypes

function TkwStringToChar.string_ToChar(const aCtx: TtfwContext;
 const aString: Il3CString): AnsiChar;
 {* ���������� ����� ������� string:ToChar }
//#UC START# *3F9E9C8EDF9E_CA33F456975C_var*
//#UC END# *3F9E9C8EDF9E_CA33F456975C_var*
begin
//#UC START# *3F9E9C8EDF9E_CA33F456975C_impl*
 RunnerAssert(aString.AsWStr.SLen = 1, '����� ������ ������ ��������� 1', aCtx);
 Result := aString.AsWStr.S[0];
//#UC END# *3F9E9C8EDF9E_CA33F456975C_impl*
end;//TkwStringToChar.string_ToChar

procedure TkwStringToChar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CA33F456975C_var*
//#UC END# *4DAEEDE10285_CA33F456975C_var*
begin
//#UC START# *4DAEEDE10285_CA33F456975C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CA33F456975C_impl*
end;//TkwStringToChar.DoDoIt

class function TkwStringToChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ToChar';
end;//TkwStringToChar.GetWordNameForRegister

function TkwStringToChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringToChar.GetResultTypeInfo

function TkwStringToChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringToChar.GetAllParamsCount

function TkwStringToChar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CA33F456975C_var*
//#UC END# *5617F4D00243_CA33F456975C_var*
begin
//#UC START# *5617F4D00243_CA33F456975C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CA33F456975C_impl*
end;//TkwStringToChar.ParamsTypes

function TkwCharToString.char_ToString(const aCtx: TtfwContext;
 aChar: AnsiChar): Il3CString;
 {* ���������� ����� ������� char:ToString }
//#UC START# *E29B58F41653_4C3CAF64FEF3_var*
//#UC END# *E29B58F41653_4C3CAF64FEF3_var*
begin
//#UC START# *E29B58F41653_4C3CAF64FEF3_impl*
 Result := TtfwCStringFactory.C(aChar);
//#UC END# *E29B58F41653_4C3CAF64FEF3_impl*
end;//TkwCharToString.char_ToString

procedure TkwCharToString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C3CAF64FEF3_var*
//#UC END# *4DAEEDE10285_4C3CAF64FEF3_var*
begin
//#UC START# *4DAEEDE10285_4C3CAF64FEF3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C3CAF64FEF3_impl*
end;//TkwCharToString.DoDoIt

class function TkwCharToString.GetWordNameForRegister: AnsiString;
begin
 Result := 'char:ToString';
end;//TkwCharToString.GetWordNameForRegister

function TkwCharToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := !!!;
end;//TkwCharToString.GetResultTypeInfo

function TkwCharToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCharToString.GetAllParamsCount

function TkwCharToString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4C3CAF64FEF3_var*
//#UC END# *5617F4D00243_4C3CAF64FEF3_var*
begin
//#UC START# *5617F4D00243_4C3CAF64FEF3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4C3CAF64FEF3_impl*
end;//TkwCharToString.ParamsTypes

function TkwCharDupe.char_Dupe(const aCtx: TtfwContext;
 const aString: Il3CString;
 aCount: Integer): Il3CString;
 {* ���������� ����� ������� char:Dupe }
//#UC START# *E230CFBF78A9_355A8C3D70FA_var*
//#UC END# *E230CFBF78A9_355A8C3D70FA_var*
begin
//#UC START# *E230CFBF78A9_355A8C3D70FA_impl*
 Result := TtfwCStringFactory.C(ev_psFixLen('', aCount, l3Char(aString, 0)));
//#UC END# *E230CFBF78A9_355A8C3D70FA_impl*
end;//TkwCharDupe.char_Dupe

procedure TkwCharDupe.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_355A8C3D70FA_var*
//#UC END# *4DAEEDE10285_355A8C3D70FA_var*
begin
//#UC START# *4DAEEDE10285_355A8C3D70FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_355A8C3D70FA_impl*
end;//TkwCharDupe.DoDoIt

class function TkwCharDupe.GetWordNameForRegister: AnsiString;
begin
 Result := 'char:Dupe';
end;//TkwCharDupe.GetWordNameForRegister

function TkwCharDupe.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwCharDupe.GetResultTypeInfo

function TkwCharDupe.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCharDupe.GetAllParamsCount

function TkwCharDupe.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_355A8C3D70FA_var*
//#UC END# *5617F4D00243_355A8C3D70FA_var*
begin
//#UC START# *5617F4D00243_355A8C3D70FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_355A8C3D70FA_impl*
end;//TkwCharDupe.ParamsTypes

function TkwStringInc.string_Inc(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:++ }
//#UC START# *FF3E231E9FA3_F3116B965978_var*
var
 l_P : Tl3PCharLen;
//#UC END# *FF3E231E9FA3_F3116B965978_var*
begin
//#UC START# *FF3E231E9FA3_F3116B965978_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(+1);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *FF3E231E9FA3_F3116B965978_impl*
end;//TkwStringInc.string_Inc

procedure TkwStringInc.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F3116B965978_var*
//#UC END# *4DAEEDE10285_F3116B965978_var*
begin
//#UC START# *4DAEEDE10285_F3116B965978_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F3116B965978_impl*
end;//TkwStringInc.DoDoIt

class function TkwStringInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:++';
end;//TkwStringInc.GetWordNameForRegister

function TkwStringInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringInc.GetResultTypeInfo

function TkwStringInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringInc.GetAllParamsCount

function TkwStringInc.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F3116B965978_var*
//#UC END# *5617F4D00243_F3116B965978_var*
begin
//#UC START# *5617F4D00243_F3116B965978_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F3116B965978_impl*
end;//TkwStringInc.ParamsTypes

function TkwStringShift.string_Shift(const aCtx: TtfwContext;
 const aString: Il3CString;
 aDelta: Integer): Il3CString;
 {* ���������� ����� ������� string:+ }
//#UC START# *89A4BEF62C61_EFB7A59A9041_var*
var
 l_P : Tl3PCharLen;
//#UC END# *89A4BEF62C61_EFB7A59A9041_var*
begin
//#UC START# *89A4BEF62C61_EFB7A59A9041_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(aDelta);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *89A4BEF62C61_EFB7A59A9041_impl*
end;//TkwStringShift.string_Shift

procedure TkwStringShift.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EFB7A59A9041_var*
//#UC END# *4DAEEDE10285_EFB7A59A9041_var*
begin
//#UC START# *4DAEEDE10285_EFB7A59A9041_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EFB7A59A9041_impl*
end;//TkwStringShift.DoDoIt

class function TkwStringShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:+';
end;//TkwStringShift.GetWordNameForRegister

function TkwStringShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringShift.GetResultTypeInfo

function TkwStringShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringShift.GetAllParamsCount

function TkwStringShift.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EFB7A59A9041_var*
//#UC END# *5617F4D00243_EFB7A59A9041_var*
begin
//#UC START# *5617F4D00243_EFB7A59A9041_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EFB7A59A9041_impl*
end;//TkwStringShift.ParamsTypes

function TkwStringFirstChar.string_FirstChar(const aCtx: TtfwContext;
 const aString: Il3CString): AnsiChar;
 {* ���������� ����� ������� string:[] }
//#UC START# *16E4F9B79ECC_4E9A5EC5FAC6_var*
//#UC END# *16E4F9B79ECC_4E9A5EC5FAC6_var*
begin
//#UC START# *16E4F9B79ECC_4E9A5EC5FAC6_impl*
 if l3IsNil(aString) then
  Result := #0
 else
  Result := aString.AsWStr.S[0];
//#UC END# *16E4F9B79ECC_4E9A5EC5FAC6_impl*
end;//TkwStringFirstChar.string_FirstChar

procedure TkwStringFirstChar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E9A5EC5FAC6_var*
//#UC END# *4DAEEDE10285_4E9A5EC5FAC6_var*
begin
//#UC START# *4DAEEDE10285_4E9A5EC5FAC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E9A5EC5FAC6_impl*
end;//TkwStringFirstChar.DoDoIt

class function TkwStringFirstChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[]';
end;//TkwStringFirstChar.GetWordNameForRegister

function TkwStringFirstChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringFirstChar.GetResultTypeInfo

function TkwStringFirstChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringFirstChar.GetAllParamsCount

function TkwStringFirstChar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4E9A5EC5FAC6_var*
//#UC END# *5617F4D00243_4E9A5EC5FAC6_var*
begin
//#UC START# *5617F4D00243_4E9A5EC5FAC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4E9A5EC5FAC6_impl*
end;//TkwStringFirstChar.ParamsTypes

function TkwStringTrim.string_Trim(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:Trim }
//#UC START# *62C91D29887A_95D9D233CD72_var*
//#UC END# *62C91D29887A_95D9D233CD72_var*
begin
//#UC START# *62C91D29887A_95D9D233CD72_impl*
 Result := TtfwCStringFactory.C(l3Trim(aString));
//#UC END# *62C91D29887A_95D9D233CD72_impl*
end;//TkwStringTrim.string_Trim

procedure TkwStringTrim.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_95D9D233CD72_var*
//#UC END# *4DAEEDE10285_95D9D233CD72_var*
begin
//#UC START# *4DAEEDE10285_95D9D233CD72_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_95D9D233CD72_impl*
end;//TkwStringTrim.DoDoIt

class function TkwStringTrim.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Trim';
end;//TkwStringTrim.GetWordNameForRegister

function TkwStringTrim.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringTrim.GetResultTypeInfo

function TkwStringTrim.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrim.GetAllParamsCount

function TkwStringTrim.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_95D9D233CD72_var*
//#UC END# *5617F4D00243_95D9D233CD72_var*
begin
//#UC START# *5617F4D00243_95D9D233CD72_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_95D9D233CD72_impl*
end;//TkwStringTrim.ParamsTypes

function TkwStringTrimLeft.string_TrimLeft(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:TrimLeft }
//#UC START# *822EF8BD3C12_2D2FC66E49DD_var*
//#UC END# *822EF8BD3C12_2D2FC66E49DD_var*
begin
//#UC START# *822EF8BD3C12_2D2FC66E49DD_impl*
 Result := TtfwCStringFactory.C(l3LTrim(aString));
//#UC END# *822EF8BD3C12_2D2FC66E49DD_impl*
end;//TkwStringTrimLeft.string_TrimLeft

procedure TkwStringTrimLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D2FC66E49DD_var*
//#UC END# *4DAEEDE10285_2D2FC66E49DD_var*
begin
//#UC START# *4DAEEDE10285_2D2FC66E49DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D2FC66E49DD_impl*
end;//TkwStringTrimLeft.DoDoIt

class function TkwStringTrimLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:TrimLeft';
end;//TkwStringTrimLeft.GetWordNameForRegister

function TkwStringTrimLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringTrimLeft.GetResultTypeInfo

function TkwStringTrimLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrimLeft.GetAllParamsCount

function TkwStringTrimLeft.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2D2FC66E49DD_var*
//#UC END# *5617F4D00243_2D2FC66E49DD_var*
begin
//#UC START# *5617F4D00243_2D2FC66E49DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2D2FC66E49DD_impl*
end;//TkwStringTrimLeft.ParamsTypes

function TkwStringTrimRight.string_TrimRight(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:TrimRight }
//#UC START# *357C9EA3B36D_807D7A8440DD_var*
//#UC END# *357C9EA3B36D_807D7A8440DD_var*
begin
//#UC START# *357C9EA3B36D_807D7A8440DD_impl*
 Result := TtfwCStringFactory.C(l3RTrim(aString, cc_WhiteSpace));
//#UC END# *357C9EA3B36D_807D7A8440DD_impl*
end;//TkwStringTrimRight.string_TrimRight

procedure TkwStringTrimRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_807D7A8440DD_var*
//#UC END# *4DAEEDE10285_807D7A8440DD_var*
begin
//#UC START# *4DAEEDE10285_807D7A8440DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_807D7A8440DD_impl*
end;//TkwStringTrimRight.DoDoIt

class function TkwStringTrimRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:TrimRight';
end;//TkwStringTrimRight.GetWordNameForRegister

function TkwStringTrimRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringTrimRight.GetResultTypeInfo

function TkwStringTrimRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrimRight.GetAllParamsCount

function TkwStringTrimRight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_807D7A8440DD_var*
//#UC END# *5617F4D00243_807D7A8440DD_var*
begin
//#UC START# *5617F4D00243_807D7A8440DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_807D7A8440DD_impl*
end;//TkwStringTrimRight.ParamsTypes

function TkwStringDeleteDoubleSpaces.string_DeleteDoubleSpaces(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:DeleteDoubleSpaces }
//#UC START# *CDE072F795B4_D5F09D866A34_var*
//#UC END# *CDE072F795B4_D5F09D866A34_var*
begin
//#UC START# *CDE072F795B4_D5F09D866A34_impl*
 Result := TtfwCStringFactory.C(l3DeleteDoubleSpace(aString));
//#UC END# *CDE072F795B4_D5F09D866A34_impl*
end;//TkwStringDeleteDoubleSpaces.string_DeleteDoubleSpaces

procedure TkwStringDeleteDoubleSpaces.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D5F09D866A34_var*
//#UC END# *4DAEEDE10285_D5F09D866A34_var*
begin
//#UC START# *4DAEEDE10285_D5F09D866A34_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D5F09D866A34_impl*
end;//TkwStringDeleteDoubleSpaces.DoDoIt

class function TkwStringDeleteDoubleSpaces.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:DeleteDoubleSpaces';
end;//TkwStringDeleteDoubleSpaces.GetWordNameForRegister

function TkwStringDeleteDoubleSpaces.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringDeleteDoubleSpaces.GetResultTypeInfo

function TkwStringDeleteDoubleSpaces.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringDeleteDoubleSpaces.GetAllParamsCount

function TkwStringDeleteDoubleSpaces.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D5F09D866A34_var*
//#UC END# *5617F4D00243_D5F09D866A34_var*
begin
//#UC START# *5617F4D00243_D5F09D866A34_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D5F09D866A34_impl*
end;//TkwStringDeleteDoubleSpaces.ParamsTypes

function TkwStringDeleteDoubleChars.string_DeleteDoubleChars(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aChar: Il3CString): Il3CString;
 {* ���������� ����� ������� string:DeleteDoubleChars }
//#UC START# *F02755D05DBC_30A1EAD7A5D9_var*
//#UC END# *F02755D05DBC_30A1EAD7A5D9_var*
begin
//#UC START# *F02755D05DBC_30A1EAD7A5D9_impl*
 Result := TtfwCStringFactory.C(l3DeleteSerias(aString, l3Char(aChar, 0))); 
//#UC END# *F02755D05DBC_30A1EAD7A5D9_impl*
end;//TkwStringDeleteDoubleChars.string_DeleteDoubleChars

procedure TkwStringDeleteDoubleChars.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_30A1EAD7A5D9_var*
//#UC END# *4DAEEDE10285_30A1EAD7A5D9_var*
begin
//#UC START# *4DAEEDE10285_30A1EAD7A5D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_30A1EAD7A5D9_impl*
end;//TkwStringDeleteDoubleChars.DoDoIt

class function TkwStringDeleteDoubleChars.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:DeleteDoubleChars';
end;//TkwStringDeleteDoubleChars.GetWordNameForRegister

function TkwStringDeleteDoubleChars.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringDeleteDoubleChars.GetResultTypeInfo

function TkwStringDeleteDoubleChars.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringDeleteDoubleChars.GetAllParamsCount

function TkwStringDeleteDoubleChars.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_30A1EAD7A5D9_var*
//#UC END# *5617F4D00243_30A1EAD7A5D9_var*
begin
//#UC START# *5617F4D00243_30A1EAD7A5D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_30A1EAD7A5D9_impl*
end;//TkwStringDeleteDoubleChars.ParamsTypes

function TkwStringSubstring.string_Substring(const aCtx: TtfwContext;
 const aString: Il3CString;
 aPos: Integer;
 aLength: Integer): Il3CString;
 {* ���������� ����� ������� string:Substring }
//#UC START# *05A68328CDCF_2E3FD122E430_var*
//#UC END# *05A68328CDCF_2E3FD122E430_var*
begin
//#UC START# *05A68328CDCF_2E3FD122E430_impl*
 Result := TtfwCStringFactory.C(l3Copy(aString, aPos, aLength));
//#UC END# *05A68328CDCF_2E3FD122E430_impl*
end;//TkwStringSubstring.string_Substring

procedure TkwStringSubstring.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E3FD122E430_var*
//#UC END# *4DAEEDE10285_2E3FD122E430_var*
begin
//#UC START# *4DAEEDE10285_2E3FD122E430_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E3FD122E430_impl*
end;//TkwStringSubstring.DoDoIt

class function TkwStringSubstring.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Substring';
end;//TkwStringSubstring.GetWordNameForRegister

function TkwStringSubstring.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringSubstring.GetResultTypeInfo

function TkwStringSubstring.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringSubstring.GetAllParamsCount

function TkwStringSubstring.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2E3FD122E430_var*
//#UC END# *5617F4D00243_2E3FD122E430_var*
begin
//#UC START# *5617F4D00243_2E3FD122E430_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2E3FD122E430_impl*
end;//TkwStringSubstring.ParamsTypes

function TkwStringLower.string_Lower(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:Lower }
//#UC START# *B1D7965F0E30_B79BEA825961_var*
//#UC END# *B1D7965F0E30_B79BEA825961_var*
begin
//#UC START# *B1D7965F0E30_B79BEA825961_impl*
 Result := l3Lower(aString);
//#UC END# *B1D7965F0E30_B79BEA825961_impl*
end;//TkwStringLower.string_Lower

procedure TkwStringLower.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B79BEA825961_var*
//#UC END# *4DAEEDE10285_B79BEA825961_var*
begin
//#UC START# *4DAEEDE10285_B79BEA825961_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B79BEA825961_impl*
end;//TkwStringLower.DoDoIt

class function TkwStringLower.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Lower';
end;//TkwStringLower.GetWordNameForRegister

function TkwStringLower.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringLower.GetResultTypeInfo

function TkwStringLower.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringLower.GetAllParamsCount

function TkwStringLower.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B79BEA825961_var*
//#UC END# *5617F4D00243_B79BEA825961_var*
begin
//#UC START# *5617F4D00243_B79BEA825961_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B79BEA825961_impl*
end;//TkwStringLower.ParamsTypes

function TkwStringUpper.string_Upper(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* ���������� ����� ������� string:Upper }
//#UC START# *68E30DDD3D3E_8BA4B632B802_var*
//#UC END# *68E30DDD3D3E_8BA4B632B802_var*
begin
//#UC START# *68E30DDD3D3E_8BA4B632B802_impl*
 Result := l3Upper(aString);
//#UC END# *68E30DDD3D3E_8BA4B632B802_impl*
end;//TkwStringUpper.string_Upper

procedure TkwStringUpper.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8BA4B632B802_var*
//#UC END# *4DAEEDE10285_8BA4B632B802_var*
begin
//#UC START# *4DAEEDE10285_8BA4B632B802_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8BA4B632B802_impl*
end;//TkwStringUpper.DoDoIt

class function TkwStringUpper.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Upper';
end;//TkwStringUpper.GetWordNameForRegister

function TkwStringUpper.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwStringUpper.GetResultTypeInfo

function TkwStringUpper.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringUpper.GetAllParamsCount

function TkwStringUpper.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8BA4B632B802_var*
//#UC END# *5617F4D00243_8BA4B632B802_var*
begin
//#UC START# *5617F4D00243_8BA4B632B802_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8BA4B632B802_impl*
end;//TkwStringUpper.ParamsTypes

procedure TkwVarDecLen.VarDecLen(const aCtx: TtfwContext;
 aVar: TtfwWord);
 {* ���������� ����� ������� string:--Len! }
//#UC START# *9CC163BCA241_5B249AD9723E_var*
var
 l_P : Tl3PCharLen;
//#UC END# *9CC163BCA241_5B249AD9723E_var*
begin
//#UC START# *9CC163BCA241_5B249AD9723E_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 Dec(l_P.SLen);
 Assert(l_P.SLen >= 0);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *9CC163BCA241_5B249AD9723E_impl*
end;//TkwVarDecLen.VarDecLen

class function TkwVarDecLen.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:--Len!';
end;//TkwVarDecLen.GetWordNameForRegister

function TkwVarDecLen.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarDecLen.RightParamsCount

procedure TkwVarDecLen.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_5B249AD9723E_var*
//#UC END# *5512949D0048_5B249AD9723E_var*
begin
//#UC START# *5512949D0048_5B249AD9723E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_5B249AD9723E_impl*
end;//TkwVarDecLen.DoRun

function TkwVarDecLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwVarDecLen.GetResultTypeInfo

function TkwVarDecLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarDecLen.GetAllParamsCount

function TkwVarDecLen.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5B249AD9723E_var*
//#UC END# *5617F4D00243_5B249AD9723E_var*
begin
//#UC START# *5617F4D00243_5B249AD9723E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5B249AD9723E_impl*
end;//TkwVarDecLen.ParamsTypes

procedure TkwVarInc.VarInc(const aCtx: TtfwContext;
 aVar: TtfwWord);
 {* ���������� ����� ������� string:++! }
//#UC START# *D3130F58366C_FF4D82AA3241_var*
var
 l_P : Tl3PCharLen;
//#UC END# *D3130F58366C_FF4D82AA3241_var*
begin
//#UC START# *D3130F58366C_FF4D82AA3241_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *D3130F58366C_FF4D82AA3241_impl*
end;//TkwVarInc.VarInc

class function TkwVarInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:++!';
end;//TkwVarInc.GetWordNameForRegister

function TkwVarInc.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarInc.RightParamsCount

procedure TkwVarInc.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_FF4D82AA3241_var*
//#UC END# *5512949D0048_FF4D82AA3241_var*
begin
//#UC START# *5512949D0048_FF4D82AA3241_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_FF4D82AA3241_impl*
end;//TkwVarInc.DoRun

function TkwVarInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwVarInc.GetResultTypeInfo

function TkwVarInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarInc.GetAllParamsCount

function TkwVarInc.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FF4D82AA3241_var*
//#UC END# *5617F4D00243_FF4D82AA3241_var*
begin
//#UC START# *5617F4D00243_FF4D82AA3241_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FF4D82AA3241_impl*
end;//TkwVarInc.ParamsTypes

function TkwRSplitTo.RSplitTo(const aCtx: TtfwContext;
 aVar: TtfwWord;
 const aDelim: Il3CString): Il3CString;
 {* ���������� ����� ������� string:RSplitTo! }
//#UC START# *6BE7506C040A_D442EF995DFF_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Found : PAnsiChar;

 //l_Pref : Il3CString;
 //l_Suff : Il3CString;
//#UC END# *6BE7506C040A_D442EF995DFF_var*
begin
//#UC START# *6BE7506C040A_D442EF995DFF_impl*
 l_V := aVar.GetValue(aCtx).AsString;
 Tl3WString(l_P) := l3PCharLen(l_V);
 l_WS := l3PCharLen(aDelim);
 Assert(not l3IsNil(l_WS));
 Assert(l_P.SLen >= 0);
 Assert(l3IsAnsi(l_P.SCodePage));
 if (l_WS.SLen = 1) then
 begin
  l_Found := ev_lpRScan(l_WS.S[0], l_P.S, l_P.SLen);
  if (l_Found = nil) then
  begin
   Result := TtfwCStringFactory.C(l_P);
   aVar.SetValue(TtfwCStringFactoryEx.ViewOf(''), aCtx);
  end//l_Found = nil
  else
  begin
   Result := TtfwCStringFactory.C(l3Copy(l_P, l_Found - l_P.S + 1));
   aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l3PCharLen(l_P.S, l_Found - l_P.S, l_P.SCodePage)), aCtx);
  end;//l_Found = nil
 end//l_WS.SLen = 1
 else
 begin
  //l3Split(l_V, aDelim, l_Pref, l_Suff);
  //aCtx.rEngine.PushString(l_Pref);
  //aVar.Value := TtfwStackValue_C(l_Suff);
  Assert(false, '���� �� �����������');
  Result := nil;
 end;//l_WS.SLen = 1
//#UC END# *6BE7506C040A_D442EF995DFF_impl*
end;//TkwRSplitTo.RSplitTo

class function TkwRSplitTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:RSplitTo!';
end;//TkwRSplitTo.GetWordNameForRegister

function TkwRSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRSplitTo.RightParamsCount

procedure TkwRSplitTo.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_D442EF995DFF_var*
//#UC END# *5512949D0048_D442EF995DFF_var*
begin
//#UC START# *5512949D0048_D442EF995DFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_D442EF995DFF_impl*
end;//TkwRSplitTo.DoRun

function TkwRSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwRSplitTo.GetResultTypeInfo

function TkwRSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwRSplitTo.GetAllParamsCount

function TkwRSplitTo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D442EF995DFF_var*
//#UC END# *5617F4D00243_D442EF995DFF_var*
begin
//#UC START# *5617F4D00243_D442EF995DFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D442EF995DFF_impl*
end;//TkwRSplitTo.ParamsTypes

procedure TkwVarShift.VarShift(const aCtx: TtfwContext;
 aVar: TtfwWord;
 aNum: Integer);
 {* ���������� ����� ������� string:+! }
//#UC START# *9E35DCA8A090_E1736F173AD3_var*
var
 l_P : Tl3PCharLen;
//#UC END# *9E35DCA8A090_E1736F173AD3_var*
begin
//#UC START# *9E35DCA8A090_E1736F173AD3_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(aNum);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *9E35DCA8A090_E1736F173AD3_impl*
end;//TkwVarShift.VarShift

class function TkwVarShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:+!';
end;//TkwVarShift.GetWordNameForRegister

function TkwVarShift.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarShift.RightParamsCount

procedure TkwVarShift.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_E1736F173AD3_var*
//#UC END# *5512949D0048_E1736F173AD3_var*
begin
//#UC START# *5512949D0048_E1736F173AD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_E1736F173AD3_impl*
end;//TkwVarShift.DoRun

function TkwVarShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwVarShift.GetResultTypeInfo

function TkwVarShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwVarShift.GetAllParamsCount

function TkwVarShift.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E1736F173AD3_var*
//#UC END# *5617F4D00243_E1736F173AD3_var*
begin
//#UC START# *5617F4D00243_E1736F173AD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E1736F173AD3_impl*
end;//TkwVarShift.ParamsTypes

function TkwSplitTo.SplitTo(const aCtx: TtfwContext;
 aVar: TtfwWord;
 const aDelim: Il3CString): Il3CString;
 {* ���������� ����� ������� string:SplitTo! }
//#UC START# *94300FB9FFA5_BF0C6B892128_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Rest : Tl3WString;

 l_Pref : Il3CString;
 l_Suff : Il3CString;
//#UC END# *94300FB9FFA5_BF0C6B892128_var*
begin
//#UC START# *94300FB9FFA5_BF0C6B892128_impl*
 l_V := aVar.GetValue(aCtx).AsString;
 Tl3WString(l_P) := l3PCharLen(l_V);
 l_WS := l3PCharLen(aDelim);
 Assert(not l3IsNil(l_WS));
 Assert(l_P.SLen >= 0);
 if (l_WS.SLen = 1) then
 begin
  l_Rest := l3FindChar(l_WS.S[0], l_P);
  if not l3IsNil(l_P) then
   if (l_P.S[l_P.SLen - 1] = l_WS.S[0]) then
    Dec(l_P.SLen);
  Result := TtfwCStringFactory.C(l_P);
  aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_Rest), aCtx);
 end//l_WS.SLen = 1
 else
 begin
  l3Split(l_V, aDelim, l_Pref, l_Suff);
  Result := l_Pref;
  aVar.SetValue(TtfwStackValue_C(l_Suff), aCtx);
  //Assert(false, '���� �� �����������');
 end;//l_WS.SLen = 1
//#UC END# *94300FB9FFA5_BF0C6B892128_impl*
end;//TkwSplitTo.SplitTo

class function TkwSplitTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:SplitTo!';
end;//TkwSplitTo.GetWordNameForRegister

function TkwSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSplitTo.RightParamsCount

procedure TkwSplitTo.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_BF0C6B892128_var*
//#UC END# *5512949D0048_BF0C6B892128_var*
begin
//#UC START# *5512949D0048_BF0C6B892128_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_BF0C6B892128_impl*
end;//TkwSplitTo.DoRun

function TkwSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwSplitTo.GetResultTypeInfo

function TkwSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSplitTo.GetAllParamsCount

function TkwSplitTo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BF0C6B892128_var*
//#UC END# *5617F4D00243_BF0C6B892128_var*
begin
//#UC START# *5617F4D00243_BF0C6B892128_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BF0C6B892128_impl*
end;//TkwSplitTo.ParamsTypes

function TkwVarPushCharAndInc.VarPushCharAndInc(const aCtx: TtfwContext;
 aVar: TtfwWord): AnsiChar;
 {* ���������� ����� ������� string:[]++! }
//#UC START# *5123A135DDBC_6014F0D564E4_var*
var
 l_P : Tl3PCharLen;
//#UC END# *5123A135DDBC_6014F0D564E4_var*
begin
//#UC START# *5123A135DDBC_6014F0D564E4_impl*
 Tl3WString(l_P) := aVar.GetValue(aCtx).AsString.AsWStr;
 Result := l_P.S^;
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *5123A135DDBC_6014F0D564E4_impl*
end;//TkwVarPushCharAndInc.VarPushCharAndInc

class function TkwVarPushCharAndInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[]++!';
end;//TkwVarPushCharAndInc.GetWordNameForRegister

function TkwVarPushCharAndInc.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarPushCharAndInc.RightParamsCount

procedure TkwVarPushCharAndInc.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_6014F0D564E4_var*
//#UC END# *5512949D0048_6014F0D564E4_var*
begin
//#UC START# *5512949D0048_6014F0D564E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_6014F0D564E4_impl*
end;//TkwVarPushCharAndInc.DoRun

function TkwVarPushCharAndInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwVarPushCharAndInc.GetResultTypeInfo

function TkwVarPushCharAndInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarPushCharAndInc.GetAllParamsCount

function TkwVarPushCharAndInc.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6014F0D564E4_var*
//#UC END# *5617F4D00243_6014F0D564E4_var*
begin
//#UC START# *5617F4D00243_6014F0D564E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6014F0D564E4_impl*
end;//TkwVarPushCharAndInc.ParamsTypes

initialization
 TtfwIl3CStringPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwStartsStr.RegisterInEngine;
 {* ����������� StartsStr }
 TkwStartsText.RegisterInEngine;
 {* ����������� StartsText }
 TkwEndsStr.RegisterInEngine;
 {* ����������� EndsStr }
 TkwEndsText.RegisterInEngine;
 {* ����������� EndsText }
 TkwSameStr.RegisterInEngine;
 {* ����������� SameStr }
 TkwSameText.RegisterInEngine;
 {* ����������� SameText }
 TkwCompareStr.RegisterInEngine;
 {* ����������� CompareStr }
 TkwCompareText.RegisterInEngine;
 {* ����������� CompareText }
 TkwStrToInt.RegisterInEngine;
 {* ����������� StrToInt }
 TkwCat.RegisterInEngine;
 {* ����������� Cat }
 TkwStringConsistsOf.RegisterInEngine;
 {* ����������� string_ConsistsOf }
 TkwStringHasAnyOf.RegisterInEngine;
 {* ����������� string_HasAnyOf }
 TkwStringPos.RegisterInEngine;
 {* ����������� string_Pos }
 TkwStringPosEx.RegisterInEngine;
 {* ����������� string_PosEx }
 TkwStringSplit.RegisterInEngine;
 {* ����������� string_Split }
 TkwStringReplace.RegisterInEngine;
 {* ����������� string_Replace }
 TkwStringReplaceFirst.RegisterInEngine;
 {* ����������� string_ReplaceFirst }
 TkwTextReplace.RegisterInEngine;
 {* ����������� text_Replace }
 TkwTextReplaceFirst.RegisterInEngine;
 {* ����������� text_ReplaceFirst }
 TkwStringChar.RegisterInEngine;
 {* ����������� string_Char }
 TkwStringCodePage.RegisterInEngine;
 {* ����������� string_CodePage }
 TkwStringLen.RegisterInEngine;
 {* ����������� string_Len }
 TkwStringToChar.RegisterInEngine;
 {* ����������� string_ToChar }
 TkwCharToString.RegisterInEngine;
 {* ����������� char_ToString }
 TkwCharDupe.RegisterInEngine;
 {* ����������� char_Dupe }
 TkwStringInc.RegisterInEngine;
 {* ����������� string_Inc }
 TkwStringShift.RegisterInEngine;
 {* ����������� string_Shift }
 TkwStringFirstChar.RegisterInEngine;
 {* ����������� string_FirstChar }
 TkwStringTrim.RegisterInEngine;
 {* ����������� string_Trim }
 TkwStringTrimLeft.RegisterInEngine;
 {* ����������� string_TrimLeft }
 TkwStringTrimRight.RegisterInEngine;
 {* ����������� string_TrimRight }
 TkwStringDeleteDoubleSpaces.RegisterInEngine;
 {* ����������� string_DeleteDoubleSpaces }
 TkwStringDeleteDoubleChars.RegisterInEngine;
 {* ����������� string_DeleteDoubleChars }
 TkwStringSubstring.RegisterInEngine;
 {* ����������� string_Substring }
 TkwStringLower.RegisterInEngine;
 {* ����������� string_Lower }
 TkwStringUpper.RegisterInEngine;
 {* ����������� string_Upper }
 TkwVarDecLen.RegisterInEngine;
 {* ����������� VarDecLen }
 TkwVarInc.RegisterInEngine;
 {* ����������� VarInc }
 TkwRSplitTo.RegisterInEngine;
 {* ����������� RSplitTo }
 TkwVarShift.RegisterInEngine;
 {* ����������� VarShift }
 TkwSplitTo.RegisterInEngine;
 {* ����������� SplitTo }
 TkwVarPushCharAndInc.RegisterInEngine;
 {* ����������� VarPushCharAndInc }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiChar));
 {* ����������� ���� Char }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
