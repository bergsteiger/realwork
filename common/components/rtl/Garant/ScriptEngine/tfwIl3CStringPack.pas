unit tfwIl3CStringPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIl3CStringPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwIl3CStringPack" MUID: (55682D8F01C7)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
 , tfwRegisterableWord
 , tfwWordWorkerEx
 , tfwGlobalKeyWord
 , tfwAxiomaticsResNameGetter
 , l3String
 , l3Types
 , l3Chars
 , l3Base
 , m2HasLib
 , tfwHash16Table
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TtfwStringIterator = class(TtfwIteratableParent, ItfwValueList)
  private
   f_String: Il3CString;
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aString: Il3CString); reintroduce;
   class function Make(const aString: Il3CString): ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwStringIterator

 TkwStartsStr = {final} class(TtfwClassLike)
  {* Слово скрипта StartsStr }
  private
   function StartsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* Реализация слова скрипта StartsStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStartsStr

 TkwStartsText = {final} class(TtfwClassLike)
  {* Слово скрипта StartsText }
  private
   function StartsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* Реализация слова скрипта StartsText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStartsText

 TkwEndsStr = {final} class(TtfwClassLike)
  {* Слово скрипта EndsStr }
  private
   function EndsStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* Реализация слова скрипта EndsStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEndsStr

 TkwEndsText = {final} class(TtfwClassLike)
  {* Слово скрипта EndsText }
  private
   function EndsText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aSubStr: Il3CString): Boolean;
    {* Реализация слова скрипта EndsText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEndsText

 TkwSameStr = {final} class(TtfwClassLike)
  {* Слово скрипта SameStr }
  private
   function SameStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
    {* Реализация слова скрипта SameStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSameStr

 TkwSameText = {final} class(TtfwClassLike)
  {* Слово скрипта SameText }
  private
   function SameText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Boolean;
    {* Реализация слова скрипта SameText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSameText

 TkwCompareStr = {final} class(TtfwClassLike)
  {* Слово скрипта CompareStr }
  private
   function CompareStr(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* Реализация слова скрипта CompareStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompareStr

 TkwCompareText = {final} class(TtfwClassLike)
  {* Слово скрипта CompareText }
  private
   function CompareText(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* Реализация слова скрипта CompareText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompareText

 TkwStrToInt = {final} class(TtfwClassLike)
  {* Слово скрипта StrToInt }
  private
   function StrToInt(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта StrToInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStrToInt

 TkwCat = {final} class(TtfwClassLike)
  {* Слово скрипта Cat }
  private
   function Cat(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Il3CString;
    {* Реализация слова скрипта Cat }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCat

 TkwStringConsistsOf = {final} class(TtfwClassLike)
  {* Слово скрипта string:ConsistsOf }
  private
   function string_ConsistsOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
    {* Реализация слова скрипта string:ConsistsOf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringConsistsOf

 TkwStringHasAnyOf = {final} class(TtfwClassLike)
  {* Слово скрипта string:HasAnyOf }
  private
   function string_HasAnyOf(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aDelims: Il3CString): Boolean;
    {* Реализация слова скрипта string:HasAnyOf }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringHasAnyOf

 TkwStringPos = {final} class(TtfwClassLike)
  {* Слово скрипта string:Pos }
  private
   function string_Pos(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString): Integer;
    {* Реализация слова скрипта string:Pos }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringPos

 TkwStringPosEx = {final} class(TtfwClassLike)
  {* Слово скрипта string:PosEx }
  private
   function string_PosEx(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    aPos: Integer): Integer;
    {* Реализация слова скрипта string:PosEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringPosEx

 TkwStringSplit = {final} class(TtfwClassLike)
  {* Слово скрипта string:Split }
  private
   function string_Split(const aCtx: TtfwContext;
    const aString: Il3CString;
    const anOther: Il3CString;
    out theTail: Il3CString): Il3CString;
    {* Реализация слова скрипта string:Split }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSplit

 TkwStringReplace = {final} class(TtfwClassLike)
  {* Слово скрипта string:Replace }
  private
   function string_Replace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* Реализация слова скрипта string:Replace }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringReplace

 TkwStringReplaceFirst = {final} class(TtfwClassLike)
  {* Слово скрипта string:ReplaceFirst }
  private
   function string_ReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* Реализация слова скрипта string:ReplaceFirst }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringReplaceFirst

 TkwTextReplace = {final} class(TtfwClassLike)
  {* Слово скрипта text:Replace }
  private
   function text_Replace(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* Реализация слова скрипта text:Replace }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextReplace

 TkwTextReplaceFirst = {final} class(TtfwClassLike)
  {* Слово скрипта text:ReplaceFirst }
  private
   function text_ReplaceFirst(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aFrom: Il3CString;
    const aMain: Il3CString): Il3CString;
    {* Реализация слова скрипта text:ReplaceFirst }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTextReplaceFirst

 TkwStringChar = {final} class(TtfwClassLike)
  {* Слово скрипта string:[i] }
  private
   function string_Char(const aCtx: TtfwContext;
    const aString: Il3CString;
    anIndex: Integer): AnsiChar;
    {* Реализация слова скрипта string:[i] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringChar

 TkwStringCodePage = {final} class(TtfwClassLike)
  {* Слово скрипта string:CodePage }
  private
   function string_CodePage(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:CodePage }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringCodePage

 TkwStringLen = {final} class(TtfwClassLike)
  {* Слово скрипта string:Len }
  private
   function string_Len(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:Len }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringLen

 TkwStringToChar = {final} class(TtfwClassLike)
  {* Слово скрипта string:ToChar }
  private
   function string_ToChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
    {* Реализация слова скрипта string:ToChar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringToChar

 TkwCharToString = {final} class(TtfwRegisterableWord)
  {* Слово скрипта char:ToString }
  private
   function char_ToString(const aCtx: TtfwContext;
    aChar: AnsiChar): Il3CString;
    {* Реализация слова скрипта char:ToString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCharToString

 TkwCharDupe = {final} class(TtfwClassLike)
  {* Слово скрипта char:Dupe }
  private
   function char_Dupe(const aCtx: TtfwContext;
    const aString: Il3CString;
    aCount: Integer): Il3CString;
    {* Реализация слова скрипта char:Dupe }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCharDupe

 TkwStringInc = {final} class(TtfwClassLike)
  {* Слово скрипта string:++ }
  private
   function string_Inc(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:++ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringInc

 TkwStringShift = {final} class(TtfwClassLike)
  {* Слово скрипта string:+ }
  private
   function string_Shift(const aCtx: TtfwContext;
    const aString: Il3CString;
    aDelta: Integer): Il3CString;
    {* Реализация слова скрипта string:+ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringShift

 TkwStringFirstChar = {final} class(TtfwClassLike)
  {* Слово скрипта string:[] }
  private
   function string_FirstChar(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiChar;
    {* Реализация слова скрипта string:[] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringFirstChar

 TkwStringTrim = {final} class(TtfwClassLike)
  {* Слово скрипта string:Trim }
  private
   function string_Trim(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:Trim }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrim

 TkwStringTrimLeft = {final} class(TtfwClassLike)
  {* Слово скрипта string:TrimLeft }
  private
   function string_TrimLeft(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:TrimLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrimLeft

 TkwStringTrimRight = {final} class(TtfwClassLike)
  {* Слово скрипта string:TrimRight }
  private
   function string_TrimRight(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:TrimRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTrimRight

 TkwStringDeleteDoubleSpaces = {final} class(TtfwClassLike)
  {* Слово скрипта string:DeleteDoubleSpaces }
  private
   function string_DeleteDoubleSpaces(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:DeleteDoubleSpaces }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringDeleteDoubleSpaces

 TkwStringDeleteDoubleChars = {final} class(TtfwClassLike)
  {* Слово скрипта string:DeleteDoubleChars }
  private
   function string_DeleteDoubleChars(const aCtx: TtfwContext;
    const aString: Il3CString;
    const aChar: Il3CString): Il3CString;
    {* Реализация слова скрипта string:DeleteDoubleChars }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringDeleteDoubleChars

 TkwStringSubstring = {final} class(TtfwClassLike)
  {* Слово скрипта string:Substring }
  private
   function string_Substring(const aCtx: TtfwContext;
    const aString: Il3CString;
    aPos: Integer;
    aLength: Integer): Il3CString;
    {* Реализация слова скрипта string:Substring }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSubstring

 TkwStringLower = {final} class(TtfwClassLike)
  {* Слово скрипта string:Lower }
  private
   function string_Lower(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:Lower }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringLower

 TkwStringUpper = {final} class(TtfwClassLike)
  {* Слово скрипта string:Upper }
  private
   function string_Upper(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:Upper }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringUpper

 TkwStringToUnicode = {final} class(TtfwClassLike)
  {* Слово скрипта string:ToUnicode }
  private
   function string_ToUnicode(const aCtx: TtfwContext;
    const aString: Il3CString): Il3CString;
    {* Реализация слова скрипта string:ToUnicode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringToUnicode

 TkwStringHash = {final} class(TtfwClassLike)
  {* Слово скрипта string:Hash }
  private
   function string_Hash(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:Hash }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringHash

 TkwStringSmallHash = {final} class(TtfwClassLike)
  {* Слово скрипта string:SmallHash }
  private
   function string_SmallHash(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:SmallHash }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSmallHash

 TkwStringIterator = {final} class(TtfwClassLike)
  {* Слово скрипта string:Iterator }
  private
   function string_Iterator(const aCtx: TtfwContext;
    const aString: Il3CString): ItfwValueList;
    {* Реализация слова скрипта string:Iterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringIterator

 TkwStringHashNew = {final} class(TtfwClassLike)
  {* Слово скрипта string:Hash:New }
  private
   function string_Hash_New(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:Hash:New }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringHashNew

 TkwStringSmallHashNew = {final} class(TtfwClassLike)
  {* Слово скрипта string:SmallHash:New }
  private
   function string_SmallHash_New(const aCtx: TtfwContext;
    const aString: Il3CString): Integer;
    {* Реализация слова скрипта string:SmallHash:New }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringSmallHashNew

 TkwStringTransliterate = {final} class(TtfwClassLike)
  {* Слово скрипта string:Transliterate }
  private
   function string_Transliterate(const aCtx: TtfwContext;
    const aString: Il3CString): AnsiString;
    {* Реализация слова скрипта string:Transliterate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStringTransliterate

 TkwVarDecLen = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:--Len! }
  private
   procedure VarDecLen(const aCtx: TtfwContext;
    aVar: TtfwWord);
    {* Реализация слова скрипта string:--Len! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwVarDecLen

 TkwVarInc = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:++! }
  private
   procedure VarInc(const aCtx: TtfwContext;
    aVar: TtfwWord);
    {* Реализация слова скрипта string:++! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwVarInc

 TkwRSplitTo = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:RSplitTo! }
  private
   function RSplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
    {* Реализация слова скрипта string:RSplitTo! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwRSplitTo

 TkwVarShift = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:+! }
  private
   procedure VarShift(const aCtx: TtfwContext;
    aVar: TtfwWord;
    aNum: Integer);
    {* Реализация слова скрипта string:+! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwVarShift

 TkwSplitTo = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:SplitTo! }
  private
   function SplitTo(const aCtx: TtfwContext;
    aVar: TtfwWord;
    const aDelim: Il3CString): Il3CString;
    {* Реализация слова скрипта string:SplitTo! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwSplitTo

 TkwVarPushCharAndInc = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта string:[]++! }
  private
   function VarPushCharAndInc(const aCtx: TtfwContext;
    aVar: TtfwWord): AnsiChar;
    {* Реализация слова скрипта string:[]++! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwVarPushCharAndInc

 TkwHash16Table = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Hash16Table }
  private
   function Hash16Table(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта Hash16Table }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwHash16Table

 TtfwIl3CStringPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TtfwIl3CStringPackResNameGetter

constructor TtfwStringIterator.Create(const aString: Il3CString);
//#UC START# *56F3EF17004C_56F3EEE50232_var*
//#UC END# *56F3EF17004C_56F3EEE50232_var*
begin
//#UC START# *56F3EF17004C_56F3EEE50232_impl*
 inherited Create;
 f_String := aString;
//#UC END# *56F3EF17004C_56F3EEE50232_impl*
end;//TtfwStringIterator.Create

class function TtfwStringIterator.Make(const aString: Il3CString): ItfwValueList;
var
 l_Inst : TtfwStringIterator;
begin
 l_Inst := Create(aString);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwStringIterator.Make

procedure TtfwStringIterator.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_56F3EEE50232_var*
var
 l_S : Tl3WString;
 l_Index : Integer;
//#UC END# *52E23B7A00EC_56F3EEE50232_var*
begin
//#UC START# *52E23B7A00EC_56F3EEE50232_impl*
 l_S := f_String.AsWStr;
 for l_Index := 0 to Pred(l_S.SLen) do
 begin
  aCtx.rEngine.PushChar(l3Char(l_S, l_Index));
  aLambda.DoIt(aCtx);
 end;//for l_Index
//#UC END# *52E23B7A00EC_56F3EEE50232_impl*
end;//TtfwStringIterator.ForEach

procedure TtfwStringIterator.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_56F3EEE50232_var*
var
 l_S : Tl3WString;
 l_Index : Integer;
//#UC END# *52E23BB102FA_56F3EEE50232_var*
begin
//#UC START# *52E23BB102FA_56F3EEE50232_impl*
 l_S := f_String.AsWStr;
 for l_Index := Pred(l_S.SLen) downto 0 do
 begin
  aCtx.rEngine.PushChar(l3Char(l_S, l_Index));
  aLambda.DoIt(aCtx);
 end;//for l_Index
//#UC END# *52E23BB102FA_56F3EEE50232_impl*
end;//TtfwStringIterator.ForEachBack

procedure TtfwStringIterator.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_56F3EEE50232_var*
//#UC END# *55CDF40C03D4_56F3EEE50232_var*
begin
//#UC START# *55CDF40C03D4_56F3EEE50232_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_56F3EEE50232_impl*
end;//TtfwStringIterator.SetItem

function TtfwStringIterator.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_56F3EEE50232_var*
//#UC END# *55E849210175_56F3EEE50232_var*
begin
//#UC START# *55E849210175_56F3EEE50232_impl*
 Result := 1;
//#UC END# *55E849210175_56F3EEE50232_impl*
end;//TtfwStringIterator.ItemsCountInSlice

procedure TtfwStringIterator.ClearFields;
begin
 f_String := nil;
 inherited;
end;//TtfwStringIterator.ClearFields

function TkwStartsStr.StartsStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* Реализация слова скрипта StartsStr }
//#UC START# *55682E07017A_0093B3082714_var*
//#UC END# *55682E07017A_0093B3082714_var*
begin
//#UC START# *55682E07017A_0093B3082714_impl*
 Result := l3Starts(aSubStr, aString, false);
//#UC END# *55682E07017A_0093B3082714_impl*
end;//TkwStartsStr.StartsStr

procedure TkwStartsStr.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aSubStr: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(StartsStr(aCtx, l_aString, l_aSubStr));
end;//TkwStartsStr.DoDoIt

class function TkwStartsStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartsStr';
end;//TkwStartsStr.GetWordNameForRegister

function TkwStartsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwStartsStr.GetResultTypeInfo

function TkwStartsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStartsStr.GetAllParamsCount

function TkwStartsStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStartsStr.ParamsTypes

function TkwStartsText.StartsText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* Реализация слова скрипта StartsText }
//#UC START# *55682E2503B9_9996D7566EDE_var*
//#UC END# *55682E2503B9_9996D7566EDE_var*
begin
//#UC START# *55682E2503B9_9996D7566EDE_impl*
 Result := l3Starts(aSubStr, aString, true);
//#UC END# *55682E2503B9_9996D7566EDE_impl*
end;//TkwStartsText.StartsText

procedure TkwStartsText.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aSubStr: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(StartsText(aCtx, l_aString, l_aSubStr));
end;//TkwStartsText.DoDoIt

class function TkwStartsText.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartsText';
end;//TkwStartsText.GetWordNameForRegister

function TkwStartsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwStartsText.GetResultTypeInfo

function TkwStartsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStartsText.GetAllParamsCount

function TkwStartsText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStartsText.ParamsTypes

function TkwEndsStr.EndsStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* Реализация слова скрипта EndsStr }
//#UC START# *55682E4401ED_397C461D6C30_var*
//#UC END# *55682E4401ED_397C461D6C30_var*
begin
//#UC START# *55682E4401ED_397C461D6C30_impl*
 Result := l3Ends(aSubStr, aString, false);
//#UC END# *55682E4401ED_397C461D6C30_impl*
end;//TkwEndsStr.EndsStr

procedure TkwEndsStr.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aSubStr: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(EndsStr(aCtx, l_aString, l_aSubStr));
end;//TkwEndsStr.DoDoIt

class function TkwEndsStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndsStr';
end;//TkwEndsStr.GetWordNameForRegister

function TkwEndsStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwEndsStr.GetResultTypeInfo

function TkwEndsStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwEndsStr.GetAllParamsCount

function TkwEndsStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwEndsStr.ParamsTypes

function TkwEndsText.EndsText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aSubStr: Il3CString): Boolean;
 {* Реализация слова скрипта EndsText }
//#UC START# *55682E4F033B_8997C15C6CA8_var*
//#UC END# *55682E4F033B_8997C15C6CA8_var*
begin
//#UC START# *55682E4F033B_8997C15C6CA8_impl*
 Result := l3Ends(aSubStr, aString, true);
//#UC END# *55682E4F033B_8997C15C6CA8_impl*
end;//TkwEndsText.EndsText

procedure TkwEndsText.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aSubStr: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(EndsText(aCtx, l_aString, l_aSubStr));
end;//TkwEndsText.DoDoIt

class function TkwEndsText.GetWordNameForRegister: AnsiString;
begin
 Result := 'EndsText';
end;//TkwEndsText.GetWordNameForRegister

function TkwEndsText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwEndsText.GetResultTypeInfo

function TkwEndsText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwEndsText.GetAllParamsCount

function TkwEndsText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwEndsText.ParamsTypes

function TkwSameStr.SameStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Boolean;
 {* Реализация слова скрипта SameStr }
//#UC START# *55682E5E01E1_2309401B7CC1_var*
//#UC END# *55682E5E01E1_2309401B7CC1_var*
begin
//#UC START# *55682E5E01E1_2309401B7CC1_impl*
 Result := l3Same(aString, anOther, false);
//#UC END# *55682E5E01E1_2309401B7CC1_impl*
end;//TkwSameStr.SameStr

procedure TkwSameStr.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(SameStr(aCtx, l_aString, l_anOther));
end;//TkwSameStr.DoDoIt

class function TkwSameStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'SameStr';
end;//TkwSameStr.GetWordNameForRegister

function TkwSameStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSameStr.GetResultTypeInfo

function TkwSameStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSameStr.GetAllParamsCount

function TkwSameStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwSameStr.ParamsTypes

function TkwSameText.SameText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Boolean;
 {* Реализация слова скрипта SameText }
//#UC START# *55682E72033C_9FC28ACB9AA1_var*
//#UC END# *55682E72033C_9FC28ACB9AA1_var*
begin
//#UC START# *55682E72033C_9FC28ACB9AA1_impl*
 Result := l3Same(aString, anOther, true);
//#UC END# *55682E72033C_9FC28ACB9AA1_impl*
end;//TkwSameText.SameText

procedure TkwSameText.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(SameText(aCtx, l_aString, l_anOther));
end;//TkwSameText.DoDoIt

class function TkwSameText.GetWordNameForRegister: AnsiString;
begin
 Result := 'SameText';
end;//TkwSameText.GetWordNameForRegister

function TkwSameText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSameText.GetResultTypeInfo

function TkwSameText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSameText.GetAllParamsCount

function TkwSameText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwSameText.ParamsTypes

function TkwCompareStr.CompareStr(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* Реализация слова скрипта CompareStr }
//#UC START# *55682E84007F_C670925F6482_var*
//#UC END# *55682E84007F_C670925F6482_var*
begin
//#UC START# *55682E84007F_C670925F6482_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString));
//#UC END# *55682E84007F_C670925F6482_impl*
end;//TkwCompareStr.CompareStr

procedure TkwCompareStr.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(CompareStr(aCtx, l_aString, l_anOther));
end;//TkwCompareStr.DoDoIt

class function TkwCompareStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompareStr';
end;//TkwCompareStr.GetWordNameForRegister

function TkwCompareStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCompareStr.GetResultTypeInfo

function TkwCompareStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCompareStr.GetAllParamsCount

function TkwCompareStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCompareStr.ParamsTypes

function TkwCompareText.CompareText(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* Реализация слова скрипта CompareText }
//#UC START# *55682E9700FE_0E02A0729BA6_var*
//#UC END# *55682E9700FE_0E02A0729BA6_var*
begin
//#UC START# *55682E9700FE_0E02A0729BA6_impl*
 Result := l3Compare(l3PCharLen(anOther), l3PCharLen(aString), l3_siCaseUnsensitive);
//#UC END# *55682E9700FE_0E02A0729BA6_impl*
end;//TkwCompareText.CompareText

procedure TkwCompareText.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(CompareText(aCtx, l_aString, l_anOther));
end;//TkwCompareText.DoDoIt

class function TkwCompareText.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompareText';
end;//TkwCompareText.GetWordNameForRegister

function TkwCompareText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwCompareText.GetResultTypeInfo

function TkwCompareText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCompareText.GetAllParamsCount

function TkwCompareText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCompareText.ParamsTypes

function TkwStrToInt.StrToInt(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта StrToInt }
//#UC START# *55682EA703B4_09008856C703_var*
//#UC END# *55682EA703B4_09008856C703_var*
begin
//#UC START# *55682EA703B4_09008856C703_impl*
 Result := SysUtils.StrToInt(l3Str(aString));
//#UC END# *55682EA703B4_09008856C703_impl*
end;//TkwStrToInt.StrToInt

procedure TkwStrToInt.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(StrToInt(aCtx, l_aString));
end;//TkwStrToInt.DoDoIt

class function TkwStrToInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'StrToInt';
end;//TkwStrToInt.GetWordNameForRegister

function TkwStrToInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStrToInt.GetResultTypeInfo

function TkwStrToInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStrToInt.GetAllParamsCount

function TkwStrToInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStrToInt.ParamsTypes

function TkwCat.Cat(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Il3CString;
 {* Реализация слова скрипта Cat }
//#UC START# *5568365E0395_DD57CECF347C_var*
//#UC END# *5568365E0395_DD57CECF347C_var*
begin
//#UC START# *5568365E0395_DD57CECF347C_impl*
 Result := TtfwCStringFactory.Cat(anOther, aString);
//#UC END# *5568365E0395_DD57CECF347C_impl*
end;//TkwCat.Cat

procedure TkwCat.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Cat(aCtx, l_aString, l_anOther));
end;//TkwCat.DoDoIt

class function TkwCat.GetWordNameForRegister: AnsiString;
begin
 Result := 'Cat';
end;//TkwCat.GetWordNameForRegister

function TkwCat.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCat.GetResultTypeInfo

function TkwCat.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCat.GetAllParamsCount

function TkwCat.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwCat.ParamsTypes

function TkwStringConsistsOf.string_ConsistsOf(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aDelims: Il3CString): Boolean;
 {* Реализация слова скрипта string:ConsistsOf }
//#UC START# *556840910148_5F306006344B_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *556840910148_5F306006344B_var*
begin
//#UC START# *556840910148_5F306006344B_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := l3IsNil(l_S2)
  // - любая непустая не может состоять ТОЛЬКО из символов пустого множества 
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
//#UC END# *556840910148_5F306006344B_impl*
end;//TkwStringConsistsOf.string_ConsistsOf

procedure TkwStringConsistsOf.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aDelims: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelims := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelims: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(string_ConsistsOf(aCtx, l_aString, l_aDelims));
end;//TkwStringConsistsOf.DoDoIt

class function TkwStringConsistsOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ConsistsOf';
end;//TkwStringConsistsOf.GetWordNameForRegister

function TkwStringConsistsOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwStringConsistsOf.GetResultTypeInfo

function TkwStringConsistsOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringConsistsOf.GetAllParamsCount

function TkwStringConsistsOf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringConsistsOf.ParamsTypes

function TkwStringHasAnyOf.string_HasAnyOf(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aDelims: Il3CString): Boolean;
 {* Реализация слова скрипта string:HasAnyOf }
//#UC START# *5568411F01E1_2256016890B3_var*
var
 l_S1 : Tl3WString;
 l_S2 : Tl3WString;
 l_C : TChars;
 l_Index : Integer;
//#UC END# *5568411F01E1_2256016890B3_var*
begin
//#UC START# *5568411F01E1_2256016890B3_impl*
 l_S1 := l3PCharLen(aDelims);
 l_S2 := l3PCharLen(aString);
 if l3IsNil(l_S1) then
  Result := true
  // - любая строка содержит символы из пустого множества, считаем так
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
//#UC END# *5568411F01E1_2256016890B3_impl*
end;//TkwStringHasAnyOf.string_HasAnyOf

procedure TkwStringHasAnyOf.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aDelims: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelims := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelims: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(string_HasAnyOf(aCtx, l_aString, l_aDelims));
end;//TkwStringHasAnyOf.DoDoIt

class function TkwStringHasAnyOf.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:HasAnyOf';
end;//TkwStringHasAnyOf.GetWordNameForRegister

function TkwStringHasAnyOf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwStringHasAnyOf.GetResultTypeInfo

function TkwStringHasAnyOf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringHasAnyOf.GetAllParamsCount

function TkwStringHasAnyOf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringHasAnyOf.ParamsTypes

function TkwStringPos.string_Pos(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString): Integer;
 {* Реализация слова скрипта string:Pos }
//#UC START# *5568417001D5_851E99BEB53B_var*
//#UC END# *5568417001D5_851E99BEB53B_var*
begin
//#UC START# *5568417001D5_851E99BEB53B_impl*
 Result := l3Pos(anOther, aString);
//#UC END# *5568417001D5_851E99BEB53B_impl*
end;//TkwStringPos.string_Pos

procedure TkwStringPos.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_Pos(aCtx, l_aString, l_anOther));
end;//TkwStringPos.DoDoIt

class function TkwStringPos.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Pos';
end;//TkwStringPos.GetWordNameForRegister

function TkwStringPos.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringPos.GetResultTypeInfo

function TkwStringPos.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringPos.GetAllParamsCount

function TkwStringPos.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringPos.ParamsTypes

function TkwStringPosEx.string_PosEx(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString;
 aPos: Integer): Integer;
 {* Реализация слова скрипта string:PosEx }
//#UC START# *556841C601CF_24901BF384F4_var*
//#UC END# *556841C601CF_24901BF384F4_var*
begin
//#UC START# *556841C601CF_24901BF384F4_impl*
 Result := l3PosEx(anOther, aString, aPos);
//#UC END# *556841C601CF_24901BF384F4_impl*
end;//TkwStringPosEx.string_PosEx

procedure TkwStringPosEx.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
var l_aPos: Integer;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPos := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPos: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_PosEx(aCtx, l_aString, l_anOther, l_aPos));
end;//TkwStringPosEx.DoDoIt

class function TkwStringPosEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:PosEx';
end;//TkwStringPosEx.GetWordNameForRegister

function TkwStringPosEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringPosEx.GetResultTypeInfo

function TkwStringPosEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringPosEx.GetAllParamsCount

function TkwStringPosEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringPosEx.ParamsTypes

function TkwStringSplit.string_Split(const aCtx: TtfwContext;
 const aString: Il3CString;
 const anOther: Il3CString;
 out theTail: Il3CString): Il3CString;
 {* Реализация слова скрипта string:Split }
//#UC START# *5568423E01F3_AA63BC1F51EC_var*
var
(* l_P : Il3CString;
 l_S : Il3CString;*)
 l_Len : Integer;
//#UC END# *5568423E01F3_AA63BC1F51EC_var*
begin
//#UC START# *5568423E01F3_AA63BC1F51EC_impl*
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
//#UC END# *5568423E01F3_AA63BC1F51EC_impl*
end;//TkwStringSplit.string_Split

procedure TkwStringSplit.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anOther: Il3CString;
var l_theTail: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Split(aCtx, l_aString, l_anOther, l_theTail));
 aCtx.rEngine.PushString(l_theTail);
end;//TkwStringSplit.DoDoIt

class function TkwStringSplit.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Split';
end;//TkwStringSplit.GetWordNameForRegister

function TkwStringSplit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringSplit.GetResultTypeInfo

function TkwStringSplit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringSplit.GetAllParamsCount

function TkwStringSplit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringSplit.ParamsTypes

function TkwStringReplace.string_Replace(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* Реализация слова скрипта string:Replace }
//#UC START# *5568520B03B5_8CA688C2805E_var*
//#UC END# *5568520B03B5_8CA688C2805E_var*
begin
//#UC START# *5568520B03B5_8CA688C2805E_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll])
//#UC END# *5568520B03B5_8CA688C2805E_impl*
end;//TkwStringReplace.string_Replace

procedure TkwStringReplace.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aFrom: Il3CString;
var l_aMain: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Replace(aCtx, l_aString, l_aFrom, l_aMain));
end;//TkwStringReplace.DoDoIt

class function TkwStringReplace.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Replace';
end;//TkwStringReplace.GetWordNameForRegister

function TkwStringReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringReplace.GetResultTypeInfo

function TkwStringReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringReplace.GetAllParamsCount

function TkwStringReplace.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwStringReplace.ParamsTypes

function TkwStringReplaceFirst.string_ReplaceFirst(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* Реализация слова скрипта string:ReplaceFirst }
//#UC START# *5568523F03BE_FF1E0A42BBEF_var*
//#UC END# *5568523F03BE_FF1E0A42BBEF_var*
begin
//#UC START# *5568523F03BE_FF1E0A42BBEF_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll}])
//#UC END# *5568523F03BE_FF1E0A42BBEF_impl*
end;//TkwStringReplaceFirst.string_ReplaceFirst

procedure TkwStringReplaceFirst.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aFrom: Il3CString;
var l_aMain: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_ReplaceFirst(aCtx, l_aString, l_aFrom, l_aMain));
end;//TkwStringReplaceFirst.DoDoIt

class function TkwStringReplaceFirst.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ReplaceFirst';
end;//TkwStringReplaceFirst.GetWordNameForRegister

function TkwStringReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringReplaceFirst.GetResultTypeInfo

function TkwStringReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringReplaceFirst.GetAllParamsCount

function TkwStringReplaceFirst.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwStringReplaceFirst.ParamsTypes

function TkwTextReplace.text_Replace(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* Реализация слова скрипта text:Replace }
//#UC START# *556852510081_6F240EDBC3AE_var*
//#UC END# *556852510081_6F240EDBC3AE_var*
begin
//#UC START# *556852510081_6F240EDBC3AE_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [rfReplaceAll, rfIgnoreCase])
//#UC END# *556852510081_6F240EDBC3AE_impl*
end;//TkwTextReplace.text_Replace

procedure TkwTextReplace.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aFrom: Il3CString;
var l_aMain: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(text_Replace(aCtx, l_aString, l_aFrom, l_aMain));
end;//TkwTextReplace.DoDoIt

class function TkwTextReplace.GetWordNameForRegister: AnsiString;
begin
 Result := 'text:Replace';
end;//TkwTextReplace.GetWordNameForRegister

function TkwTextReplace.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwTextReplace.GetResultTypeInfo

function TkwTextReplace.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTextReplace.GetAllParamsCount

function TkwTextReplace.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwTextReplace.ParamsTypes

function TkwTextReplaceFirst.text_ReplaceFirst(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aFrom: Il3CString;
 const aMain: Il3CString): Il3CString;
 {* Реализация слова скрипта text:ReplaceFirst }
//#UC START# *5568525F008C_0527F8C9DF24_var*
//#UC END# *5568525F008C_0527F8C9DF24_var*
begin
//#UC START# *5568525F008C_0527F8C9DF24_impl*
 Result := l3StringReplace(aMain,
                           l3PCharLen(aFrom),
                           l3PCharLen(aString), [{rfReplaceAll,} rfIgnoreCase])
//#UC END# *5568525F008C_0527F8C9DF24_impl*
end;//TkwTextReplaceFirst.text_ReplaceFirst

procedure TkwTextReplaceFirst.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aFrom: Il3CString;
var l_aMain: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFrom := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFrom: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMain := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMain: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(text_ReplaceFirst(aCtx, l_aString, l_aFrom, l_aMain));
end;//TkwTextReplaceFirst.DoDoIt

class function TkwTextReplaceFirst.GetWordNameForRegister: AnsiString;
begin
 Result := 'text:ReplaceFirst';
end;//TkwTextReplaceFirst.GetWordNameForRegister

function TkwTextReplaceFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwTextReplaceFirst.GetResultTypeInfo

function TkwTextReplaceFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTextReplaceFirst.GetAllParamsCount

function TkwTextReplaceFirst.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwTextReplaceFirst.ParamsTypes

function TkwStringChar.string_Char(const aCtx: TtfwContext;
 const aString: Il3CString;
 anIndex: Integer): AnsiChar;
 {* Реализация слова скрипта string:[i] }
//#UC START# *55685FAB0248_9597582C9BD4_var*
//#UC END# *55685FAB0248_9597582C9BD4_var*
begin
//#UC START# *55685FAB0248_9597582C9BD4_impl*
 Result := aString.AsWStr.S[anIndex];
//#UC END# *55685FAB0248_9597582C9BD4_impl*
end;//TkwStringChar.string_Char

procedure TkwStringChar.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_anIndex: Integer;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar(string_Char(aCtx, l_aString, l_anIndex));
end;//TkwStringChar.DoDoIt

class function TkwStringChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[i]';
end;//TkwStringChar.GetWordNameForRegister

function TkwStringChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringChar.GetResultTypeInfo

function TkwStringChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringChar.GetAllParamsCount

function TkwStringChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringChar.ParamsTypes

function TkwStringCodePage.string_CodePage(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:CodePage }
//#UC START# *55685FD801DF_6CAF85926E0C_var*
//#UC END# *55685FD801DF_6CAF85926E0C_var*
begin
//#UC START# *55685FD801DF_6CAF85926E0C_impl*
 Result := aString.AsWStr.SCodePage;
//#UC END# *55685FD801DF_6CAF85926E0C_impl*
end;//TkwStringCodePage.string_CodePage

procedure TkwStringCodePage.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_CodePage(aCtx, l_aString));
end;//TkwStringCodePage.DoDoIt

class function TkwStringCodePage.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:CodePage';
end;//TkwStringCodePage.GetWordNameForRegister

function TkwStringCodePage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringCodePage.GetResultTypeInfo

function TkwStringCodePage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringCodePage.GetAllParamsCount

function TkwStringCodePage.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringCodePage.ParamsTypes

function TkwStringLen.string_Len(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:Len }
//#UC START# *55685FF101AC_0BA6E62BEF84_var*
//#UC END# *55685FF101AC_0BA6E62BEF84_var*
begin
//#UC START# *55685FF101AC_0BA6E62BEF84_impl*
 if (aString = nil) then
  Result := 0
 else
  Result := aString.AsWStr.SLen;
//#UC END# *55685FF101AC_0BA6E62BEF84_impl*
end;//TkwStringLen.string_Len

procedure TkwStringLen.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_Len(aCtx, l_aString));
end;//TkwStringLen.DoDoIt

class function TkwStringLen.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Len';
end;//TkwStringLen.GetWordNameForRegister

function TkwStringLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringLen.GetResultTypeInfo

function TkwStringLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringLen.GetAllParamsCount

function TkwStringLen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringLen.ParamsTypes

function TkwStringToChar.string_ToChar(const aCtx: TtfwContext;
 const aString: Il3CString): AnsiChar;
 {* Реализация слова скрипта string:ToChar }
//#UC START# *556860130209_CA33F456975C_var*
//#UC END# *556860130209_CA33F456975C_var*
begin
//#UC START# *556860130209_CA33F456975C_impl*
 RunnerAssert(aString.AsWStr.SLen = 1, 'Длина строки должна равняться 1', aCtx);
 Result := aString.AsWStr.S[0];
//#UC END# *556860130209_CA33F456975C_impl*
end;//TkwStringToChar.string_ToChar

procedure TkwStringToChar.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar(string_ToChar(aCtx, l_aString));
end;//TkwStringToChar.DoDoIt

class function TkwStringToChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ToChar';
end;//TkwStringToChar.GetWordNameForRegister

function TkwStringToChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringToChar.GetResultTypeInfo

function TkwStringToChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringToChar.GetAllParamsCount

function TkwStringToChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringToChar.ParamsTypes

function TkwCharToString.char_ToString(const aCtx: TtfwContext;
 aChar: AnsiChar): Il3CString;
 {* Реализация слова скрипта char:ToString }
//#UC START# *556866CA0045_4C3CAF64FEF3_var*
//#UC END# *556866CA0045_4C3CAF64FEF3_var*
begin
//#UC START# *556866CA0045_4C3CAF64FEF3_impl*
 Result := TtfwCStringFactory.C(aChar);
//#UC END# *556866CA0045_4C3CAF64FEF3_impl*
end;//TkwCharToString.char_ToString

class function TkwCharToString.GetWordNameForRegister: AnsiString;
begin
 Result := 'char:ToString';
end;//TkwCharToString.GetWordNameForRegister

function TkwCharToString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCharToString.GetResultTypeInfo

function TkwCharToString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCharToString.GetAllParamsCount

function TkwCharToString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(AnsiChar)]);
end;//TkwCharToString.ParamsTypes

procedure TkwCharToString.DoDoIt(const aCtx: TtfwContext);
var l_aChar: AnsiChar;
begin
 try
  l_aChar := aCtx.rEngine.PopChar;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChar: AnsiChar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(char_ToString(aCtx, l_aChar));
end;//TkwCharToString.DoDoIt

function TkwCharDupe.char_Dupe(const aCtx: TtfwContext;
 const aString: Il3CString;
 aCount: Integer): Il3CString;
 {* Реализация слова скрипта char:Dupe }
//#UC START# *55687BBF0087_355A8C3D70FA_var*
//#UC END# *55687BBF0087_355A8C3D70FA_var*
begin
//#UC START# *55687BBF0087_355A8C3D70FA_impl*
 Result := TtfwCStringFactory.C(ev_psFixLen('', aCount, l3Char(aString, 0)));
//#UC END# *55687BBF0087_355A8C3D70FA_impl*
end;//TkwCharDupe.char_Dupe

procedure TkwCharDupe.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aCount: Integer;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCount := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCount: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(char_Dupe(aCtx, l_aString, l_aCount));
end;//TkwCharDupe.DoDoIt

class function TkwCharDupe.GetWordNameForRegister: AnsiString;
begin
 Result := 'char:Dupe';
end;//TkwCharDupe.GetWordNameForRegister

function TkwCharDupe.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCharDupe.GetResultTypeInfo

function TkwCharDupe.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCharDupe.GetAllParamsCount

function TkwCharDupe.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwCharDupe.ParamsTypes

function TkwStringInc.string_Inc(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:++ }
//#UC START# *5603F61302F1_F3116B965978_var*
var
 l_P : Tl3PCharLen;
//#UC END# *5603F61302F1_F3116B965978_var*
begin
//#UC START# *5603F61302F1_F3116B965978_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(+1);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *5603F61302F1_F3116B965978_impl*
end;//TkwStringInc.string_Inc

procedure TkwStringInc.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Inc(aCtx, l_aString));
end;//TkwStringInc.DoDoIt

class function TkwStringInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:++';
end;//TkwStringInc.GetWordNameForRegister

function TkwStringInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringInc.GetResultTypeInfo

function TkwStringInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringInc.GetAllParamsCount

function TkwStringInc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringInc.ParamsTypes

function TkwStringShift.string_Shift(const aCtx: TtfwContext;
 const aString: Il3CString;
 aDelta: Integer): Il3CString;
 {* Реализация слова скрипта string:+ }
//#UC START# *5603F655014B_EFB7A59A9041_var*
var
 l_P : Tl3PCharLen;
//#UC END# *5603F655014B_EFB7A59A9041_var*
begin
//#UC START# *5603F655014B_EFB7A59A9041_impl*
 l_P := l3PCharLen(aString);
 l_P.Shift(aDelta);
 Result := TtfwCStringFactory.ViewOf(l_P);
//#UC END# *5603F655014B_EFB7A59A9041_impl*
end;//TkwStringShift.string_Shift

procedure TkwStringShift.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aDelta: Integer;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelta := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelta: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Shift(aCtx, l_aString, l_aDelta));
end;//TkwStringShift.DoDoIt

class function TkwStringShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:+';
end;//TkwStringShift.GetWordNameForRegister

function TkwStringShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringShift.GetResultTypeInfo

function TkwStringShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringShift.GetAllParamsCount

function TkwStringShift.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer)]);
end;//TkwStringShift.ParamsTypes

