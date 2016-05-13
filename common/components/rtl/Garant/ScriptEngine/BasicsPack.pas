unit BasicsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "BasicsPack" MUID: (4F43A128007E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwTypeInfo
 , tfwScriptingInterfaces
 , kwCompiledWordWorker
 , l3Interfaces
;

type
 TkwCompiledPushWord = class(TkwCompiledWordWorker)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetRef(const aCtx: TtfwContext): TtfwWord; override;
   function WordName: Il3CString; override;
 end;//TkwCompiledPushWord

function CompareValues(const aV1: TtfwStackValue;
 const aV2: TtfwStackValue;
 const aCtx: TtfwContext;
 aCaller: TtfwWord): Boolean;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwConstLike
 , kwCompiledWordPrim
 , tfwGlobalKeyWord
 , TypInfo
 , tfwWordWorkerEx
 , tfwParserInterfaces
 , tfwAxiomaticsResNameGetter
 , l3Chars
 , Windows
 , l3String
 , l3MessagesService
 , tfwClassRef
 , Classes
 , l3Math
 , l3Base
 , kwInteger
 , kwString
 , kwValue
 , kwWordPtrPushWord
 , kwForwardDeclarationHolder
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwDefine = {final} class(TtfwConstLike)
  protected
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
    aCompiled: TkwCompiledWordPrim;
    const aContext: TtfwContext); override;
    {* Завершает определение вновь созданного слова }
   function GetNewWordName(const aContext: TtfwContext): Il3CString; override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
 end;//TkwDefine

 TkwTrue = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта True }
  private
   function True(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта True }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTrue

 TkwFalse = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта False }
  private
   function False(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта False }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFalse

 TkwMsg = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Msg }
  private
   procedure Msg(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта Msg }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsg

 TkwPrint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта . }
  private
   procedure Print(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта . }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPrint

 TkwLOOP = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта LOOP }
  private
   procedure LOOP(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCount: Integer);
    {* Реализация слова скрипта LOOP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwLOOP

 TkwWHILEDO = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WHILEDO }
  private
   procedure WHILEDO(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: TtfwWord);
    {* Реализация слова скрипта WHILEDO }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWHILEDO

 TkwBREAK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBREAK

 TkwCONTINUE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CONTINUE }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCONTINUE

 TkwEXIT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EXIT }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEXIT

 TkwHALT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта HALT }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwHALT

 TkwBREAKITERATOR = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK-ITERATOR }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBREAKITERATOR

 TkwNOP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NOP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNOP

 TkwSLEEP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SLEEP }
  private
   procedure SLEEP(const aCtx: TtfwContext;
    aDuration: Integer);
    {* Реализация слова скрипта SLEEP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSLEEP

 TkwProcessMessages = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ProcessMessages }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwProcessMessages

 TkwCheckAssert = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ASSERT }
  private
   procedure CheckAssert(const aCtx: TtfwContext;
    aCondition: Boolean);
    {* Реализация слова скрипта ASSERT }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCheckAssert

 TkwASSERTS = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ASSERTS }
  private
   procedure ASSERTS(const aCtx: TtfwContext;
    const aMsg: AnsiString;
    aCondition: Boolean);
    {* Реализация слова скрипта ASSERTS }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwASSERTS

 TkwNil = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта nil }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNil

 TkwDoWord = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DO }
  private
   procedure DoWord(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта DO }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDoWord

 TkwSmartEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?== }
  private
   function SmartEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
    {* Реализация слова скрипта ?== }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartEquals

 TkwSmartNotEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?!= }
  private
   function SmartNotEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
    {* Реализация слова скрипта ?!= }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartNotEquals

 TkwPushWord = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта @ }
  private
   function PushWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта @ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function SuppressNextImmediate(const aContext: TtfwContext;
    aWordNumber: Integer): TtfwSuppressNextImmediate; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwPushWord

 TkwCurrentException = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception }
  private
   function current_exception(const aCtx: TtfwContext): TObject;
    {* Реализация слова скрипта current:exception }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentException

 TkwCurrentExceptionClass = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:class }
  private
   function current_exception_class(const aCtx: TtfwContext): TClass;
    {* Реализация слова скрипта current:exception:class }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClass

 TkwCurrentExceptionClassName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:ClassName }
  private
   function current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта current:exception:ClassName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClassName

 TkwCurrentExceptionMessage = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:Message }
  private
   function current_exception_Message(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта current:exception:Message }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionMessage

 TkwInc = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ++ }
  private
   function Inc(const aCtx: TtfwContext;
    aValue: Integer): Integer;
    {* Реализация слова скрипта ++ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwInc

 TkwDec = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта -- }
  private
   function Dec(const aCtx: TtfwContext;
    aValue: Integer): Integer;
    {* Реализация слова скрипта -- }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDec

 TkwAdd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта + }
  private
   function Add(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): TtfwStackValue;
    {* Реализация слова скрипта + }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdd

 TkwSub = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта - }
  private
   function Sub(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта - }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSub

 TkwDivision = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DIV }
  private
   function Division(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта DIV }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivision

 TkwMul = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта * }
  private
   function Mul(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта * }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul

 TkwDivide = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта / }
  private
   function Divide(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта / }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivide

 TkwMul2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2* }
  private
   function Mul2(const aCtx: TtfwContext;
    aA: Integer): Integer;
    {* Реализация слова скрипта 2* }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul2

 TkwDiv2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2/ }
  private
   function Div2(const aCtx: TtfwContext;
    aA: Integer): Integer;
    {* Реализация слова скрипта 2/ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDiv2

 TkwMulDiv = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта */ }
  private
   function MulDiv(const aCtx: TtfwContext;
    aC: Integer;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта */ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMulDiv

 TkwBoolNot = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ! }
  private
   function BoolNot(const aCtx: TtfwContext;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта ! }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolNot

 TkwModFromDiv = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MOD }
  private
   function ModFromDiv(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта MOD }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwModFromDiv

 TkwBoolAnd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта && }
  private
   function BoolAnd(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта && }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolAnd

 TkwBoolOr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта || }
  private
   function BoolOr(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта || }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolOr

 TkwNotZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта !=0 }
  private
   function NotZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
    {* Реализация слова скрипта !=0 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotZero

 TkwEqualZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта =0 }
  private
   function EqualZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
    {* Реализация слова скрипта =0 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEqualZero

 TkwSWAP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SWAP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSWAP

 TkwDROP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DROP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDROP

 TkwDUP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DUP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUP

 TkwDUPIfNotZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?DUP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUPIfNotZero

 TkwROT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ROT }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwROT

 TkwPICK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта PICK }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPICK

 TkwInvertROT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта -ROT }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwInvertROT

 TkwSWAP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2SWAP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSWAP2

 TkwOVER2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2OVER }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwOVER2

 TkwDUP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DUP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUP2

 TkwDROP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DROP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDROP2

 TkwNIP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NIP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNIP

 TkwTUCK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта TUCK }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTUCK

 TkwOVER = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта OVER }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwOVER

 TkwROLL = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ROLL }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwROLL

 TkwNotEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта != }
  private
   function NotEquals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта != }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotEquals

 TkwGREATER = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GREATER }
  private
   function GREATER(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта GREATER }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGREATER

 TkwLESS = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта LESS }
  private
   function LESS(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта LESS }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLESS

 TkwEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта == }
  private
   function Equals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта == }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEquals

 TkwLessThanZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта <0 }
  private
   function LessThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
    {* Реализация слова скрипта <0 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLessThanZero

 TkwGreaterThanZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта >0 }
  private
   function GreaterThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
    {* Реализация слова скрипта >0 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGreaterThanZero

 TkwBitAnd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта & }
  private
   function BitAnd(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта & }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitAnd

 TkwBitOR = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта | }
  private
   function BitOR(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта | }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitOR

 TkwBitNot = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ~ }
  private
   function BitNot(const aCtx: TtfwContext;
    aB: Integer): Integer;
    {* Реализация слова скрипта ~ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitNot

 TkwStackLevel = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StackLevel }
  private
   function StackLevel(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта StackLevel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStackLevel

 TkwReduceStackLevel = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ReduceStackLevel }
  private
   procedure ReduceStackLevel(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта ReduceStackLevel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwReduceStackLevel

 TkwCtxParserPushString = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushString }
  private
   procedure Ctx_Parser_PushString(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:Parser:PushString }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushString

 TkwCtxParserPushSymbol = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushSymbol }
  private
   procedure Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:Parser:PushSymbol }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushSymbol

 TkwCtxParserPushInt = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushInt }
  private
   procedure Ctx_Parser_PushInt(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта Ctx:Parser:PushInt }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushInt

 TkwCtxParser = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser }
  private
   function Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
    {* Реализация слова скрипта Ctx:Parser }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParser

 TkwAtomicIf = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта ? }
  private
   procedure AtomicIf(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: Boolean);
    {* Реализация слова скрипта ? }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwAtomicIf

 TkwCompileValue = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileValue }
  private
   procedure CompileValue(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileValue }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileValue

 TkwIMMEDIATE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IMMEDIATE }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
 end;//TkwIMMEDIATE

 TkwCtxScriptCaller = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ScriptCaller }
  private
   function Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
    {* Реализация слова скрипта Ctx:ScriptCaller }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxScriptCaller

 TkwCtxEngine = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Engine }
  private
   function Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
    {* Реализация слова скрипта Ctx:Engine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxEngine

 TkwCtxStoredValuesStack = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StoredValuesStack }
  private
   function Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
    {* Реализация слова скрипта Ctx:StoredValuesStack }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxStoredValuesStack

 TkwCreateAndRaise = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CreateAndRaise }
  private
   procedure CreateAndRaise(const aCtx: TtfwContext;
    aClass: TClass;
    const aMessage: AnsiString);
    {* Реализация слова скрипта CreateAndRaise }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateAndRaise

 TkwCompileRef = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileRef }
  private
   procedure CompileRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileRef

 TkwCompileWeakRef = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileWeakRef }
  private
   procedure CompileWeakRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileWeakRef }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileWeakRef

 TkwDUPN = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DUPN }
  private
   procedure DUPN(const aCtx: TtfwContext;
    aN: Integer);
    {* Реализация слова скрипта DUPN }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUPN

 TkwDROPN = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DROPN }
  private
   procedure DROPN(const aCtx: TtfwContext;
    aN: Integer);
    {* Реализация слова скрипта DROPN }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDROPN

 TBasicsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TBasicsPackResNameGetter

function CompareValues(const aV1: TtfwStackValue;
 const aV2: TtfwStackValue;
 const aCtx: TtfwContext;
 aCaller: TtfwWord): Boolean;
//#UC START# *4F51EE02033C_4F43A128007E_var*

 procedure CompareAsPrintable;
 begin//CompareAsPrintable
  Result := l3Same(aV1.AsPrintable, aV2.AsPrintable);
 end;//CompareAsPrintable

var
 l_C : AnsiChar;
//#UC END# *4F51EE02033C_4F43A128007E_var*
begin
//#UC START# *4F51EE02033C_4F43A128007E_impl*
 Result := false;
 if (aV1.rType = aV2.rType) then
 begin
  Case aV1.rType of
   tfw_vtVoid:
    Result := true;
   tfw_vtInt:
    Result := (aV1.rInteger = aV2.rInteger);
   tfw_vtBool:
    Result := (aV1.AsBoolean = aV2.AsBoolean);
   tfw_vtStr:
    Result := l3Same(aV1.AsString, aV2.AsString);
   tfw_vtObj:
    Result := (aV1.AsObject = aV2.AsObject);
   tfw_vtList:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtIntf:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtNil:
    Result := true;
   tfw_vtFile:
    Result := (aV1.AsIntf = aV2.AsIntf);
   tfw_vtChar:
    Result := (aV1.AsChar = aV2.AsChar);
(*   tfw_vtWStr:
    Result := l3Same(aV1.AsWString, aV2.AsWString);*)
(*   tfw_vtBracket:
    Result := true;*)
   else
    aCaller.RunnerError('Неизвестный тип для сравнения', aCtx);
  end;//aV1.rType
 end//aV1.rType = aV2.rType
 else
 begin
  Case aV1.rType of
(*   tfw_svtVoid:
    Result := true;
   tfw_svtInt:
    Result := (aV1.rInteger = aV2.rInteger);
   tfw_svtBool:
    Result := (aV1.AsBoolean = aV2.AsBoolean);*)
   tfw_vtStr:
   begin
    Case aV2.rType of
