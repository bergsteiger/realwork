unit BasicsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\BasicsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , tfwParserInterfaces
 , l3Interfaces
 , tfwConstLike
 , kwCompiledWordPrim
 , kwCompiledWordWorker
 , tfwAxiomaticsResNameGetter
 , tfwGlobalKeyWord
 , TypInfo
 , tfwWordWorkerEx
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwDefine = {final} class(TtfwConstLike)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   procedure FinishDefinitionOfNewWord(aWordToFinish: TtfwKeyWord;
    aCompiled: TkwCompiledWordPrim;
    const aContext: TtfwContext); override;
    {* Завершает определение вновь созданного слова }
   function GetNewWordName(const aContext: TtfwContext): Il3CString; override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
 end;//TkwDefine

 //#UC START# *94E4F896CE56ci*
 //#UC END# *94E4F896CE56ci*
 //#UC START# *94E4F896CE56cit*
 //#UC END# *94E4F896CE56cit*
 TBasicsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *94E4F896CE56publ*
 //#UC END# *94E4F896CE56publ*
 end;//TBasicsPackResNameGetter

 TkwTrue = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта true
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 true >>> l_Boolean
[code]  }
  private
   function True(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта true }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTrue

 TkwFalse = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта false
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 false >>> l_Boolean
[code]  }
  private
   function False(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта false }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFalse

 TkwMsg = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Msg
*Пример:*
[code]
 aValue Msg
[code]  }
  private
   procedure Msg(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта Msg }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMsg

 TkwPrint = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта .
*Пример:*
[code]
 aValue .
[code]  }
  private
   procedure Print(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта . }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPrint

 TkwLOOP = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта LOOP
[panel]Цикл LOOP.
Пример:
[code]
 10 LOOP ( 'Hello' . )
[code][panel]
*Пример:*
[code]
 aCount LOOP aWord
[code]  }
  private
   procedure LOOP(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCount: Integer);
    {* Реализация слова скрипта LOOP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLOOP

 TkwWHILEDO = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WHILEDO
[panel]Цикл While. Повторяется пока выполняется некоторое условие.
Пример:
[code] 10 @ ( ?DUP !=0 ) @ ( DUP . -- ) WHILEDO [code]
Но ЛУЧШЕ пользоваться паскалеподобной конструкцией - WHILE[panel]
*Пример:*
[code]
 aCondition aWord WHILEDO
[code]  }
  private
   procedure WHILEDO(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: TtfwWord);
    {* Реализация слова скрипта WHILEDO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWHILEDO

 TkwBREAK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK
[panel]Выход из цикла[panel]
*Пример:*
[code]
 BREAK
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwBREAK

 TkwCONTINUE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CONTINUE
[panel]Переход к началу цикла[panel]
*Пример:*
[code]
 CONTINUE
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwCONTINUE

 TkwEXIT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EXIT
[panel]Выход из процедуры[panel]
*Пример:*
[code]
 EXIT
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEXIT

 TkwHALT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта HALT
[panel]Прервать выполяемый скрипт[panel]
*Пример:*
[code]
 HALT
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwHALT

 TkwBREAKITERATOR = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK-ITERATOR
*Пример:*
[code]
 BREAK-ITERATOR
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwBREAKITERATOR

 TkwNOP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NOP
*Пример:*
[code]
 NOP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNOP

 TkwSLEEP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SLEEP
*Пример:*
[code]
 aDuration SLEEP
[code]  }
  private
   procedure SLEEP(const aCtx: TtfwContext;
    aDuration: Integer);
    {* Реализация слова скрипта SLEEP }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSLEEP

 TkwProcessMessages = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ProcessMessages
*Пример:*
[code]
 ProcessMessages
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwProcessMessages

 TkwCheckAssert = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ASSERT
[panel]Функция Assert.
Пример:
[code]
 waited:? ASSERT
[code][panel]
*Пример:*
[code]
 aCondition ASSERT
[code]  }
  private
   procedure CheckAssert(const aCtx: TtfwContext;
    aCondition: Boolean);
    {* Реализация слова скрипта ASSERT }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCheckAssert

 TkwASSERTS = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ASSERTS
[panel]Аналогичен Assert, но сообщение об ошибке берется из стека[panel]
*Пример:*
[code]
 aCondition aMsg ASSERTS
[code]  }
  private
   procedure ASSERTS(const aCtx: TtfwContext;
    const aMsg: AnsiString;
    aCondition: Boolean);
    {* Реализация слова скрипта ASSERTS }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwASSERTS

 TkwNil = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта nil
*Пример:*
[code]
 nil
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNil

 TkwDoWord = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DO
[panel]Исполняет скомпилированное слово.[panel]
*Пример:*
[code]
 aWord DO
[code]  }
  private
   procedure DoWord(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта DO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDoWord

 TkwSmartEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?==
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?== >>> l_Boolean
[code]  }
  private
   function SmartEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
    {* Реализация слова скрипта ?== }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartEquals

 TkwSmartNotEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?!=
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?!= >>> l_Boolean
[code]  }
  private
   function SmartNotEquals(const aCtx: TtfwContext;
    const aV1: TtfwStackValue;
    const aV2: TtfwStackValue): Boolean;
    {* Реализация слова скрипта ?!= }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSmartNotEquals

 TkwPushWord = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта @
[panel]Кладёт на стек адрес указанного слова[panel]
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 @ aWord >>> l_TtfwWord
[code]  }
  private
   function PushWord(const aCtx: TtfwContext;
    aWord: TtfwWord): TtfwWord;
    {* Реализация слова скрипта @ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function SuppressNextImmediate(const aContext: TtfwContext;
    aWordNumber: Integer): TtfwSuppressNextImmediate; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPushWord

 TkwCurrentException = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception
*Тип результата:* TObject
*Пример:*
[code]
OBJECT VAR l_TObject
 current:exception >>> l_TObject
[code]  }
  private
   function current_exception(const aCtx: TtfwContext): TObject;
    {* Реализация слова скрипта current:exception }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentException

 TkwCurrentExceptionClass = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:class
*Тип результата:* TClass
*Пример:*
[code]
CLASS VAR l_TClass
 current:exception:class >>> l_TClass
[code]  }
  private
   function current_exception_class(const aCtx: TtfwContext): TClass;
    {* Реализация слова скрипта current:exception:class }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClass

 TkwCurrentExceptionClassName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:ClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 current:exception:ClassName >>> l_String
[code]  }
  private
   function current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта current:exception:ClassName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionClassName

 TkwCurrentExceptionMessage = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:Message
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 current:exception:Message >>> l_String
[code]  }
  private
   function current_exception_Message(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта current:exception:Message }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCurrentExceptionMessage

 TkwInc = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ++
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aValue ++ >>> l_Integer
[code]  }
  private
   function Inc(const aCtx: TtfwContext;
    aValue: Integer): Integer;
    {* Реализация слова скрипта ++ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwInc

 TkwDec = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта --
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aValue -- >>> l_Integer
[code]  }
  private
   function Dec(const aCtx: TtfwContext;
    aValue: Integer): Integer;
    {* Реализация слова скрипта -- }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDec

 TkwAdd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта +
*Тип результата:* TtfwStackValue
*Пример:*
[code]
VAR l_TtfwStackValue
 aA aB + >>> l_TtfwStackValue
[code]  }
  private
   function Add(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): TtfwStackValue;
    {* Реализация слова скрипта + }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAdd

 TkwSub = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта -
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB - >>> l_Integer
[code]  }
  private
   function Sub(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта - }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSub

 TkwDivision = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DIV
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB DIV >>> l_Integer
[code]  }
  private
   function Division(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта DIV }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivision

 TkwMul = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта *
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB * >>> l_Integer
[code]  }
  private
   function Mul(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта * }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul

 TkwDivide = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта /
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB / >>> l_Integer
[code]  }
  private
   function Divide(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта / }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDivide

 TkwMul2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2*
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA 2* >>> l_Integer
[code]  }
  private
   function Mul2(const aCtx: TtfwContext;
    aA: Integer): Integer;
    {* Реализация слова скрипта 2* }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMul2

 TkwDiv2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2/
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA 2/ >>> l_Integer
[code]  }
  private
   function Div2(const aCtx: TtfwContext;
    aA: Integer): Integer;
    {* Реализация слова скрипта 2/ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDiv2

 TkwMulDiv = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта */
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB aC */ >>> l_Integer
[code]  }
  private
   function MulDiv(const aCtx: TtfwContext;
    aC: Integer;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта */ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMulDiv

 TkwBoolNot = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта !
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA ! >>> l_Boolean
[code]  }
  private
   function BoolNot(const aCtx: TtfwContext;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта ! }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolNot

 TkwModFromDiv = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта MOD
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB MOD >>> l_Integer
[code]  }
  private
   function ModFromDiv(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта MOD }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwModFromDiv

 TkwBoolAnd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта &&
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB && >>> l_Boolean
[code]  }
  private
   function BoolAnd(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта && }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolAnd

 TkwBoolOr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ||
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB || >>> l_Boolean
[code]  }
  private
   function BoolOr(const aCtx: TtfwContext;
    aB: Boolean;
    aA: Boolean): Boolean;
    {* Реализация слова скрипта || }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBoolOr

 TkwNotZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта !=0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA !=0 >>> l_Boolean
[code]  }
  private
   function NotZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
    {* Реализация слова скрипта !=0 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotZero

 TkwEqualZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта =0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA =0 >>> l_Boolean
[code]  }
  private
   function EqualZero(const aCtx: TtfwContext;
    aA: Integer): Boolean;
    {* Реализация слова скрипта =0 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEqualZero

 TkwSWAP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SWAP
*Пример:*
[code]
 SWAP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwSWAP

 TkwDROP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DROP
*Пример:*
[code]
 DROP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDROP

 TkwDUP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DUP
*Пример:*
[code]
 DUP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUP

 TkwDUPIfNotZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ?DUP
*Пример:*
[code]
 ?DUP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUPIfNotZero

 TkwROT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ROT
[panel]Прокрутить три верхних элемента стека: ( x1 x2 x3 -- x2 x3 x1 )[panel]
*Пример:*
[code]
 ROT
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwROT

 TkwPICK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта PICK
[panel]Формат: u PICK. 
Удаляет u. Копирует xu на вершину стека. ( xu ... x1 x0 u -- xu ... x1 x0 xu )[panel]
*Пример:*
[code]
 PICK
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwPICK

 TkwInvertROT = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта -ROT
[panel]Прокрутить три верхних элемента стека: ( x1 x2 x3 -- x3 x1 x2 )[panel]
*Пример:*
[code]
 -ROT
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwInvertROT

 TkwSWAP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2SWAP
[panel]Меняет местами две верхних пары-ячеек. ( x1 x2 x3 x4 -- x3 x4 x1 x2 )[panel]
*Пример:*
[code]
 2SWAP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwSWAP2

 TkwOVER2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2OVER
[panel]Копирует пару-ячеек x1 x2 на вершину стека. ( x1 x2 x3 x4 -- x1 x2 x3 x4 x1 x2 )[panel]
*Пример:*
[code]
 2OVER
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwOVER2

 TkwDUP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DUP
[panel]Дублирует пару-ячеек x1 x2. ( x1 x2 -- x1 x2 x1 x2 )[panel]
*Пример:*
[code]
 2DUP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDUP2

 TkwDROP2 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DROP
[panel]Удаляет пару-ячеек x1 x2 из стека. ( x1 x2 -- )[panel]
*Пример:*
[code]
 2DROP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwDROP2

 TkwNIP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта NIP
[panel]Удаляет первый элемент ниже вершины стека. ( x1 x2 -- x2 )[panel]
*Пример:*
[code]
 NIP
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwNIP

 TkwTUCK = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта TUCK
[panel]Копирует верхний элемент стека ниже второго элемента стека. ( x1 x2 -- x2 x1 x2 )[panel]
*Пример:*
[code]
 TUCK
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwTUCK

 TkwOVER = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта OVER
[panel]Помещает копию x1 на вершине стека. ( x1 x2 -- x1 x2 x1 )[panel]
*Пример:*
[code]
 OVER
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwOVER

 TkwROLL = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ROLL
[panel]Формат: u ROLL. 
Убрать u. Повернуть u+1 элемент на вершине стека. ( xu xu-1 ... x0 u -- xu-1 ... x0 xu )[panel]
*Пример:*
[code]
 ROLL
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwROLL

 TkwNotEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта !=
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB != >>> l_Boolean
[code]  }
  private
   function NotEquals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта != }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNotEquals

 TkwGREATER = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GREATER
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB GREATER >>> l_Boolean
[code]  }
  private
   function GREATER(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта GREATER }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGREATER

 TkwLESS = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта LESS
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB LESS >>> l_Boolean
[code]  }
  private
   function LESS(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта LESS }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLESS

 TkwEquals = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ==
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB == >>> l_Boolean
[code]  }
  private
   function Equals(const aCtx: TtfwContext;
    const aB: TtfwStackValue;
    const aA: TtfwStackValue): Boolean;
    {* Реализация слова скрипта == }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEquals

 TkwLessThanZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта <0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aB <0 >>> l_Boolean
[code]  }
  private
   function LessThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
    {* Реализация слова скрипта <0 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLessThanZero

 TkwGreaterThanZero = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта >0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aB >0 >>> l_Boolean
[code]  }
  private
   function GreaterThanZero(const aCtx: TtfwContext;
    aB: Integer): Boolean;
    {* Реализация слова скрипта >0 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGreaterThanZero

 TkwBitAnd = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта &
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB & >>> l_Integer
[code]  }
  private
   function BitAnd(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта & }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitAnd

 TkwBitOR = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта |
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB | >>> l_Integer
[code]  }
  private
   function BitOR(const aCtx: TtfwContext;
    aB: Integer;
    aA: Integer): Integer;
    {* Реализация слова скрипта | }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitOR

 TkwBitNot = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ~
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aB ~ >>> l_Integer
[code]  }
  private
   function BitNot(const aCtx: TtfwContext;
    aB: Integer): Integer;
    {* Реализация слова скрипта ~ }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBitNot

 TkwStackLevel = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StackLevel
[panel]Текущий уровень стека[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 StackLevel >>> l_Integer
[code]  }
  private
   function StackLevel(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта StackLevel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStackLevel

 TkwReduceStackLevel = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ReduceStackLevel
*Пример:*
[code]
 aValue ReduceStackLevel
[code]  }
  private
   procedure ReduceStackLevel(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта ReduceStackLevel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwReduceStackLevel

 TkwCtxParserPushString = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushString
*Пример:*
[code]
 aValue Ctx:Parser:PushString
[code]  }
  private
   procedure Ctx_Parser_PushString(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:Parser:PushString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushString

 TkwCtxParserPushSymbol = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushSymbol
*Пример:*
[code]
 aValue Ctx:Parser:PushSymbol
[code]  }
  private
   procedure Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта Ctx:Parser:PushSymbol }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushSymbol

 TkwCtxParserPushInt = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushInt
*Пример:*
[code]
 aValue Ctx:Parser:PushInt
[code]  }
  private
   procedure Ctx_Parser_PushInt(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта Ctx:Parser:PushInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParserPushInt

 TkwCtxParser = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser
*Тип результата:* ItfwParserEx
*Пример:*
[code]
INTERFACE VAR l_ItfwParserEx
 Ctx:Parser >>> l_ItfwParserEx
[code]  }
  private
   function Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
    {* Реализация слова скрипта Ctx:Parser }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxParser

 TkwAtomicIf = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта ?
*Пример:*
[code]
 aCondition ? aWord
[code]  }
  private
   procedure AtomicIf(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aCondition: Boolean);
    {* Реализация слова скрипта ? }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAtomicIf

 TkwCompileValue = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileValue
*Пример:*
[code]
 aValue CompileValue
[code]  }
  private
   procedure CompileValue(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileValue }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileValue

 TkwIMMEDIATE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IMMEDIATE
*Пример:*
[code]
 IMMEDIATE
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwIMMEDIATE

 TkwCtxScriptCaller = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ScriptCaller
*Тип результата:* ItfwScriptCaller
*Пример:*
[code]
INTERFACE VAR l_ItfwScriptCaller
 Ctx:ScriptCaller >>> l_ItfwScriptCaller
[code]  }
  private
   function Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
    {* Реализация слова скрипта Ctx:ScriptCaller }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxScriptCaller

 TkwCtxEngine = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Engine