function TkwStringFirstChar.string_FirstChar(const aCtx: TtfwContext;
 const aString: Il3CString): AnsiChar;
 {* Реализация слова скрипта string:[] }
//#UC START# *5603F68D018F_4E9A5EC5FAC6_var*
//#UC END# *5603F68D018F_4E9A5EC5FAC6_var*
begin
//#UC START# *5603F68D018F_4E9A5EC5FAC6_impl*
 if l3IsNil(aString) then
  Result := #0
 else
  Result := aString.AsWStr.S[0];
//#UC END# *5603F68D018F_4E9A5EC5FAC6_impl*
end;//TkwStringFirstChar.string_FirstChar

procedure TkwStringFirstChar.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar(string_FirstChar(aCtx, l_aString));
end;//TkwStringFirstChar.DoDoIt

class function TkwStringFirstChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[]';
end;//TkwStringFirstChar.GetWordNameForRegister

function TkwStringFirstChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(AnsiChar);
end;//TkwStringFirstChar.GetResultTypeInfo

function TkwStringFirstChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringFirstChar.GetAllParamsCount

function TkwStringFirstChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringFirstChar.ParamsTypes

function TkwStringTrim.string_Trim(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:Trim }
//#UC START# *569E3511013C_95D9D233CD72_var*
//#UC END# *569E3511013C_95D9D233CD72_var*
begin
//#UC START# *569E3511013C_95D9D233CD72_impl*
 Result := TtfwCStringFactory.C(l3Trim(aString));