(*     tfw_vtWStr:
      Result := l3Same(aV1.AsString.AsWStr, aV2.AsWString);*)
     tfw_vtChar:
     begin
      l_C := aV2.AsChar;
      Result := l3Same(aV1.AsString.AsWStr, l3PCharLen(@l_C, 1, CP_ANSI));
     end;//tfw_svtChar
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   end;//tfw_svtStr
   tfw_vtObj:
    Case aV2.rType of
     tfw_vtNil:
      Result := (aV1.AsObject = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   tfw_vtIntf:
    Case aV2.rType of
     tfw_vtNil:
      Result := (aV1.AsIntf = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   tfw_vtNil:
    Case aV2.rType of
     tfw_vtIntf:
      Result := (aV2.AsIntf = nil);
     tfw_vtObj:
      Result := (aV2.AsObject = nil);
     else
      CompareAsPrintable;
    end;//Case aV2.rType
(*   tfw_svtFile:
    Result := (aV1.AsIntf = aV2.AsIntf);*)
   tfw_vtChar:
   begin
    l_C := aV1.AsChar;
    Case aV2.rType of
     tfw_vtStr:
      Result := l3Same(l3PCharLen(@l_C, 1, CP_ANSI), aV2.AsString.AsWStr);
(*     tfw_vtWStr:
      Result := l3Same(l3PCharLen(@l_C, 1, CP_ANSI), aV2.AsWString);*)
     else
      CompareAsPrintable;
    end;//Case aV2.rType
   end;//tfw_svtChar
(*   tfw_vtWStr:
    Case aV2.rType of
     tfw_vtStr:
      Result := l3Same(aV1.AsWString, aV2.AsString.AsWStr);
     tfw_vtChar:
     begin
      l_C := aV2.AsChar;
      Result := l3Same(aV1.AsWString, l3PCharLen(@l_C, 1, CP_ANSI));
     end;//tfw_svtChar
     else
      CompareAsPrintable;
    end;//Case aV2.rType*)
(*   tfw_svtBracket:
    Result := true;*)
   else
    CompareAsPrintable;
  end;//aV1.rType
 end;//aV1.rType = aV2.rType
//#UC END# *4F51EE02033C_4F43A128007E_impl*
end;//CompareValues

function TkwDefine.IsImmediate(const aCtx: TtfwContext): Boolean;
//#UC START# *4DB6D7F70155_55880B6D01A0_var*
//#UC END# *4DB6D7F70155_55880B6D01A0_var*
begin
//#UC START# *4DB6D7F70155_55880B6D01A0_impl*
 Result := false; 
//#UC END# *4DB6D7F70155_55880B6D01A0_impl*
end;//TkwDefine.IsImmediate

function TkwDefine.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_55880B6D01A0_var*
//#UC END# *4DB9B446039A_55880B6D01A0_var*
begin
//#UC START# *4DB9B446039A_55880B6D01A0_impl*
 Result := 0;
//#UC END# *4DB9B446039A_55880B6D01A0_impl*
end;//TkwDefine.AfterWordMaxCount

procedure TkwDefine.FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
 aCompiled: TkwCompiledWordPrim;
 const aContext: TtfwContext);
 {* Завершает определение вновь созданного слова }
//#UC START# *4F219629036A_55880B6D01A0_var*
var
 l_W : TtfwWord;
 l_Key : TtfwKeyWord;
//#UC END# *4F219629036A_55880B6D01A0_var*
begin
//#UC START# *4F219629036A_55880B6D01A0_impl*
 l_W := aContext.rEngine.PopObj As TtfwWord;
 l_Key := TtfwKeyWord(l_W.Key);
 try
  aWordToFinish.SetWord(aContext, l_W);
 finally
  l_W.Key := l_Key;
 end;//try..finally
//#UC END# *4F219629036A_55880B6D01A0_impl*
end;//TkwDefine.FinishDefinitionOfNewWord

function TkwDefine.GetNewWordName(const aContext: TtfwContext): Il3CString;
//#UC START# *4F37B3F10318_55880B6D01A0_var*
//#UC END# *4F37B3F10318_55880B6D01A0_var*
begin
//#UC START# *4F37B3F10318_55880B6D01A0_impl*
 Result := aContext.rEngine.PopString;
//#UC END# *4F37B3F10318_55880B6D01A0_impl*
end;//TkwDefine.GetNewWordName

class function TkwDefine.GetWordNameForRegister: AnsiString;
begin
 Result := 'Define';
end;//TkwDefine.GetWordNameForRegister

procedure TkwCompiledPushWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55A50F960186_var*
//#UC END# *4DAEEDE10285_55A50F960186_var*
begin
//#UC START# *4DAEEDE10285_55A50F960186_impl*
 aCtx.rEngine.PushObj(WordToWork);
//#UC END# *4DAEEDE10285_55A50F960186_impl*
end;//TkwCompiledPushWord.DoDoIt

function TkwCompiledPushWord.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_55A50F960186_var*
//#UC END# *558D2BCA0324_55A50F960186_var*
begin
//#UC START# *558D2BCA0324_55A50F960186_impl*
 Result := WordToWork;
 Result := Result.GetRef(aCtx); 
//#UC END# *558D2BCA0324_55A50F960186_impl*
end;//TkwCompiledPushWord.GetRef

function TkwCompiledPushWord.WordName: Il3CString;
//#UC START# *55AFD7DA0258_55A50F960186_var*
//#UC END# *55AFD7DA0258_55A50F960186_var*
begin
//#UC START# *55AFD7DA0258_55A50F960186_impl*
 Result := WordToWork.WordName;
//#UC END# *55AFD7DA0258_55A50F960186_impl*
end;//TkwCompiledPushWord.WordName

function TkwTrue.True(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта True }
//#UC START# *5511611100EB_5511611100EB_Word_var*
//#UC END# *5511611100EB_5511611100EB_Word_var*
begin
//#UC START# *5511611100EB_5511611100EB_Word_impl*
 Result := System.true;
//#UC END# *5511611100EB_5511611100EB_Word_impl*
end;//TkwTrue.True

class function TkwTrue.GetWordNameForRegister: AnsiString;
begin
 Result := 'True';
end;//TkwTrue.GetWordNameForRegister

function TkwTrue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwTrue.GetResultTypeInfo

function TkwTrue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwTrue.GetAllParamsCount

function TkwTrue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTrue.ParamsTypes

procedure TkwTrue.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(True(aCtx));
end;//TkwTrue.DoDoIt

function TkwFalse.False(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта False }
//#UC START# *55116124039C_55116124039C_Word_var*
//#UC END# *55116124039C_55116124039C_Word_var*
begin
//#UC START# *55116124039C_55116124039C_Word_impl*
 Result := System.false;
//#UC END# *55116124039C_55116124039C_Word_impl*
end;//TkwFalse.False

class function TkwFalse.GetWordNameForRegister: AnsiString;
begin
 Result := 'False';
end;//TkwFalse.GetWordNameForRegister

function TkwFalse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFalse.GetResultTypeInfo

function TkwFalse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwFalse.GetAllParamsCount

function TkwFalse.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwFalse.ParamsTypes

procedure TkwFalse.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(False(aCtx));
end;//TkwFalse.DoDoIt

procedure TkwMsg.Msg(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта Msg }
//#UC START# *55116B670356_55116B670356_Word_var*
var
 l_S : AnsiString;
//#UC END# *55116B670356_55116B670356_Word_var*
begin
//#UC START# *55116B670356_55116B670356_Word_impl*
 l_S := l3Str(aValue.AsPrintable);
 MessageBoxA(0, PAnsiChar(l_S), 'script message', MB_OK);
//#UC END# *55116B670356_55116B670356_Word_impl*
end;//TkwMsg.Msg

class function TkwMsg.GetWordNameForRegister: AnsiString;
begin
 Result := 'Msg';
end;//TkwMsg.GetWordNameForRegister

function TkwMsg.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMsg.GetResultTypeInfo

function TkwMsg.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsg.GetAllParamsCount

function TkwMsg.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwMsg.ParamsTypes

procedure TkwMsg.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Msg(aCtx, l_aValue);
end;//TkwMsg.DoDoIt

procedure TkwPrint.Print(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта . }
//#UC START# *55116B9100CF_55116B9100CF_Word_var*
//#UC END# *55116B9100CF_55116B9100CF_Word_var*
begin
//#UC START# *55116B9100CF_55116B9100CF_Word_impl*
 aCtx.rCaller.Print(aValue.AsPrintable);
//#UC END# *55116B9100CF_55116B9100CF_Word_impl*
end;//TkwPrint.Print

class function TkwPrint.GetWordNameForRegister: AnsiString;
begin
 Result := '.';
end;//TkwPrint.GetWordNameForRegister

function TkwPrint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPrint.GetResultTypeInfo

function TkwPrint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPrint.GetAllParamsCount

function TkwPrint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwPrint.ParamsTypes

procedure TkwPrint.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Print(aCtx, l_aValue);
end;//TkwPrint.DoDoIt

procedure TkwLOOP.LOOP(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCount: Integer);
 {* Реализация слова скрипта LOOP }
//#UC START# *5513E11A00F5_5513E11A00F5_Word_var*
var
 l_I : Integer;
//#UC END# *5513E11A00F5_5513E11A00F5_Word_var*
begin
//#UC START# *5513E11A00F5_5513E11A00F5_Word_impl*
 for l_I := 0 to Pred(aCount) do
  try
   aWord.DoIt(aCtx);
  except
   on EtfwBreak do
    break;
   on EtfwContinue do
    continue;
  end;//try..except
//#UC END# *5513E11A00F5_5513E11A00F5_Word_impl*
end;//TkwLOOP.LOOP

class function TkwLOOP.GetWordNameForRegister: AnsiString;
begin
 Result := 'LOOP';
end;//TkwLOOP.GetWordNameForRegister

function TkwLOOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwLOOP.GetResultTypeInfo

function TkwLOOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwLOOP.GetAllParamsCount

function TkwLOOP.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLOOP.RightParamsCount

function TkwLOOP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwLOOP.ParamsTypes

procedure TkwLOOP.DoRun(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aCount: Integer;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
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
 LOOP(aCtx, l_aWord, l_aCount);
end;//TkwLOOP.DoRun

procedure TkwWHILEDO.WHILEDO(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCondition: TtfwWord);
 {* Реализация слова скрипта WHILEDO }
//#UC START# *5513E760006C_5513E760006C_Word_var*
//#UC END# *5513E760006C_5513E760006C_Word_var*
begin
//#UC START# *5513E760006C_5513E760006C_Word_impl*
 while true do
 begin
  aCondition.DoIt(aCtx);
  if not aCtx.rEngine.PopBool then
   break;
  try
   aWord.DoIt(aCtx);
  except
   on EtfwBreak do
    break;
   on EtfwContinue do
    continue;
  end;//try..except
 end;//while true
//#UC END# *5513E760006C_5513E760006C_Word_impl*
end;//TkwWHILEDO.WHILEDO

class function TkwWHILEDO.GetWordNameForRegister: AnsiString;
begin
 Result := 'WHILEDO';
end;//TkwWHILEDO.GetWordNameForRegister

function TkwWHILEDO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwWHILEDO.GetResultTypeInfo

function TkwWHILEDO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwWHILEDO.GetAllParamsCount

function TkwWHILEDO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord), TypeInfo(TtfwWord)]);
end;//TkwWHILEDO.ParamsTypes

procedure TkwWHILEDO.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aCondition: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCondition := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCondition: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WHILEDO(aCtx, l_aWord, l_aCondition);
end;//TkwWHILEDO.DoDoIt

class function TkwBREAK.GetWordNameForRegister: AnsiString;
begin
 Result := 'BREAK';
end;//TkwBREAK.GetWordNameForRegister

function TkwBREAK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwBREAK.GetResultTypeInfo

function TkwBREAK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwBREAK.GetAllParamsCount

function TkwBREAK.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwBREAK.ParamsTypes

procedure TkwBREAK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513EC0A01DB_Word_var*
//#UC END# *4DAEEDE10285_5513EC0A01DB_Word_var*
begin
//#UC START# *4DAEEDE10285_5513EC0A01DB_Word_impl*
 raise EtfwBreak.Instance;
//#UC END# *4DAEEDE10285_5513EC0A01DB_Word_impl*
end;//TkwBREAK.DoDoIt

class function TkwCONTINUE.GetWordNameForRegister: AnsiString;
begin
 Result := 'CONTINUE';
end;//TkwCONTINUE.GetWordNameForRegister

function TkwCONTINUE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCONTINUE.GetResultTypeInfo

function TkwCONTINUE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCONTINUE.GetAllParamsCount

function TkwCONTINUE.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCONTINUE.ParamsTypes

procedure TkwCONTINUE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513EC3F02BC_Word_var*
//#UC END# *4DAEEDE10285_5513EC3F02BC_Word_var*
begin
//#UC START# *4DAEEDE10285_5513EC3F02BC_Word_impl*
 raise EtfwContinue.Instance;
 //raise EtfwContinue.Create('Выход на начало цикла');
//#UC END# *4DAEEDE10285_5513EC3F02BC_Word_impl*
end;//TkwCONTINUE.DoDoIt

class function TkwEXIT.GetWordNameForRegister: AnsiString;
begin
 Result := 'EXIT';
end;//TkwEXIT.GetWordNameForRegister

function TkwEXIT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEXIT.GetResultTypeInfo

function TkwEXIT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEXIT.GetAllParamsCount

function TkwEXIT.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEXIT.ParamsTypes

procedure TkwEXIT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513EC59004D_Word_var*
//#UC END# *4DAEEDE10285_5513EC59004D_Word_var*
begin
//#UC START# *4DAEEDE10285_5513EC59004D_Word_impl*
 raise EtfwExit.Instance;
 //raise EtfwExit.Create('Выход из процедуры');
//#UC END# *4DAEEDE10285_5513EC59004D_Word_impl*
end;//TkwEXIT.DoDoIt

class function TkwHALT.GetWordNameForRegister: AnsiString;
begin
 Result := 'HALT';
end;//TkwHALT.GetWordNameForRegister

function TkwHALT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwHALT.GetResultTypeInfo

function TkwHALT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwHALT.GetAllParamsCount

function TkwHALT.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwHALT.ParamsTypes