*Тип результата:* ItfwScriptEngine
*Пример:*
[code]
INTERFACE VAR l_ItfwScriptEngine
 Ctx:Engine >>> l_ItfwScriptEngine
[code]  }
  private
   function Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
    {* Реализация слова скрипта Ctx:Engine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxEngine

 TkwCtxStoredValuesStack = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StoredValuesStack
*Тип результата:* ItfwStoredValuesStack
*Пример:*
[code]
INTERFACE VAR l_ItfwStoredValuesStack
 Ctx:StoredValuesStack >>> l_ItfwStoredValuesStack
[code]  }
  private
   function Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
    {* Реализация слова скрипта Ctx:StoredValuesStack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCtxStoredValuesStack

 TkwCreateAndRaise = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CreateAndRaise
[panel]Возбуждает исключение указаного класса aClass с сообщением aMessage[panel]
*Пример:*
[code]
 aMessage aClass CreateAndRaise
[code]  }
  private
   procedure CreateAndRaise(const aCtx: TtfwContext;
    aClass: TClass;
    const aMessage: AnsiString);
    {* Реализация слова скрипта CreateAndRaise }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateAndRaise

 TkwCompileRef = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileRef
*Пример:*
[code]
 aValue CompileRef
[code]  }
  private
   procedure CompileRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileRef }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileRef

 TkwCompileWeakRef = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileWeakRef
*Пример:*
[code]
 aValue CompileWeakRef
[code]  }
  private
   procedure CompileWeakRef(const aCtx: TtfwContext;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта CompileWeakRef }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompileWeakRef

 TkwDUPN = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DUPN
*Пример:*
[code]
 aN DUPN
[code]  }
  private
   procedure DUPN(const aCtx: TtfwContext;
    aN: Integer);
    {* Реализация слова скрипта DUPN }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDUPN

 TkwDROPN = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DROPN
*Пример:*
[code]
 aN DROPN
[code]  }
  private
   procedure DROPN(const aCtx: TtfwContext;
    aN: Integer);
    {* Реализация слова скрипта DROPN }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDROPN

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

class function TkwDefine.GetWordNameForRegister: AnsiString;
begin
 Result := 'Define';
end;//TkwDefine.GetWordNameForRegister

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

class function TBasicsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'BasicsPack';
end;//TBasicsPackResNameGetter.ResName

 {$R BasicsPack.res}

function TkwTrue.True(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта true }
//#UC START# *31D2EDD18C66_384521AFEDE4_var*
//#UC END# *31D2EDD18C66_384521AFEDE4_var*
begin
//#UC START# *31D2EDD18C66_384521AFEDE4_impl*
 Result := System.true;
//#UC END# *31D2EDD18C66_384521AFEDE4_impl*
end;//TkwTrue.True

procedure TkwTrue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_384521AFEDE4_var*
//#UC END# *4DAEEDE10285_384521AFEDE4_var*
begin
//#UC START# *4DAEEDE10285_384521AFEDE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_384521AFEDE4_impl*
end;//TkwTrue.DoDoIt

class function TkwTrue.GetWordNameForRegister: AnsiString;
begin
 Result := 'true';
end;//TkwTrue.GetWordNameForRegister

function TkwTrue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_384521AFEDE4_var*
//#UC END# *551544E2001A_384521AFEDE4_var*
begin
//#UC START# *551544E2001A_384521AFEDE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_384521AFEDE4_impl*
end;//TkwTrue.GetResultTypeInfo

function TkwTrue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTrue.GetAllParamsCount

function TkwTrue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_384521AFEDE4_var*
//#UC END# *5617F4D00243_384521AFEDE4_var*
begin
//#UC START# *5617F4D00243_384521AFEDE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_384521AFEDE4_impl*
end;//TkwTrue.ParamsTypes

function TkwFalse.False(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта false }
//#UC START# *CEB83FCC48B0_A3E68B91DEB2_var*
//#UC END# *CEB83FCC48B0_A3E68B91DEB2_var*
begin
//#UC START# *CEB83FCC48B0_A3E68B91DEB2_impl*
 Result := System.false;
//#UC END# *CEB83FCC48B0_A3E68B91DEB2_impl*
end;//TkwFalse.False

procedure TkwFalse.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A3E68B91DEB2_var*
//#UC END# *4DAEEDE10285_A3E68B91DEB2_var*
begin
//#UC START# *4DAEEDE10285_A3E68B91DEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A3E68B91DEB2_impl*
end;//TkwFalse.DoDoIt

class function TkwFalse.GetWordNameForRegister: AnsiString;
begin
 Result := 'false';
end;//TkwFalse.GetWordNameForRegister

function TkwFalse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A3E68B91DEB2_var*
//#UC END# *551544E2001A_A3E68B91DEB2_var*
begin
//#UC START# *551544E2001A_A3E68B91DEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A3E68B91DEB2_impl*
end;//TkwFalse.GetResultTypeInfo

function TkwFalse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFalse.GetAllParamsCount

function TkwFalse.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A3E68B91DEB2_var*
//#UC END# *5617F4D00243_A3E68B91DEB2_var*
begin
//#UC START# *5617F4D00243_A3E68B91DEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A3E68B91DEB2_impl*
end;//TkwFalse.ParamsTypes

procedure TkwMsg.Msg(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта Msg }
//#UC START# *420EA6C5993D_8BA2A290A172_var*
var
 l_S : AnsiString;
//#UC END# *420EA6C5993D_8BA2A290A172_var*
begin
//#UC START# *420EA6C5993D_8BA2A290A172_impl*
 l_S := l3Str(aValue.AsPrintable);
 MessageBoxA(0, PAnsiChar(l_S), 'script message', MB_OK);
//#UC END# *420EA6C5993D_8BA2A290A172_impl*
end;//TkwMsg.Msg

procedure TkwMsg.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8BA2A290A172_var*
//#UC END# *4DAEEDE10285_8BA2A290A172_var*
begin
//#UC START# *4DAEEDE10285_8BA2A290A172_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8BA2A290A172_impl*
end;//TkwMsg.DoDoIt

class function TkwMsg.GetWordNameForRegister: AnsiString;
begin
 Result := 'Msg';
end;//TkwMsg.GetWordNameForRegister

function TkwMsg.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8BA2A290A172_var*
//#UC END# *551544E2001A_8BA2A290A172_var*
begin
//#UC START# *551544E2001A_8BA2A290A172_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8BA2A290A172_impl*
end;//TkwMsg.GetResultTypeInfo

function TkwMsg.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMsg.GetAllParamsCount

function TkwMsg.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8BA2A290A172_var*
//#UC END# *5617F4D00243_8BA2A290A172_var*
begin
//#UC START# *5617F4D00243_8BA2A290A172_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8BA2A290A172_impl*
end;//TkwMsg.ParamsTypes

procedure TkwPrint.Print(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта . }
//#UC START# *5053122C683A_9AAA1AEFBAE6_var*
//#UC END# *5053122C683A_9AAA1AEFBAE6_var*
begin
//#UC START# *5053122C683A_9AAA1AEFBAE6_impl*
 aCtx.rCaller.Print(aValue.AsPrintable);
//#UC END# *5053122C683A_9AAA1AEFBAE6_impl*
end;//TkwPrint.Print

procedure TkwPrint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9AAA1AEFBAE6_var*
//#UC END# *4DAEEDE10285_9AAA1AEFBAE6_var*
begin
//#UC START# *4DAEEDE10285_9AAA1AEFBAE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9AAA1AEFBAE6_impl*
end;//TkwPrint.DoDoIt

class function TkwPrint.GetWordNameForRegister: AnsiString;
begin
 Result := '.';
end;//TkwPrint.GetWordNameForRegister

function TkwPrint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9AAA1AEFBAE6_var*
//#UC END# *551544E2001A_9AAA1AEFBAE6_var*
begin
//#UC START# *551544E2001A_9AAA1AEFBAE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9AAA1AEFBAE6_impl*
end;//TkwPrint.GetResultTypeInfo

function TkwPrint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPrint.GetAllParamsCount

function TkwPrint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9AAA1AEFBAE6_var*
//#UC END# *5617F4D00243_9AAA1AEFBAE6_var*
begin
//#UC START# *5617F4D00243_9AAA1AEFBAE6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9AAA1AEFBAE6_impl*
end;//TkwPrint.ParamsTypes

procedure TkwLOOP.LOOP(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCount: Integer);
 {* Реализация слова скрипта LOOP }
//#UC START# *02D71503A219_A183EE1D2A6D_var*
var
 l_I : Integer;
//#UC END# *02D71503A219_A183EE1D2A6D_var*
begin
//#UC START# *02D71503A219_A183EE1D2A6D_impl*
 for l_I := 0 to Pred(aCount) do
  try
   aWord.DoIt(aCtx);
  except
   on EtfwBreak do
    break;
   on EtfwContinue do
    continue;
  end;//try..except
//#UC END# *02D71503A219_A183EE1D2A6D_impl*
end;//TkwLOOP.LOOP

class function TkwLOOP.GetWordNameForRegister: AnsiString;
begin
 Result := 'LOOP';
end;//TkwLOOP.GetWordNameForRegister

function TkwLOOP.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLOOP.RightParamsCount

procedure TkwLOOP.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_A183EE1D2A6D_var*
//#UC END# *5512949D0048_A183EE1D2A6D_var*
begin
//#UC START# *5512949D0048_A183EE1D2A6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_A183EE1D2A6D_impl*
end;//TkwLOOP.DoRun

function TkwLOOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A183EE1D2A6D_var*
//#UC END# *551544E2001A_A183EE1D2A6D_var*
begin
//#UC START# *551544E2001A_A183EE1D2A6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A183EE1D2A6D_impl*
end;//TkwLOOP.GetResultTypeInfo

function TkwLOOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLOOP.GetAllParamsCount

function TkwLOOP.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A183EE1D2A6D_var*
//#UC END# *5617F4D00243_A183EE1D2A6D_var*
begin
//#UC START# *5617F4D00243_A183EE1D2A6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A183EE1D2A6D_impl*
end;//TkwLOOP.ParamsTypes

procedure TkwWHILEDO.WHILEDO(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCondition: TtfwWord);
 {* Реализация слова скрипта WHILEDO }
//#UC START# *998553D17C4B_B8595935D002_var*
//#UC END# *998553D17C4B_B8595935D002_var*
begin
//#UC START# *998553D17C4B_B8595935D002_impl*
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
//#UC END# *998553D17C4B_B8595935D002_impl*
end;//TkwWHILEDO.WHILEDO

procedure TkwWHILEDO.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B8595935D002_var*
//#UC END# *4DAEEDE10285_B8595935D002_var*
begin
//#UC START# *4DAEEDE10285_B8595935D002_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B8595935D002_impl*
end;//TkwWHILEDO.DoDoIt

class function TkwWHILEDO.GetWordNameForRegister: AnsiString;
begin
 Result := 'WHILEDO';
end;//TkwWHILEDO.GetWordNameForRegister

function TkwWHILEDO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B8595935D002_var*
//#UC END# *551544E2001A_B8595935D002_var*
begin
//#UC START# *551544E2001A_B8595935D002_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B8595935D002_impl*
end;//TkwWHILEDO.GetResultTypeInfo

function TkwWHILEDO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWHILEDO.GetAllParamsCount

function TkwWHILEDO.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B8595935D002_var*
//#UC END# *5617F4D00243_B8595935D002_var*
begin
//#UC START# *5617F4D00243_B8595935D002_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B8595935D002_impl*
end;//TkwWHILEDO.ParamsTypes

procedure TkwBREAK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9FA400CD8713_var*
//#UC END# *4DAEEDE10285_9FA400CD8713_var*
begin
//#UC START# *4DAEEDE10285_9FA400CD8713_impl*
 raise EtfwBreak.Instance;
 //raise EtfwBreak.Create('Выход из цикла');
//#UC END# *4DAEEDE10285_9FA400CD8713_impl*
end;//TkwBREAK.DoDoIt

class function TkwBREAK.GetWordNameForRegister: AnsiString;
begin
 Result := 'BREAK';
end;//TkwBREAK.GetWordNameForRegister

function TkwBREAK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9FA400CD8713_var*
//#UC END# *551544E2001A_9FA400CD8713_var*
begin
//#UC START# *551544E2001A_9FA400CD8713_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9FA400CD8713_impl*
end;//TkwBREAK.GetResultTypeInfo

function TkwBREAK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBREAK.GetAllParamsCount

procedure TkwCONTINUE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_816E4F5C3613_var*
//#UC END# *4DAEEDE10285_816E4F5C3613_var*
begin
//#UC START# *4DAEEDE10285_816E4F5C3613_impl*
 raise EtfwContinue.Instance;
 //raise EtfwContinue.Create('Выход на начало цикла');
//#UC END# *4DAEEDE10285_816E4F5C3613_impl*
end;//TkwCONTINUE.DoDoIt

class function TkwCONTINUE.GetWordNameForRegister: AnsiString;
begin
 Result := 'CONTINUE';
end;//TkwCONTINUE.GetWordNameForRegister

function TkwCONTINUE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_816E4F5C3613_var*
//#UC END# *551544E2001A_816E4F5C3613_var*
begin
//#UC START# *551544E2001A_816E4F5C3613_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_816E4F5C3613_impl*
end;//TkwCONTINUE.GetResultTypeInfo

function TkwCONTINUE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCONTINUE.GetAllParamsCount

procedure TkwEXIT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A0EA325C2BC_var*
//#UC END# *4DAEEDE10285_1A0EA325C2BC_var*
begin
//#UC START# *4DAEEDE10285_1A0EA325C2BC_impl*
 raise EtfwExit.Instance;
 //raise EtfwExit.Create('Выход из процедуры');
//#UC END# *4DAEEDE10285_1A0EA325C2BC_impl*
end;//TkwEXIT.DoDoIt

class function TkwEXIT.GetWordNameForRegister: AnsiString;
begin
 Result := 'EXIT';
end;//TkwEXIT.GetWordNameForRegister

function TkwEXIT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1A0EA325C2BC_var*
//#UC END# *551544E2001A_1A0EA325C2BC_var*
begin
//#UC START# *551544E2001A_1A0EA325C2BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1A0EA325C2BC_impl*
end;//TkwEXIT.GetResultTypeInfo

function TkwEXIT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEXIT.GetAllParamsCount

procedure TkwHALT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F7BD1ACB2D33_var*
//#UC END# *4DAEEDE10285_F7BD1ACB2D33_var*
begin
//#UC START# *4DAEEDE10285_F7BD1ACB2D33_impl*
 raise EtfwHalt.Instance;
 //raise EtfwHalt.Create('Выход из скрипта');
//#UC END# *4DAEEDE10285_F7BD1ACB2D33_impl*
end;//TkwHALT.DoDoIt

class function TkwHALT.GetWordNameForRegister: AnsiString;
begin
 Result := 'HALT';
end;//TkwHALT.GetWordNameForRegister

function TkwHALT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F7BD1ACB2D33_var*
//#UC END# *551544E2001A_F7BD1ACB2D33_var*
begin
//#UC START# *551544E2001A_F7BD1ACB2D33_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F7BD1ACB2D33_impl*
end;//TkwHALT.GetResultTypeInfo

function TkwHALT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwHALT.GetAllParamsCount

procedure TkwBREAKITERATOR.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A2D97BCAC0E_var*
//#UC END# *4DAEEDE10285_4A2D97BCAC0E_var*
begin
//#UC START# *4DAEEDE10285_4A2D97BCAC0E_impl*
 raise EtfwBreakIterator.Instance;
 //raise EtfwBreakIterator.Create('Выход из итератора');
//#UC END# *4DAEEDE10285_4A2D97BCAC0E_impl*
end;//TkwBREAKITERATOR.DoDoIt

class function TkwBREAKITERATOR.GetWordNameForRegister: AnsiString;
begin
 Result := 'BREAK-ITERATOR';
end;//TkwBREAKITERATOR.GetWordNameForRegister

function TkwBREAKITERATOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4A2D97BCAC0E_var*
//#UC END# *551544E2001A_4A2D97BCAC0E_var*
begin
//#UC START# *551544E2001A_4A2D97BCAC0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4A2D97BCAC0E_impl*
end;//TkwBREAKITERATOR.GetResultTypeInfo

function TkwBREAKITERATOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBREAKITERATOR.GetAllParamsCount

procedure TkwNOP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_143C5B139D7D_var*
//#UC END# *4DAEEDE10285_143C5B139D7D_var*
begin
//#UC START# *4DAEEDE10285_143C5B139D7D_impl*
 // - осознанно ничего не делаем
//#UC END# *4DAEEDE10285_143C5B139D7D_impl*
end;//TkwNOP.DoDoIt

class function TkwNOP.GetWordNameForRegister: AnsiString;
begin
 Result := 'NOP';
end;//TkwNOP.GetWordNameForRegister

function TkwNOP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_143C5B139D7D_var*
//#UC END# *551544E2001A_143C5B139D7D_var*
begin
//#UC START# *551544E2001A_143C5B139D7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_143C5B139D7D_impl*
end;//TkwNOP.GetResultTypeInfo

function TkwNOP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNOP.GetAllParamsCount

procedure TkwSLEEP.SLEEP(const aCtx: TtfwContext;
 aDuration: Integer);
 {* Реализация слова скрипта SLEEP }
//#UC START# *4DB1E11DA389_837DF133349F_var*
//#UC END# *4DB1E11DA389_837DF133349F_var*
begin
//#UC START# *4DB1E11DA389_837DF133349F_impl*
 SysUtils.Sleep(aDuration);
//#UC END# *4DB1E11DA389_837DF133349F_impl*
end;//TkwSLEEP.SLEEP

procedure TkwSLEEP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_837DF133349F_var*
//#UC END# *4DAEEDE10285_837DF133349F_var*
begin
//#UC START# *4DAEEDE10285_837DF133349F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_837DF133349F_impl*
end;//TkwSLEEP.DoDoIt

class function TkwSLEEP.GetWordNameForRegister: AnsiString;
begin
 Result := 'SLEEP';
end;//TkwSLEEP.GetWordNameForRegister

function TkwSLEEP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_837DF133349F_var*
//#UC END# *551544E2001A_837DF133349F_var*
begin
//#UC START# *551544E2001A_837DF133349F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_837DF133349F_impl*
end;//TkwSLEEP.GetResultTypeInfo

function TkwSLEEP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSLEEP.GetAllParamsCount

function TkwSLEEP.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_837DF133349F_var*
//#UC END# *5617F4D00243_837DF133349F_var*
begin
//#UC START# *5617F4D00243_837DF133349F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_837DF133349F_impl*
end;//TkwSLEEP.ParamsTypes

procedure TkwProcessMessages.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E4C5BF333038_var*
//#UC END# *4DAEEDE10285_E4C5BF333038_var*
begin
//#UC START# *4DAEEDE10285_E4C5BF333038_impl*
 try
  Tl3MessagesService.Instance.ProcessMessages;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;//on E: Exception
 end;//try..finally
//#UC END# *4DAEEDE10285_E4C5BF333038_impl*
end;//TkwProcessMessages.DoDoIt

class function TkwProcessMessages.GetWordNameForRegister: AnsiString;
begin
 Result := 'ProcessMessages';
end;//TkwProcessMessages.GetWordNameForRegister

function TkwProcessMessages.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E4C5BF333038_var*
//#UC END# *551544E2001A_E4C5BF333038_var*
begin
//#UC START# *551544E2001A_E4C5BF333038_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E4C5BF333038_impl*
end;//TkwProcessMessages.GetResultTypeInfo

function TkwProcessMessages.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwProcessMessages.GetAllParamsCount

procedure TkwCheckAssert.CheckAssert(const aCtx: TtfwContext;
 aCondition: Boolean);
 {* Реализация слова скрипта ASSERT }
//#UC START# *A9F0DE62C340_21B5CB646447_var*
//#UC END# *A9F0DE62C340_21B5CB646447_var*
begin
//#UC START# *A9F0DE62C340_21B5CB646447_impl*
 aCtx.rCaller.Check(aCondition);
//#UC END# *A9F0DE62C340_21B5CB646447_impl*
end;//TkwCheckAssert.CheckAssert

procedure TkwCheckAssert.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_21B5CB646447_var*
//#UC END# *4DAEEDE10285_21B5CB646447_var*
begin
//#UC START# *4DAEEDE10285_21B5CB646447_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_21B5CB646447_impl*
end;//TkwCheckAssert.DoDoIt

class function TkwCheckAssert.GetWordNameForRegister: AnsiString;
begin
 Result := 'ASSERT';
end;//TkwCheckAssert.GetWordNameForRegister

function TkwCheckAssert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_21B5CB646447_var*
//#UC END# *551544E2001A_21B5CB646447_var*
begin
//#UC START# *551544E2001A_21B5CB646447_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_21B5CB646447_impl*
end;//TkwCheckAssert.GetResultTypeInfo

function TkwCheckAssert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCheckAssert.GetAllParamsCount

function TkwCheckAssert.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_21B5CB646447_var*
//#UC END# *5617F4D00243_21B5CB646447_var*
begin
//#UC START# *5617F4D00243_21B5CB646447_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_21B5CB646447_impl*
end;//TkwCheckAssert.ParamsTypes

procedure TkwASSERTS.ASSERTS(const aCtx: TtfwContext;
 const aMsg: AnsiString;
 aCondition: Boolean);
 {* Реализация слова скрипта ASSERTS }
//#UC START# *C32D02D46DF5_EC908CD7498C_var*
//#UC END# *C32D02D46DF5_EC908CD7498C_var*
begin
//#UC START# *C32D02D46DF5_EC908CD7498C_impl*
 aCtx.rCaller.Check(aCondition, aMsg);
//#UC END# *C32D02D46DF5_EC908CD7498C_impl*
end;//TkwASSERTS.ASSERTS

procedure TkwASSERTS.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EC908CD7498C_var*
//#UC END# *4DAEEDE10285_EC908CD7498C_var*
begin
//#UC START# *4DAEEDE10285_EC908CD7498C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EC908CD7498C_impl*
end;//TkwASSERTS.DoDoIt

class function TkwASSERTS.GetWordNameForRegister: AnsiString;
begin
 Result := 'ASSERTS';
end;//TkwASSERTS.GetWordNameForRegister

function TkwASSERTS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EC908CD7498C_var*
//#UC END# *551544E2001A_EC908CD7498C_var*
begin
//#UC START# *551544E2001A_EC908CD7498C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EC908CD7498C_impl*
end;//TkwASSERTS.GetResultTypeInfo

function TkwASSERTS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwASSERTS.GetAllParamsCount

function TkwASSERTS.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EC908CD7498C_var*
//#UC END# *5617F4D00243_EC908CD7498C_var*
begin
//#UC START# *5617F4D00243_EC908CD7498C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EC908CD7498C_impl*
end;//TkwASSERTS.ParamsTypes

procedure TkwNil.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D498DDF5F479_var*
//#UC END# *4DAEEDE10285_D498DDF5F479_var*
begin
//#UC START# *4DAEEDE10285_D498DDF5F479_impl*
 aCtx.rEngine.Push(TtfwStackValue_NULL);
//#UC END# *4DAEEDE10285_D498DDF5F479_impl*
end;//TkwNil.DoDoIt

class function TkwNil.GetWordNameForRegister: AnsiString;
begin
 Result := 'nil';
end;//TkwNil.GetWordNameForRegister

function TkwNil.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D498DDF5F479_var*
//#UC END# *551544E2001A_D498DDF5F479_var*
begin
//#UC START# *551544E2001A_D498DDF5F479_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D498DDF5F479_impl*
end;//TkwNil.GetResultTypeInfo

function TkwNil.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNil.GetAllParamsCount

procedure TkwDoWord.DoWord(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта DO }
//#UC START# *61B2E2983CE5_8756115930CD_var*
//#UC END# *61B2E2983CE5_8756115930CD_var*
begin
//#UC START# *61B2E2983CE5_8756115930CD_impl*
 aWord.DoIt(aCtx);
//#UC END# *61B2E2983CE5_8756115930CD_impl*
end;//TkwDoWord.DoWord

procedure TkwDoWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8756115930CD_var*
//#UC END# *4DAEEDE10285_8756115930CD_var*
begin
//#UC START# *4DAEEDE10285_8756115930CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8756115930CD_impl*
end;//TkwDoWord.DoDoIt

class function TkwDoWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'DO';
end;//TkwDoWord.GetWordNameForRegister

function TkwDoWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8756115930CD_var*
//#UC END# *551544E2001A_8756115930CD_var*
begin
//#UC START# *551544E2001A_8756115930CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8756115930CD_impl*
end;//TkwDoWord.GetResultTypeInfo

function TkwDoWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDoWord.GetAllParamsCount

function TkwDoWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8756115930CD_var*
//#UC END# *5617F4D00243_8756115930CD_var*
begin
//#UC START# *5617F4D00243_8756115930CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8756115930CD_impl*
end;//TkwDoWord.ParamsTypes

function TkwSmartEquals.SmartEquals(const aCtx: TtfwContext;
 const aV1: TtfwStackValue;
 const aV2: TtfwStackValue): Boolean;
 {* Реализация слова скрипта ?== }
//#UC START# *60743477D321_C3CE906B1F67_var*
//#UC END# *60743477D321_C3CE906B1F67_var*
begin
//#UC START# *60743477D321_C3CE906B1F67_impl*
 Result := CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *60743477D321_C3CE906B1F67_impl*
end;//TkwSmartEquals.SmartEquals

procedure TkwSmartEquals.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C3CE906B1F67_var*
//#UC END# *4DAEEDE10285_C3CE906B1F67_var*
begin
//#UC START# *4DAEEDE10285_C3CE906B1F67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C3CE906B1F67_impl*
end;//TkwSmartEquals.DoDoIt

class function TkwSmartEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '?==';
end;//TkwSmartEquals.GetWordNameForRegister

function TkwSmartEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C3CE906B1F67_var*
//#UC END# *551544E2001A_C3CE906B1F67_var*
begin
//#UC START# *551544E2001A_C3CE906B1F67_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C3CE906B1F67_impl*
end;//TkwSmartEquals.GetResultTypeInfo

function TkwSmartEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSmartEquals.GetAllParamsCount

function TkwSmartEquals.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C3CE906B1F67_var*
//#UC END# *5617F4D00243_C3CE906B1F67_var*
begin
//#UC START# *5617F4D00243_C3CE906B1F67_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C3CE906B1F67_impl*
end;//TkwSmartEquals.ParamsTypes

function TkwSmartNotEquals.SmartNotEquals(const aCtx: TtfwContext;
 const aV1: TtfwStackValue;
 const aV2: TtfwStackValue): Boolean;
 {* Реализация слова скрипта ?!= }
//#UC START# *1E530026939A_CC9B8514F681_var*
//#UC END# *1E530026939A_CC9B8514F681_var*
begin
//#UC START# *1E530026939A_CC9B8514F681_impl*
 Result := not CompareValues(aV1, aV2, aCtx, Self);
//#UC END# *1E530026939A_CC9B8514F681_impl*
end;//TkwSmartNotEquals.SmartNotEquals

procedure TkwSmartNotEquals.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CC9B8514F681_var*
//#UC END# *4DAEEDE10285_CC9B8514F681_var*
begin
//#UC START# *4DAEEDE10285_CC9B8514F681_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CC9B8514F681_impl*
end;//TkwSmartNotEquals.DoDoIt

class function TkwSmartNotEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '?!=';
end;//TkwSmartNotEquals.GetWordNameForRegister

function TkwSmartNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CC9B8514F681_var*
//#UC END# *551544E2001A_CC9B8514F681_var*
begin
//#UC START# *551544E2001A_CC9B8514F681_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CC9B8514F681_impl*
end;//TkwSmartNotEquals.GetResultTypeInfo

function TkwSmartNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSmartNotEquals.GetAllParamsCount

function TkwSmartNotEquals.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CC9B8514F681_var*
//#UC END# *5617F4D00243_CC9B8514F681_var*
begin
//#UC START# *5617F4D00243_CC9B8514F681_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CC9B8514F681_impl*
end;//TkwSmartNotEquals.ParamsTypes

function TkwPushWord.PushWord(const aCtx: TtfwContext;
 aWord: TtfwWord): TtfwWord;
 {* Реализация слова скрипта @ }
//#UC START# *E64338F25E47_D110B4F78BD0_var*
//#UC END# *E64338F25E47_D110B4F78BD0_var*
begin
//#UC START# *E64338F25E47_D110B4F78BD0_impl*
 Result := aWord;
//#UC END# *E64338F25E47_D110B4F78BD0_impl*
end;//TkwPushWord.PushWord

class function TkwPushWord.GetWordNameForRegister: AnsiString;
begin
 Result := '@';
end;//TkwPushWord.GetWordNameForRegister

function TkwPushWord.SuppressNextImmediate(const aContext: TtfwContext;
 aWordNumber: Integer): TtfwSuppressNextImmediate;
//#UC START# *4F3AB3B101FC_D110B4F78BD0_var*
//#UC END# *4F3AB3B101FC_D110B4F78BD0_var*
begin
//#UC START# *4F3AB3B101FC_D110B4F78BD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F3AB3B101FC_D110B4F78BD0_impl*
end;//TkwPushWord.SuppressNextImmediate

function TkwPushWord.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPushWord.RightParamsCount

procedure TkwPushWord.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_D110B4F78BD0_var*
//#UC END# *5512949D0048_D110B4F78BD0_var*
begin
//#UC START# *5512949D0048_D110B4F78BD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_D110B4F78BD0_impl*
end;//TkwPushWord.DoRun

function TkwPushWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D110B4F78BD0_var*
//#UC END# *551544E2001A_D110B4F78BD0_var*
begin
//#UC START# *551544E2001A_D110B4F78BD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D110B4F78BD0_impl*
end;//TkwPushWord.GetResultTypeInfo

function TkwPushWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPushWord.GetAllParamsCount

function TkwPushWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D110B4F78BD0_var*
//#UC END# *5617F4D00243_D110B4F78BD0_var*
begin
//#UC START# *5617F4D00243_D110B4F78BD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D110B4F78BD0_impl*
end;//TkwPushWord.ParamsTypes

function TkwCurrentException.current_exception(const aCtx: TtfwContext): TObject;
 {* Реализация слова скрипта current:exception }
//#UC START# *6715463935A1_FC4619680919_var*
//#UC END# *6715463935A1_FC4619680919_var*
begin
//#UC START# *6715463935A1_FC4619680919_impl*
 Result := aCtx.rException;
//#UC END# *6715463935A1_FC4619680919_impl*
end;//TkwCurrentException.current_exception

procedure TkwCurrentException.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FC4619680919_var*
//#UC END# *4DAEEDE10285_FC4619680919_var*
begin
//#UC START# *4DAEEDE10285_FC4619680919_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FC4619680919_impl*
end;//TkwCurrentException.DoDoIt

class function TkwCurrentException.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception';
end;//TkwCurrentException.GetWordNameForRegister

function TkwCurrentException.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FC4619680919_var*
//#UC END# *551544E2001A_FC4619680919_var*
begin
//#UC START# *551544E2001A_FC4619680919_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FC4619680919_impl*
end;//TkwCurrentException.GetResultTypeInfo

function TkwCurrentException.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCurrentException.GetAllParamsCount

function TkwCurrentException.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FC4619680919_var*
//#UC END# *5617F4D00243_FC4619680919_var*
begin
//#UC START# *5617F4D00243_FC4619680919_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FC4619680919_impl*
end;//TkwCurrentException.ParamsTypes

function TkwCurrentExceptionClass.current_exception_class(const aCtx: TtfwContext): TClass;
 {* Реализация слова скрипта current:exception:class }
//#UC START# *E3D187DF3985_1AF5C18788F4_var*
//#UC END# *E3D187DF3985_1AF5C18788F4_var*
begin
//#UC START# *E3D187DF3985_1AF5C18788F4_impl*
 if (aCtx.rException = nil) then
  Result := nil
 else
  Result := aCtx.rException.ClassType;
//#UC END# *E3D187DF3985_1AF5C18788F4_impl*
end;//TkwCurrentExceptionClass.current_exception_class

procedure TkwCurrentExceptionClass.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1AF5C18788F4_var*
//#UC END# *4DAEEDE10285_1AF5C18788F4_var*
begin
//#UC START# *4DAEEDE10285_1AF5C18788F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1AF5C18788F4_impl*
end;//TkwCurrentExceptionClass.DoDoIt