//#UC END# *569E3511013C_95D9D233CD72_impl*
end;//TkwStringTrim.string_Trim

procedure TkwStringTrim.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Trim(aCtx, l_aString));
end;//TkwStringTrim.DoDoIt

class function TkwStringTrim.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Trim';
end;//TkwStringTrim.GetWordNameForRegister

function TkwStringTrim.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringTrim.GetResultTypeInfo

function TkwStringTrim.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrim.GetAllParamsCount

function TkwStringTrim.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringTrim.ParamsTypes

function TkwStringTrimLeft.string_TrimLeft(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:TrimLeft }
//#UC START# *569E3529023A_2D2FC66E49DD_var*
//#UC END# *569E3529023A_2D2FC66E49DD_var*
begin
//#UC START# *569E3529023A_2D2FC66E49DD_impl*
 Result := TtfwCStringFactory.C(l3LTrim(aString));
//#UC END# *569E3529023A_2D2FC66E49DD_impl*
end;//TkwStringTrimLeft.string_TrimLeft

procedure TkwStringTrimLeft.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_TrimLeft(aCtx, l_aString));
end;//TkwStringTrimLeft.DoDoIt

class function TkwStringTrimLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:TrimLeft';
end;//TkwStringTrimLeft.GetWordNameForRegister

function TkwStringTrimLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringTrimLeft.GetResultTypeInfo

function TkwStringTrimLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrimLeft.GetAllParamsCount

function TkwStringTrimLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringTrimLeft.ParamsTypes

function TkwStringTrimRight.string_TrimRight(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:TrimRight }
//#UC START# *569E353501BE_807D7A8440DD_var*
//#UC END# *569E353501BE_807D7A8440DD_var*
begin
//#UC START# *569E353501BE_807D7A8440DD_impl*
 Result := TtfwCStringFactory.C(l3RTrim(aString, cc_WhiteSpace));
//#UC END# *569E353501BE_807D7A8440DD_impl*
end;//TkwStringTrimRight.string_TrimRight

procedure TkwStringTrimRight.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_TrimRight(aCtx, l_aString));
end;//TkwStringTrimRight.DoDoIt

class function TkwStringTrimRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:TrimRight';
end;//TkwStringTrimRight.GetWordNameForRegister

function TkwStringTrimRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringTrimRight.GetResultTypeInfo

function TkwStringTrimRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTrimRight.GetAllParamsCount

function TkwStringTrimRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringTrimRight.ParamsTypes

function TkwStringDeleteDoubleSpaces.string_DeleteDoubleSpaces(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:DeleteDoubleSpaces }
//#UC START# *569E3542031A_D5F09D866A34_var*
//#UC END# *569E3542031A_D5F09D866A34_var*
begin
//#UC START# *569E3542031A_D5F09D866A34_impl*
 Result := TtfwCStringFactory.C(l3DeleteDoubleSpace(aString));