procedure TkwHALT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513EC7A029E_Word_var*
//#UC END# *4DAEEDE10285_5513EC7A029E_Word_var*
begin
//#UC START# *4DAEEDE10285_5513EC7A029E_Word_impl*
 raise EtfwHalt.Instance;
 //raise EtfwHalt.Create('Выход из скрипта');
//#UC END# *4DAEEDE10285_5513EC7A029E_Word_impl*
end;//TkwHALT.DoDoIt

class function TkwBREAKITERATOR.GetWordNameForRegister: AnsiString;
begin
 Result := 'BREAK-ITERATOR';
end;//TkwBREAKITERATOR.GetWordNameForRegister

function TkwBREAKITERATOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwBREAKITERATOR.GetResultTypeInfo

function TkwBREAKITERATOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwBREAKITERATOR.GetAllParamsCount

function TkwBREAKITERATOR.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwBREAKITERATOR.ParamsTypes

procedure TkwBREAKITERATOR.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513EC94003D_Word_var*
//#UC END# *4DAEEDE10285_5513EC94003D_Word_var*
begin
//#UC START# *4DAEEDE10285_5513EC94003D_Word_impl*
 raise EtfwBreakIterator.Instance;
 //raise EtfwBreakIterator.Create('Выход из итератора');
//#UC END# *4DAEEDE10285_5513EC94003D_Word_impl*
end;//TkwBREAKITERATOR.DoDoIt

class function TkwNOP.GetWordNameForRegister: AnsiString;
begin
 Result := 'NOP';
end;//TkwNOP.GetWordNameForRegister

function TkwNOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwNOP.GetResultTypeInfo

function TkwNOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwNOP.GetAllParamsCount

function TkwNOP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNOP.ParamsTypes

procedure TkwNOP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513F98C032C_Word_var*
//#UC END# *4DAEEDE10285_5513F98C032C_Word_var*
begin
//#UC START# *4DAEEDE10285_5513F98C032C_Word_impl*
 // - осознанно ничего не делаем
//#UC END# *4DAEEDE10285_5513F98C032C_Word_impl*
end;//TkwNOP.DoDoIt

procedure TkwSLEEP.SLEEP(const aCtx: TtfwContext;
 aDuration: Integer);
 {* Реализация слова скрипта SLEEP }
//#UC START# *5513F9A002BA_5513F9A002BA_Word_var*
//#UC END# *5513F9A002BA_5513F9A002BA_Word_var*
begin
//#UC START# *5513F9A002BA_5513F9A002BA_Word_impl*
 SysUtils.Sleep(aDuration);
//#UC END# *5513F9A002BA_5513F9A002BA_Word_impl*
end;//TkwSLEEP.SLEEP

class function TkwSLEEP.GetWordNameForRegister: AnsiString;
begin
 Result := 'SLEEP';
end;//TkwSLEEP.GetWordNameForRegister

function TkwSLEEP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSLEEP.GetResultTypeInfo

function TkwSLEEP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSLEEP.GetAllParamsCount

function TkwSLEEP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSLEEP.ParamsTypes

procedure TkwSLEEP.DoDoIt(const aCtx: TtfwContext);
var l_aDuration: Integer;
begin
 try
  l_aDuration := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDuration: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SLEEP(aCtx, l_aDuration);
end;//TkwSLEEP.DoDoIt

class function TkwProcessMessages.GetWordNameForRegister: AnsiString;
begin
 Result := 'ProcessMessages';
end;//TkwProcessMessages.GetWordNameForRegister

function TkwProcessMessages.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwProcessMessages.GetResultTypeInfo

function TkwProcessMessages.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwProcessMessages.GetAllParamsCount

function TkwProcessMessages.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwProcessMessages.ParamsTypes

procedure TkwProcessMessages.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513F9CA0059_Word_var*
//#UC END# *4DAEEDE10285_5513F9CA0059_Word_var*
begin
//#UC START# *4DAEEDE10285_5513F9CA0059_Word_impl*
 try
  Tl3MessagesService.Instance.ProcessMessages;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;//on E: Exception
 end;//try..finally
//#UC END# *4DAEEDE10285_5513F9CA0059_Word_impl*
end;//TkwProcessMessages.DoDoIt

procedure TkwCheckAssert.CheckAssert(const aCtx: TtfwContext;
 aCondition: Boolean);
 {* Реализация слова скрипта ASSERT }
//#UC START# *5513FABD01F6_5513FABD01F6_Word_var*
//#UC END# *5513FABD01F6_5513FABD01F6_Word_var*
begin
//#UC START# *5513FABD01F6_5513FABD01F6_Word_impl*
 aCtx.rCaller.Check(aCondition);
//#UC END# *5513FABD01F6_5513FABD01F6_Word_impl*
end;//TkwCheckAssert.CheckAssert

class function TkwCheckAssert.GetWordNameForRegister: AnsiString;
begin
 Result := 'ASSERT';
end;//TkwCheckAssert.GetWordNameForRegister

function TkwCheckAssert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCheckAssert.GetResultTypeInfo

function TkwCheckAssert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCheckAssert.GetAllParamsCount

function TkwCheckAssert.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwCheckAssert.ParamsTypes

procedure TkwCheckAssert.DoDoIt(const aCtx: TtfwContext);
var l_aCondition: Boolean;
begin
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CheckAssert(aCtx, l_aCondition);
end;//TkwCheckAssert.DoDoIt

procedure TkwASSERTS.ASSERTS(const aCtx: TtfwContext;
 const aMsg: AnsiString;
 aCondition: Boolean);
 {* Реализация слова скрипта ASSERTS }
//#UC START# *5513FB260063_5513FB260063_Word_var*
//#UC END# *5513FB260063_5513FB260063_Word_var*
begin
//#UC START# *5513FB260063_5513FB260063_Word_impl*
 aCtx.rCaller.Check(aCondition, aMsg);
//#UC END# *5513FB260063_5513FB260063_Word_impl*
end;//TkwASSERTS.ASSERTS

class function TkwASSERTS.GetWordNameForRegister: AnsiString;
begin
 Result := 'ASSERTS';
end;//TkwASSERTS.GetWordNameForRegister

function TkwASSERTS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwASSERTS.GetResultTypeInfo

function TkwASSERTS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwASSERTS.GetAllParamsCount

function TkwASSERTS.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(Boolean)]);
end;//TkwASSERTS.ParamsTypes

procedure TkwASSERTS.DoDoIt(const aCtx: TtfwContext);
var l_aMsg: AnsiString;
var l_aCondition: Boolean;
begin
 try
  l_aMsg := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMsg: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ASSERTS(aCtx, l_aMsg, l_aCondition);
end;//TkwASSERTS.DoDoIt

class function TkwNil.GetWordNameForRegister: AnsiString;
begin
 Result := 'nil';
end;//TkwNil.GetWordNameForRegister

function TkwNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwNil.GetResultTypeInfo

function TkwNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwNil.GetAllParamsCount

function TkwNil.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNil.ParamsTypes

procedure TkwNil.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5513FB5B00B2_Word_var*
//#UC END# *4DAEEDE10285_5513FB5B00B2_Word_var*
begin
//#UC START# *4DAEEDE10285_5513FB5B00B2_Word_impl*
 aCtx.rEngine.Push(TtfwStackValue_NULL);
//#UC END# *4DAEEDE10285_5513FB5B00B2_Word_impl*
end;//TkwNil.DoDoIt

procedure TkwDoWord.DoWord(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта DO }
//#UC START# *5513FC1D0085_5513FC1D0085_Word_var*
//#UC END# *5513FC1D0085_5513FC1D0085_Word_var*
begin
//#UC START# *5513FC1D0085_5513FC1D0085_Word_impl*
 aWord.DoIt(aCtx);
//#UC END# *5513FC1D0085_5513FC1D0085_Word_impl*
end;//TkwDoWord.DoWord

class function TkwDoWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'DO';
end;//TkwDoWord.GetWordNameForRegister

function TkwDoWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDoWord.GetResultTypeInfo

function TkwDoWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDoWord.GetAllParamsCount

function TkwDoWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwDoWord.ParamsTypes

procedure TkwDoWord.DoDoIt(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoWord(aCtx, l_aWord);
end;//TkwDoWord.DoDoIt

function TkwSmartEquals.SmartEquals(const aCtx: TtfwContext;
 const aV1: TtfwStackValue;
 const aV2: TtfwStackValue): Boolean;
 {* Реализация слова скрипта ?== }
//#UC START# *5514019E03BD_5514019E03BD_Word_var*
//#UC END# *5514019E03BD_5514019E03BD_Word_var*
begin
//#UC START# *5514019E03BD_5514019E03BD_Word_impl*
 Result := CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *5514019E03BD_5514019E03BD_Word_impl*
end;//TkwSmartEquals.SmartEquals

class function TkwSmartEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '?==';
end;//TkwSmartEquals.GetWordNameForRegister

function TkwSmartEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSmartEquals.GetResultTypeInfo

function TkwSmartEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSmartEquals.GetAllParamsCount

function TkwSmartEquals.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwSmartEquals.ParamsTypes

procedure TkwSmartEquals.DoDoIt(const aCtx: TtfwContext);
var l_aV1: TtfwStackValue;
var l_aV2: TtfwStackValue;
begin
 try
  l_aV1 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aV1: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aV2 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aV2: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(SmartEquals(aCtx, l_aV1, l_aV2));
end;//TkwSmartEquals.DoDoIt

function TkwSmartNotEquals.SmartNotEquals(const aCtx: TtfwContext;
 const aV1: TtfwStackValue;
 const aV2: TtfwStackValue): Boolean;
 {* Реализация слова скрипта ?!= }
//#UC START# *551401F0003E_551401F0003E_Word_var*
//#UC END# *551401F0003E_551401F0003E_Word_var*
begin
//#UC START# *551401F0003E_551401F0003E_Word_impl*
 Result := not CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *551401F0003E_551401F0003E_Word_impl*
end;//TkwSmartNotEquals.SmartNotEquals

class function TkwSmartNotEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '?!=';
end;//TkwSmartNotEquals.GetWordNameForRegister

function TkwSmartNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSmartNotEquals.GetResultTypeInfo

function TkwSmartNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSmartNotEquals.GetAllParamsCount

function TkwSmartNotEquals.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwSmartNotEquals.ParamsTypes

procedure TkwSmartNotEquals.DoDoIt(const aCtx: TtfwContext);
var l_aV1: TtfwStackValue;
var l_aV2: TtfwStackValue;
begin
 try
  l_aV1 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aV1: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aV2 := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aV2: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(SmartNotEquals(aCtx, l_aV1, l_aV2));
end;//TkwSmartNotEquals.DoDoIt

function TkwPushWord.PushWord(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта @ }
//#UC START# *551420EE03BE_551420EE03BE_Word_var*
//#UC END# *551420EE03BE_551420EE03BE_Word_var*
begin
//#UC START# *551420EE03BE_551420EE03BE_Word_impl*
 if (aWord Is TkwForwardDeclarationHolder) then
  Result := TkwForwardDeclarationHolder(aWord).Holded
 else
  Result := aWord;
//#UC END# *551420EE03BE_551420EE03BE_Word_impl*
end;//TkwPushWord.PushWord

class function TkwPushWord.GetWordNameForRegister: AnsiString;
begin
 Result := '@';
end;//TkwPushWord.GetWordNameForRegister

function TkwPushWord.SuppressNextImmediate(const aContext: TtfwContext;
 aWordNumber: Integer): TtfwSuppressNextImmediate;
begin
 Result := tfw_sniYes;
end;//TkwPushWord.SuppressNextImmediate

function TkwPushWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPushWord.GetResultTypeInfo

function TkwPushWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPushWord.GetAllParamsCount

function TkwPushWord.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPushWord.RightParamsCount

function TkwPushWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwPushWord.ParamsTypes

procedure TkwPushWord.DoRun(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PushWord(aCtx, l_aWord));
end;//TkwPushWord.DoRun

function TkwCurrentException.current_exception(const aCtx: TtfwContext): TObject;
 {* Реализация слова скрипта current:exception }
//#UC START# *551577F400BC_551577F400BC_Word_var*
//#UC END# *551577F400BC_551577F400BC_Word_var*
begin
//#UC START# *551577F400BC_551577F400BC_Word_impl*
 Result := aCtx.rException;
//#UC END# *551577F400BC_551577F400BC_Word_impl*
end;//TkwCurrentException.current_exception

class function TkwCurrentException.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception';
end;//TkwCurrentException.GetWordNameForRegister

function TkwCurrentException.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TObject);
end;//TkwCurrentException.GetResultTypeInfo

function TkwCurrentException.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCurrentException.GetAllParamsCount

function TkwCurrentException.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentException.ParamsTypes

procedure TkwCurrentException.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(current_exception(aCtx));
end;//TkwCurrentException.DoDoIt

function TkwCurrentExceptionClass.current_exception_class(const aCtx: TtfwContext): TClass;
 {* Реализация слова скрипта current:exception:class }
//#UC START# *5515780800CC_5515780800CC_Word_var*
//#UC END# *5515780800CC_5515780800CC_Word_var*
begin
//#UC START# *5515780800CC_5515780800CC_Word_impl*
 if (aCtx.rException = nil) then
  Result := nil
 else
  Result := aCtx.rException.ClassType;
//#UC END# *5515780800CC_5515780800CC_Word_impl*
end;//TkwCurrentExceptionClass.current_exception_class