class function TkwCurrentExceptionClass.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:class';
end;//TkwCurrentExceptionClass.GetWordNameForRegister

function TkwCurrentExceptionClass.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1AF5C18788F4_var*
//#UC END# *551544E2001A_1AF5C18788F4_var*
begin
//#UC START# *551544E2001A_1AF5C18788F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1AF5C18788F4_impl*
end;//TkwCurrentExceptionClass.GetResultTypeInfo

function TkwCurrentExceptionClass.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCurrentExceptionClass.GetAllParamsCount

function TkwCurrentExceptionClass.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1AF5C18788F4_var*
//#UC END# *5617F4D00243_1AF5C18788F4_var*
begin
//#UC START# *5617F4D00243_1AF5C18788F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1AF5C18788F4_impl*
end;//TkwCurrentExceptionClass.ParamsTypes

function TkwCurrentExceptionClassName.current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта current:exception:ClassName }
//#UC START# *4B72A5BBE511_884F3012E3E7_var*
//#UC END# *4B72A5BBE511_884F3012E3E7_var*
begin
//#UC START# *4B72A5BBE511_884F3012E3E7_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.ClassName;
//#UC END# *4B72A5BBE511_884F3012E3E7_impl*
end;//TkwCurrentExceptionClassName.current_exception_ClassName

procedure TkwCurrentExceptionClassName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_884F3012E3E7_var*
//#UC END# *4DAEEDE10285_884F3012E3E7_var*
begin
//#UC START# *4DAEEDE10285_884F3012E3E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_884F3012E3E7_impl*
end;//TkwCurrentExceptionClassName.DoDoIt

class function TkwCurrentExceptionClassName.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:ClassName';
end;//TkwCurrentExceptionClassName.GetWordNameForRegister

function TkwCurrentExceptionClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_884F3012E3E7_var*
//#UC END# *551544E2001A_884F3012E3E7_var*
begin
//#UC START# *551544E2001A_884F3012E3E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_884F3012E3E7_impl*
end;//TkwCurrentExceptionClassName.GetResultTypeInfo

function TkwCurrentExceptionClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCurrentExceptionClassName.GetAllParamsCount

function TkwCurrentExceptionClassName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_884F3012E3E7_var*
//#UC END# *5617F4D00243_884F3012E3E7_var*
begin
//#UC START# *5617F4D00243_884F3012E3E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_884F3012E3E7_impl*
end;//TkwCurrentExceptionClassName.ParamsTypes

function TkwCurrentExceptionMessage.current_exception_Message(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта current:exception:Message }
//#UC START# *51C60F25F7F2_700EDDB5F050_var*
//#UC END# *51C60F25F7F2_700EDDB5F050_var*
begin
//#UC START# *51C60F25F7F2_700EDDB5F050_impl*
 if (aCtx.rException = nil) then
  Result := ''
 else
  Result := aCtx.rException.Message;
//#UC END# *51C60F25F7F2_700EDDB5F050_impl*
end;//TkwCurrentExceptionMessage.current_exception_Message

procedure TkwCurrentExceptionMessage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_700EDDB5F050_var*
//#UC END# *4DAEEDE10285_700EDDB5F050_var*
begin
//#UC START# *4DAEEDE10285_700EDDB5F050_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_700EDDB5F050_impl*
end;//TkwCurrentExceptionMessage.DoDoIt

class function TkwCurrentExceptionMessage.GetWordNameForRegister: AnsiString;
begin
 Result := 'current:exception:Message';
end;//TkwCurrentExceptionMessage.GetWordNameForRegister

function TkwCurrentExceptionMessage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_700EDDB5F050_var*
//#UC END# *551544E2001A_700EDDB5F050_var*
begin
//#UC START# *551544E2001A_700EDDB5F050_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_700EDDB5F050_impl*
end;//TkwCurrentExceptionMessage.GetResultTypeInfo

function TkwCurrentExceptionMessage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCurrentExceptionMessage.GetAllParamsCount

function TkwCurrentExceptionMessage.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_700EDDB5F050_var*
//#UC END# *5617F4D00243_700EDDB5F050_var*
begin
//#UC START# *5617F4D00243_700EDDB5F050_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_700EDDB5F050_impl*
end;//TkwCurrentExceptionMessage.ParamsTypes

function TkwInc.Inc(const aCtx: TtfwContext;
 aValue: Integer): Integer;
 {* Реализация слова скрипта ++ }
//#UC START# *D77DFD505D71_EC8ABDF1263C_var*
//#UC END# *D77DFD505D71_EC8ABDF1263C_var*
begin
//#UC START# *D77DFD505D71_EC8ABDF1263C_impl*
 Result := aValue + 1;
//#UC END# *D77DFD505D71_EC8ABDF1263C_impl*
end;//TkwInc.Inc

procedure TkwInc.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EC8ABDF1263C_var*
//#UC END# *4DAEEDE10285_EC8ABDF1263C_var*
begin
//#UC START# *4DAEEDE10285_EC8ABDF1263C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EC8ABDF1263C_impl*
end;//TkwInc.DoDoIt

class function TkwInc.GetWordNameForRegister: AnsiString;
begin
 Result := '++';
end;//TkwInc.GetWordNameForRegister

function TkwInc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EC8ABDF1263C_var*
//#UC END# *551544E2001A_EC8ABDF1263C_var*
begin
//#UC START# *551544E2001A_EC8ABDF1263C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EC8ABDF1263C_impl*
end;//TkwInc.GetResultTypeInfo

function TkwInc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwInc.GetAllParamsCount

function TkwInc.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EC8ABDF1263C_var*
//#UC END# *5617F4D00243_EC8ABDF1263C_var*
begin
//#UC START# *5617F4D00243_EC8ABDF1263C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EC8ABDF1263C_impl*
end;//TkwInc.ParamsTypes

function TkwDec.Dec(const aCtx: TtfwContext;
 aValue: Integer): Integer;
 {* Реализация слова скрипта -- }
//#UC START# *953F49C35391_B2F2C7D2DE77_var*
//#UC END# *953F49C35391_B2F2C7D2DE77_var*
begin
//#UC START# *953F49C35391_B2F2C7D2DE77_impl*
 Result := aValue - 1;
//#UC END# *953F49C35391_B2F2C7D2DE77_impl*
end;//TkwDec.Dec

procedure TkwDec.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2F2C7D2DE77_var*
//#UC END# *4DAEEDE10285_B2F2C7D2DE77_var*
begin
//#UC START# *4DAEEDE10285_B2F2C7D2DE77_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2F2C7D2DE77_impl*
end;//TkwDec.DoDoIt

class function TkwDec.GetWordNameForRegister: AnsiString;
begin
 Result := '--';
end;//TkwDec.GetWordNameForRegister

function TkwDec.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B2F2C7D2DE77_var*
//#UC END# *551544E2001A_B2F2C7D2DE77_var*
begin
//#UC START# *551544E2001A_B2F2C7D2DE77_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B2F2C7D2DE77_impl*
end;//TkwDec.GetResultTypeInfo

function TkwDec.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDec.GetAllParamsCount

function TkwDec.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B2F2C7D2DE77_var*
//#UC END# *5617F4D00243_B2F2C7D2DE77_var*
begin
//#UC START# *5617F4D00243_B2F2C7D2DE77_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B2F2C7D2DE77_impl*
end;//TkwDec.ParamsTypes

function TkwAdd.Add(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): TtfwStackValue;
 {* Реализация слова скрипта + }
//#UC START# *4A2B2E436561_9C21970CCFB0_var*
//#UC END# *4A2B2E436561_9C21970CCFB0_var*
begin
//#UC START# *4A2B2E436561_9C21970CCFB0_impl*
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
//#UC END# *4A2B2E436561_9C21970CCFB0_impl*
end;//TkwAdd.Add

procedure TkwAdd.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C21970CCFB0_var*
//#UC END# *4DAEEDE10285_9C21970CCFB0_var*
begin
//#UC START# *4DAEEDE10285_9C21970CCFB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C21970CCFB0_impl*
end;//TkwAdd.DoDoIt

class function TkwAdd.GetWordNameForRegister: AnsiString;
begin
 Result := '+';
end;//TkwAdd.GetWordNameForRegister

function TkwAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9C21970CCFB0_var*
//#UC END# *551544E2001A_9C21970CCFB0_var*
begin
//#UC START# *551544E2001A_9C21970CCFB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9C21970CCFB0_impl*
end;//TkwAdd.GetResultTypeInfo

function TkwAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAdd.GetAllParamsCount

function TkwAdd.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9C21970CCFB0_var*
//#UC END# *5617F4D00243_9C21970CCFB0_var*
begin
//#UC START# *5617F4D00243_9C21970CCFB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9C21970CCFB0_impl*
end;//TkwAdd.ParamsTypes

function TkwSub.Sub(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта - }
//#UC START# *48DD1F61327A_07CF656336AF_var*
//#UC END# *48DD1F61327A_07CF656336AF_var*
begin
//#UC START# *48DD1F61327A_07CF656336AF_impl*
 Result := aA - aB;
//#UC END# *48DD1F61327A_07CF656336AF_impl*
end;//TkwSub.Sub

procedure TkwSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_07CF656336AF_var*
//#UC END# *4DAEEDE10285_07CF656336AF_var*
begin
//#UC START# *4DAEEDE10285_07CF656336AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_07CF656336AF_impl*
end;//TkwSub.DoDoIt

class function TkwSub.GetWordNameForRegister: AnsiString;
begin
 Result := '-';
end;//TkwSub.GetWordNameForRegister

function TkwSub.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_07CF656336AF_var*
//#UC END# *551544E2001A_07CF656336AF_var*
begin
//#UC START# *551544E2001A_07CF656336AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_07CF656336AF_impl*
end;//TkwSub.GetResultTypeInfo

function TkwSub.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSub.GetAllParamsCount

function TkwSub.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_07CF656336AF_var*
//#UC END# *5617F4D00243_07CF656336AF_var*
begin
//#UC START# *5617F4D00243_07CF656336AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_07CF656336AF_impl*
end;//TkwSub.ParamsTypes

function TkwDivision.Division(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта DIV }
//#UC START# *88D113F4B496_E81F1590332D_var*
//#UC END# *88D113F4B496_E81F1590332D_var*
begin
//#UC START# *88D113F4B496_E81F1590332D_impl*
 Result := aA div aB;
//#UC END# *88D113F4B496_E81F1590332D_impl*
end;//TkwDivision.Division

procedure TkwDivision.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E81F1590332D_var*
//#UC END# *4DAEEDE10285_E81F1590332D_var*
begin
//#UC START# *4DAEEDE10285_E81F1590332D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E81F1590332D_impl*
end;//TkwDivision.DoDoIt

class function TkwDivision.GetWordNameForRegister: AnsiString;
begin
 Result := 'DIV';
end;//TkwDivision.GetWordNameForRegister

function TkwDivision.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E81F1590332D_var*
//#UC END# *551544E2001A_E81F1590332D_var*
begin
//#UC START# *551544E2001A_E81F1590332D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E81F1590332D_impl*
end;//TkwDivision.GetResultTypeInfo

function TkwDivision.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDivision.GetAllParamsCount

function TkwDivision.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E81F1590332D_var*
//#UC END# *5617F4D00243_E81F1590332D_var*
begin
//#UC START# *5617F4D00243_E81F1590332D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E81F1590332D_impl*
end;//TkwDivision.ParamsTypes

function TkwMul.Mul(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта * }
//#UC START# *5AE4AB3CE60E_0B21BAF8C4D4_var*
//#UC END# *5AE4AB3CE60E_0B21BAF8C4D4_var*
begin
//#UC START# *5AE4AB3CE60E_0B21BAF8C4D4_impl*
 Result := aA * aB;
//#UC END# *5AE4AB3CE60E_0B21BAF8C4D4_impl*
end;//TkwMul.Mul

procedure TkwMul.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0B21BAF8C4D4_var*
//#UC END# *4DAEEDE10285_0B21BAF8C4D4_var*
begin
//#UC START# *4DAEEDE10285_0B21BAF8C4D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0B21BAF8C4D4_impl*
end;//TkwMul.DoDoIt

class function TkwMul.GetWordNameForRegister: AnsiString;
begin
 Result := '*';
end;//TkwMul.GetWordNameForRegister

function TkwMul.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0B21BAF8C4D4_var*
//#UC END# *551544E2001A_0B21BAF8C4D4_var*
begin
//#UC START# *551544E2001A_0B21BAF8C4D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0B21BAF8C4D4_impl*
end;//TkwMul.GetResultTypeInfo

function TkwMul.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMul.GetAllParamsCount

function TkwMul.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0B21BAF8C4D4_var*
//#UC END# *5617F4D00243_0B21BAF8C4D4_var*
begin
//#UC START# *5617F4D00243_0B21BAF8C4D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0B21BAF8C4D4_impl*
end;//TkwMul.ParamsTypes

function TkwDivide.Divide(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта / }
//#UC START# *736A69199423_3396B991D47C_var*
//#UC END# *736A69199423_3396B991D47C_var*
begin
//#UC START# *736A69199423_3396B991D47C_impl*
 Result := aA div aB;
//#UC END# *736A69199423_3396B991D47C_impl*
end;//TkwDivide.Divide

procedure TkwDivide.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3396B991D47C_var*
//#UC END# *4DAEEDE10285_3396B991D47C_var*
begin
//#UC START# *4DAEEDE10285_3396B991D47C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3396B991D47C_impl*
end;//TkwDivide.DoDoIt

class function TkwDivide.GetWordNameForRegister: AnsiString;
begin
 Result := '/';
end;//TkwDivide.GetWordNameForRegister

function TkwDivide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3396B991D47C_var*
//#UC END# *551544E2001A_3396B991D47C_var*
begin
//#UC START# *551544E2001A_3396B991D47C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3396B991D47C_impl*
end;//TkwDivide.GetResultTypeInfo

function TkwDivide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDivide.GetAllParamsCount

function TkwDivide.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3396B991D47C_var*
//#UC END# *5617F4D00243_3396B991D47C_var*
begin
//#UC START# *5617F4D00243_3396B991D47C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3396B991D47C_impl*
end;//TkwDivide.ParamsTypes

function TkwMul2.Mul2(const aCtx: TtfwContext;
 aA: Integer): Integer;
 {* Реализация слова скрипта 2* }
//#UC START# *344C0B9A5E91_2281645E0EB6_var*
//#UC END# *344C0B9A5E91_2281645E0EB6_var*
begin
//#UC START# *344C0B9A5E91_2281645E0EB6_impl*
 Result := aA shl 1;
//#UC END# *344C0B9A5E91_2281645E0EB6_impl*
end;//TkwMul2.Mul2

procedure TkwMul2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2281645E0EB6_var*
//#UC END# *4DAEEDE10285_2281645E0EB6_var*
begin
//#UC START# *4DAEEDE10285_2281645E0EB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2281645E0EB6_impl*
end;//TkwMul2.DoDoIt

class function TkwMul2.GetWordNameForRegister: AnsiString;
begin
 Result := '2*';
end;//TkwMul2.GetWordNameForRegister

function TkwMul2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2281645E0EB6_var*
//#UC END# *551544E2001A_2281645E0EB6_var*
begin
//#UC START# *551544E2001A_2281645E0EB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2281645E0EB6_impl*
end;//TkwMul2.GetResultTypeInfo

function TkwMul2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMul2.GetAllParamsCount

function TkwMul2.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2281645E0EB6_var*
//#UC END# *5617F4D00243_2281645E0EB6_var*
begin
//#UC START# *5617F4D00243_2281645E0EB6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2281645E0EB6_impl*
end;//TkwMul2.ParamsTypes

function TkwDiv2.Div2(const aCtx: TtfwContext;
 aA: Integer): Integer;
 {* Реализация слова скрипта 2/ }
//#UC START# *FEC2D095F55C_F236BCF7B4F7_var*
//#UC END# *FEC2D095F55C_F236BCF7B4F7_var*
begin
//#UC START# *FEC2D095F55C_F236BCF7B4F7_impl*
 Result := aA shr 1;
//#UC END# *FEC2D095F55C_F236BCF7B4F7_impl*
end;//TkwDiv2.Div2