//#UC END# *569E3542031A_D5F09D866A34_impl*
end;//TkwStringDeleteDoubleSpaces.string_DeleteDoubleSpaces

procedure TkwStringDeleteDoubleSpaces.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_DeleteDoubleSpaces(aCtx, l_aString));
end;//TkwStringDeleteDoubleSpaces.DoDoIt

class function TkwStringDeleteDoubleSpaces.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:DeleteDoubleSpaces';
end;//TkwStringDeleteDoubleSpaces.GetWordNameForRegister

function TkwStringDeleteDoubleSpaces.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringDeleteDoubleSpaces.GetResultTypeInfo

function TkwStringDeleteDoubleSpaces.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringDeleteDoubleSpaces.GetAllParamsCount

function TkwStringDeleteDoubleSpaces.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringDeleteDoubleSpaces.ParamsTypes

function TkwStringDeleteDoubleChars.string_DeleteDoubleChars(const aCtx: TtfwContext;
 const aString: Il3CString;
 const aChar: Il3CString): Il3CString;
 {* Реализация слова скрипта string:DeleteDoubleChars }
//#UC START# *569E355C01F2_30A1EAD7A5D9_var*
//#UC END# *569E355C01F2_30A1EAD7A5D9_var*
begin
//#UC START# *569E355C01F2_30A1EAD7A5D9_impl*
 Result := TtfwCStringFactory.C(l3DeleteSerias(aString, l3Char(aChar, 0))); 