class function TkwCurrentExceptionClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:class';
end;//TkwCurrentExceptionClass.GetWordNameForRegister

function TkwCurrentExceptionClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiClassRef;
end;//TkwCurrentExceptionClass.GetResultTypeInfo

function TkwCurrentExceptionClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCurrentExceptionClass.GetAllParamsCount

function TkwCurrentExceptionClass.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionClass.ParamsTypes

procedure TkwCurrentExceptionClass.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushClass(current_exception_class(aCtx));
end;//TkwCurrentExceptionClass.DoDoIt

function TkwCurrentExceptionClassName.current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта current:exception:ClassName }
//#UC START# *5515781D0251_5515781D0251_Word_var*
//#UC END# *5515781D0251_5515781D0251_Word_var*
begin
//#UC START# *5515781D0251_5515781D0251_Word_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.ClassName;
//#UC END# *5515781D0251_5515781D0251_Word_impl*
end;//TkwCurrentExceptionClassName.current_exception_ClassName

class function TkwCurrentExceptionClassName.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:ClassName';
end;//TkwCurrentExceptionClassName.GetWordNameForRegister

function TkwCurrentExceptionClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCurrentExceptionClassName.GetResultTypeInfo

function TkwCurrentExceptionClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCurrentExceptionClassName.GetAllParamsCount

function TkwCurrentExceptionClassName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionClassName.ParamsTypes

procedure TkwCurrentExceptionClassName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(current_exception_ClassName(aCtx));
end;//TkwCurrentExceptionClassName.DoDoIt

function TkwCurrentExceptionMessage.current_exception_Message(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта current:exception:Message }
//#UC START# *551578460058_551578460058_Word_var*
//#UC END# *551578460058_551578460058_Word_var*
begin
//#UC START# *551578460058_551578460058_Word_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.Message;
//#UC END# *551578460058_551578460058_Word_impl*
end;//TkwCurrentExceptionMessage.current_exception_Message

class function TkwCurrentExceptionMessage.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:Message';
end;//TkwCurrentExceptionMessage.GetWordNameForRegister

function TkwCurrentExceptionMessage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwCurrentExceptionMessage.GetResultTypeInfo

function TkwCurrentExceptionMessage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCurrentExceptionMessage.GetAllParamsCount

function TkwCurrentExceptionMessage.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCurrentExceptionMessage.ParamsTypes

procedure TkwCurrentExceptionMessage.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(current_exception_Message(aCtx));
end;//TkwCurrentExceptionMessage.DoDoIt

function TkwInc.Inc(const aCtx: TtfwContext;
 aValue: Integer): Integer;
 {* Реализация слова скрипта ++ }
//#UC START# *551597600166_551597600166_Word_var*
//#UC END# *551597600166_551597600166_Word_var*
begin
//#UC START# *551597600166_551597600166_Word_impl*
 Result := aValue + 1;
//#UC END# *551597600166_551597600166_Word_impl*
end;//TkwInc.Inc

class function TkwInc.GetWordNameForRegister: AnsiString;
begin
 Result := '++';
end;//TkwInc.GetWordNameForRegister

function TkwInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwInc.GetResultTypeInfo

function TkwInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwInc.GetAllParamsCount

function TkwInc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwInc.ParamsTypes

procedure TkwInc.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Inc(aCtx, l_aValue));
end;//TkwInc.DoDoIt

function TkwDec.Dec(const aCtx: TtfwContext;
 aValue: Integer): Integer;
 {* Реализация слова скрипта -- }
//#UC START# *551597780135_551597780135_Word_var*
//#UC END# *551597780135_551597780135_Word_var*
begin
//#UC START# *551597780135_551597780135_Word_impl*
 Result := aValue - 1;
//#UC END# *551597780135_551597780135_Word_impl*
end;//TkwDec.Dec

class function TkwDec.GetWordNameForRegister: AnsiString;
begin
 Result := '--';
end;//TkwDec.GetWordNameForRegister

function TkwDec.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDec.GetResultTypeInfo

function TkwDec.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDec.GetAllParamsCount

function TkwDec.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDec.ParamsTypes

procedure TkwDec.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Dec(aCtx, l_aValue));
end;//TkwDec.DoDoIt

function TkwAdd.Add(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): TtfwStackValue;
 {* Реализация слова скрипта + }
//#UC START# *551597B8004D_551597B8004D_Word_var*
//#UC END# *551597B8004D_551597B8004D_Word_var*
begin
//#UC START# *551597B8004D_551597B8004D_Word_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := TtfwStackValue_C(aA.AsInt + aB.AsInt);
  tfw_vtStr:
   Result := TtfwStackValue_C(TtfwCStringFactory.Cat(aA.AsString, aB.AsString));
  else
  begin
   Result := TtfwStackValue_E;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *551597B8004D_551597B8004D_Word_impl*
end;//TkwAdd.Add

class function TkwAdd.GetWordNameForRegister: AnsiString;
begin
 Result := '+';
end;//TkwAdd.GetWordNameForRegister

function TkwAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwAdd.GetResultTypeInfo

function TkwAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwAdd.GetAllParamsCount

function TkwAdd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwAdd.ParamsTypes

procedure TkwAdd.DoDoIt(const aCtx: TtfwContext);
var l_aB: TtfwStackValue;
var l_aA: TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.Push(Add(aCtx, l_aB, l_aA));
end;//TkwAdd.DoDoIt

function TkwSub.Sub(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта - }
//#UC START# *551597E800AA_551597E800AA_Word_var*
//#UC END# *551597E800AA_551597E800AA_Word_var*
begin
//#UC START# *551597E800AA_551597E800AA_Word_impl*
 Result := aA - aB;
//#UC END# *551597E800AA_551597E800AA_Word_impl*
end;//TkwSub.Sub

class function TkwSub.GetWordNameForRegister: AnsiString;
begin
 Result := '-';
end;//TkwSub.GetWordNameForRegister

function TkwSub.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwSub.GetResultTypeInfo

function TkwSub.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSub.GetAllParamsCount

function TkwSub.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwSub.ParamsTypes

procedure TkwSub.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Sub(aCtx, l_aB, l_aA));
end;//TkwSub.DoDoIt

function TkwDivision.Division(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта DIV }
//#UC START# *551598030154_551598030154_Word_var*
//#UC END# *551598030154_551598030154_Word_var*
begin
//#UC START# *551598030154_551598030154_Word_impl*
 Result := aA div aB;
//#UC END# *551598030154_551598030154_Word_impl*
end;//TkwDivision.Division

class function TkwDivision.GetWordNameForRegister: AnsiString;
begin
 Result := 'DIV';
end;//TkwDivision.GetWordNameForRegister

function TkwDivision.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDivision.GetResultTypeInfo

function TkwDivision.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwDivision.GetAllParamsCount

function TkwDivision.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwDivision.ParamsTypes

procedure TkwDivision.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Division(aCtx, l_aB, l_aA));
end;//TkwDivision.DoDoIt

function TkwMul.Mul(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта * }
//#UC START# *5515981700DC_5515981700DC_Word_var*
//#UC END# *5515981700DC_5515981700DC_Word_var*
begin
//#UC START# *5515981700DC_5515981700DC_Word_impl*
 Result := aA * aB;
//#UC END# *5515981700DC_5515981700DC_Word_impl*
end;//TkwMul.Mul

class function TkwMul.GetWordNameForRegister: AnsiString;
begin
 Result := '*';
end;//TkwMul.GetWordNameForRegister

function TkwMul.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMul.GetResultTypeInfo

function TkwMul.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMul.GetAllParamsCount

function TkwMul.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwMul.ParamsTypes

procedure TkwMul.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Mul(aCtx, l_aB, l_aA));
end;//TkwMul.DoDoIt

function TkwDivide.Divide(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта / }
//#UC START# *551598250365_551598250365_Word_var*
//#UC END# *551598250365_551598250365_Word_var*
begin
//#UC START# *551598250365_551598250365_Word_impl*
 Result := aA div aB;
//#UC END# *551598250365_551598250365_Word_impl*
end;//TkwDivide.Divide

class function TkwDivide.GetWordNameForRegister: AnsiString;
begin
 Result := '/';
end;//TkwDivide.GetWordNameForRegister

function TkwDivide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDivide.GetResultTypeInfo

function TkwDivide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwDivide.GetAllParamsCount

function TkwDivide.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwDivide.ParamsTypes

procedure TkwDivide.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Divide(aCtx, l_aB, l_aA));
end;//TkwDivide.DoDoIt

function TkwMul2.Mul2(const aCtx: TtfwContext;
 aA: Integer): Integer;
 {* Реализация слова скрипта 2* }
//#UC START# *5515984C0341_5515984C0341_Word_var*
//#UC END# *5515984C0341_5515984C0341_Word_var*
begin
//#UC START# *5515984C0341_5515984C0341_Word_impl*
 Result := aA shl 1;
//#UC END# *5515984C0341_5515984C0341_Word_impl*
end;//TkwMul2.Mul2

class function TkwMul2.GetWordNameForRegister: AnsiString;
begin
 Result := '2*';
end;//TkwMul2.GetWordNameForRegister

function TkwMul2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMul2.GetResultTypeInfo

function TkwMul2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMul2.GetAllParamsCount

function TkwMul2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwMul2.ParamsTypes

procedure TkwMul2.DoDoIt(const aCtx: TtfwContext);
var l_aA: Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Mul2(aCtx, l_aA));
end;//TkwMul2.DoDoIt

function TkwDiv2.Div2(const aCtx: TtfwContext;
 aA: Integer): Integer;
 {* Реализация слова скрипта 2/ }
//#UC START# *5515987201EB_5515987201EB_Word_var*
//#UC END# *5515987201EB_5515987201EB_Word_var*
begin
//#UC START# *5515987201EB_5515987201EB_Word_impl*
 Result := aA shr 1;
//#UC END# *5515987201EB_5515987201EB_Word_impl*
end;//TkwDiv2.Div2

class function TkwDiv2.GetWordNameForRegister: AnsiString;
begin
 Result := '2/';
end;//TkwDiv2.GetWordNameForRegister

function TkwDiv2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwDiv2.GetResultTypeInfo

function TkwDiv2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDiv2.GetAllParamsCount

function TkwDiv2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDiv2.ParamsTypes

procedure TkwDiv2.DoDoIt(const aCtx: TtfwContext);
var l_aA: Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Div2(aCtx, l_aA));
end;//TkwDiv2.DoDoIt

function TkwMulDiv.MulDiv(const aCtx: TtfwContext;
 aC: Integer;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта */ }
//#UC START# *551598B003B0_551598B003B0_Word_var*
//#UC END# *551598B003B0_551598B003B0_Word_var*
begin
//#UC START# *551598B003B0_551598B003B0_Word_impl*
 Result := l3MulDiv(aA, aB, aC);
//#UC END# *551598B003B0_551598B003B0_Word_impl*
end;//TkwMulDiv.MulDiv

class function TkwMulDiv.GetWordNameForRegister: AnsiString;
begin
 Result := '*/';
end;//TkwMulDiv.GetWordNameForRegister

function TkwMulDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMulDiv.GetResultTypeInfo

function TkwMulDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwMulDiv.GetAllParamsCount

function TkwMulDiv.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwMulDiv.ParamsTypes

procedure TkwMulDiv.DoDoIt(const aCtx: TtfwContext);
var l_aC: Integer;
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aC := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aC: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(MulDiv(aCtx, l_aC, l_aB, l_aA));
end;//TkwMulDiv.DoDoIt

function TkwBoolNot.BoolNot(const aCtx: TtfwContext;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта ! }
//#UC START# *5515993901E9_5515993901E9_Word_var*
//#UC END# *5515993901E9_5515993901E9_Word_var*
begin
//#UC START# *5515993901E9_5515993901E9_Word_impl*
 Result := not aA;
//#UC END# *5515993901E9_5515993901E9_Word_impl*
end;//TkwBoolNot.BoolNot

class function TkwBoolNot.GetWordNameForRegister: AnsiString;
begin
 Result := '!';
end;//TkwBoolNot.GetWordNameForRegister

function TkwBoolNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolNot.GetResultTypeInfo

function TkwBoolNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBoolNot.GetAllParamsCount

function TkwBoolNot.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwBoolNot.ParamsTypes

procedure TkwBoolNot.DoDoIt(const aCtx: TtfwContext);
var l_aA: Boolean;
begin
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(BoolNot(aCtx, l_aA));
end;//TkwBoolNot.DoDoIt

function TkwModFromDiv.ModFromDiv(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта MOD }
//#UC START# *551599950364_551599950364_Word_var*
//#UC END# *551599950364_551599950364_Word_var*
begin
//#UC START# *551599950364_551599950364_Word_impl*
 Result := aA mod aB;
//#UC END# *551599950364_551599950364_Word_impl*
end;//TkwModFromDiv.ModFromDiv

class function TkwModFromDiv.GetWordNameForRegister: AnsiString;
begin
 Result := 'MOD';
end;//TkwModFromDiv.GetWordNameForRegister

function TkwModFromDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwModFromDiv.GetResultTypeInfo

function TkwModFromDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwModFromDiv.GetAllParamsCount

function TkwModFromDiv.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwModFromDiv.ParamsTypes

procedure TkwModFromDiv.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ModFromDiv(aCtx, l_aB, l_aA));
end;//TkwModFromDiv.DoDoIt