procedure TkwDiv2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F236BCF7B4F7_var*
//#UC END# *4DAEEDE10285_F236BCF7B4F7_var*
begin
//#UC START# *4DAEEDE10285_F236BCF7B4F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F236BCF7B4F7_impl*
end;//TkwDiv2.DoDoIt

class function TkwDiv2.GetWordNameForRegister: AnsiString;
begin
 Result := '2/';
end;//TkwDiv2.GetWordNameForRegister

function TkwDiv2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F236BCF7B4F7_var*
//#UC END# *551544E2001A_F236BCF7B4F7_var*
begin
//#UC START# *551544E2001A_F236BCF7B4F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F236BCF7B4F7_impl*
end;//TkwDiv2.GetResultTypeInfo

function TkwDiv2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDiv2.GetAllParamsCount

function TkwDiv2.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F236BCF7B4F7_var*
//#UC END# *5617F4D00243_F236BCF7B4F7_var*
begin
//#UC START# *5617F4D00243_F236BCF7B4F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F236BCF7B4F7_impl*
end;//TkwDiv2.ParamsTypes

function TkwMulDiv.MulDiv(const aCtx: TtfwContext;
 aC: Integer;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта */ }
//#UC START# *1D630924D3F3_DD076C655ECA_var*
//#UC END# *1D630924D3F3_DD076C655ECA_var*
begin
//#UC START# *1D630924D3F3_DD076C655ECA_impl*
 Result := l3MulDiv(aA, aB, aC);
//#UC END# *1D630924D3F3_DD076C655ECA_impl*
end;//TkwMulDiv.MulDiv

procedure TkwMulDiv.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD076C655ECA_var*
//#UC END# *4DAEEDE10285_DD076C655ECA_var*
begin
//#UC START# *4DAEEDE10285_DD076C655ECA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD076C655ECA_impl*
end;//TkwMulDiv.DoDoIt

class function TkwMulDiv.GetWordNameForRegister: AnsiString;
begin
 Result := '*/';
end;//TkwMulDiv.GetWordNameForRegister

function TkwMulDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DD076C655ECA_var*
//#UC END# *551544E2001A_DD076C655ECA_var*
begin
//#UC START# *551544E2001A_DD076C655ECA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DD076C655ECA_impl*
end;//TkwMulDiv.GetResultTypeInfo

function TkwMulDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMulDiv.GetAllParamsCount

function TkwMulDiv.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DD076C655ECA_var*
//#UC END# *5617F4D00243_DD076C655ECA_var*
begin
//#UC START# *5617F4D00243_DD076C655ECA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DD076C655ECA_impl*
end;//TkwMulDiv.ParamsTypes

function TkwBoolNot.BoolNot(const aCtx: TtfwContext;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта ! }
//#UC START# *CAC63578DC71_DE39DE30D615_var*
//#UC END# *CAC63578DC71_DE39DE30D615_var*
begin
//#UC START# *CAC63578DC71_DE39DE30D615_impl*
 Result := not aA;
//#UC END# *CAC63578DC71_DE39DE30D615_impl*
end;//TkwBoolNot.BoolNot

procedure TkwBoolNot.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DE39DE30D615_var*
//#UC END# *4DAEEDE10285_DE39DE30D615_var*
begin
//#UC START# *4DAEEDE10285_DE39DE30D615_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DE39DE30D615_impl*
end;//TkwBoolNot.DoDoIt

class function TkwBoolNot.GetWordNameForRegister: AnsiString;
begin
 Result := '!';
end;//TkwBoolNot.GetWordNameForRegister

function TkwBoolNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DE39DE30D615_var*
//#UC END# *551544E2001A_DE39DE30D615_var*
begin
//#UC START# *551544E2001A_DE39DE30D615_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DE39DE30D615_impl*
end;//TkwBoolNot.GetResultTypeInfo

function TkwBoolNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBoolNot.GetAllParamsCount

function TkwBoolNot.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DE39DE30D615_var*
//#UC END# *5617F4D00243_DE39DE30D615_var*
begin
//#UC START# *5617F4D00243_DE39DE30D615_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DE39DE30D615_impl*
end;//TkwBoolNot.ParamsTypes

function TkwModFromDiv.ModFromDiv(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта MOD }
//#UC START# *6F1D80D40414_6CA2C2693736_var*
//#UC END# *6F1D80D40414_6CA2C2693736_var*
begin
//#UC START# *6F1D80D40414_6CA2C2693736_impl*
 Result := aA mod aB;
//#UC END# *6F1D80D40414_6CA2C2693736_impl*
end;//TkwModFromDiv.ModFromDiv

procedure TkwModFromDiv.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6CA2C2693736_var*
//#UC END# *4DAEEDE10285_6CA2C2693736_var*
begin
//#UC START# *4DAEEDE10285_6CA2C2693736_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6CA2C2693736_impl*
end;//TkwModFromDiv.DoDoIt

class function TkwModFromDiv.GetWordNameForRegister: AnsiString;
begin
 Result := 'MOD';
end;//TkwModFromDiv.GetWordNameForRegister

function TkwModFromDiv.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6CA2C2693736_var*
//#UC END# *551544E2001A_6CA2C2693736_var*
begin
//#UC START# *551544E2001A_6CA2C2693736_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6CA2C2693736_impl*
end;//TkwModFromDiv.GetResultTypeInfo

function TkwModFromDiv.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwModFromDiv.GetAllParamsCount

function TkwModFromDiv.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6CA2C2693736_var*
//#UC END# *5617F4D00243_6CA2C2693736_var*
begin
//#UC START# *5617F4D00243_6CA2C2693736_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6CA2C2693736_impl*
end;//TkwModFromDiv.ParamsTypes

function TkwBoolAnd.BoolAnd(const aCtx: TtfwContext;
 aB: Boolean;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта && }
//#UC START# *B5F366B3195C_B473FE645DEA_var*
//#UC END# *B5F366B3195C_B473FE645DEA_var*
begin
//#UC START# *B5F366B3195C_B473FE645DEA_impl*
 Result := aA AND aB;
//#UC END# *B5F366B3195C_B473FE645DEA_impl*
end;//TkwBoolAnd.BoolAnd

procedure TkwBoolAnd.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B473FE645DEA_var*
//#UC END# *4DAEEDE10285_B473FE645DEA_var*
begin
//#UC START# *4DAEEDE10285_B473FE645DEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B473FE645DEA_impl*
end;//TkwBoolAnd.DoDoIt

class function TkwBoolAnd.GetWordNameForRegister: AnsiString;
begin
 Result := '&&';
end;//TkwBoolAnd.GetWordNameForRegister

function TkwBoolAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B473FE645DEA_var*
//#UC END# *551544E2001A_B473FE645DEA_var*
begin
//#UC START# *551544E2001A_B473FE645DEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B473FE645DEA_impl*
end;//TkwBoolAnd.GetResultTypeInfo

function TkwBoolAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBoolAnd.GetAllParamsCount

function TkwBoolAnd.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B473FE645DEA_var*
//#UC END# *5617F4D00243_B473FE645DEA_var*
begin
//#UC START# *5617F4D00243_B473FE645DEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B473FE645DEA_impl*
end;//TkwBoolAnd.ParamsTypes

function TkwBoolOr.BoolOr(const aCtx: TtfwContext;
 aB: Boolean;
 aA: Boolean): Boolean;
 {* Реализация слова скрипта || }
//#UC START# *A7F5B8B75EED_26485F660013_var*
//#UC END# *A7F5B8B75EED_26485F660013_var*
begin
//#UC START# *A7F5B8B75EED_26485F660013_impl*
 Result := aA OR aB;
//#UC END# *A7F5B8B75EED_26485F660013_impl*
end;//TkwBoolOr.BoolOr

procedure TkwBoolOr.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_26485F660013_var*
//#UC END# *4DAEEDE10285_26485F660013_var*
begin
//#UC START# *4DAEEDE10285_26485F660013_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_26485F660013_impl*
end;//TkwBoolOr.DoDoIt

class function TkwBoolOr.GetWordNameForRegister: AnsiString;
begin
 Result := '||';
end;//TkwBoolOr.GetWordNameForRegister

function TkwBoolOr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_26485F660013_var*
//#UC END# *551544E2001A_26485F660013_var*
begin
//#UC START# *551544E2001A_26485F660013_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_26485F660013_impl*
end;//TkwBoolOr.GetResultTypeInfo

function TkwBoolOr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBoolOr.GetAllParamsCount

function TkwBoolOr.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_26485F660013_var*
//#UC END# *5617F4D00243_26485F660013_var*
begin
//#UC START# *5617F4D00243_26485F660013_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_26485F660013_impl*
end;//TkwBoolOr.ParamsTypes

function TkwNotZero.NotZero(const aCtx: TtfwContext;
 aA: Integer): Boolean;
 {* Реализация слова скрипта !=0 }
//#UC START# *4C0DDFEB9207_904983DADEB2_var*
//#UC END# *4C0DDFEB9207_904983DADEB2_var*
begin
//#UC START# *4C0DDFEB9207_904983DADEB2_impl*
 Result := (aA <> 0);
//#UC END# *4C0DDFEB9207_904983DADEB2_impl*
end;//TkwNotZero.NotZero

procedure TkwNotZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_904983DADEB2_var*
//#UC END# *4DAEEDE10285_904983DADEB2_var*
begin
//#UC START# *4DAEEDE10285_904983DADEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_904983DADEB2_impl*
end;//TkwNotZero.DoDoIt

class function TkwNotZero.GetWordNameForRegister: AnsiString;
begin
 Result := '!=0';
end;//TkwNotZero.GetWordNameForRegister

function TkwNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_904983DADEB2_var*
//#UC END# *551544E2001A_904983DADEB2_var*
begin
//#UC START# *551544E2001A_904983DADEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_904983DADEB2_impl*
end;//TkwNotZero.GetResultTypeInfo

function TkwNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNotZero.GetAllParamsCount

function TkwNotZero.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_904983DADEB2_var*
//#UC END# *5617F4D00243_904983DADEB2_var*
begin
//#UC START# *5617F4D00243_904983DADEB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_904983DADEB2_impl*
end;//TkwNotZero.ParamsTypes

function TkwEqualZero.EqualZero(const aCtx: TtfwContext;
 aA: Integer): Boolean;
 {* Реализация слова скрипта =0 }
//#UC START# *7F71955C78B0_41CE11D9C1A2_var*
//#UC END# *7F71955C78B0_41CE11D9C1A2_var*
begin
//#UC START# *7F71955C78B0_41CE11D9C1A2_impl*
 Result := (aA = 0);
//#UC END# *7F71955C78B0_41CE11D9C1A2_impl*
end;//TkwEqualZero.EqualZero

procedure TkwEqualZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_41CE11D9C1A2_var*
//#UC END# *4DAEEDE10285_41CE11D9C1A2_var*
begin
//#UC START# *4DAEEDE10285_41CE11D9C1A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_41CE11D9C1A2_impl*
end;//TkwEqualZero.DoDoIt

class function TkwEqualZero.GetWordNameForRegister: AnsiString;
begin
 Result := '=0';
end;//TkwEqualZero.GetWordNameForRegister

function TkwEqualZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_41CE11D9C1A2_var*
//#UC END# *551544E2001A_41CE11D9C1A2_var*
begin
//#UC START# *551544E2001A_41CE11D9C1A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_41CE11D9C1A2_impl*
end;//TkwEqualZero.GetResultTypeInfo

function TkwEqualZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEqualZero.GetAllParamsCount

function TkwEqualZero.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_41CE11D9C1A2_var*
//#UC END# *5617F4D00243_41CE11D9C1A2_var*
begin
//#UC START# *5617F4D00243_41CE11D9C1A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_41CE11D9C1A2_impl*
end;//TkwEqualZero.ParamsTypes

procedure TkwSWAP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FABB1CF992DE_var*
//#UC END# *4DAEEDE10285_FABB1CF992DE_var*
begin
//#UC START# *4DAEEDE10285_FABB1CF992DE_impl*
 aCtx.rEngine.SWAP;
//#UC END# *4DAEEDE10285_FABB1CF992DE_impl*
end;//TkwSWAP.DoDoIt

class function TkwSWAP.GetWordNameForRegister: AnsiString;
begin
 Result := 'SWAP';
end;//TkwSWAP.GetWordNameForRegister

function TkwSWAP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FABB1CF992DE_var*
//#UC END# *551544E2001A_FABB1CF992DE_var*
begin
//#UC START# *551544E2001A_FABB1CF992DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FABB1CF992DE_impl*
end;//TkwSWAP.GetResultTypeInfo

function TkwSWAP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSWAP.GetAllParamsCount

procedure TkwDROP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_58414ABA5048_var*
//#UC END# *4DAEEDE10285_58414ABA5048_var*
begin
//#UC START# *4DAEEDE10285_58414ABA5048_impl*
 aCtx.rEngine.DROP;
//#UC END# *4DAEEDE10285_58414ABA5048_impl*
end;//TkwDROP.DoDoIt

class function TkwDROP.GetWordNameForRegister: AnsiString;
begin
 Result := 'DROP';
end;//TkwDROP.GetWordNameForRegister

function TkwDROP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_58414ABA5048_var*
//#UC END# *551544E2001A_58414ABA5048_var*
begin
//#UC START# *551544E2001A_58414ABA5048_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_58414ABA5048_impl*
end;//TkwDROP.GetResultTypeInfo

function TkwDROP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDROP.GetAllParamsCount

procedure TkwDUP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B275E59B185_var*
//#UC END# *4DAEEDE10285_1B275E59B185_var*
begin
//#UC START# *4DAEEDE10285_1B275E59B185_impl*
 aCtx.rEngine.Dup;
//#UC END# *4DAEEDE10285_1B275E59B185_impl*
end;//TkwDUP.DoDoIt

class function TkwDUP.GetWordNameForRegister: AnsiString;
begin
 Result := 'DUP';
end;//TkwDUP.GetWordNameForRegister

function TkwDUP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1B275E59B185_var*
//#UC END# *551544E2001A_1B275E59B185_var*
begin
//#UC START# *551544E2001A_1B275E59B185_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1B275E59B185_impl*
end;//TkwDUP.GetResultTypeInfo

function TkwDUP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDUP.GetAllParamsCount

procedure TkwDUPIfNotZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E5F590E5C48_var*
//#UC END# *4DAEEDE10285_7E5F590E5C48_var*
begin
//#UC START# *4DAEEDE10285_7E5F590E5C48_impl*
 aCtx.rEngine.DupIfNotZero;
//#UC END# *4DAEEDE10285_7E5F590E5C48_impl*
end;//TkwDUPIfNotZero.DoDoIt

class function TkwDUPIfNotZero.GetWordNameForRegister: AnsiString;
begin
 Result := '?DUP';
end;//TkwDUPIfNotZero.GetWordNameForRegister

function TkwDUPIfNotZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7E5F590E5C48_var*
//#UC END# *551544E2001A_7E5F590E5C48_var*
begin
//#UC START# *551544E2001A_7E5F590E5C48_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7E5F590E5C48_impl*
end;//TkwDUPIfNotZero.GetResultTypeInfo

function TkwDUPIfNotZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDUPIfNotZero.GetAllParamsCount

procedure TkwROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E1E6ADB3161D_var*
//#UC END# *4DAEEDE10285_E1E6ADB3161D_var*
begin
//#UC START# *4DAEEDE10285_E1E6ADB3161D_impl*
 aCtx.rEngine.ROT;
//#UC END# *4DAEEDE10285_E1E6ADB3161D_impl*
end;//TkwROT.DoDoIt

class function TkwROT.GetWordNameForRegister: AnsiString;
begin
 Result := 'ROT';
end;//TkwROT.GetWordNameForRegister

function TkwROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E1E6ADB3161D_var*
//#UC END# *551544E2001A_E1E6ADB3161D_var*
begin
//#UC START# *551544E2001A_E1E6ADB3161D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E1E6ADB3161D_impl*
end;//TkwROT.GetResultTypeInfo

function TkwROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwROT.GetAllParamsCount

procedure TkwPICK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75F53535698F_var*
//#UC END# *4DAEEDE10285_75F53535698F_var*
begin
//#UC START# *4DAEEDE10285_75F53535698F_impl*
 aCtx.rEngine.PICK;
//#UC END# *4DAEEDE10285_75F53535698F_impl*
end;//TkwPICK.DoDoIt

