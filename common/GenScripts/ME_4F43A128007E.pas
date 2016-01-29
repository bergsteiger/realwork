unit BasicsPack;

interface

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
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompiledPushWord
 
implementation

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
 TkwDefine = class(TtfwConstLike)
 end;//TkwDefine
 
 TBasicsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TBasicsPackResNameGetter
 
 TkwTrue = class(TtfwGlobalKeyWord)
  {* Слово скрипта true
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 true >>> l_Boolean
[code]  }
  function True(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта true }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTrue
 
 TkwFalse = class(TtfwGlobalKeyWord)
  {* Слово скрипта false
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 false >>> l_Boolean
[code]  }
  function False(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта false }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFalse
 
 TkwMsg = class(TtfwGlobalKeyWord)
  {* Слово скрипта Msg
*Пример:*
[code]
 aValue Msg
[code]  }
  procedure Msg(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта Msg }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMsg
 
 TkwPrint = class(TtfwGlobalKeyWord)
  {* Слово скрипта .
*Пример:*
[code]
 aValue .
[code]  }
  procedure Print(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта . }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPrint
 
 TkwLOOP = class(TtfwWordWorkerEx)
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
  procedure LOOP(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCount: Integer);
   {* Реализация слова скрипта LOOP }
 end;//TkwLOOP
 
 TkwWHILEDO = class(TtfwGlobalKeyWord)
  {* Слово скрипта WHILEDO
[panel]Цикл While. Повторяется пока выполняется некоторое условие.
Пример:
[code] 10 @ ( ?DUP !=0 ) @ ( DUP . -- ) WHILEDO [code]
Но ЛУЧШЕ пользоваться паскалеподобной конструкцией - WHILE[panel]
*Пример:*
[code]
 aCondition aWord WHILEDO
[code]  }
  procedure WHILEDO(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCondition: TtfwWord);
   {* Реализация слова скрипта WHILEDO }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWHILEDO
 
 TkwBREAK = class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK
[panel]Выход из цикла[panel]
*Пример:*
[code]
 BREAK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBREAK
 
 TkwCONTINUE = class(TtfwGlobalKeyWord)
  {* Слово скрипта CONTINUE
[panel]Переход к началу цикла[panel]
*Пример:*
[code]
 CONTINUE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCONTINUE
 
 TkwEXIT = class(TtfwGlobalKeyWord)
  {* Слово скрипта EXIT
[panel]Выход из процедуры[panel]
*Пример:*
[code]
 EXIT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEXIT
 
 TkwHALT = class(TtfwGlobalKeyWord)
  {* Слово скрипта HALT
[panel]Прервать выполяемый скрипт[panel]
*Пример:*
[code]
 HALT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwHALT
 
 TkwBREAKITERATOR = class(TtfwGlobalKeyWord)
  {* Слово скрипта BREAK-ITERATOR
*Пример:*
[code]
 BREAK-ITERATOR
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBREAKITERATOR
 
 TkwNOP = class(TtfwGlobalKeyWord)
  {* Слово скрипта NOP
*Пример:*
[code]
 NOP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNOP
 
 TkwSLEEP = class(TtfwGlobalKeyWord)
  {* Слово скрипта SLEEP
*Пример:*
[code]
 aDuration SLEEP
[code]  }
  procedure SLEEP(const aCtx: TtfwContext;
   aDuration: Integer);
   {* Реализация слова скрипта SLEEP }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSLEEP
 
 TkwProcessMessages = class(TtfwGlobalKeyWord)
  {* Слово скрипта ProcessMessages
*Пример:*
[code]
 ProcessMessages
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessMessages
 
 TkwCheckAssert = class(TtfwGlobalKeyWord)
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
  procedure CheckAssert(const aCtx: TtfwContext;
   aCondition: Boolean);
   {* Реализация слова скрипта ASSERT }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCheckAssert
 
 TkwASSERTS = class(TtfwGlobalKeyWord)
  {* Слово скрипта ASSERTS
[panel]Аналогичен Assert, но сообщение об ошибке берется из стека[panel]
*Пример:*
[code]
 aCondition aMsg ASSERTS
[code]  }
  procedure ASSERTS(const aCtx: TtfwContext;
   const aMsg: AnsiString;
   aCondition: Boolean);
   {* Реализация слова скрипта ASSERTS }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwASSERTS
 
 TkwNil = class(TtfwGlobalKeyWord)
  {* Слово скрипта nil
*Пример:*
[code]
 nil
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNil
 
 TkwDoWord = class(TtfwGlobalKeyWord)
  {* Слово скрипта DO
[panel]Исполняет скомпилированное слово.[panel]
*Пример:*
[code]
 aWord DO
[code]  }
  procedure DoWord(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* Реализация слова скрипта DO }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDoWord
 
 TkwSmartEquals = class(TtfwGlobalKeyWord)
  {* Слово скрипта ?==
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?== >>> l_Boolean
[code]  }
  function SmartEquals(const aCtx: TtfwContext;
   const aV1: TtfwStackValue;
   const aV2: TtfwStackValue): Boolean;
   {* Реализация слова скрипта ?== }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSmartEquals
 
 TkwSmartNotEquals = class(TtfwGlobalKeyWord)
  {* Слово скрипта ?!=
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?!= >>> l_Boolean
[code]  }
  function SmartNotEquals(const aCtx: TtfwContext;
   const aV1: TtfwStackValue;
   const aV2: TtfwStackValue): Boolean;
   {* Реализация слова скрипта ?!= }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSmartNotEquals
 
 TkwPushWord = class(TtfwWordWorkerEx)
  {* Слово скрипта @
[panel]Кладёт на стек адрес указанного слова[panel]
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 @ aWord >>> l_TtfwWord
[code]  }
  function PushWord(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* Реализация слова скрипта @ }
 end;//TkwPushWord
 
 TkwCurrentException = class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception
*Тип результата:* TObject
*Пример:*
[code]
OBJECT VAR l_TObject
 current:exception >>> l_TObject
[code]  }
  function current_exception(const aCtx: TtfwContext): TObject;
   {* Реализация слова скрипта current:exception }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentException
 
 TkwCurrentExceptionClass = class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:class
*Тип результата:* TClass
*Пример:*
[code]
CLASS VAR l_TClass
 current:exception:class >>> l_TClass
[code]  }
  function current_exception_class(const aCtx: TtfwContext): TClass;
   {* Реализация слова скрипта current:exception:class }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionClass
 
 TkwCurrentExceptionClassName = class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:ClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 current:exception:ClassName >>> l_String
[code]  }
  function current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта current:exception:ClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionClassName
 
 TkwCurrentExceptionMessage = class(TtfwGlobalKeyWord)
  {* Слово скрипта current:exception:Message
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 current:exception:Message >>> l_String
[code]  }
  function current_exception_Message(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта current:exception:Message }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionMessage
 
 TkwInc = class(TtfwGlobalKeyWord)
  {* Слово скрипта ++
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aValue ++ >>> l_Integer
[code]  }
  function Inc(const aCtx: TtfwContext;
   aValue: Integer): Integer;
   {* Реализация слова скрипта ++ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwInc
 
 TkwDec = class(TtfwGlobalKeyWord)
  {* Слово скрипта --
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aValue -- >>> l_Integer
[code]  }
  function Dec(const aCtx: TtfwContext;
   aValue: Integer): Integer;
   {* Реализация слова скрипта -- }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDec
 
 TkwAdd = class(TtfwGlobalKeyWord)
  {* Слово скрипта +
*Тип результата:* TtfwStackValue
*Пример:*
[code]
VAR l_TtfwStackValue
 aA aB + >>> l_TtfwStackValue
[code]  }
  function Add(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): TtfwStackValue;
   {* Реализация слова скрипта + }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwAdd
 
 TkwSub = class(TtfwGlobalKeyWord)
  {* Слово скрипта -
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB - >>> l_Integer
[code]  }
  function Sub(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта - }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSub
 
 TkwDivision = class(TtfwGlobalKeyWord)
  {* Слово скрипта DIV
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB DIV >>> l_Integer
[code]  }
  function Division(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта DIV }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDivision
 
 TkwMul = class(TtfwGlobalKeyWord)
  {* Слово скрипта *
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB * >>> l_Integer
[code]  }
  function Mul(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта * }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMul
 
 TkwDivide = class(TtfwGlobalKeyWord)
  {* Слово скрипта /
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB / >>> l_Integer
[code]  }
  function Divide(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта / }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDivide
 
 TkwMul2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2*
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA 2* >>> l_Integer
[code]  }
  function Mul2(const aCtx: TtfwContext;
   aA: Integer): Integer;
   {* Реализация слова скрипта 2* }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMul2
 
 TkwDiv2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2/
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA 2/ >>> l_Integer
[code]  }
  function Div2(const aCtx: TtfwContext;
   aA: Integer): Integer;
   {* Реализация слова скрипта 2/ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDiv2
 
 TkwMulDiv = class(TtfwGlobalKeyWord)
  {* Слово скрипта */
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB aC */ >>> l_Integer
[code]  }
  function MulDiv(const aCtx: TtfwContext;
   aC: Integer;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта */ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMulDiv
 
 TkwBoolNot = class(TtfwGlobalKeyWord)
  {* Слово скрипта !
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA ! >>> l_Boolean
[code]  }
  function BoolNot(const aCtx: TtfwContext;
   aA: Boolean): Boolean;
   {* Реализация слова скрипта ! }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolNot
 
 TkwModFromDiv = class(TtfwGlobalKeyWord)
  {* Слово скрипта MOD
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB MOD >>> l_Integer
[code]  }
  function ModFromDiv(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта MOD }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwModFromDiv
 
 TkwBoolAnd = class(TtfwGlobalKeyWord)
  {* Слово скрипта &&
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB && >>> l_Boolean
[code]  }
  function BoolAnd(const aCtx: TtfwContext;
   aB: Boolean;
   aA: Boolean): Boolean;
   {* Реализация слова скрипта && }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolAnd
 
 TkwBoolOr = class(TtfwGlobalKeyWord)
  {* Слово скрипта ||
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB || >>> l_Boolean
[code]  }
  function BoolOr(const aCtx: TtfwContext;
   aB: Boolean;
   aA: Boolean): Boolean;
   {* Реализация слова скрипта || }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolOr
 
 TkwNotZero = class(TtfwGlobalKeyWord)
  {* Слово скрипта !=0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA !=0 >>> l_Boolean
[code]  }
  function NotZero(const aCtx: TtfwContext;
   aA: Integer): Boolean;
   {* Реализация слова скрипта !=0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotZero
 
 TkwEqualZero = class(TtfwGlobalKeyWord)
  {* Слово скрипта =0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA =0 >>> l_Boolean
[code]  }
  function EqualZero(const aCtx: TtfwContext;
   aA: Integer): Boolean;
   {* Реализация слова скрипта =0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEqualZero
 
 TkwSWAP = class(TtfwGlobalKeyWord)
  {* Слово скрипта SWAP
*Пример:*
[code]
 SWAP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSWAP
 
 TkwDROP = class(TtfwGlobalKeyWord)
  {* Слово скрипта DROP
*Пример:*
[code]
 DROP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROP
 
 TkwDUP = class(TtfwGlobalKeyWord)
  {* Слово скрипта DUP
*Пример:*
[code]
 DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUP
 
 TkwDUPIfNotZero = class(TtfwGlobalKeyWord)
  {* Слово скрипта ?DUP
*Пример:*
[code]
 ?DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUPIfNotZero
 
 TkwROT = class(TtfwGlobalKeyWord)
  {* Слово скрипта ROT
[panel]Прокрутить три верхних элемента стека: ( x1 x2 x3 -- x2 x3 x1 )[panel]
*Пример:*
[code]
 ROT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwROT
 
 TkwPICK = class(TtfwGlobalKeyWord)
  {* Слово скрипта PICK
[panel]Формат: u PICK. 
Удаляет u. Копирует xu на вершину стека. ( xu ... x1 x0 u -- xu ... x1 x0 xu )[panel]
*Пример:*
[code]
 PICK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPICK
 
 TkwInvertROT = class(TtfwGlobalKeyWord)
  {* Слово скрипта -ROT
[panel]Прокрутить три верхних элемента стека: ( x1 x2 x3 -- x3 x1 x2 )[panel]
*Пример:*
[code]
 -ROT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwInvertROT
 
 TkwSWAP2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2SWAP
[panel]Меняет местами две верхних пары-ячеек. ( x1 x2 x3 x4 -- x3 x4 x1 x2 )[panel]
*Пример:*
[code]
 2SWAP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSWAP2
 
 TkwOVER2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2OVER
[panel]Копирует пару-ячеек x1 x2 на вершину стека. ( x1 x2 x3 x4 -- x1 x2 x3 x4 x1 x2 )[panel]
*Пример:*
[code]
 2OVER
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOVER2
 
 TkwDUP2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DUP
[panel]Дублирует пару-ячеек x1 x2. ( x1 x2 -- x1 x2 x1 x2 )[panel]
*Пример:*
[code]
 2DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUP2
 
 TkwDROP2 = class(TtfwGlobalKeyWord)
  {* Слово скрипта 2DROP
[panel]Удаляет пару-ячеек x1 x2 из стека. ( x1 x2 -- )[panel]
*Пример:*
[code]
 2DROP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROP2
 
 TkwNIP = class(TtfwGlobalKeyWord)
  {* Слово скрипта NIP
[panel]Удаляет первый элемент ниже вершины стека. ( x1 x2 -- x2 )[panel]
*Пример:*
[code]
 NIP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNIP
 
 TkwTUCK = class(TtfwGlobalKeyWord)
  {* Слово скрипта TUCK
[panel]Копирует верхний элемент стека ниже второго элемента стека. ( x1 x2 -- x2 x1 x2 )[panel]
*Пример:*
[code]
 TUCK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTUCK
 
 TkwOVER = class(TtfwGlobalKeyWord)
  {* Слово скрипта OVER
[panel]Помещает копию x1 на вершине стека. ( x1 x2 -- x1 x2 x1 )[panel]
*Пример:*
[code]
 OVER
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOVER
 
 TkwROLL = class(TtfwGlobalKeyWord)
  {* Слово скрипта ROLL
[panel]Формат: u ROLL. 
Убрать u. Повернуть u+1 элемент на вершине стека. ( xu xu-1 ... x0 u -- xu-1 ... x0 xu )[panel]
*Пример:*
[code]
 ROLL
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwROLL
 
 TkwNotEquals = class(TtfwGlobalKeyWord)
  {* Слово скрипта !=
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB != >>> l_Boolean
[code]  }
  function NotEquals(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* Реализация слова скрипта != }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotEquals
 
 TkwGREATER = class(TtfwGlobalKeyWord)
  {* Слово скрипта GREATER
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB GREATER >>> l_Boolean
[code]  }
  function GREATER(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* Реализация слова скрипта GREATER }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGREATER
 
 TkwLESS = class(TtfwGlobalKeyWord)
  {* Слово скрипта LESS
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB LESS >>> l_Boolean
[code]  }
  function LESS(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* Реализация слова скрипта LESS }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLESS
 
 TkwEquals = class(TtfwGlobalKeyWord)
  {* Слово скрипта ==
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aA aB == >>> l_Boolean
[code]  }
  function Equals(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* Реализация слова скрипта == }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEquals
 
 TkwLessThanZero = class(TtfwGlobalKeyWord)
  {* Слово скрипта <0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aB <0 >>> l_Boolean
[code]  }
  function LessThanZero(const aCtx: TtfwContext;
   aB: Integer): Boolean;
   {* Реализация слова скрипта <0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLessThanZero
 
 TkwGreaterThanZero = class(TtfwGlobalKeyWord)
  {* Слово скрипта >0
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aB >0 >>> l_Boolean
[code]  }
  function GreaterThanZero(const aCtx: TtfwContext;
   aB: Integer): Boolean;
   {* Реализация слова скрипта >0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGreaterThanZero
 
 TkwBitAnd = class(TtfwGlobalKeyWord)
  {* Слово скрипта &
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB & >>> l_Integer
[code]  }
  function BitAnd(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта & }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitAnd
 
 TkwBitOR = class(TtfwGlobalKeyWord)
  {* Слово скрипта |
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aA aB | >>> l_Integer
[code]  }
  function BitOR(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* Реализация слова скрипта | }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitOR
 
 TkwBitNot = class(TtfwGlobalKeyWord)
  {* Слово скрипта ~
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aB ~ >>> l_Integer
[code]  }
  function BitNot(const aCtx: TtfwContext;
   aB: Integer): Integer;
   {* Реализация слова скрипта ~ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitNot
 
 TkwStackLevel = class(TtfwGlobalKeyWord)
  {* Слово скрипта StackLevel
[panel]Текущий уровень стека[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 StackLevel >>> l_Integer
[code]  }
  function StackLevel(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта StackLevel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStackLevel
 
 TkwReduceStackLevel = class(TtfwGlobalKeyWord)
  {* Слово скрипта ReduceStackLevel
*Пример:*
[code]
 aValue ReduceStackLevel
[code]  }
  procedure ReduceStackLevel(const aCtx: TtfwContext;
   aValue: Integer);
   {* Реализация слова скрипта ReduceStackLevel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwReduceStackLevel
 
 TkwCtxParserPushString = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushString
*Пример:*
[code]
 aValue Ctx:Parser:PushString
[code]  }
  procedure Ctx_Parser_PushString(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* Реализация слова скрипта Ctx:Parser:PushString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushString
 
 TkwCtxParserPushSymbol = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushSymbol
*Пример:*
[code]
 aValue Ctx:Parser:PushSymbol
[code]  }
  procedure Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* Реализация слова скрипта Ctx:Parser:PushSymbol }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushSymbol
 
 TkwCtxParserPushInt = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser:PushInt
*Пример:*
[code]
 aValue Ctx:Parser:PushInt
[code]  }
  procedure Ctx_Parser_PushInt(const aCtx: TtfwContext;
   aValue: Integer);
   {* Реализация слова скрипта Ctx:Parser:PushInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushInt
 
 TkwCtxParser = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Parser
*Тип результата:* ItfwParserEx
*Пример:*
[code]
INTERFACE VAR l_ItfwParserEx
 Ctx:Parser >>> l_ItfwParserEx
[code]  }
  function Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
   {* Реализация слова скрипта Ctx:Parser }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParser
 
 TkwAtomicIf = class(TtfwWordWorkerEx)
  {* Слово скрипта ?
*Пример:*
[code]
 aCondition ? aWord
[code]  }
  procedure AtomicIf(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCondition: Boolean);
   {* Реализация слова скрипта ? }
 end;//TkwAtomicIf
 
 TkwCompileValue = class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileValue
*Пример:*
[code]
 aValue CompileValue
[code]  }
  procedure CompileValue(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта CompileValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileValue
 
 TkwIMMEDIATE = class(TtfwGlobalKeyWord)
  {* Слово скрипта IMMEDIATE
*Пример:*
[code]
 IMMEDIATE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIMMEDIATE
 
 TkwCtxScriptCaller = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:ScriptCaller
*Тип результата:* ItfwScriptCaller
*Пример:*
[code]
INTERFACE VAR l_ItfwScriptCaller
 Ctx:ScriptCaller >>> l_ItfwScriptCaller
[code]  }
  function Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
   {* Реализация слова скрипта Ctx:ScriptCaller }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxScriptCaller
 
 TkwCtxEngine = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:Engine
*Тип результата:* ItfwScriptEngine
*Пример:*
[code]
INTERFACE VAR l_ItfwScriptEngine
 Ctx:Engine >>> l_ItfwScriptEngine
[code]  }
  function Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
   {* Реализация слова скрипта Ctx:Engine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxEngine
 
 TkwCtxStoredValuesStack = class(TtfwGlobalKeyWord)
  {* Слово скрипта Ctx:StoredValuesStack
*Тип результата:* ItfwStoredValuesStack
*Пример:*
[code]
INTERFACE VAR l_ItfwStoredValuesStack
 Ctx:StoredValuesStack >>> l_ItfwStoredValuesStack
[code]  }
  function Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
   {* Реализация слова скрипта Ctx:StoredValuesStack }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxStoredValuesStack
 
 TkwCreateAndRaise = class(TtfwGlobalKeyWord)
  {* Слово скрипта CreateAndRaise
[panel]Возбуждает исключение указаного класса aClass с сообщением aMessage[panel]
*Пример:*
[code]
 aMessage aClass CreateAndRaise
[code]  }
  procedure CreateAndRaise(const aCtx: TtfwContext;
   aClass: TClass;
   const aMessage: AnsiString);
   {* Реализация слова скрипта CreateAndRaise }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCreateAndRaise
 
 TkwCompileRef = class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileRef
*Пример:*
[code]
 aValue CompileRef
[code]  }
  procedure CompileRef(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта CompileRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileRef
 
 TkwCompileWeakRef = class(TtfwGlobalKeyWord)
  {* Слово скрипта CompileWeakRef
*Пример:*
[code]
 aValue CompileWeakRef
[code]  }
  procedure CompileWeakRef(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта CompileWeakRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileWeakRef
 
 TkwDUPN = class(TtfwGlobalKeyWord)
  {* Слово скрипта DUPN
*Пример:*
[code]
 aN DUPN
[code]  }
  procedure DUPN(const aCtx: TtfwContext;
   aN: Integer);
   {* Реализация слова скрипта DUPN }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUPN
 
 TkwDROPN = class(TtfwGlobalKeyWord)
  {* Слово скрипта DROPN
*Пример:*
[code]
 aN DROPN
[code]  }
  procedure DROPN(const aCtx: TtfwContext;
   aN: Integer);
   {* Реализация слова скрипта DROPN }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROPN
 
end.