function TkwBoolAnd.BoolAnd(const aCtx: TtfwContext;
 aB: Boolean;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта && }
//#UC START# *551599DF020D_551599DF020D_Word_var*
//#UC END# *551599DF020D_551599DF020D_Word_var*
begin
//#UC START# *551599DF020D_551599DF020D_Word_impl*
 Result := aA AND aB;
//#UC END# *551599DF020D_551599DF020D_Word_impl*
end;//TkwBoolAnd.BoolAnd

class function TkwBoolAnd.GetWordNameForRegister: AnsiString;
begin
 Result := '&&';
end;//TkwBoolAnd.GetWordNameForRegister

function TkwBoolAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolAnd.GetResultTypeInfo

function TkwBoolAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwBoolAnd.GetAllParamsCount

function TkwBoolAnd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean), TypeInfo(Boolean)]);
end;//TkwBoolAnd.ParamsTypes

procedure TkwBoolAnd.DoDoIt(const aCtx: TtfwContext);
var l_aB: Boolean;
var l_aA: Boolean;
begin
 try
  l_aB := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(BoolAnd(aCtx, l_aB, l_aA));
end;//TkwBoolAnd.DoDoIt

function TkwBoolOr.BoolOr(const aCtx: TtfwContext;
 aB: Boolean;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта || }
//#UC START# *55159A05030F_55159A05030F_Word_var*
//#UC END# *55159A05030F_55159A05030F_Word_var*
begin
//#UC START# *55159A05030F_55159A05030F_Word_impl*
 Result := aA OR aB;
//#UC END# *55159A05030F_55159A05030F_Word_impl*
end;//TkwBoolOr.BoolOr

class function TkwBoolOr.GetWordNameForRegister: AnsiString;
begin
 Result := '||';
end;//TkwBoolOr.GetWordNameForRegister

function TkwBoolOr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwBoolOr.GetResultTypeInfo

function TkwBoolOr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwBoolOr.GetAllParamsCount

function TkwBoolOr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean), TypeInfo(Boolean)]);
end;//TkwBoolOr.ParamsTypes

procedure TkwBoolOr.DoDoIt(const aCtx: TtfwContext);
var l_aB: Boolean;
var l_aA: Boolean;
begin
 try
  l_aB := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(BoolOr(aCtx, l_aB, l_aA));
end;//TkwBoolOr.DoDoIt

function TkwNotZero.NotZero(const aCtx: TtfwContext;
 aA: Integer): Boolean;
 {* Реализация слова скрипта !=0 }
//#UC START# *55159A2E020E_55159A2E020E_Word_var*
//#UC END# *55159A2E020E_55159A2E020E_Word_var*
begin
//#UC START# *55159A2E020E_55159A2E020E_Word_impl*
 Result := (aA <> 0);
//#UC END# *55159A2E020E_55159A2E020E_Word_impl*
end;//TkwNotZero.NotZero

class function TkwNotZero.GetWordNameForRegister: AnsiString;
begin
 Result := '!=0';
end;//TkwNotZero.GetWordNameForRegister

function TkwNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwNotZero.GetResultTypeInfo

function TkwNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNotZero.GetAllParamsCount

function TkwNotZero.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwNotZero.ParamsTypes

procedure TkwNotZero.DoDoIt(const aCtx: TtfwContext);
var l_aA: Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(NotZero(aCtx, l_aA));
end;//TkwNotZero.DoDoIt

function TkwEqualZero.EqualZero(const aCtx: TtfwContext;
 aA: Integer): Boolean;
 {* Реализация слова скрипта =0 }
//#UC START# *55159A4F0009_55159A4F0009_Word_var*
//#UC END# *55159A4F0009_55159A4F0009_Word_var*
begin
//#UC START# *55159A4F0009_55159A4F0009_Word_impl*
 Result := (aA = 0);
//#UC END# *55159A4F0009_55159A4F0009_Word_impl*
end;//TkwEqualZero.EqualZero

class function TkwEqualZero.GetWordNameForRegister: AnsiString;
begin
 Result := '=0';
end;//TkwEqualZero.GetWordNameForRegister

function TkwEqualZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwEqualZero.GetResultTypeInfo

function TkwEqualZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEqualZero.GetAllParamsCount

function TkwEqualZero.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwEqualZero.ParamsTypes

procedure TkwEqualZero.DoDoIt(const aCtx: TtfwContext);
var l_aA: Integer;
begin
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(EqualZero(aCtx, l_aA));
end;//TkwEqualZero.DoDoIt

class function TkwSWAP.GetWordNameForRegister: AnsiString;
begin
 Result := 'SWAP';
end;//TkwSWAP.GetWordNameForRegister

function TkwSWAP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSWAP.GetResultTypeInfo

function TkwSWAP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSWAP.GetAllParamsCount

function TkwSWAP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSWAP.ParamsTypes

procedure TkwSWAP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159A960126_Word_var*
//#UC END# *4DAEEDE10285_55159A960126_Word_var*
begin
//#UC START# *4DAEEDE10285_55159A960126_Word_impl*
 aCtx.rEngine.SWAP;
//#UC END# *4DAEEDE10285_55159A960126_Word_impl*
end;//TkwSWAP.DoDoIt

class function TkwDROP.GetWordNameForRegister: AnsiString;
begin
 Result := 'DROP';
end;//TkwDROP.GetWordNameForRegister

function TkwDROP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDROP.GetResultTypeInfo

function TkwDROP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDROP.GetAllParamsCount

function TkwDROP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDROP.ParamsTypes

procedure TkwDROP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159AAF0133_Word_var*
//#UC END# *4DAEEDE10285_55159AAF0133_Word_var*
begin
//#UC START# *4DAEEDE10285_55159AAF0133_Word_impl*
 aCtx.rEngine.DROP;
//#UC END# *4DAEEDE10285_55159AAF0133_Word_impl*
end;//TkwDROP.DoDoIt

class function TkwDUP.GetWordNameForRegister: AnsiString;
begin
 Result := 'DUP';
end;//TkwDUP.GetWordNameForRegister

function TkwDUP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDUP.GetResultTypeInfo

function TkwDUP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDUP.GetAllParamsCount

function TkwDUP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDUP.ParamsTypes

procedure TkwDUP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159ACB036B_Word_var*
//#UC END# *4DAEEDE10285_55159ACB036B_Word_var*
begin
//#UC START# *4DAEEDE10285_55159ACB036B_Word_impl*
 aCtx.rEngine.Dup;
//#UC END# *4DAEEDE10285_55159ACB036B_Word_impl*
end;//TkwDUP.DoDoIt

class function TkwDUPIfNotZero.GetWordNameForRegister: AnsiString;
begin
 Result := '?DUP';
end;//TkwDUPIfNotZero.GetWordNameForRegister

function TkwDUPIfNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDUPIfNotZero.GetResultTypeInfo

function TkwDUPIfNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDUPIfNotZero.GetAllParamsCount

function TkwDUPIfNotZero.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDUPIfNotZero.ParamsTypes

procedure TkwDUPIfNotZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159AE500C8_Word_var*
//#UC END# *4DAEEDE10285_55159AE500C8_Word_var*
begin
//#UC START# *4DAEEDE10285_55159AE500C8_Word_impl*
 aCtx.rEngine.DupIfNotZero;
//#UC END# *4DAEEDE10285_55159AE500C8_Word_impl*
end;//TkwDUPIfNotZero.DoDoIt

class function TkwROT.GetWordNameForRegister: AnsiString;
begin
 Result := 'ROT';
end;//TkwROT.GetWordNameForRegister

function TkwROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwROT.GetResultTypeInfo

function TkwROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwROT.GetAllParamsCount

function TkwROT.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwROT.ParamsTypes

procedure TkwROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159B2B0192_Word_var*
//#UC END# *4DAEEDE10285_55159B2B0192_Word_var*
begin
//#UC START# *4DAEEDE10285_55159B2B0192_Word_impl*
 aCtx.rEngine.ROT;
//#UC END# *4DAEEDE10285_55159B2B0192_Word_impl*
end;//TkwROT.DoDoIt

class function TkwPICK.GetWordNameForRegister: AnsiString;
begin
 Result := 'PICK';
end;//TkwPICK.GetWordNameForRegister

function TkwPICK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPICK.GetResultTypeInfo

function TkwPICK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwPICK.GetAllParamsCount

function TkwPICK.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwPICK.ParamsTypes

procedure TkwPICK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159B710263_Word_var*
//#UC END# *4DAEEDE10285_55159B710263_Word_var*
begin
//#UC START# *4DAEEDE10285_55159B710263_Word_impl*
 aCtx.rEngine.PICK;
//#UC END# *4DAEEDE10285_55159B710263_Word_impl*
end;//TkwPICK.DoDoIt

class function TkwInvertROT.GetWordNameForRegister: AnsiString;
begin
 Result := '-ROT';
end;//TkwInvertROT.GetWordNameForRegister

function TkwInvertROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwInvertROT.GetResultTypeInfo

function TkwInvertROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwInvertROT.GetAllParamsCount

function TkwInvertROT.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwInvertROT.ParamsTypes

procedure TkwInvertROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55159BC002DA_Word_var*
//#UC END# *4DAEEDE10285_55159BC002DA_Word_var*
begin
//#UC START# *4DAEEDE10285_55159BC002DA_Word_impl*
 aCtx.rEngine.InvertROT;
//#UC END# *4DAEEDE10285_55159BC002DA_Word_impl*
end;//TkwInvertROT.DoDoIt

class function TkwSWAP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2SWAP';
end;//TkwSWAP2.GetWordNameForRegister

function TkwSWAP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSWAP2.GetResultTypeInfo

function TkwSWAP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSWAP2.GetAllParamsCount

function TkwSWAP2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSWAP2.ParamsTypes

procedure TkwSWAP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5519343300DE_Word_var*
//#UC END# *4DAEEDE10285_5519343300DE_Word_var*
begin
//#UC START# *4DAEEDE10285_5519343300DE_Word_impl*
 aCtx.rEngine.Swap2;
//#UC END# *4DAEEDE10285_5519343300DE_Word_impl*
end;//TkwSWAP2.DoDoIt

class function TkwOVER2.GetWordNameForRegister: AnsiString;
begin
 Result := '2OVER';
end;//TkwOVER2.GetWordNameForRegister

function TkwOVER2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwOVER2.GetResultTypeInfo

function TkwOVER2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwOVER2.GetAllParamsCount

function TkwOVER2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwOVER2.ParamsTypes

procedure TkwOVER2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5519345301D5_Word_var*
//#UC END# *4DAEEDE10285_5519345301D5_Word_var*
begin
//#UC START# *4DAEEDE10285_5519345301D5_Word_impl*
 aCtx.rEngine.Over2;
//#UC END# *4DAEEDE10285_5519345301D5_Word_impl*
end;//TkwOVER2.DoDoIt

class function TkwDUP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2DUP';
end;//TkwDUP2.GetWordNameForRegister

function TkwDUP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDUP2.GetResultTypeInfo

function TkwDUP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDUP2.GetAllParamsCount

function TkwDUP2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDUP2.ParamsTypes

procedure TkwDUP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_551934800380_Word_var*
//#UC END# *4DAEEDE10285_551934800380_Word_var*
begin
//#UC START# *4DAEEDE10285_551934800380_Word_impl*
 aCtx.rEngine.Dup2;
//#UC END# *4DAEEDE10285_551934800380_Word_impl*
end;//TkwDUP2.DoDoIt

class function TkwDROP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2DROP';
end;//TkwDROP2.GetWordNameForRegister

function TkwDROP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDROP2.GetResultTypeInfo

function TkwDROP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwDROP2.GetAllParamsCount

function TkwDROP2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDROP2.ParamsTypes

procedure TkwDROP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_551934A50225_Word_var*
//#UC END# *4DAEEDE10285_551934A50225_Word_var*
begin
//#UC START# *4DAEEDE10285_551934A50225_Word_impl*
 aCtx.rEngine.Drop2;
//#UC END# *4DAEEDE10285_551934A50225_Word_impl*
end;//TkwDROP2.DoDoIt

class function TkwNIP.GetWordNameForRegister: AnsiString;
begin
 Result := 'NIP';
end;//TkwNIP.GetWordNameForRegister

function TkwNIP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwNIP.GetResultTypeInfo

function TkwNIP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwNIP.GetAllParamsCount

function TkwNIP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNIP.ParamsTypes

procedure TkwNIP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_551934CA02D6_Word_var*
//#UC END# *4DAEEDE10285_551934CA02D6_Word_var*
begin
//#UC START# *4DAEEDE10285_551934CA02D6_Word_impl*
 aCtx.rEngine.NIP;
//#UC END# *4DAEEDE10285_551934CA02D6_Word_impl*
end;//TkwNIP.DoDoIt

class function TkwTUCK.GetWordNameForRegister: AnsiString;
begin
 Result := 'TUCK';
end;//TkwTUCK.GetWordNameForRegister

function TkwTUCK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTUCK.GetResultTypeInfo

function TkwTUCK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwTUCK.GetAllParamsCount

function TkwTUCK.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTUCK.ParamsTypes

procedure TkwTUCK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_551934E700E6_Word_var*
//#UC END# *4DAEEDE10285_551934E700E6_Word_var*
begin
//#UC START# *4DAEEDE10285_551934E700E6_Word_impl*
 aCtx.rEngine.TUCK;