class function TkwPICK.GetWordNameForRegister: AnsiString;
begin
 Result := 'PICK';
end;//TkwPICK.GetWordNameForRegister

function TkwPICK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_75F53535698F_var*
//#UC END# *551544E2001A_75F53535698F_var*
begin
//#UC START# *551544E2001A_75F53535698F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_75F53535698F_impl*
end;//TkwPICK.GetResultTypeInfo

function TkwPICK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPICK.GetAllParamsCount

procedure TkwInvertROT.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F07D92F8E519_var*
//#UC END# *4DAEEDE10285_F07D92F8E519_var*
begin
//#UC START# *4DAEEDE10285_F07D92F8E519_impl*
 aCtx.rEngine.InvertROT;
//#UC END# *4DAEEDE10285_F07D92F8E519_impl*
end;//TkwInvertROT.DoDoIt

class function TkwInvertROT.GetWordNameForRegister: AnsiString;
begin
 Result := '-ROT';
end;//TkwInvertROT.GetWordNameForRegister

function TkwInvertROT.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F07D92F8E519_var*
//#UC END# *551544E2001A_F07D92F8E519_var*
begin
//#UC START# *551544E2001A_F07D92F8E519_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F07D92F8E519_impl*
end;//TkwInvertROT.GetResultTypeInfo

function TkwInvertROT.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwInvertROT.GetAllParamsCount

procedure TkwSWAP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F7F6BAC82E0F_var*
//#UC END# *4DAEEDE10285_F7F6BAC82E0F_var*
begin
//#UC START# *4DAEEDE10285_F7F6BAC82E0F_impl*
 aCtx.rEngine.Swap2;
//#UC END# *4DAEEDE10285_F7F6BAC82E0F_impl*
end;//TkwSWAP2.DoDoIt

class function TkwSWAP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2SWAP';
end;//TkwSWAP2.GetWordNameForRegister

function TkwSWAP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F7F6BAC82E0F_var*
//#UC END# *551544E2001A_F7F6BAC82E0F_var*
begin
//#UC START# *551544E2001A_F7F6BAC82E0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F7F6BAC82E0F_impl*
end;//TkwSWAP2.GetResultTypeInfo

function TkwSWAP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSWAP2.GetAllParamsCount

procedure TkwOVER2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9918552ECDEB_var*
//#UC END# *4DAEEDE10285_9918552ECDEB_var*
begin
//#UC START# *4DAEEDE10285_9918552ECDEB_impl*
 aCtx.rEngine.Over2;
//#UC END# *4DAEEDE10285_9918552ECDEB_impl*
end;//TkwOVER2.DoDoIt

class function TkwOVER2.GetWordNameForRegister: AnsiString;
begin
 Result := '2OVER';
end;//TkwOVER2.GetWordNameForRegister

function TkwOVER2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9918552ECDEB_var*
//#UC END# *551544E2001A_9918552ECDEB_var*
begin
//#UC START# *551544E2001A_9918552ECDEB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9918552ECDEB_impl*
end;//TkwOVER2.GetResultTypeInfo

function TkwOVER2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwOVER2.GetAllParamsCount

procedure TkwDUP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B22DDB43B438_var*
//#UC END# *4DAEEDE10285_B22DDB43B438_var*
begin
//#UC START# *4DAEEDE10285_B22DDB43B438_impl*
 aCtx.rEngine.Dup2;
//#UC END# *4DAEEDE10285_B22DDB43B438_impl*
end;//TkwDUP2.DoDoIt

class function TkwDUP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2DUP';
end;//TkwDUP2.GetWordNameForRegister

function TkwDUP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B22DDB43B438_var*
//#UC END# *551544E2001A_B22DDB43B438_var*
begin
//#UC START# *551544E2001A_B22DDB43B438_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B22DDB43B438_impl*
end;//TkwDUP2.GetResultTypeInfo

function TkwDUP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDUP2.GetAllParamsCount

procedure TkwDROP2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_79D7140F1BCC_var*
//#UC END# *4DAEEDE10285_79D7140F1BCC_var*
begin
//#UC START# *4DAEEDE10285_79D7140F1BCC_impl*
 aCtx.rEngine.Drop2;
//#UC END# *4DAEEDE10285_79D7140F1BCC_impl*
end;//TkwDROP2.DoDoIt

class function TkwDROP2.GetWordNameForRegister: AnsiString;
begin
 Result := '2DROP';
end;//TkwDROP2.GetWordNameForRegister

function TkwDROP2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_79D7140F1BCC_var*
//#UC END# *551544E2001A_79D7140F1BCC_var*
begin
//#UC START# *551544E2001A_79D7140F1BCC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_79D7140F1BCC_impl*
end;//TkwDROP2.GetResultTypeInfo

function TkwDROP2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDROP2.GetAllParamsCount

procedure TkwNIP.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_58C1120D11ED_var*
//#UC END# *4DAEEDE10285_58C1120D11ED_var*
begin
//#UC START# *4DAEEDE10285_58C1120D11ED_impl*
 aCtx.rEngine.NIP;
//#UC END# *4DAEEDE10285_58C1120D11ED_impl*
end;//TkwNIP.DoDoIt

class function TkwNIP.GetWordNameForRegister: AnsiString;
begin
 Result := 'NIP';
end;//TkwNIP.GetWordNameForRegister

function TkwNIP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_58C1120D11ED_var*
//#UC END# *551544E2001A_58C1120D11ED_var*
begin
//#UC START# *551544E2001A_58C1120D11ED_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_58C1120D11ED_impl*
end;//TkwNIP.GetResultTypeInfo

function TkwNIP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNIP.GetAllParamsCount

procedure TkwTUCK.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_17D731E639BC_var*
//#UC END# *4DAEEDE10285_17D731E639BC_var*
begin
//#UC START# *4DAEEDE10285_17D731E639BC_impl*
 aCtx.rEngine.TUCK;
//#UC END# *4DAEEDE10285_17D731E639BC_impl*
end;//TkwTUCK.DoDoIt

class function TkwTUCK.GetWordNameForRegister: AnsiString;
begin
 Result := 'TUCK';
end;//TkwTUCK.GetWordNameForRegister

function TkwTUCK.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_17D731E639BC_var*
//#UC END# *551544E2001A_17D731E639BC_var*
begin
//#UC START# *551544E2001A_17D731E639BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_17D731E639BC_impl*
end;//TkwTUCK.GetResultTypeInfo

function TkwTUCK.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTUCK.GetAllParamsCount

procedure TkwOVER.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3113FD88EFFC_var*
//#UC END# *4DAEEDE10285_3113FD88EFFC_var*
begin
//#UC START# *4DAEEDE10285_3113FD88EFFC_impl*
 aCtx.rEngine.OVER;
//#UC END# *4DAEEDE10285_3113FD88EFFC_impl*
end;//TkwOVER.DoDoIt

class function TkwOVER.GetWordNameForRegister: AnsiString;
begin
 Result := 'OVER';
end;//TkwOVER.GetWordNameForRegister

function TkwOVER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3113FD88EFFC_var*
//#UC END# *551544E2001A_3113FD88EFFC_var*
begin
//#UC START# *551544E2001A_3113FD88EFFC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3113FD88EFFC_impl*
end;//TkwOVER.GetResultTypeInfo

function TkwOVER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwOVER.GetAllParamsCount

procedure TkwROLL.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7A5418ADBC12_var*
//#UC END# *4DAEEDE10285_7A5418ADBC12_var*
begin
//#UC START# *4DAEEDE10285_7A5418ADBC12_impl*
 aCtx.rEngine.ROLL;
//#UC END# *4DAEEDE10285_7A5418ADBC12_impl*
end;//TkwROLL.DoDoIt

class function TkwROLL.GetWordNameForRegister: AnsiString;
begin
 Result := 'ROLL';
end;//TkwROLL.GetWordNameForRegister

function TkwROLL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7A5418ADBC12_var*
//#UC END# *551544E2001A_7A5418ADBC12_var*
begin
//#UC START# *551544E2001A_7A5418ADBC12_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7A5418ADBC12_impl*
end;//TkwROLL.GetResultTypeInfo

function TkwROLL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwROLL.GetAllParamsCount

function TkwNotEquals.NotEquals(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта != }
//#UC START# *DAC93FA73644_121F11B3416F_var*
//#UC END# *DAC93FA73644_121F11B3416F_var*
begin
//#UC START# *DAC93FA73644_121F11B3416F_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt <> aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean <> aB.AsBoolean;
  tfw_vtStr:
   Result := not l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject <> aB.AsObject;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *DAC93FA73644_121F11B3416F_impl*
end;//TkwNotEquals.NotEquals

procedure TkwNotEquals.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_121F11B3416F_var*
//#UC END# *4DAEEDE10285_121F11B3416F_var*
begin
//#UC START# *4DAEEDE10285_121F11B3416F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_121F11B3416F_impl*
end;//TkwNotEquals.DoDoIt

class function TkwNotEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '!=';
end;//TkwNotEquals.GetWordNameForRegister

function TkwNotEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_121F11B3416F_var*
//#UC END# *551544E2001A_121F11B3416F_var*
begin
//#UC START# *551544E2001A_121F11B3416F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_121F11B3416F_impl*
end;//TkwNotEquals.GetResultTypeInfo

function TkwNotEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNotEquals.GetAllParamsCount

function TkwNotEquals.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_121F11B3416F_var*
//#UC END# *5617F4D00243_121F11B3416F_var*
begin
//#UC START# *5617F4D00243_121F11B3416F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_121F11B3416F_impl*
end;//TkwNotEquals.ParamsTypes

function TkwGREATER.GREATER(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта GREATER }
//#UC START# *907965538A11_0863B7ED4B56_var*
//#UC END# *907965538A11_0863B7ED4B56_var*
begin
//#UC START# *907965538A11_0863B7ED4B56_impl*
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
//#UC END# *907965538A11_0863B7ED4B56_impl*
end;//TkwGREATER.GREATER

procedure TkwGREATER.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0863B7ED4B56_var*
//#UC END# *4DAEEDE10285_0863B7ED4B56_var*
begin
//#UC START# *4DAEEDE10285_0863B7ED4B56_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0863B7ED4B56_impl*
end;//TkwGREATER.DoDoIt

class function TkwGREATER.GetWordNameForRegister: AnsiString;
begin
 Result := 'GREATER';
end;//TkwGREATER.GetWordNameForRegister

function TkwGREATER.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0863B7ED4B56_var*
//#UC END# *551544E2001A_0863B7ED4B56_var*
begin
//#UC START# *551544E2001A_0863B7ED4B56_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0863B7ED4B56_impl*
end;//TkwGREATER.GetResultTypeInfo

function TkwGREATER.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwGREATER.GetAllParamsCount

function TkwGREATER.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0863B7ED4B56_var*
//#UC END# *5617F4D00243_0863B7ED4B56_var*
begin
//#UC START# *5617F4D00243_0863B7ED4B56_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0863B7ED4B56_impl*
end;//TkwGREATER.ParamsTypes

function TkwLESS.LESS(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта LESS }
//#UC START# *EAAF403E752C_2AFA590B937B_var*
//#UC END# *EAAF403E752C_2AFA590B937B_var*
begin
//#UC START# *EAAF403E752C_2AFA590B937B_impl*
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
//#UC END# *EAAF403E752C_2AFA590B937B_impl*
end;//TkwLESS.LESS

procedure TkwLESS.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2AFA590B937B_var*
//#UC END# *4DAEEDE10285_2AFA590B937B_var*
begin
//#UC START# *4DAEEDE10285_2AFA590B937B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2AFA590B937B_impl*
end;//TkwLESS.DoDoIt

class function TkwLESS.GetWordNameForRegister: AnsiString;
begin
 Result := 'LESS';
end;//TkwLESS.GetWordNameForRegister

function TkwLESS.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2AFA590B937B_var*
//#UC END# *551544E2001A_2AFA590B937B_var*
begin
//#UC START# *551544E2001A_2AFA590B937B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2AFA590B937B_impl*
end;//TkwLESS.GetResultTypeInfo

function TkwLESS.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLESS.GetAllParamsCount

function TkwLESS.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2AFA590B937B_var*
//#UC END# *5617F4D00243_2AFA590B937B_var*
begin
//#UC START# *5617F4D00243_2AFA590B937B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2AFA590B937B_impl*
end;//TkwLESS.ParamsTypes

function TkwEquals.Equals(const aCtx: TtfwContext;
 const aB: TtfwStackValue;
 const aA: TtfwStackValue): Boolean;
 {* Реализация слова скрипта == }
//#UC START# *7E71F9CCB18C_1A66A4BEC1B0_var*
//#UC END# *7E71F9CCB18C_1A66A4BEC1B0_var*
begin
//#UC START# *7E71F9CCB18C_1A66A4BEC1B0_impl*
 Case aA.rType of
  tfw_vtInt:
   Result := aA.AsInt = aB.AsInt;
  tfw_vtBool:
   Result := aA.AsBoolean = aB.AsBoolean;
  tfw_vtStr:
   Result := l3Same(aA.AsString, aB.AsString);
  tfw_vtObj:
   Result := aA.AsObject = aB.AsObject;
  else
  begin
   Result := false;
   BadValueType(aA.rType, aCtx);
  end;//else
 end;//Case aA.rType
//#UC END# *7E71F9CCB18C_1A66A4BEC1B0_impl*
end;//TkwEquals.Equals

procedure TkwEquals.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A66A4BEC1B0_var*
//#UC END# *4DAEEDE10285_1A66A4BEC1B0_var*
begin
//#UC START# *4DAEEDE10285_1A66A4BEC1B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A66A4BEC1B0_impl*
end;//TkwEquals.DoDoIt

class function TkwEquals.GetWordNameForRegister: AnsiString;
begin
 Result := '==';
end;//TkwEquals.GetWordNameForRegister

function TkwEquals.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1A66A4BEC1B0_var*
//#UC END# *551544E2001A_1A66A4BEC1B0_var*
begin
//#UC START# *551544E2001A_1A66A4BEC1B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1A66A4BEC1B0_impl*
end;//TkwEquals.GetResultTypeInfo

function TkwEquals.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEquals.GetAllParamsCount

function TkwEquals.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1A66A4BEC1B0_var*
//#UC END# *5617F4D00243_1A66A4BEC1B0_var*
begin
//#UC START# *5617F4D00243_1A66A4BEC1B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1A66A4BEC1B0_impl*
end;//TkwEquals.ParamsTypes

function TkwLessThanZero.LessThanZero(const aCtx: TtfwContext;
 aB: Integer): Boolean;
 {* Реализация слова скрипта <0 }
//#UC START# *76343505B981_AD14C7183370_var*
//#UC END# *76343505B981_AD14C7183370_var*
begin
//#UC START# *76343505B981_AD14C7183370_impl*
 Result := (aB < 0);
//#UC END# *76343505B981_AD14C7183370_impl*
end;//TkwLessThanZero.LessThanZero

procedure TkwLessThanZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AD14C7183370_var*
//#UC END# *4DAEEDE10285_AD14C7183370_var*
begin
//#UC START# *4DAEEDE10285_AD14C7183370_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AD14C7183370_impl*
end;//TkwLessThanZero.DoDoIt

class function TkwLessThanZero.GetWordNameForRegister: AnsiString;
begin
 Result := '<0';
end;//TkwLessThanZero.GetWordNameForRegister

function TkwLessThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AD14C7183370_var*
//#UC END# *551544E2001A_AD14C7183370_var*
begin
//#UC START# *551544E2001A_AD14C7183370_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AD14C7183370_impl*
end;//TkwLessThanZero.GetResultTypeInfo

function TkwLessThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLessThanZero.GetAllParamsCount

function TkwLessThanZero.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AD14C7183370_var*
//#UC END# *5617F4D00243_AD14C7183370_var*
begin
//#UC START# *5617F4D00243_AD14C7183370_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AD14C7183370_impl*
end;//TkwLessThanZero.ParamsTypes

function TkwGreaterThanZero.GreaterThanZero(const aCtx: TtfwContext;
 aB: Integer): Boolean;
 {* Реализация слова скрипта >0 }
//#UC START# *1832AF7A2450_CC7B740D2755_var*
//#UC END# *1832AF7A2450_CC7B740D2755_var*
begin
//#UC START# *1832AF7A2450_CC7B740D2755_impl*
 Result := (aB > 0);