//#UC END# *569E355C01F2_30A1EAD7A5D9_impl*
end;//TkwStringDeleteDoubleChars.string_DeleteDoubleChars

procedure TkwStringDeleteDoubleChars.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aChar: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aChar := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChar: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_DeleteDoubleChars(aCtx, l_aString, l_aChar));
end;//TkwStringDeleteDoubleChars.DoDoIt

class function TkwStringDeleteDoubleChars.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:DeleteDoubleChars';
end;//TkwStringDeleteDoubleChars.GetWordNameForRegister

function TkwStringDeleteDoubleChars.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringDeleteDoubleChars.GetResultTypeInfo

function TkwStringDeleteDoubleChars.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStringDeleteDoubleChars.GetAllParamsCount

function TkwStringDeleteDoubleChars.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStringDeleteDoubleChars.ParamsTypes

function TkwStringSubstring.string_Substring(const aCtx: TtfwContext;
 const aString: Il3CString;
 aPos: Integer;
 aLength: Integer): Il3CString;
 {* Реализация слова скрипта string:Substring }
//#UC START# *569E357D015D_2E3FD122E430_var*
//#UC END# *569E357D015D_2E3FD122E430_var*
begin
//#UC START# *569E357D015D_2E3FD122E430_impl*
 Result := TtfwCStringFactory.C(l3Copy(aString, aPos, aLength));
//#UC END# *569E357D015D_2E3FD122E430_impl*
end;//TkwStringSubstring.string_Substring

procedure TkwStringSubstring.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
var l_aPos: Integer;
var l_aLength: Integer;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPos := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPos: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLength := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLength: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Substring(aCtx, l_aString, l_aPos, l_aLength));
end;//TkwStringSubstring.DoDoIt

class function TkwStringSubstring.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Substring';
end;//TkwStringSubstring.GetWordNameForRegister

function TkwStringSubstring.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringSubstring.GetResultTypeInfo

function TkwStringSubstring.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwStringSubstring.GetAllParamsCount

function TkwStringSubstring.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwStringSubstring.ParamsTypes

function TkwStringLower.string_Lower(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:Lower }
//#UC START# *56AB7AC10249_B79BEA825961_var*
//#UC END# *56AB7AC10249_B79BEA825961_var*
begin
//#UC START# *56AB7AC10249_B79BEA825961_impl*
 Result := l3Lower(aString);
//#UC END# *56AB7AC10249_B79BEA825961_impl*
end;//TkwStringLower.string_Lower

procedure TkwStringLower.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Lower(aCtx, l_aString));
end;//TkwStringLower.DoDoIt

class function TkwStringLower.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Lower';
end;//TkwStringLower.GetWordNameForRegister

function TkwStringLower.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringLower.GetResultTypeInfo

function TkwStringLower.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringLower.GetAllParamsCount

function TkwStringLower.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringLower.ParamsTypes

function TkwStringUpper.string_Upper(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:Upper }
//#UC START# *56AB7AD00352_8BA4B632B802_var*
//#UC END# *56AB7AD00352_8BA4B632B802_var*
begin
//#UC START# *56AB7AD00352_8BA4B632B802_impl*
 Result := l3Upper(aString);
//#UC END# *56AB7AD00352_8BA4B632B802_impl*
end;//TkwStringUpper.string_Upper

procedure TkwStringUpper.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Upper(aCtx, l_aString));
end;//TkwStringUpper.DoDoIt

class function TkwStringUpper.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Upper';
end;//TkwStringUpper.GetWordNameForRegister

function TkwStringUpper.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringUpper.GetResultTypeInfo

function TkwStringUpper.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringUpper.GetAllParamsCount

function TkwStringUpper.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringUpper.ParamsTypes

function TkwStringToUnicode.string_ToUnicode(const aCtx: TtfwContext;
 const aString: Il3CString): Il3CString;
 {* Реализация слова скрипта string:ToUnicode }
//#UC START# *56F3E6A203DB_F137872D0D02_var*
//#UC END# *56F3E6A203DB_F137872D0D02_var*
begin
//#UC START# *56F3E6A203DB_F137872D0D02_impl*
 Result := TtfwCStringFactory.ToUnicode(aString);
//#UC END# *56F3E6A203DB_F137872D0D02_impl*
end;//TkwStringToUnicode.string_ToUnicode

procedure TkwStringToUnicode.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_ToUnicode(aCtx, l_aString));
end;//TkwStringToUnicode.DoDoIt

class function TkwStringToUnicode.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:ToUnicode';
end;//TkwStringToUnicode.GetWordNameForRegister

function TkwStringToUnicode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringToUnicode.GetResultTypeInfo

function TkwStringToUnicode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringToUnicode.GetAllParamsCount

function TkwStringToUnicode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringToUnicode.ParamsTypes

function TkwStringHash.string_Hash(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:Hash }
//#UC START# *56F3E6BE0100_58C52E8D04B3_var*
//#UC END# *56F3E6BE0100_58C52E8D04B3_var*
begin
//#UC START# *56F3E6BE0100_58C52E8D04B3_impl*
 Result := m2Hash16(l3DStr(TtfwCStringFactory.ToUnicode(aString)), Cm2HASVersionCRC);
//#UC END# *56F3E6BE0100_58C52E8D04B3_impl*
end;//TkwStringHash.string_Hash

procedure TkwStringHash.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_Hash(aCtx, l_aString));
end;//TkwStringHash.DoDoIt

class function TkwStringHash.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Hash';
end;//TkwStringHash.GetWordNameForRegister

function TkwStringHash.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringHash.GetResultTypeInfo

function TkwStringHash.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringHash.GetAllParamsCount

function TkwStringHash.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringHash.ParamsTypes

function TkwStringSmallHash.string_SmallHash(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:SmallHash }
//#UC START# *56F3E6D102C5_15AF617143C8_var*
//#UC END# *56F3E6D102C5_15AF617143C8_var*
begin
//#UC START# *56F3E6D102C5_15AF617143C8_impl*
 Result := m2SmallHash16(l3DStr(TtfwCStringFactory.ToUnicode(aString)), Cm2HASVersionCRC);
//#UC END# *56F3E6D102C5_15AF617143C8_impl*
end;//TkwStringSmallHash.string_SmallHash

procedure TkwStringSmallHash.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_SmallHash(aCtx, l_aString));
end;//TkwStringSmallHash.DoDoIt

class function TkwStringSmallHash.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:SmallHash';
end;//TkwStringSmallHash.GetWordNameForRegister

function TkwStringSmallHash.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringSmallHash.GetResultTypeInfo