//#UC END# *4DAEEDE10285_551934E700E6_Word_impl*
end;//TkwTUCK.DoDoIt

class function TkwOVER.GetWordNameForRegister: AnsiString;
begin
 Result := 'OVER';
end;//TkwOVER.GetWordNameForRegister

function TkwOVER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwOVER.GetResultTypeInfo

function TkwOVER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwOVER.GetAllParamsCount

function TkwOVER.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwOVER.ParamsTypes

procedure TkwOVER.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_551935010364_Word_var*
//#UC END# *4DAEEDE10285_551935010364_Word_var*
begin
//#UC START# *4DAEEDE10285_551935010364_Word_impl*
 aCtx.rEngine.OVER;
//#UC END# *4DAEEDE10285_551935010364_Word_impl*
end;//TkwOVER.DoDoIt

class function TkwROLL.GetWordNameForRegister: AnsiString;
begin
 Result := 'ROLL';
end;//TkwROLL.GetWordNameForRegister

function TkwROLL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwROLL.GetResultTypeInfo

function TkwROLL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwROLL.GetAllParamsCount

function TkwROLL.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwROLL.ParamsTypes

procedure TkwROLL.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5519351F01E3_Word_var*
//#UC END# *4DAEEDE10285_5519351F01E3_Word_var*
begin
//#UC START# *4DAEEDE10285_5519351F01E3_Word_impl*
 aCtx.rEngine.ROLL;
//#UC END# *4DAEEDE10285_5519351F01E3_Word_impl*
end;//TkwROLL.DoDoIt

function TkwNotEquals.NotEquals(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта != }
//#UC START# *5519355003E4_5519355003E4_Word_var*
//#UC END# *5519355003E4_5519355003E4_Word_var*
begin
//#UC START# *5519355003E4_5519355003E4_Word_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt <> aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean <> aB.AsBoolean;
  tfw_vtStr:
   Result := not l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject <> aB.AsObject;
  tfw_vtIntf:
   Result := aA.AsIntf <> aB.AsIntf;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *5519355003E4_5519355003E4_Word_impl*
end;//TkwNotEquals.NotEquals

class function TkwNotEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '!=';
end;//TkwNotEquals.GetWordNameForRegister

function TkwNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwNotEquals.GetResultTypeInfo

function TkwNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwNotEquals.GetAllParamsCount

function TkwNotEquals.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwNotEquals.ParamsTypes

procedure TkwNotEquals.DoDoIt(const aCtx: TtfwContext);
var l_aB: TtfwStackValue;
var l_aA: TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(NotEquals(aCtx, l_aB, l_aA));
end;//TkwNotEquals.DoDoIt

function TkwGREATER.GREATER(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта GREATER }
//#UC START# *55193584030D_55193584030D_Word_var*
//#UC END# *55193584030D_55193584030D_Word_var*
begin
//#UC START# *55193584030D_55193584030D_Word_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt > aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean > aB.AsBoolean;
  tfw_vtStr:
   Result := l3Compare(l3PCharLen(aA.AsString), l3PCharLen(aB.AsString)) > 0;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *55193584030D_55193584030D_Word_impl*
end;//TkwGREATER.GREATER

class function TkwGREATER.GetWordNameForRegister: AnsiString;
begin
 Result := 'GREATER';
end;//TkwGREATER.GetWordNameForRegister

function TkwGREATER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwGREATER.GetResultTypeInfo

function TkwGREATER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwGREATER.GetAllParamsCount

function TkwGREATER.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwGREATER.ParamsTypes

procedure TkwGREATER.DoDoIt(const aCtx: TtfwContext);
var l_aB: TtfwStackValue;
var l_aA: TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(GREATER(aCtx, l_aB, l_aA));
end;//TkwGREATER.DoDoIt

function TkwLESS.LESS(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта LESS }
//#UC START# *5519359B0317_5519359B0317_Word_var*
//#UC END# *5519359B0317_5519359B0317_Word_var*
begin
//#UC START# *5519359B0317_5519359B0317_Word_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt < aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean < aB.AsBoolean;
  tfw_vtStr:
   Result := l3Compare(l3PCharLen(aA.AsString), l3PCharLen(aB.AsString)) < 0;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *5519359B0317_5519359B0317_Word_impl*
end;//TkwLESS.LESS

class function TkwLESS.GetWordNameForRegister: AnsiString;
begin
 Result := 'LESS';
end;//TkwLESS.GetWordNameForRegister

function TkwLESS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwLESS.GetResultTypeInfo

function TkwLESS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwLESS.GetAllParamsCount

function TkwLESS.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwLESS.ParamsTypes

procedure TkwLESS.DoDoIt(const aCtx: TtfwContext);
var l_aB: TtfwStackValue;
var l_aA: TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(LESS(aCtx, l_aB, l_aA));
end;//TkwLESS.DoDoIt

function TkwEquals.Equals(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта == }
//#UC START# *551935B4011D_551935B4011D_Word_var*
//#UC END# *551935B4011D_551935B4011D_Word_var*
begin
//#UC START# *551935B4011D_551935B4011D_Word_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt = aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean = aB.AsBoolean;
  tfw_vtStr:
   Result := l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject = aB.AsObject;
  tfw_vtIntf:
   Result := aA.AsIntf = aB.AsIntf;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *551935B4011D_551935B4011D_Word_impl*
end;//TkwEquals.Equals

class function TkwEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '==';
end;//TkwEquals.GetWordNameForRegister

function TkwEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwEquals.GetResultTypeInfo

function TkwEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwEquals.GetAllParamsCount

function TkwEquals.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct, @tfw_tiStruct]);
end;//TkwEquals.ParamsTypes

procedure TkwEquals.DoDoIt(const aCtx: TtfwContext);
var l_aB: TtfwStackValue;
var l_aA: TtfwStackValue;
begin
 try
  l_aB := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Equals(aCtx, l_aB, l_aA));
end;//TkwEquals.DoDoIt

function TkwLessThanZero.LessThanZero(const aCtx: TtfwContext;
 aB: Integer): Boolean;
 {* Реализация слова скрипта <0 }
//#UC START# *551935D00032_551935D00032_Word_var*
//#UC END# *551935D00032_551935D00032_Word_var*
begin
//#UC START# *551935D00032_551935D00032_Word_impl*
 Result := (aB < 0);
//#UC END# *551935D00032_551935D00032_Word_impl*
end;//TkwLessThanZero.LessThanZero

class function TkwLessThanZero.GetWordNameForRegister: AnsiString;
begin
 Result := '<0';
end;//TkwLessThanZero.GetWordNameForRegister

function TkwLessThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwLessThanZero.GetResultTypeInfo

function TkwLessThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLessThanZero.GetAllParamsCount

function TkwLessThanZero.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwLessThanZero.ParamsTypes

procedure TkwLessThanZero.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(LessThanZero(aCtx, l_aB));
end;//TkwLessThanZero.DoDoIt

function TkwGreaterThanZero.GreaterThanZero(const aCtx: TtfwContext;
 aB: Integer): Boolean;
 {* Реализация слова скрипта >0 }
//#UC START# *551935F7037F_551935F7037F_Word_var*
//#UC END# *551935F7037F_551935F7037F_Word_var*
begin
//#UC START# *551935F7037F_551935F7037F_Word_impl*
 Result := (aB > 0);
//#UC END# *551935F7037F_551935F7037F_Word_impl*
end;//TkwGreaterThanZero.GreaterThanZero

class function TkwGreaterThanZero.GetWordNameForRegister: AnsiString;
begin
 Result := '>0';
end;//TkwGreaterThanZero.GetWordNameForRegister

function TkwGreaterThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwGreaterThanZero.GetResultTypeInfo

function TkwGreaterThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwGreaterThanZero.GetAllParamsCount

function TkwGreaterThanZero.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwGreaterThanZero.ParamsTypes

procedure TkwGreaterThanZero.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(GreaterThanZero(aCtx, l_aB));
end;//TkwGreaterThanZero.DoDoIt

function TkwBitAnd.BitAnd(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта & }
//#UC START# *5519361F0234_5519361F0234_Word_var*
//#UC END# *5519361F0234_5519361F0234_Word_var*
begin
//#UC START# *5519361F0234_5519361F0234_Word_impl*
 Result := aA AND aB;
//#UC END# *5519361F0234_5519361F0234_Word_impl*
end;//TkwBitAnd.BitAnd

class function TkwBitAnd.GetWordNameForRegister: AnsiString;
begin
 Result := '&';
end;//TkwBitAnd.GetWordNameForRegister

function TkwBitAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwBitAnd.GetResultTypeInfo

function TkwBitAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwBitAnd.GetAllParamsCount

function TkwBitAnd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwBitAnd.ParamsTypes

procedure TkwBitAnd.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(BitAnd(aCtx, l_aB, l_aA));
end;//TkwBitAnd.DoDoIt

function TkwBitOR.BitOR(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта | }
//#UC START# *55193639024F_55193639024F_Word_var*
//#UC END# *55193639024F_55193639024F_Word_var*
begin
//#UC START# *55193639024F_55193639024F_Word_impl*
 Result := aA OR aB;
//#UC END# *55193639024F_55193639024F_Word_impl*
end;//TkwBitOR.BitOR

class function TkwBitOR.GetWordNameForRegister: AnsiString;
begin
 Result := '|';
end;//TkwBitOR.GetWordNameForRegister

function TkwBitOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwBitOR.GetResultTypeInfo

function TkwBitOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwBitOR.GetAllParamsCount

function TkwBitOR.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwBitOR.ParamsTypes

procedure TkwBitOR.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aA: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aA := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aA: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(BitOR(aCtx, l_aB, l_aA));
end;//TkwBitOR.DoDoIt

function TkwBitNot.BitNot(const aCtx: TtfwContext;
 aB: Integer): Integer;
 {* Реализация слова скрипта ~ }
//#UC START# *55193651025A_55193651025A_Word_var*
//#UC END# *55193651025A_55193651025A_Word_var*
begin
//#UC START# *55193651025A_55193651025A_Word_impl*
 Result := not aB;
//#UC END# *55193651025A_55193651025A_Word_impl*
end;//TkwBitNot.BitNot

class function TkwBitNot.GetWordNameForRegister: AnsiString;
begin
 Result := '~';
end;//TkwBitNot.GetWordNameForRegister

function TkwBitNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwBitNot.GetResultTypeInfo

function TkwBitNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBitNot.GetAllParamsCount

function TkwBitNot.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwBitNot.ParamsTypes

procedure TkwBitNot.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(BitNot(aCtx, l_aB));
end;//TkwBitNot.DoDoIt

function TkwStackLevel.StackLevel(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта StackLevel }
//#UC START# *55682EDB02B0_55682EDB02B0_Word_var*
//#UC END# *55682EDB02B0_55682EDB02B0_Word_var*
begin
//#UC START# *55682EDB02B0_55682EDB02B0_Word_impl*
 Result := aCtx.rEngine.ValuesCount;
//#UC END# *55682EDB02B0_55682EDB02B0_Word_impl*
end;//TkwStackLevel.StackLevel

class function TkwStackLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'StackLevel';
end;//TkwStackLevel.GetWordNameForRegister

function TkwStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStackLevel.GetResultTypeInfo

function TkwStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwStackLevel.GetAllParamsCount

function TkwStackLevel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwStackLevel.ParamsTypes

procedure TkwStackLevel.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(StackLevel(aCtx));
end;//TkwStackLevel.DoDoIt

procedure TkwReduceStackLevel.ReduceStackLevel(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта ReduceStackLevel }
//#UC START# *55682EFC0160_55682EFC0160_Word_var*
//#UC END# *55682EFC0160_55682EFC0160_Word_var*
begin
//#UC START# *55682EFC0160_55682EFC0160_Word_impl*
 while (aCtx.rEngine.ValuesCount > aValue) do
  aCtx.rEngine.Drop;
//#UC END# *55682EFC0160_55682EFC0160_Word_impl*
end;//TkwReduceStackLevel.ReduceStackLevel

class function TkwReduceStackLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'ReduceStackLevel';
end;//TkwReduceStackLevel.GetWordNameForRegister

function TkwReduceStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwReduceStackLevel.GetResultTypeInfo

function TkwReduceStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwReduceStackLevel.GetAllParamsCount

function TkwReduceStackLevel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwReduceStackLevel.ParamsTypes

procedure TkwReduceStackLevel.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ReduceStackLevel(aCtx, l_aValue);
end;//TkwReduceStackLevel.DoDoIt

procedure TkwCtxParserPushString.Ctx_Parser_PushString(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:Parser:PushString }
//#UC START# *5576DF540107_5576DF540107_Word_var*
//#UC END# *5576DF540107_5576DF540107_Word_var*
begin
//#UC START# *5576DF540107_5576DF540107_Word_impl*
 aCtx.rParser.PushString(aValue);
//#UC END# *5576DF540107_5576DF540107_Word_impl*
end;//TkwCtxParserPushString.Ctx_Parser_PushString

class function TkwCtxParserPushString.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushString';
end;//TkwCtxParserPushString.GetWordNameForRegister

function TkwCtxParserPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushString.GetResultTypeInfo

function TkwCtxParserPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushString.GetAllParamsCount

function TkwCtxParserPushString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxParserPushString.ParamsTypes

procedure TkwCtxParserPushString.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Il3CString;
begin
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_Parser_PushString(aCtx, l_aValue);
end;//TkwCtxParserPushString.DoDoIt