//#UC END# *1832AF7A2450_CC7B740D2755_impl*
end;//TkwGreaterThanZero.GreaterThanZero

procedure TkwGreaterThanZero.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CC7B740D2755_var*
//#UC END# *4DAEEDE10285_CC7B740D2755_var*
begin
//#UC START# *4DAEEDE10285_CC7B740D2755_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CC7B740D2755_impl*
end;//TkwGreaterThanZero.DoDoIt

class function TkwGreaterThanZero.GetWordNameForRegister: AnsiString;
begin
 Result := '>0';
end;//TkwGreaterThanZero.GetWordNameForRegister

function TkwGreaterThanZero.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CC7B740D2755_var*
//#UC END# *551544E2001A_CC7B740D2755_var*
begin
//#UC START# *551544E2001A_CC7B740D2755_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CC7B740D2755_impl*
end;//TkwGreaterThanZero.GetResultTypeInfo

function TkwGreaterThanZero.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwGreaterThanZero.GetAllParamsCount

function TkwGreaterThanZero.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CC7B740D2755_var*
//#UC END# *5617F4D00243_CC7B740D2755_var*
begin
//#UC START# *5617F4D00243_CC7B740D2755_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CC7B740D2755_impl*
end;//TkwGreaterThanZero.ParamsTypes

function TkwBitAnd.BitAnd(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта & }
//#UC START# *B61F439AC566_0E401EC02EF4_var*
//#UC END# *B61F439AC566_0E401EC02EF4_var*
begin
//#UC START# *B61F439AC566_0E401EC02EF4_impl*
 Result := aA AND aB;
//#UC END# *B61F439AC566_0E401EC02EF4_impl*
end;//TkwBitAnd.BitAnd

procedure TkwBitAnd.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0E401EC02EF4_var*
//#UC END# *4DAEEDE10285_0E401EC02EF4_var*
begin
//#UC START# *4DAEEDE10285_0E401EC02EF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0E401EC02EF4_impl*
end;//TkwBitAnd.DoDoIt

class function TkwBitAnd.GetWordNameForRegister: AnsiString;
begin
 Result := '&';
end;//TkwBitAnd.GetWordNameForRegister

function TkwBitAnd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0E401EC02EF4_var*
//#UC END# *551544E2001A_0E401EC02EF4_var*
begin
//#UC START# *551544E2001A_0E401EC02EF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0E401EC02EF4_impl*
end;//TkwBitAnd.GetResultTypeInfo

function TkwBitAnd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBitAnd.GetAllParamsCount

function TkwBitAnd.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0E401EC02EF4_var*
//#UC END# *5617F4D00243_0E401EC02EF4_var*
begin
//#UC START# *5617F4D00243_0E401EC02EF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0E401EC02EF4_impl*
end;//TkwBitAnd.ParamsTypes

function TkwBitOR.BitOR(const aCtx: TtfwContext;
 aB: Integer;
 aA: Integer): Integer;
 {* Реализация слова скрипта | }
//#UC START# *13EB96AAB427_69326D5123FC_var*
//#UC END# *13EB96AAB427_69326D5123FC_var*
begin
//#UC START# *13EB96AAB427_69326D5123FC_impl*
 Result := aA OR aB;
//#UC END# *13EB96AAB427_69326D5123FC_impl*
end;//TkwBitOR.BitOR

procedure TkwBitOR.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_69326D5123FC_var*
//#UC END# *4DAEEDE10285_69326D5123FC_var*
begin
//#UC START# *4DAEEDE10285_69326D5123FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_69326D5123FC_impl*
end;//TkwBitOR.DoDoIt

class function TkwBitOR.GetWordNameForRegister: AnsiString;
begin
 Result := '|';
end;//TkwBitOR.GetWordNameForRegister

function TkwBitOR.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_69326D5123FC_var*
//#UC END# *551544E2001A_69326D5123FC_var*
begin
//#UC START# *551544E2001A_69326D5123FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_69326D5123FC_impl*
end;//TkwBitOR.GetResultTypeInfo

function TkwBitOR.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBitOR.GetAllParamsCount

function TkwBitOR.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_69326D5123FC_var*
//#UC END# *5617F4D00243_69326D5123FC_var*
begin
//#UC START# *5617F4D00243_69326D5123FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_69326D5123FC_impl*
end;//TkwBitOR.ParamsTypes

function TkwBitNot.BitNot(const aCtx: TtfwContext;
 aB: Integer): Integer;
 {* Реализация слова скрипта ~ }
//#UC START# *B69DB28A46FE_7DACF7561AEE_var*
//#UC END# *B69DB28A46FE_7DACF7561AEE_var*
begin
//#UC START# *B69DB28A46FE_7DACF7561AEE_impl*
 Result := not aB;
//#UC END# *B69DB28A46FE_7DACF7561AEE_impl*
end;//TkwBitNot.BitNot

procedure TkwBitNot.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7DACF7561AEE_var*
//#UC END# *4DAEEDE10285_7DACF7561AEE_var*
begin
//#UC START# *4DAEEDE10285_7DACF7561AEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7DACF7561AEE_impl*
end;//TkwBitNot.DoDoIt

class function TkwBitNot.GetWordNameForRegister: AnsiString;
begin
 Result := '~';
end;//TkwBitNot.GetWordNameForRegister

function TkwBitNot.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7DACF7561AEE_var*
//#UC END# *551544E2001A_7DACF7561AEE_var*
begin
//#UC START# *551544E2001A_7DACF7561AEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7DACF7561AEE_impl*
end;//TkwBitNot.GetResultTypeInfo

function TkwBitNot.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBitNot.GetAllParamsCount

function TkwBitNot.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7DACF7561AEE_var*
//#UC END# *5617F4D00243_7DACF7561AEE_var*
begin
//#UC START# *5617F4D00243_7DACF7561AEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7DACF7561AEE_impl*
end;//TkwBitNot.ParamsTypes

function TkwStackLevel.StackLevel(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта StackLevel }
//#UC START# *42FCDB4340A7_3C430AEBDFB3_var*
//#UC END# *42FCDB4340A7_3C430AEBDFB3_var*
begin
//#UC START# *42FCDB4340A7_3C430AEBDFB3_impl*
 Result := aCtx.rEngine.ValuesCount;
//#UC END# *42FCDB4340A7_3C430AEBDFB3_impl*
end;//TkwStackLevel.StackLevel

procedure TkwStackLevel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3C430AEBDFB3_var*
//#UC END# *4DAEEDE10285_3C430AEBDFB3_var*
begin
//#UC START# *4DAEEDE10285_3C430AEBDFB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3C430AEBDFB3_impl*
end;//TkwStackLevel.DoDoIt

class function TkwStackLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'StackLevel';
end;//TkwStackLevel.GetWordNameForRegister

function TkwStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3C430AEBDFB3_var*
//#UC END# *551544E2001A_3C430AEBDFB3_var*
begin
//#UC START# *551544E2001A_3C430AEBDFB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3C430AEBDFB3_impl*
end;//TkwStackLevel.GetResultTypeInfo

function TkwStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStackLevel.GetAllParamsCount

function TkwStackLevel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3C430AEBDFB3_var*
//#UC END# *5617F4D00243_3C430AEBDFB3_var*
begin
//#UC START# *5617F4D00243_3C430AEBDFB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3C430AEBDFB3_impl*
end;//TkwStackLevel.ParamsTypes

procedure TkwReduceStackLevel.ReduceStackLevel(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта ReduceStackLevel }
//#UC START# *8AD57442466F_50820082E666_var*
//#UC END# *8AD57442466F_50820082E666_var*
begin
//#UC START# *8AD57442466F_50820082E666_impl*
 while (aCtx.rEngine.ValuesCount > aValue) do
  aCtx.rEngine.Drop;
//#UC END# *8AD57442466F_50820082E666_impl*
end;//TkwReduceStackLevel.ReduceStackLevel

procedure TkwReduceStackLevel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50820082E666_var*
//#UC END# *4DAEEDE10285_50820082E666_var*
begin
//#UC START# *4DAEEDE10285_50820082E666_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_50820082E666_impl*
end;//TkwReduceStackLevel.DoDoIt

class function TkwReduceStackLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'ReduceStackLevel';
end;//TkwReduceStackLevel.GetWordNameForRegister

function TkwReduceStackLevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_50820082E666_var*
//#UC END# *551544E2001A_50820082E666_var*
begin
//#UC START# *551544E2001A_50820082E666_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_50820082E666_impl*
end;//TkwReduceStackLevel.GetResultTypeInfo

function TkwReduceStackLevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwReduceStackLevel.GetAllParamsCount

function TkwReduceStackLevel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_50820082E666_var*
//#UC END# *5617F4D00243_50820082E666_var*
begin
//#UC START# *5617F4D00243_50820082E666_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_50820082E666_impl*
end;//TkwReduceStackLevel.ParamsTypes

procedure TkwCtxParserPushString.Ctx_Parser_PushString(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:Parser:PushString }
//#UC START# *8E726023F8EB_D8442EFB554F_var*
//#UC END# *8E726023F8EB_D8442EFB554F_var*
begin
//#UC START# *8E726023F8EB_D8442EFB554F_impl*
 aCtx.rParser.PushString(aValue);
//#UC END# *8E726023F8EB_D8442EFB554F_impl*
end;//TkwCtxParserPushString.Ctx_Parser_PushString

procedure TkwCtxParserPushString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D8442EFB554F_var*
//#UC END# *4DAEEDE10285_D8442EFB554F_var*
begin
//#UC START# *4DAEEDE10285_D8442EFB554F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D8442EFB554F_impl*
end;//TkwCtxParserPushString.DoDoIt

class function TkwCtxParserPushString.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushString';
end;//TkwCtxParserPushString.GetWordNameForRegister

function TkwCtxParserPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D8442EFB554F_var*
//#UC END# *551544E2001A_D8442EFB554F_var*
begin
//#UC START# *551544E2001A_D8442EFB554F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D8442EFB554F_impl*
end;//TkwCtxParserPushString.GetResultTypeInfo

function TkwCtxParserPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushString.GetAllParamsCount

function TkwCtxParserPushString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D8442EFB554F_var*
//#UC END# *5617F4D00243_D8442EFB554F_var*
begin
//#UC START# *5617F4D00243_D8442EFB554F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D8442EFB554F_impl*
end;//TkwCtxParserPushString.ParamsTypes

procedure TkwCtxParserPushSymbol.Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта Ctx:Parser:PushSymbol }
//#UC START# *4FE75C990836_7CF3976BA94E_var*
//#UC END# *4FE75C990836_7CF3976BA94E_var*
begin
//#UC START# *4FE75C990836_7CF3976BA94E_impl*
 aCtx.rParser.PushSymbol(aValue);
//#UC END# *4FE75C990836_7CF3976BA94E_impl*
end;//TkwCtxParserPushSymbol.Ctx_Parser_PushSymbol

procedure TkwCtxParserPushSymbol.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7CF3976BA94E_var*
//#UC END# *4DAEEDE10285_7CF3976BA94E_var*
begin
//#UC START# *4DAEEDE10285_7CF3976BA94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7CF3976BA94E_impl*
end;//TkwCtxParserPushSymbol.DoDoIt

class function TkwCtxParserPushSymbol.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushSymbol';
end;//TkwCtxParserPushSymbol.GetWordNameForRegister

function TkwCtxParserPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7CF3976BA94E_var*
//#UC END# *551544E2001A_7CF3976BA94E_var*
begin
//#UC START# *551544E2001A_7CF3976BA94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7CF3976BA94E_impl*
end;//TkwCtxParserPushSymbol.GetResultTypeInfo

function TkwCtxParserPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushSymbol.GetAllParamsCount

function TkwCtxParserPushSymbol.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7CF3976BA94E_var*
//#UC END# *5617F4D00243_7CF3976BA94E_var*
begin
//#UC START# *5617F4D00243_7CF3976BA94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7CF3976BA94E_impl*
end;//TkwCtxParserPushSymbol.ParamsTypes

procedure TkwCtxParserPushInt.Ctx_Parser_PushInt(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта Ctx:Parser:PushInt }
//#UC START# *281A6BDFE308_6506A524A1D6_var*
//#UC END# *281A6BDFE308_6506A524A1D6_var*
begin
//#UC START# *281A6BDFE308_6506A524A1D6_impl*
 aCtx.rParser.PushInt(aValue);
//#UC END# *281A6BDFE308_6506A524A1D6_impl*
end;//TkwCtxParserPushInt.Ctx_Parser_PushInt

procedure TkwCtxParserPushInt.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6506A524A1D6_var*
//#UC END# *4DAEEDE10285_6506A524A1D6_var*
begin
//#UC START# *4DAEEDE10285_6506A524A1D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6506A524A1D6_impl*
end;//TkwCtxParserPushInt.DoDoIt

class function TkwCtxParserPushInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser:PushInt';
end;//TkwCtxParserPushInt.GetWordNameForRegister

function TkwCtxParserPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6506A524A1D6_var*
//#UC END# *551544E2001A_6506A524A1D6_var*
begin
//#UC START# *551544E2001A_6506A524A1D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6506A524A1D6_impl*
end;//TkwCtxParserPushInt.GetResultTypeInfo

function TkwCtxParserPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParserPushInt.GetAllParamsCount

function TkwCtxParserPushInt.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6506A524A1D6_var*
//#UC END# *5617F4D00243_6506A524A1D6_var*
begin
//#UC START# *5617F4D00243_6506A524A1D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6506A524A1D6_impl*
end;//TkwCtxParserPushInt.ParamsTypes

function TkwCtxParser.Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
 {* Реализация слова скрипта Ctx:Parser }
//#UC START# *E7656563CEDD_31E4D21646AB_var*
//#UC END# *E7656563CEDD_31E4D21646AB_var*
begin
//#UC START# *E7656563CEDD_31E4D21646AB_impl*
 Result := aCtx.rParser;
//#UC END# *E7656563CEDD_31E4D21646AB_impl*
end;//TkwCtxParser.Ctx_Parser

procedure TkwCtxParser.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_31E4D21646AB_var*
//#UC END# *4DAEEDE10285_31E4D21646AB_var*
begin
//#UC START# *4DAEEDE10285_31E4D21646AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_31E4D21646AB_impl*
end;//TkwCtxParser.DoDoIt

class function TkwCtxParser.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Parser';
end;//TkwCtxParser.GetWordNameForRegister

function TkwCtxParser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_31E4D21646AB_var*
//#UC END# *551544E2001A_31E4D21646AB_var*
begin
//#UC START# *551544E2001A_31E4D21646AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_31E4D21646AB_impl*
end;//TkwCtxParser.GetResultTypeInfo

function TkwCtxParser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxParser.GetAllParamsCount

function TkwCtxParser.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_31E4D21646AB_var*
//#UC END# *5617F4D00243_31E4D21646AB_var*
begin
//#UC START# *5617F4D00243_31E4D21646AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_31E4D21646AB_impl*
end;//TkwCtxParser.ParamsTypes

procedure TkwAtomicIf.AtomicIf(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aCondition: Boolean);
 {* Реализация слова скрипта ? }
//#UC START# *EC03275D308E_0DAE5A00538B_var*
//#UC END# *EC03275D308E_0DAE5A00538B_var*
begin
//#UC START# *EC03275D308E_0DAE5A00538B_impl*
 if aCondition then
  aWord.DoIt(aCtx);
//#UC END# *EC03275D308E_0DAE5A00538B_impl*
end;//TkwAtomicIf.AtomicIf

class function TkwAtomicIf.GetWordNameForRegister: AnsiString;
begin
 Result := '?';
end;//TkwAtomicIf.GetWordNameForRegister

function TkwAtomicIf.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAtomicIf.RightParamsCount

procedure TkwAtomicIf.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_0DAE5A00538B_var*
//#UC END# *5512949D0048_0DAE5A00538B_var*
begin
//#UC START# *5512949D0048_0DAE5A00538B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_0DAE5A00538B_impl*
end;//TkwAtomicIf.DoRun

function TkwAtomicIf.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0DAE5A00538B_var*
//#UC END# *551544E2001A_0DAE5A00538B_var*
begin
//#UC START# *551544E2001A_0DAE5A00538B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0DAE5A00538B_impl*
end;//TkwAtomicIf.GetResultTypeInfo