function TkwStringSmallHash.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringSmallHash.GetAllParamsCount

function TkwStringSmallHash.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringSmallHash.ParamsTypes

function TkwStringIterator.string_Iterator(const aCtx: TtfwContext;
 const aString: Il3CString): ItfwValueList;
 {* Реализация слова скрипта string:Iterator }
//#UC START# *56F3EF7C0205_AE2A1F9F2367_var*
//#UC END# *56F3EF7C0205_AE2A1F9F2367_var*
begin
//#UC START# *56F3EF7C0205_AE2A1F9F2367_impl*
 Result := TtfwStringIterator.Make(aString);
//#UC END# *56F3EF7C0205_AE2A1F9F2367_impl*
end;//TkwStringIterator.string_Iterator

procedure TkwStringIterator.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(string_Iterator(aCtx, l_aString));
end;//TkwStringIterator.DoDoIt

class function TkwStringIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Iterator';
end;//TkwStringIterator.GetWordNameForRegister

function TkwStringIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwStringIterator.GetResultTypeInfo

function TkwStringIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringIterator.GetAllParamsCount

function TkwStringIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringIterator.ParamsTypes

function TkwStringHashNew.string_Hash_New(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:Hash:New }
//#UC START# *56F40BBA029D_B0A153973998_var*
//#UC END# *56F40BBA029D_B0A153973998_var*
begin
//#UC START# *56F40BBA029D_B0A153973998_impl*
 Result := m2Hash16(l3DStr(TtfwCStringFactory.ToUnicode(aString)), Cm2HASVersionCRC + 1);
//#UC END# *56F40BBA029D_B0A153973998_impl*
end;//TkwStringHashNew.string_Hash_New

procedure TkwStringHashNew.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_Hash_New(aCtx, l_aString));
end;//TkwStringHashNew.DoDoIt

class function TkwStringHashNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Hash:New';
end;//TkwStringHashNew.GetWordNameForRegister

function TkwStringHashNew.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringHashNew.GetResultTypeInfo

function TkwStringHashNew.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringHashNew.GetAllParamsCount

function TkwStringHashNew.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringHashNew.ParamsTypes

function TkwStringSmallHashNew.string_SmallHash_New(const aCtx: TtfwContext;
 const aString: Il3CString): Integer;
 {* Реализация слова скрипта string:SmallHash:New }
//#UC START# *56F40BD3026A_A91467BC2C27_var*
//#UC END# *56F40BD3026A_A91467BC2C27_var*
begin
//#UC START# *56F40BD3026A_A91467BC2C27_impl*
 Result := m2SmallHash16(l3DStr(TtfwCStringFactory.ToUnicode(aString)), Cm2HASVersionCRC + 1);
//#UC END# *56F40BD3026A_A91467BC2C27_impl*
end;//TkwStringSmallHashNew.string_SmallHash_New

procedure TkwStringSmallHashNew.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(string_SmallHash_New(aCtx, l_aString));
end;//TkwStringSmallHashNew.DoDoIt

class function TkwStringSmallHashNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:SmallHash:New';
end;//TkwStringSmallHashNew.GetWordNameForRegister

function TkwStringSmallHashNew.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStringSmallHashNew.GetResultTypeInfo

function TkwStringSmallHashNew.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringSmallHashNew.GetAllParamsCount

function TkwStringSmallHashNew.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringSmallHashNew.ParamsTypes

function TkwStringTransliterate.string_Transliterate(const aCtx: TtfwContext;
 const aString: Il3CString): AnsiString;
 {* Реализация слова скрипта string:Transliterate }
//#UC START# *5718A63E039C_FDCE9825C3FB_var*
//#UC END# *5718A63E039C_FDCE9825C3FB_var*
begin
//#UC START# *5718A63E039C_FDCE9825C3FB_impl*
 Result := l3Transliterate(l3Str(aString));
//#UC END# *5718A63E039C_FDCE9825C3FB_impl*
end;//TkwStringTransliterate.string_Transliterate

procedure TkwStringTransliterate.DoDoIt(const aCtx: TtfwContext);
var l_aString: Il3CString;
begin
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(string_Transliterate(aCtx, l_aString));
end;//TkwStringTransliterate.DoDoIt

class function TkwStringTransliterate.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:Transliterate';
end;//TkwStringTransliterate.GetWordNameForRegister

function TkwStringTransliterate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwStringTransliterate.GetResultTypeInfo

function TkwStringTransliterate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStringTransliterate.GetAllParamsCount

function TkwStringTransliterate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStringTransliterate.ParamsTypes

procedure TkwVarDecLen.VarDecLen(const aCtx: TtfwContext;
 aVar: TtfwWord);
 {* Реализация слова скрипта string:--Len! }
//#UC START# *55686F4301AB_55686F4301AB_Word_var*
var
 l_P : Tl3PCharLen;
//#UC END# *55686F4301AB_55686F4301AB_Word_var*
begin
//#UC START# *55686F4301AB_55686F4301AB_Word_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 Dec(l_P.SLen);
 Assert(l_P.SLen >= 0);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *55686F4301AB_55686F4301AB_Word_impl*
end;//TkwVarDecLen.VarDecLen

class function TkwVarDecLen.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:--Len!';
end;//TkwVarDecLen.GetWordNameForRegister

function TkwVarDecLen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVarDecLen.GetResultTypeInfo

function TkwVarDecLen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarDecLen.GetAllParamsCount

function TkwVarDecLen.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarDecLen.RightParamsCount

function TkwVarDecLen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVarDecLen.ParamsTypes

procedure TkwVarDecLen.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarDecLen(aCtx, l_aVar);
end;//TkwVarDecLen.DoRun

procedure TkwVarInc.VarInc(const aCtx: TtfwContext;
 aVar: TtfwWord);
 {* Реализация слова скрипта string:++! }
//#UC START# *55686F75015A_55686F75015A_Word_var*
var
 l_P : Tl3PCharLen;
//#UC END# *55686F75015A_55686F75015A_Word_var*
begin
//#UC START# *55686F75015A_55686F75015A_Word_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *55686F75015A_55686F75015A_Word_impl*
end;//TkwVarInc.VarInc

class function TkwVarInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:++!';
end;//TkwVarInc.GetWordNameForRegister

function TkwVarInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVarInc.GetResultTypeInfo

function TkwVarInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarInc.GetAllParamsCount

function TkwVarInc.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarInc.RightParamsCount

function TkwVarInc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVarInc.ParamsTypes

procedure TkwVarInc.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarInc(aCtx, l_aVar);
end;//TkwVarInc.DoRun

function TkwRSplitTo.RSplitTo(const aCtx: TtfwContext;
 aVar: TtfwWord;
 const aDelim: Il3CString): Il3CString;
 {* Реализация слова скрипта string:RSplitTo! }
//#UC START# *55686F9A037E_55686F9A037E_Word_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Found : PAnsiChar;

 //l_Pref : Il3CString;
 //l_Suff : Il3CString;
//#UC END# *55686F9A037E_55686F9A037E_Word_var*
begin
//#UC START# *55686F9A037E_55686F9A037E_Word_impl*
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
  Assert(false, 'Пока не реализовано');
  Result := nil;
 end;//l_WS.SLen = 1
//#UC END# *55686F9A037E_55686F9A037E_Word_impl*
end;//TkwRSplitTo.RSplitTo

class function TkwRSplitTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:RSplitTo!';
end;//TkwRSplitTo.GetWordNameForRegister

function TkwRSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwRSplitTo.GetResultTypeInfo

function TkwRSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwRSplitTo.GetAllParamsCount

function TkwRSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRSplitTo.RightParamsCount

function TkwRSplitTo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwRSplitTo.ParamsTypes

procedure TkwRSplitTo.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
var l_aDelim: Il3CString;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelim := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelim: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(RSplitTo(aCtx, l_aVar, l_aDelim));
end;//TkwRSplitTo.DoRun

procedure TkwVarShift.VarShift(const aCtx: TtfwContext;
 aVar: TtfwWord;
 aNum: Integer);
 {* Реализация слова скрипта string:+! }
//#UC START# *55686FC6020D_55686FC6020D_Word_var*
var
 l_P : Tl3PCharLen;
//#UC END# *55686FC6020D_55686FC6020D_Word_var*
begin
//#UC START# *55686FC6020D_55686FC6020D_Word_impl*
 Tl3WString(l_P) := l3PCharLen(aVar.GetValue(aCtx).AsString);
 l_P.Shift(aNum);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *55686FC6020D_55686FC6020D_Word_impl*
end;//TkwVarShift.VarShift

class function TkwVarShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:+!';
end;//TkwVarShift.GetWordNameForRegister

function TkwVarShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVarShift.GetResultTypeInfo

function TkwVarShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwVarShift.GetAllParamsCount

function TkwVarShift.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarShift.RightParamsCount

function TkwVarShift.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVarShift.ParamsTypes

procedure TkwVarShift.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
var l_aNum: Integer;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 VarShift(aCtx, l_aVar, l_aNum);
end;//TkwVarShift.DoRun