procedure TkwCtxParserPushSymbol.Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:Parser:PushSymbol }
//#UC START# *5576DF7D015F_5576DF7D015F_Word_var*
//#UC END# *5576DF7D015F_5576DF7D015F_Word_var*
begin
//#UC START# *5576DF7D015F_5576DF7D015F_Word_impl*
 aCtx.rParser.PushSymbol(aValue);
//#UC END# *5576DF7D015F_5576DF7D015F_Word_impl*
end;//TkwCtxParserPushSymbol.Ctx_Parser_PushSymbol

class function TkwCtxParserPushSymbol.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushSymbol';
end;//TkwCtxParserPushSymbol.GetWordNameForRegister

function TkwCtxParserPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushSymbol.GetResultTypeInfo

function TkwCtxParserPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushSymbol.GetAllParamsCount

function TkwCtxParserPushSymbol.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwCtxParserPushSymbol.ParamsTypes

procedure TkwCtxParserPushSymbol.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Il3CString;
begin
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_Parser_PushSymbol(aCtx, l_aValue);
end;//TkwCtxParserPushSymbol.DoDoIt

procedure TkwCtxParserPushInt.Ctx_Parser_PushInt(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта Ctx:Parser:PushInt }
//#UC START# *5576DFC10276_5576DFC10276_Word_var*
//#UC END# *5576DFC10276_5576DFC10276_Word_var*
begin
//#UC START# *5576DFC10276_5576DFC10276_Word_impl*
 aCtx.rParser.PushInt(aValue);
//#UC END# *5576DFC10276_5576DFC10276_Word_impl*
end;//TkwCtxParserPushInt.Ctx_Parser_PushInt

class function TkwCtxParserPushInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushInt';
end;//TkwCtxParserPushInt.GetWordNameForRegister

function TkwCtxParserPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCtxParserPushInt.GetResultTypeInfo

function TkwCtxParserPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushInt.GetAllParamsCount

function TkwCtxParserPushInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwCtxParserPushInt.ParamsTypes

procedure TkwCtxParserPushInt.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Ctx_Parser_PushInt(aCtx, l_aValue);
end;//TkwCtxParserPushInt.DoDoIt

function TkwCtxParser.Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
 {* Реализация слова скрипта Ctx:Parser }
//#UC START# *558951EE023C_558951EE023C_Word_var*
//#UC END# *558951EE023C_558951EE023C_Word_var*
begin
//#UC START# *558951EE023C_558951EE023C_Word_impl*
 Result := aCtx.rParser;
//#UC END# *558951EE023C_558951EE023C_Word_impl*
end;//TkwCtxParser.Ctx_Parser

class function TkwCtxParser.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser';
end;//TkwCtxParser.GetWordNameForRegister

function TkwCtxParser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwParserEx);
end;//TkwCtxParser.GetResultTypeInfo

function TkwCtxParser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxParser.GetAllParamsCount

function TkwCtxParser.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxParser.ParamsTypes

procedure TkwCtxParser.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushIntf(Ctx_Parser(aCtx), TypeInfo(ItfwParserEx));
end;//TkwCtxParser.DoDoIt

procedure TkwAtomicIf.AtomicIf(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCondition: Boolean);
 {* Реализация слова скрипта ? }
//#UC START# *55962C7502AB_55962C7502AB_Word_var*
//#UC END# *55962C7502AB_55962C7502AB_Word_var*
begin
//#UC START# *55962C7502AB_55962C7502AB_Word_impl*
 if aCondition then
  aWord.DoIt(aCtx);
//#UC END# *55962C7502AB_55962C7502AB_Word_impl*
end;//TkwAtomicIf.AtomicIf

class function TkwAtomicIf.GetWordNameForRegister: AnsiString;
begin
 Result := '?';
end;//TkwAtomicIf.GetWordNameForRegister

function TkwAtomicIf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwAtomicIf.GetResultTypeInfo

function TkwAtomicIf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwAtomicIf.GetAllParamsCount

function TkwAtomicIf.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAtomicIf.RightParamsCount

function TkwAtomicIf.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwAtomicIf.ParamsTypes

procedure TkwAtomicIf.DoRun(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aCondition: Boolean;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCondition := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCondition: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AtomicIf(aCtx, l_aWord, l_aCondition);
end;//TkwAtomicIf.DoRun

procedure TkwCompileValue.CompileValue(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileValue }
//#UC START# *55964548035E_55964548035E_Word_var*
var
 l_W : TtfwWord;
//#UC END# *55964548035E_55964548035E_Word_var*
begin
//#UC START# *55964548035E_55964548035E_Word_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TtfwWord(aValue.AsObject).Use
 else
  l_W := TkwValue.Create(aValue);
 try
  RunnerAssert(l_W <> nil, 'Нет слова для компиляции', aCtx);
  aCtx.rCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *55964548035E_55964548035E_Word_impl*
end;//TkwCompileValue.CompileValue

class function TkwCompileValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileValue';
end;//TkwCompileValue.GetWordNameForRegister

function TkwCompileValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCompileValue.GetResultTypeInfo

function TkwCompileValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileValue.GetAllParamsCount

function TkwCompileValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileValue.ParamsTypes

procedure TkwCompileValue.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileValue(aCtx, l_aValue);
end;//TkwCompileValue.DoDoIt

class function TkwIMMEDIATE.GetWordNameForRegister: AnsiString;
begin
 Result := 'IMMEDIATE';
end;//TkwIMMEDIATE.GetWordNameForRegister

function TkwIMMEDIATE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwIMMEDIATE.GetResultTypeInfo

function TkwIMMEDIATE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwIMMEDIATE.GetAllParamsCount

function TkwIMMEDIATE.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwIMMEDIATE.ParamsTypes

procedure TkwIMMEDIATE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5596615501C1_Word_var*
//#UC END# *4DAEEDE10285_5596615501C1_Word_var*
begin
//#UC START# *4DAEEDE10285_5596615501C1_Word_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(tfw_wmImmediate));
//#UC END# *4DAEEDE10285_5596615501C1_Word_impl*
end;//TkwIMMEDIATE.DoDoIt

function TkwIMMEDIATE.IsImmediate(const aCtx: TtfwContext): Boolean;
begin
 Result := True;
end;//TkwIMMEDIATE.IsImmediate

function TkwCtxScriptCaller.Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
 {* Реализация слова скрипта Ctx:ScriptCaller }
//#UC START# *559BCE8B03A4_559BCE8B03A4_Word_var*
//#UC END# *559BCE8B03A4_559BCE8B03A4_Word_var*
begin
//#UC START# *559BCE8B03A4_559BCE8B03A4_Word_impl*
 Result := aCtx.rCaller;
//#UC END# *559BCE8B03A4_559BCE8B03A4_Word_impl*
end;//TkwCtxScriptCaller.Ctx_ScriptCaller

class function TkwCtxScriptCaller.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ScriptCaller';
end;//TkwCtxScriptCaller.GetWordNameForRegister

function TkwCtxScriptCaller.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwScriptCaller);
end;//TkwCtxScriptCaller.GetResultTypeInfo

function TkwCtxScriptCaller.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxScriptCaller.GetAllParamsCount

function TkwCtxScriptCaller.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxScriptCaller.ParamsTypes

procedure TkwCtxScriptCaller.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushIntf(Ctx_ScriptCaller(aCtx), TypeInfo(ItfwScriptCaller));
end;//TkwCtxScriptCaller.DoDoIt

function TkwCtxEngine.Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
 {* Реализация слова скрипта Ctx:Engine }
//#UC START# *559BCEAE039E_559BCEAE039E_Word_var*
//#UC END# *559BCEAE039E_559BCEAE039E_Word_var*
begin
//#UC START# *559BCEAE039E_559BCEAE039E_Word_impl*
 Result := aCtx.rEngine;
//#UC END# *559BCEAE039E_559BCEAE039E_Word_impl*
end;//TkwCtxEngine.Ctx_Engine

class function TkwCtxEngine.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Engine';
end;//TkwCtxEngine.GetWordNameForRegister

function TkwCtxEngine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwScriptEngine);
end;//TkwCtxEngine.GetResultTypeInfo

function TkwCtxEngine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxEngine.GetAllParamsCount

function TkwCtxEngine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxEngine.ParamsTypes

procedure TkwCtxEngine.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushIntf(Ctx_Engine(aCtx), TypeInfo(ItfwScriptEngine));
end;//TkwCtxEngine.DoDoIt

function TkwCtxStoredValuesStack.Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
 {* Реализация слова скрипта Ctx:StoredValuesStack }
//#UC START# *559BD00001BA_559BD00001BA_Word_var*
//#UC END# *559BD00001BA_559BD00001BA_Word_var*
begin
//#UC START# *559BD00001BA_559BD00001BA_Word_impl*
 Result := aCtx.rStoredValuesStack;
//#UC END# *559BD00001BA_559BD00001BA_Word_impl*
end;//TkwCtxStoredValuesStack.Ctx_StoredValuesStack

class function TkwCtxStoredValuesStack.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:StoredValuesStack';
end;//TkwCtxStoredValuesStack.GetWordNameForRegister

function TkwCtxStoredValuesStack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwStoredValuesStack);
end;//TkwCtxStoredValuesStack.GetResultTypeInfo

function TkwCtxStoredValuesStack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCtxStoredValuesStack.GetAllParamsCount

function TkwCtxStoredValuesStack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCtxStoredValuesStack.ParamsTypes

procedure TkwCtxStoredValuesStack.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushIntf(Ctx_StoredValuesStack(aCtx), TypeInfo(ItfwStoredValuesStack));
end;//TkwCtxStoredValuesStack.DoDoIt

procedure TkwCreateAndRaise.CreateAndRaise(const aCtx: TtfwContext;
 aClass: TClass;
 const aMessage: AnsiString);
 {* Реализация слова скрипта CreateAndRaise }
//#UC START# *559BFEBF0299_559BFEBF0299_Word_var*
type
 RException = class of Exception;
//#UC END# *559BFEBF0299_559BFEBF0299_Word_var*
begin
//#UC START# *559BFEBF0299_559BFEBF0299_Word_impl*
 if aClass.InheritsFrom(Exception) then
  raise RException(aClass).Create(aMessage)
 else
  RunnerError('Передан не класс исключения, а ' + aClass.ClassName, aCtx); 
//#UC END# *559BFEBF0299_559BFEBF0299_Word_impl*
end;//TkwCreateAndRaise.CreateAndRaise

class function TkwCreateAndRaise.GetWordNameForRegister: AnsiString;
begin
 Result := 'CreateAndRaise';
end;//TkwCreateAndRaise.GetWordNameForRegister

function TkwCreateAndRaise.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCreateAndRaise.GetResultTypeInfo

function TkwCreateAndRaise.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwCreateAndRaise.GetAllParamsCount

function TkwCreateAndRaise.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiClassRef, @tfw_tiString]);
end;//TkwCreateAndRaise.ParamsTypes

procedure TkwCreateAndRaise.DoDoIt(const aCtx: TtfwContext);
var l_aClass: TClass;
var l_aMessage: AnsiString;
begin
 try
  l_aClass := TClass(aCtx.rEngine.PopClass);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aClass: TClass : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMessage := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMessage: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CreateAndRaise(aCtx, l_aClass, l_aMessage);
end;//TkwCreateAndRaise.DoDoIt

procedure TkwCompileRef.CompileRef(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileRef }
//#UC START# *55A50F69026F_55A50F69026F_Word_var*
var
 l_W : TtfwWord;
 l_PW : TkwCompiledPushWord;
//#UC END# *55A50F69026F_55A50F69026F_Word_var*
begin
//#UC START# *55A50F69026F_55A50F69026F_Word_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TtfwWord(aValue.AsObject).Use
 else
  l_W := TkwValue.Create(aValue);
 try
  RunnerAssert(l_W <> nil, 'Нет слова для компиляции', aCtx);
  l_PW := TkwCompiledPushWord.Create(l_W, nil, aCtx);
  try
   aCtx.rCompiler.AddCodePart(l_PW, aCtx, tfw_sniNo);
  finally
   FreeAndNil(l_PW);
  end;//try..finally
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *55A50F69026F_55A50F69026F_Word_impl*
end;//TkwCompileRef.CompileRef

class function TkwCompileRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileRef';
end;//TkwCompileRef.GetWordNameForRegister

function TkwCompileRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCompileRef.GetResultTypeInfo

function TkwCompileRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileRef.GetAllParamsCount

function TkwCompileRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileRef.ParamsTypes

procedure TkwCompileRef.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileRef(aCtx, l_aValue);
end;//TkwCompileRef.DoDoIt

procedure TkwCompileWeakRef.CompileWeakRef(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileWeakRef }
//#UC START# *55CC86DC0163_55CC86DC0163_Word_var*
var
 l_W : TtfwWord;
//#UC END# *55CC86DC0163_55CC86DC0163_Word_var*
begin
//#UC START# *55CC86DC0163_55CC86DC0163_Word_impl*
 if (aValue.rType = tfw_vtObj) AND (aValue.AsObject Is TtfwWord) then
  l_W := TkwWordPtrPushWord.Create(aValue.AsObject As TtfwWord)
 else
  l_W := nil;
 try
  RunnerAssert(l_W <> nil, 'Нет слова для компиляции', aCtx);
  aCtx.rCompiler.AddCodePart(l_W, aCtx, tfw_sniNo);
 finally
  FreeAndNil(l_W);
 end;//try..finally