function TkwAtomicIf.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAtomicIf.GetAllParamsCount

function TkwAtomicIf.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0DAE5A00538B_var*
//#UC END# *5617F4D00243_0DAE5A00538B_var*
begin
//#UC START# *5617F4D00243_0DAE5A00538B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0DAE5A00538B_impl*
end;//TkwAtomicIf.ParamsTypes

procedure TkwCompileValue.CompileValue(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileValue }
//#UC START# *749E10496472_C02DF9F9363F_var*
var
 l_W : TtfwWord;
//#UC END# *749E10496472_C02DF9F9363F_var*
begin
//#UC START# *749E10496472_C02DF9F9363F_impl*
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
//#UC END# *749E10496472_C02DF9F9363F_impl*
end;//TkwCompileValue.CompileValue

procedure TkwCompileValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C02DF9F9363F_var*
//#UC END# *4DAEEDE10285_C02DF9F9363F_var*
begin
//#UC START# *4DAEEDE10285_C02DF9F9363F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C02DF9F9363F_impl*
end;//TkwCompileValue.DoDoIt

class function TkwCompileValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileValue';
end;//TkwCompileValue.GetWordNameForRegister

function TkwCompileValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C02DF9F9363F_var*
//#UC END# *551544E2001A_C02DF9F9363F_var*
begin
//#UC START# *551544E2001A_C02DF9F9363F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C02DF9F9363F_impl*
end;//TkwCompileValue.GetResultTypeInfo

function TkwCompileValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileValue.GetAllParamsCount

function TkwCompileValue.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C02DF9F9363F_var*
//#UC END# *5617F4D00243_C02DF9F9363F_var*
begin
//#UC START# *5617F4D00243_C02DF9F9363F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C02DF9F9363F_impl*
end;//TkwCompileValue.ParamsTypes

procedure TkwIMMEDIATE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6EC672F8FA27_var*
//#UC END# *4DAEEDE10285_6EC672F8FA27_var*
begin
//#UC START# *4DAEEDE10285_6EC672F8FA27_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeModifier(tfw_wmImmediate));
//#UC END# *4DAEEDE10285_6EC672F8FA27_impl*
end;//TkwIMMEDIATE.DoDoIt

class function TkwIMMEDIATE.GetWordNameForRegister: AnsiString;
begin
 Result := 'IMMEDIATE';
end;//TkwIMMEDIATE.GetWordNameForRegister

function TkwIMMEDIATE.IsImmediate(const aCtx: TtfwContext): Boolean;
begin
 Result := True;
end;//TkwIMMEDIATE.IsImmediate

function TkwIMMEDIATE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6EC672F8FA27_var*
//#UC END# *551544E2001A_6EC672F8FA27_var*
begin
//#UC START# *551544E2001A_6EC672F8FA27_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6EC672F8FA27_impl*
end;//TkwIMMEDIATE.GetResultTypeInfo

function TkwIMMEDIATE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIMMEDIATE.GetAllParamsCount

function TkwCtxScriptCaller.Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
 {* Реализация слова скрипта Ctx:ScriptCaller }
//#UC START# *7E032295C1C9_F308C4778C99_var*
//#UC END# *7E032295C1C9_F308C4778C99_var*
begin
//#UC START# *7E032295C1C9_F308C4778C99_impl*
 Result := aCtx.rCaller;
//#UC END# *7E032295C1C9_F308C4778C99_impl*
end;//TkwCtxScriptCaller.Ctx_ScriptCaller

procedure TkwCtxScriptCaller.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F308C4778C99_var*
//#UC END# *4DAEEDE10285_F308C4778C99_var*
begin
//#UC START# *4DAEEDE10285_F308C4778C99_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F308C4778C99_impl*
end;//TkwCtxScriptCaller.DoDoIt

class function TkwCtxScriptCaller.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:ScriptCaller';
end;//TkwCtxScriptCaller.GetWordNameForRegister

function TkwCtxScriptCaller.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F308C4778C99_var*
//#UC END# *551544E2001A_F308C4778C99_var*
begin
//#UC START# *551544E2001A_F308C4778C99_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F308C4778C99_impl*
end;//TkwCtxScriptCaller.GetResultTypeInfo

function TkwCtxScriptCaller.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxScriptCaller.GetAllParamsCount

function TkwCtxScriptCaller.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F308C4778C99_var*
//#UC END# *5617F4D00243_F308C4778C99_var*
begin
//#UC START# *5617F4D00243_F308C4778C99_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F308C4778C99_impl*
end;//TkwCtxScriptCaller.ParamsTypes

function TkwCtxEngine.Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
 {* Реализация слова скрипта Ctx:Engine }
//#UC START# *E94F373360E6_42CA0C676D88_var*
//#UC END# *E94F373360E6_42CA0C676D88_var*
begin
//#UC START# *E94F373360E6_42CA0C676D88_impl*
 Result := aCtx.rEngine;
//#UC END# *E94F373360E6_42CA0C676D88_impl*
end;//TkwCtxEngine.Ctx_Engine

procedure TkwCtxEngine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42CA0C676D88_var*
//#UC END# *4DAEEDE10285_42CA0C676D88_var*
begin
//#UC START# *4DAEEDE10285_42CA0C676D88_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42CA0C676D88_impl*
end;//TkwCtxEngine.DoDoIt

class function TkwCtxEngine.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:Engine';
end;//TkwCtxEngine.GetWordNameForRegister

function TkwCtxEngine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_42CA0C676D88_var*
//#UC END# *551544E2001A_42CA0C676D88_var*
begin
//#UC START# *551544E2001A_42CA0C676D88_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_42CA0C676D88_impl*
end;//TkwCtxEngine.GetResultTypeInfo

function TkwCtxEngine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxEngine.GetAllParamsCount

function TkwCtxEngine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_42CA0C676D88_var*
//#UC END# *5617F4D00243_42CA0C676D88_var*
begin
//#UC START# *5617F4D00243_42CA0C676D88_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_42CA0C676D88_impl*
end;//TkwCtxEngine.ParamsTypes

function TkwCtxStoredValuesStack.Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
 {* Реализация слова скрипта Ctx:StoredValuesStack }
//#UC START# *6EA47AE2D452_089904B15389_var*
//#UC END# *6EA47AE2D452_089904B15389_var*
begin
//#UC START# *6EA47AE2D452_089904B15389_impl*
 Result := aCtx.rStoredValuesStack;
//#UC END# *6EA47AE2D452_089904B15389_impl*
end;//TkwCtxStoredValuesStack.Ctx_StoredValuesStack

procedure TkwCtxStoredValuesStack.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_089904B15389_var*
//#UC END# *4DAEEDE10285_089904B15389_var*
begin
//#UC START# *4DAEEDE10285_089904B15389_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_089904B15389_impl*
end;//TkwCtxStoredValuesStack.DoDoIt

class function TkwCtxStoredValuesStack.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ctx:StoredValuesStack';
end;//TkwCtxStoredValuesStack.GetWordNameForRegister

function TkwCtxStoredValuesStack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_089904B15389_var*
//#UC END# *551544E2001A_089904B15389_var*
begin
//#UC START# *551544E2001A_089904B15389_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_089904B15389_impl*
end;//TkwCtxStoredValuesStack.GetResultTypeInfo

function TkwCtxStoredValuesStack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCtxStoredValuesStack.GetAllParamsCount

function TkwCtxStoredValuesStack.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_089904B15389_var*
//#UC END# *5617F4D00243_089904B15389_var*
begin
//#UC START# *5617F4D00243_089904B15389_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_089904B15389_impl*
end;//TkwCtxStoredValuesStack.ParamsTypes

procedure TkwCreateAndRaise.CreateAndRaise(const aCtx: TtfwContext;
 aClass: TClass;
 const aMessage: AnsiString);
 {* Реализация слова скрипта CreateAndRaise }
//#UC START# *28A55B6DB9FC_19AF75640AE2_var*
type
 RException = class of Exception;
//#UC END# *28A55B6DB9FC_19AF75640AE2_var*
begin
//#UC START# *28A55B6DB9FC_19AF75640AE2_impl*
 if aClass.InheritsFrom(Exception) then
  raise RException(aClass).Create(aMessage)
 else
  RunnerError('Передан не класс исключения, а ' + aClass.ClassName, aCtx); 
//#UC END# *28A55B6DB9FC_19AF75640AE2_impl*
end;//TkwCreateAndRaise.CreateAndRaise

procedure TkwCreateAndRaise.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_19AF75640AE2_var*
//#UC END# *4DAEEDE10285_19AF75640AE2_var*
begin
//#UC START# *4DAEEDE10285_19AF75640AE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_19AF75640AE2_impl*
end;//TkwCreateAndRaise.DoDoIt

class function TkwCreateAndRaise.GetWordNameForRegister: AnsiString;
begin
 Result := 'CreateAndRaise';
end;//TkwCreateAndRaise.GetWordNameForRegister

function TkwCreateAndRaise.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_19AF75640AE2_var*
//#UC END# *551544E2001A_19AF75640AE2_var*
begin
//#UC START# *551544E2001A_19AF75640AE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_19AF75640AE2_impl*
end;//TkwCreateAndRaise.GetResultTypeInfo

function TkwCreateAndRaise.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCreateAndRaise.GetAllParamsCount

function TkwCreateAndRaise.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_19AF75640AE2_var*
//#UC END# *5617F4D00243_19AF75640AE2_var*
begin
//#UC START# *5617F4D00243_19AF75640AE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_19AF75640AE2_impl*
end;//TkwCreateAndRaise.ParamsTypes

procedure TkwCompileRef.CompileRef(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileRef }
//#UC START# *D7798F759F29_C0A961058CA4_var*
var
 l_W : TtfwWord;
 l_PW : TkwCompiledPushWord;
//#UC END# *D7798F759F29_C0A961058CA4_var*
begin
//#UC START# *D7798F759F29_C0A961058CA4_impl*
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
//#UC END# *D7798F759F29_C0A961058CA4_impl*
end;//TkwCompileRef.CompileRef

procedure TkwCompileRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C0A961058CA4_var*
//#UC END# *4DAEEDE10285_C0A961058CA4_var*
begin
//#UC START# *4DAEEDE10285_C0A961058CA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C0A961058CA4_impl*
end;//TkwCompileRef.DoDoIt

class function TkwCompileRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileRef';
end;//TkwCompileRef.GetWordNameForRegister

function TkwCompileRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C0A961058CA4_var*
//#UC END# *551544E2001A_C0A961058CA4_var*
begin
//#UC START# *551544E2001A_C0A961058CA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C0A961058CA4_impl*
end;//TkwCompileRef.GetResultTypeInfo

function TkwCompileRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileRef.GetAllParamsCount

function TkwCompileRef.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C0A961058CA4_var*
//#UC END# *5617F4D00243_C0A961058CA4_var*
begin
//#UC START# *5617F4D00243_C0A961058CA4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C0A961058CA4_impl*
end;//TkwCompileRef.ParamsTypes

procedure TkwCompileWeakRef.CompileWeakRef(const aCtx: TtfwContext;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта CompileWeakRef }
//#UC START# *854CA0D04456_896B70A80D41_var*
var
 l_W : TtfwWord;
//#UC END# *854CA0D04456_896B70A80D41_var*
begin
//#UC START# *854CA0D04456_896B70A80D41_impl*
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
//#UC END# *854CA0D04456_896B70A80D41_impl*
end;//TkwCompileWeakRef.CompileWeakRef

procedure TkwCompileWeakRef.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_896B70A80D41_var*
//#UC END# *4DAEEDE10285_896B70A80D41_var*
begin
//#UC START# *4DAEEDE10285_896B70A80D41_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_896B70A80D41_impl*
end;//TkwCompileWeakRef.DoDoIt

class function TkwCompileWeakRef.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompileWeakRef';
end;//TkwCompileWeakRef.GetWordNameForRegister

function TkwCompileWeakRef.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_896B70A80D41_var*
//#UC END# *551544E2001A_896B70A80D41_var*
begin
//#UC START# *551544E2001A_896B70A80D41_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_896B70A80D41_impl*
end;//TkwCompileWeakRef.GetResultTypeInfo

function TkwCompileWeakRef.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompileWeakRef.GetAllParamsCount

function TkwCompileWeakRef.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_896B70A80D41_var*
//#UC END# *5617F4D00243_896B70A80D41_var*
begin
//#UC START# *5617F4D00243_896B70A80D41_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_896B70A80D41_impl*
end;//TkwCompileWeakRef.ParamsTypes

procedure TkwDUPN.DUPN(const aCtx: TtfwContext;
 aN: Integer);
 {* Реализация слова скрипта DUPN }
//#UC START# *90BD7A4A66F6_9A75B00E3D0A_var*
//#UC END# *90BD7A4A66F6_9A75B00E3D0A_var*
begin
//#UC START# *90BD7A4A66F6_9A75B00E3D0A_impl*
 aCtx.rEngine.DupN(aN);
//#UC END# *90BD7A4A66F6_9A75B00E3D0A_impl*
end;//TkwDUPN.DUPN

procedure TkwDUPN.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9A75B00E3D0A_var*
//#UC END# *4DAEEDE10285_9A75B00E3D0A_var*
begin
//#UC START# *4DAEEDE10285_9A75B00E3D0A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9A75B00E3D0A_impl*
end;//TkwDUPN.DoDoIt

class function TkwDUPN.GetWordNameForRegister: AnsiString;
begin
 Result := 'DUPN';
end;//TkwDUPN.GetWordNameForRegister

function TkwDUPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9A75B00E3D0A_var*
//#UC END# *551544E2001A_9A75B00E3D0A_var*
begin
//#UC START# *551544E2001A_9A75B00E3D0A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9A75B00E3D0A_impl*
end;//TkwDUPN.GetResultTypeInfo

function TkwDUPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDUPN.GetAllParamsCount

function TkwDUPN.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9A75B00E3D0A_var*
//#UC END# *5617F4D00243_9A75B00E3D0A_var*
begin
//#UC START# *5617F4D00243_9A75B00E3D0A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9A75B00E3D0A_impl*
end;//TkwDUPN.ParamsTypes

procedure TkwDROPN.DROPN(const aCtx: TtfwContext;
 aN: Integer);
 {* Реализация слова скрипта DROPN }
//#UC START# *F080EC8A46A5_938A8F1CB0B1_var*
//#UC END# *F080EC8A46A5_938A8F1CB0B1_var*
begin
//#UC START# *F080EC8A46A5_938A8F1CB0B1_impl*
 aCtx.rEngine.DropN(aN);
//#UC END# *F080EC8A46A5_938A8F1CB0B1_impl*
end;//TkwDROPN.DROPN

procedure TkwDROPN.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_938A8F1CB0B1_var*
//#UC END# *4DAEEDE10285_938A8F1CB0B1_var*
begin
//#UC START# *4DAEEDE10285_938A8F1CB0B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_938A8F1CB0B1_impl*
end;//TkwDROPN.DoDoIt

class function TkwDROPN.GetWordNameForRegister: AnsiString;
begin
 Result := 'DROPN';
end;//TkwDROPN.GetWordNameForRegister

function TkwDROPN.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_938A8F1CB0B1_var*
//#UC END# *551544E2001A_938A8F1CB0B1_var*
begin
//#UC START# *551544E2001A_938A8F1CB0B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_938A8F1CB0B1_impl*
end;//TkwDROPN.GetResultTypeInfo

function TkwDROPN.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDROPN.GetAllParamsCount

function TkwDROPN.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_938A8F1CB0B1_var*
//#UC END# *5617F4D00243_938A8F1CB0B1_var*
begin
//#UC START# *5617F4D00243_938A8F1CB0B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_938A8F1CB0B1_impl*
end;//TkwDROPN.ParamsTypes

initialization
 TkwDefine.RegisterInEngine;
 {* Регистрация Define }
 TkwCompiledPushWord.RegisterClass;
 {* Регистрация TkwCompiledPushWord }
 TBasicsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TObject));
 {* Регистрация типа TObject }
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
 {* Регистрация типа TClass }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
 {* Регистрация типа ItfwParserEx }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptCaller));
 {* Регистрация типа ItfwScriptCaller }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptEngine));
 {* Регистрация типа ItfwScriptEngine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwStoredValuesStack));
 {* Регистрация типа ItfwStoredValuesStack }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