function TkwSplitTo.SplitTo(const aCtx: TtfwContext;
 aVar: TtfwWord;
 const aDelim: Il3CString): Il3CString;
 {* Реализация слова скрипта string:SplitTo! }
//#UC START# *55686FEE03A7_55686FEE03A7_Word_var*
var
 l_V : Il3CString;
 l_P : Tl3PCharLen;
 l_WS : Tl3WString;
 l_Rest : Tl3WString;

 l_Pref : Il3CString;
 l_Suff : Il3CString;
//#UC END# *55686FEE03A7_55686FEE03A7_Word_var*
begin
//#UC START# *55686FEE03A7_55686FEE03A7_Word_impl*
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
  //Assert(false, 'Пока не реализовано');
 end;//l_WS.SLen = 1
//#UC END# *55686FEE03A7_55686FEE03A7_Word_impl*
end;//TkwSplitTo.SplitTo

class function TkwSplitTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:SplitTo!';
end;//TkwSplitTo.GetWordNameForRegister

function TkwSplitTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSplitTo.GetResultTypeInfo

function TkwSplitTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSplitTo.GetAllParamsCount

function TkwSplitTo.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSplitTo.RightParamsCount

function TkwSplitTo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSplitTo.ParamsTypes

procedure TkwSplitTo.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
var l_aDelim: Il3CString;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelim := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelim: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(SplitTo(aCtx, l_aVar, l_aDelim));
end;//TkwSplitTo.DoRun

function TkwVarPushCharAndInc.VarPushCharAndInc(const aCtx: TtfwContext;
 aVar: TtfwWord): AnsiChar;
 {* Реализация слова скрипта string:[]++! }
//#UC START# *5603F5980215_5603F5980215_Word_var*
var
 l_P : Tl3PCharLen;
//#UC END# *5603F5980215_5603F5980215_Word_var*
begin
//#UC START# *5603F5980215_5603F5980215_Word_impl*
 Tl3WString(l_P) := aVar.GetValue(aCtx).AsString.AsWStr;
 Result := l_P.S^;
 l_P.Shift(+1);
 aVar.SetValue(TtfwCStringFactoryEx.ViewOf(l_P), aCtx);
//#UC END# *5603F5980215_5603F5980215_Word_impl*
end;//TkwVarPushCharAndInc.VarPushCharAndInc

class function TkwVarPushCharAndInc.GetWordNameForRegister: AnsiString;
begin
 Result := 'string:[]++!';
end;//TkwVarPushCharAndInc.GetWordNameForRegister

function TkwVarPushCharAndInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(AnsiChar);
end;//TkwVarPushCharAndInc.GetResultTypeInfo

function TkwVarPushCharAndInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarPushCharAndInc.GetAllParamsCount

function TkwVarPushCharAndInc.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVarPushCharAndInc.RightParamsCount

function TkwVarPushCharAndInc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVarPushCharAndInc.ParamsTypes

procedure TkwVarPushCharAndInc.DoRun(const aCtx: TtfwContext);
var l_aVar: TtfwWord;
begin
 try
  l_aVar := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVar: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushChar(VarPushCharAndInc(aCtx, l_aVar));
end;//TkwVarPushCharAndInc.DoRun

function TkwHash16Table.Hash16Table(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта Hash16Table }
//#UC START# *56F3E8880129_56F3E8880129_Word_var*
//#UC END# *56F3E8880129_56F3E8880129_Word_var*
begin
//#UC START# *56F3E8880129_56F3E8880129_Word_impl*
 Result := TtfwHash16Table.Make;
//#UC END# *56F3E8880129_56F3E8880129_Word_impl*
end;//TkwHash16Table.Hash16Table

class function TkwHash16Table.GetWordNameForRegister: AnsiString;
begin
 Result := 'Hash16Table';
end;//TkwHash16Table.GetWordNameForRegister

function TkwHash16Table.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwHash16Table.GetResultTypeInfo

function TkwHash16Table.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwHash16Table.GetAllParamsCount

function TkwHash16Table.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwHash16Table.ParamsTypes

procedure TkwHash16Table.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(Hash16Table(aCtx));
end;//TkwHash16Table.DoDoIt

class function TtfwIl3CStringPackResNameGetter.ResName: AnsiString;
begin
 Result := 'tfwIl3CStringPack';
end;//TtfwIl3CStringPackResNameGetter.ResName

 {$R tfwIl3CStringPack.res}

initialization
 TkwStartsStr.RegisterInEngine;
 {* Регистрация StartsStr }
 TkwStartsText.RegisterInEngine;
 {* Регистрация StartsText }
 TkwEndsStr.RegisterInEngine;
 {* Регистрация EndsStr }
 TkwEndsText.RegisterInEngine;
 {* Регистрация EndsText }
 TkwSameStr.RegisterInEngine;
 {* Регистрация SameStr }
 TkwSameText.RegisterInEngine;
 {* Регистрация SameText }
 TkwCompareStr.RegisterInEngine;
 {* Регистрация CompareStr }
 TkwCompareText.RegisterInEngine;
 {* Регистрация CompareText }
 TkwStrToInt.RegisterInEngine;
 {* Регистрация StrToInt }
 TkwCat.RegisterInEngine;
 {* Регистрация Cat }
 TkwStringConsistsOf.RegisterInEngine;
 {* Регистрация string_ConsistsOf }
 TkwStringHasAnyOf.RegisterInEngine;
 {* Регистрация string_HasAnyOf }
 TkwStringPos.RegisterInEngine;
 {* Регистрация string_Pos }
 TkwStringPosEx.RegisterInEngine;
 {* Регистрация string_PosEx }
 TkwStringSplit.RegisterInEngine;
 {* Регистрация string_Split }
 TkwStringReplace.RegisterInEngine;
 {* Регистрация string_Replace }
 TkwStringReplaceFirst.RegisterInEngine;
 {* Регистрация string_ReplaceFirst }
 TkwTextReplace.RegisterInEngine;
 {* Регистрация text_Replace }
 TkwTextReplaceFirst.RegisterInEngine;
 {* Регистрация text_ReplaceFirst }
 TkwStringChar.RegisterInEngine;
 {* Регистрация string_Char }
 TkwStringCodePage.RegisterInEngine;
 {* Регистрация string_CodePage }
 TkwStringLen.RegisterInEngine;
 {* Регистрация string_Len }
 TkwStringToChar.RegisterInEngine;
 {* Регистрация string_ToChar }
 TkwCharToString.RegisterInEngine;
 {* Регистрация char_ToString }
 TkwCharDupe.RegisterInEngine;
 {* Регистрация char_Dupe }
 TkwStringInc.RegisterInEngine;
 {* Регистрация string_Inc }
 TkwStringShift.RegisterInEngine;
 {* Регистрация string_Shift }
 TkwStringFirstChar.RegisterInEngine;
 {* Регистрация string_FirstChar }
 TkwStringTrim.RegisterInEngine;
 {* Регистрация string_Trim }
 TkwStringTrimLeft.RegisterInEngine;
 {* Регистрация string_TrimLeft }
 TkwStringTrimRight.RegisterInEngine;
 {* Регистрация string_TrimRight }
 TkwStringDeleteDoubleSpaces.RegisterInEngine;
 {* Регистрация string_DeleteDoubleSpaces }
 TkwStringDeleteDoubleChars.RegisterInEngine;
 {* Регистрация string_DeleteDoubleChars }
 TkwStringSubstring.RegisterInEngine;
 {* Регистрация string_Substring }
 TkwStringLower.RegisterInEngine;
 {* Регистрация string_Lower }
 TkwStringUpper.RegisterInEngine;
 {* Регистрация string_Upper }
 TkwStringToUnicode.RegisterInEngine;
 {* Регистрация string_ToUnicode }
 TkwStringHash.RegisterInEngine;
 {* Регистрация string_Hash }
 TkwStringSmallHash.RegisterInEngine;
 {* Регистрация string_SmallHash }
 TkwStringIterator.RegisterInEngine;
 {* Регистрация string_Iterator }
 TkwStringHashNew.RegisterInEngine;
 {* Регистрация string_Hash_New }
 TkwStringSmallHashNew.RegisterInEngine;
 {* Регистрация string_SmallHash_New }
 TkwStringTransliterate.RegisterInEngine;
 {* Регистрация string_Transliterate }
 TkwVarDecLen.RegisterInEngine;
 {* Регистрация VarDecLen }
 TkwVarInc.RegisterInEngine;
 {* Регистрация VarInc }
 TkwRSplitTo.RegisterInEngine;
 {* Регистрация RSplitTo }
 TkwVarShift.RegisterInEngine;
 {* Регистрация VarShift }
 TkwSplitTo.RegisterInEngine;
 {* Регистрация SplitTo }
 TkwVarPushCharAndInc.RegisterInEngine;
 {* Регистрация VarPushCharAndInc }
 TkwHash16Table.RegisterInEngine;
 {* Регистрация Hash16Table }
 TtfwIl3CStringPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiChar));
 {* Регистрация типа AnsiChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