//#UC END# *55CC86DC0163_55CC86DC0163_Word_impl*
end;//TkwCompileWeakRef.CompileWeakRef

class function TkwCompileWeakRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileWeakRef';
end;//TkwCompileWeakRef.GetWordNameForRegister

function TkwCompileWeakRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCompileWeakRef.GetResultTypeInfo

function TkwCompileWeakRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileWeakRef.GetAllParamsCount

function TkwCompileWeakRef.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwCompileWeakRef.ParamsTypes

procedure TkwCompileWeakRef.DoDoIt(const aCtx: TtfwContext);
var l_aValue: TtfwStackValue;
begin
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CompileWeakRef(aCtx, l_aValue);
end;//TkwCompileWeakRef.DoDoIt

procedure TkwDUPN.DUPN(const aCtx: TtfwContext;
 aN: Integer);
 {* Реализация слова скрипта DUPN }
//#UC START# *55E866650225_55E866650225_Word_var*
//#UC END# *55E866650225_55E866650225_Word_var*
begin
//#UC START# *55E866650225_55E866650225_Word_impl*
 aCtx.rEngine.DupN(aN);
//#UC END# *55E866650225_55E866650225_Word_impl*
end;//TkwDUPN.DUPN

class function TkwDUPN.GetWordNameForRegister: AnsiString;
begin
 Result := 'DUPN';
end;//TkwDUPN.GetWordNameForRegister

function TkwDUPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDUPN.GetResultTypeInfo

function TkwDUPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDUPN.GetAllParamsCount

function TkwDUPN.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDUPN.ParamsTypes

procedure TkwDUPN.DoDoIt(const aCtx: TtfwContext);
var l_aN: Integer;
begin
 try
  l_aN := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aN: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DUPN(aCtx, l_aN);
end;//TkwDUPN.DoDoIt

procedure TkwDROPN.DROPN(const aCtx: TtfwContext;
 aN: Integer);
 {* Реализация слова скрипта DROPN }
//#UC START# *55E8667C0309_55E8667C0309_Word_var*
//#UC END# *55E8667C0309_55E8667C0309_Word_var*
begin
//#UC START# *55E8667C0309_55E8667C0309_Word_impl*
 aCtx.rEngine.DropN(aN);
//#UC END# *55E8667C0309_55E8667C0309_Word_impl*
end;//TkwDROPN.DROPN

class function TkwDROPN.GetWordNameForRegister: AnsiString;
begin
 Result := 'DROPN';
end;//TkwDROPN.GetWordNameForRegister

function TkwDROPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDROPN.GetResultTypeInfo

function TkwDROPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDROPN.GetAllParamsCount

function TkwDROPN.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwDROPN.ParamsTypes

procedure TkwDROPN.DoDoIt(const aCtx: TtfwContext);
var l_aN: Integer;
begin
 try
  l_aN := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aN: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DROPN(aCtx, l_aN);
end;//TkwDROPN.DoDoIt

class function TBasicsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'BasicsPack';
end;//TBasicsPackResNameGetter.ResName

 {$R BasicsPack.res}

initialization
 TkwDefine.RegisterInEngine;
 {* Регистрация Define }
 TkwCompiledPushWord.RegisterClass;
 {* Регистрация TkwCompiledPushWord }
 TkwTrue.RegisterInEngine;
 {* Регистрация True }
 TkwFalse.RegisterInEngine;
 {* Регистрация False }
 TkwMsg.RegisterInEngine;
 {* Регистрация Msg }
 TkwPrint.RegisterInEngine;
 {* Регистрация Print }
 TkwLOOP.RegisterInEngine;
 {* Регистрация LOOP }
 TkwWHILEDO.RegisterInEngine;
 {* Регистрация WHILEDO }
 TkwBREAK.RegisterInEngine;
 {* Регистрация BREAK }
 TkwCONTINUE.RegisterInEngine;
 {* Регистрация CONTINUE }
 TkwEXIT.RegisterInEngine;
 {* Регистрация EXIT }
 TkwHALT.RegisterInEngine;
 {* Регистрация HALT }
 TkwBREAKITERATOR.RegisterInEngine;
 {* Регистрация BREAKITERATOR }
 TkwNOP.RegisterInEngine;
 {* Регистрация NOP }
 TkwSLEEP.RegisterInEngine;
 {* Регистрация SLEEP }
 TkwProcessMessages.RegisterInEngine;
 {* Регистрация ProcessMessages }
 TkwCheckAssert.RegisterInEngine;
 {* Регистрация CheckAssert }
 TkwASSERTS.RegisterInEngine;
 {* Регистрация ASSERTS }
 TkwNil.RegisterInEngine;
 {* Регистрация Nil }
 TkwDoWord.RegisterInEngine;
 {* Регистрация DoWord }
 TkwSmartEquals.RegisterInEngine;
 {* Регистрация SmartEquals }
 TkwSmartNotEquals.RegisterInEngine;
 {* Регистрация SmartNotEquals }
 TkwPushWord.RegisterInEngine;
 {* Регистрация PushWord }
 TkwCurrentException.RegisterInEngine;
 {* Регистрация current_exception }
 TkwCurrentExceptionClass.RegisterInEngine;
 {* Регистрация current_exception_class }
 TkwCurrentExceptionClassName.RegisterInEngine;
 {* Регистрация current_exception_ClassName }
 TkwCurrentExceptionMessage.RegisterInEngine;
 {* Регистрация current_exception_Message }
 TkwInc.RegisterInEngine;
 {* Регистрация Inc }
 TkwDec.RegisterInEngine;
 {* Регистрация Dec }
 TkwAdd.RegisterInEngine;
 {* Регистрация Add }
 TkwSub.RegisterInEngine;
 {* Регистрация Sub }
 TkwDivision.RegisterInEngine;
 {* Регистрация Division }
 TkwMul.RegisterInEngine;
 {* Регистрация Mul }
 TkwDivide.RegisterInEngine;
 {* Регистрация Divide }
 TkwMul2.RegisterInEngine;
 {* Регистрация Mul2 }
 TkwDiv2.RegisterInEngine;
 {* Регистрация Div2 }
 TkwMulDiv.RegisterInEngine;
 {* Регистрация MulDiv }
 TkwBoolNot.RegisterInEngine;
 {* Регистрация BoolNot }
 TkwModFromDiv.RegisterInEngine;
 {* Регистрация ModFromDiv }
 TkwBoolAnd.RegisterInEngine;
 {* Регистрация BoolAnd }
 TkwBoolOr.RegisterInEngine;
 {* Регистрация BoolOr }
 TkwNotZero.RegisterInEngine;
 {* Регистрация NotZero }
 TkwEqualZero.RegisterInEngine;
 {* Регистрация EqualZero }
 TkwSWAP.RegisterInEngine;
 {* Регистрация SWAP }
 TkwDROP.RegisterInEngine;
 {* Регистрация DROP }
 TkwDUP.RegisterInEngine;
 {* Регистрация DUP }
 TkwDUPIfNotZero.RegisterInEngine;
 {* Регистрация DUPIfNotZero }
 TkwROT.RegisterInEngine;
 {* Регистрация ROT }
 TkwPICK.RegisterInEngine;
 {* Регистрация PICK }
 TkwInvertROT.RegisterInEngine;
 {* Регистрация InvertROT }
 TkwSWAP2.RegisterInEngine;
 {* Регистрация SWAP2 }
 TkwOVER2.RegisterInEngine;
 {* Регистрация OVER2 }
 TkwDUP2.RegisterInEngine;
 {* Регистрация DUP2 }
 TkwDROP2.RegisterInEngine;
 {* Регистрация DROP2 }
 TkwNIP.RegisterInEngine;
 {* Регистрация NIP }
 TkwTUCK.RegisterInEngine;
 {* Регистрация TUCK }
 TkwOVER.RegisterInEngine;
 {* Регистрация OVER }
 TkwROLL.RegisterInEngine;
 {* Регистрация ROLL }
 TkwNotEquals.RegisterInEngine;
 {* Регистрация NotEquals }
 TkwGREATER.RegisterInEngine;
 {* Регистрация GREATER }
 TkwLESS.RegisterInEngine;
 {* Регистрация LESS }
 TkwEquals.RegisterInEngine;
 {* Регистрация Equals }
 TkwLessThanZero.RegisterInEngine;
 {* Регистрация LessThanZero }
 TkwGreaterThanZero.RegisterInEngine;
 {* Регистрация GreaterThanZero }
 TkwBitAnd.RegisterInEngine;
 {* Регистрация BitAnd }
 TkwBitOR.RegisterInEngine;
 {* Регистрация BitOR }
 TkwBitNot.RegisterInEngine;
 {* Регистрация BitNot }
 TkwStackLevel.RegisterInEngine;
 {* Регистрация StackLevel }
 TkwReduceStackLevel.RegisterInEngine;
 {* Регистрация ReduceStackLevel }
 TkwCtxParserPushString.RegisterInEngine;
 {* Регистрация Ctx_Parser_PushString }
 TkwCtxParserPushSymbol.RegisterInEngine;
 {* Регистрация Ctx_Parser_PushSymbol }
 TkwCtxParserPushInt.RegisterInEngine;
 {* Регистрация Ctx_Parser_PushInt }
 TkwCtxParser.RegisterInEngine;
 {* Регистрация Ctx_Parser }
 TkwAtomicIf.RegisterInEngine;
 {* Регистрация AtomicIf }
 TkwCompileValue.RegisterInEngine;
 {* Регистрация CompileValue }
 TkwIMMEDIATE.RegisterInEngine;
 {* Регистрация IMMEDIATE }
 TkwCtxScriptCaller.RegisterInEngine;
 {* Регистрация Ctx_ScriptCaller }
 TkwCtxEngine.RegisterInEngine;
 {* Регистрация Ctx_Engine }
 TkwCtxStoredValuesStack.RegisterInEngine;
 {* Регистрация Ctx_StoredValuesStack }
 TkwCreateAndRaise.RegisterInEngine;
 {* Регистрация CreateAndRaise }
 TkwCompileRef.RegisterInEngine;
 {* Регистрация CompileRef }
 TkwCompileWeakRef.RegisterInEngine;
 {* Регистрация CompileWeakRef }
 TkwDUPN.RegisterInEngine;
 {* Регистрация DUPN }
 TkwDROPN.RegisterInEngine;
 {* Регистрация DROPN }
 TBasicsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
//#UC START# *551588F90151*
 TtfwClassRef.Register(EStreamError);
 TtfwClassRef.Register(EFileStreamError);
 TtfwClassRef.Register(EFCreateError);
 TtfwClassRef.Register(EFOpenError);
 TtfwClassRef.Register(EFilerError);
 TtfwClassRef.Register(EReadError);
 TtfwClassRef.Register(EWriteError);
 TtfwClassRef.Register(EClassNotFound);
 TtfwClassRef.Register(EMethodNotFound);
 TtfwClassRef.Register(EInvalidImage);
 TtfwClassRef.Register(EResNotFound);
 TtfwClassRef.Register(EListError);
 TtfwClassRef.Register(EBitsError);
 TtfwClassRef.Register(EStringListError);
 TtfwClassRef.Register(EComponentError);
 TtfwClassRef.Register(EParserError);
 TtfwClassRef.Register(EOutOfResources);
 TtfwClassRef.Register(EInvalidOperation);

 TtfwClassRef.Register(EAssertionFailed);
 TtfwClassRef.Register(EAccessViolation);
 
 TtfwClassRef.Register(ERangeError);

 TtfwClassRef.Register(EZeroDivide);
 
 TtfwClassRef.Register(EExternalException);
 TtfwClassRef.Register(EIntError);
 TtfwClassRef.Register(EDivByZero);
 TtfwClassRef.Register(EIntOverflow);

 TtfwClassRef.Register(EInvalidOp);
 TtfwClassRef.Register(EOverflow);
 TtfwClassRef.Register(EUnderflow);
 TtfwClassRef.Register(EInvalidPointer);
 TtfwClassRef.Register(EInvalidCast);
 
 TtfwClassRef.Register(EConvertError);
 TtfwClassRef.Register(EPrivilege);
 TtfwClassRef.Register(EStackOverflow);
 
 TtfwClassRef.Register(EControlC);
 
 TtfwClassRef.Register(EIntfCastError);
 
 TtfwClassRef.Register(EOSError);

 TtfwClassRef.Register(EtfwCompiler);
 TtfwClassRef.Register(EtfwRunner);
 TtfwClassRef.Register(EtfwScriptException);
 
 TtfwClassRef.Register(EtfwContinue);
 TtfwClassRef.Register(EtfwBreak);
 TtfwClassRef.Register(EtfwBreakIterator);
 TtfwClassRef.Register(EtfwExit);
 TtfwClassRef.Register(EtfwHalt);

 TtfwClassRef.Register(EtfwFail);
 TtfwClassRef.Register(EtfwManualBreak);
//#UC END# *551588F90151*
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
 {* Регистрация типа TObject }
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
 {* Регистрация типа TClass }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
 {* Регистрация типа ItfwParserEx }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptCaller));
 {* Регистрация типа ItfwScriptCaller }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptEngine));
 {* Регистрация типа ItfwScriptEngine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwStoredValuesStack));
 {* Регистрация типа ItfwStoredValuesStack }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
