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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TBasicsPackResNameGetter
 
 TkwTrue = class(TtfwGlobalKeyWord)
  {* ����� ������� true
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 true >>> l_Boolean
[code]  }
  function True(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� true }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTrue
 
 TkwFalse = class(TtfwGlobalKeyWord)
  {* ����� ������� false
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 false >>> l_Boolean
[code]  }
  function False(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� false }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFalse
 
 TkwMsg = class(TtfwGlobalKeyWord)
  {* ����� ������� Msg
*������:*
[code]
 aValue Msg
[code]  }
  procedure Msg(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� Msg }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMsg
 
 TkwPrint = class(TtfwGlobalKeyWord)
  {* ����� ������� .
*������:*
[code]
 aValue .
[code]  }
  procedure Print(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� . }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPrint
 
 TkwLOOP = class(TtfwWordWorkerEx)
  {* ����� ������� LOOP
[panel]���� LOOP.
������:
[code]
 10 LOOP ( 'Hello' . )
[code][panel]
*������:*
[code]
 aCount LOOP aWord
[code]  }
  procedure LOOP(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCount: Integer);
   {* ���������� ����� ������� LOOP }
 end;//TkwLOOP
 
 TkwWHILEDO = class(TtfwGlobalKeyWord)
  {* ����� ������� WHILEDO
[panel]���� While. ����������� ���� ����������� ��������� �������.
������:
[code] 10 @ ( ?DUP !=0 ) @ ( DUP . -- ) WHILEDO [code]
�� ����� ������������ ��������������� ������������ - WHILE[panel]
*������:*
[code]
 aCondition aWord WHILEDO
[code]  }
  procedure WHILEDO(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCondition: TtfwWord);
   {* ���������� ����� ������� WHILEDO }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWHILEDO
 
 TkwBREAK = class(TtfwGlobalKeyWord)
  {* ����� ������� BREAK
[panel]����� �� �����[panel]
*������:*
[code]
 BREAK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBREAK
 
 TkwCONTINUE = class(TtfwGlobalKeyWord)
  {* ����� ������� CONTINUE
[panel]������� � ������ �����[panel]
*������:*
[code]
 CONTINUE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCONTINUE
 
 TkwEXIT = class(TtfwGlobalKeyWord)
  {* ����� ������� EXIT
[panel]����� �� ���������[panel]
*������:*
[code]
 EXIT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEXIT
 
 TkwHALT = class(TtfwGlobalKeyWord)
  {* ����� ������� HALT
[panel]�������� ���������� ������[panel]
*������:*
[code]
 HALT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwHALT
 
 TkwBREAKITERATOR = class(TtfwGlobalKeyWord)
  {* ����� ������� BREAK-ITERATOR
*������:*
[code]
 BREAK-ITERATOR
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBREAKITERATOR
 
 TkwNOP = class(TtfwGlobalKeyWord)
  {* ����� ������� NOP
*������:*
[code]
 NOP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNOP
 
 TkwSLEEP = class(TtfwGlobalKeyWord)
  {* ����� ������� SLEEP
*������:*
[code]
 aDuration SLEEP
[code]  }
  procedure SLEEP(const aCtx: TtfwContext;
   aDuration: Integer);
   {* ���������� ����� ������� SLEEP }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSLEEP
 
 TkwProcessMessages = class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessMessages
*������:*
[code]
 ProcessMessages
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessMessages
 
 TkwCheckAssert = class(TtfwGlobalKeyWord)
  {* ����� ������� ASSERT
[panel]������� Assert.
������:
[code]
 waited:? ASSERT
[code][panel]
*������:*
[code]
 aCondition ASSERT
[code]  }
  procedure CheckAssert(const aCtx: TtfwContext;
   aCondition: Boolean);
   {* ���������� ����� ������� ASSERT }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCheckAssert
 
 TkwASSERTS = class(TtfwGlobalKeyWord)
  {* ����� ������� ASSERTS
[panel]���������� Assert, �� ��������� �� ������ ������� �� �����[panel]
*������:*
[code]
 aCondition aMsg ASSERTS
[code]  }
  procedure ASSERTS(const aCtx: TtfwContext;
   const aMsg: AnsiString;
   aCondition: Boolean);
   {* ���������� ����� ������� ASSERTS }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwASSERTS
 
 TkwNil = class(TtfwGlobalKeyWord)
  {* ����� ������� nil
*������:*
[code]
 nil
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNil
 
 TkwDoWord = class(TtfwGlobalKeyWord)
  {* ����� ������� DO
[panel]��������� ���������������� �����.[panel]
*������:*
[code]
 aWord DO
[code]  }
  procedure DoWord(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* ���������� ����� ������� DO }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDoWord
 
 TkwSmartEquals = class(TtfwGlobalKeyWord)
  {* ����� ������� ?==
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?== >>> l_Boolean
[code]  }
  function SmartEquals(const aCtx: TtfwContext;
   const aV1: TtfwStackValue;
   const aV2: TtfwStackValue): Boolean;
   {* ���������� ����� ������� ?== }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSmartEquals
 
 TkwSmartNotEquals = class(TtfwGlobalKeyWord)
  {* ����� ������� ?!=
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aV2 aV1 ?!= >>> l_Boolean
[code]  }
  function SmartNotEquals(const aCtx: TtfwContext;
   const aV1: TtfwStackValue;
   const aV2: TtfwStackValue): Boolean;
   {* ���������� ����� ������� ?!= }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSmartNotEquals
 
 TkwPushWord = class(TtfwWordWorkerEx)
  {* ����� ������� @
[panel]����� �� ���� ����� ���������� �����[panel]
*��� ����������:* TtfwWord
*������:*
[code]
OBJECT VAR l_TtfwWord
 @ aWord >>> l_TtfwWord
[code]  }
  function PushWord(const aCtx: TtfwContext;
   aWord: TtfwWord): TtfwWord;
   {* ���������� ����� ������� @ }
 end;//TkwPushWord
 
 TkwCurrentException = class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception
*��� ����������:* TObject
*������:*
[code]
OBJECT VAR l_TObject
 current:exception >>> l_TObject
[code]  }
  function current_exception(const aCtx: TtfwContext): TObject;
   {* ���������� ����� ������� current:exception }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentException
 
 TkwCurrentExceptionClass = class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:class
*��� ����������:* TClass
*������:*
[code]
CLASS VAR l_TClass
 current:exception:class >>> l_TClass
[code]  }
  function current_exception_class(const aCtx: TtfwContext): TClass;
   {* ���������� ����� ������� current:exception:class }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionClass
 
 TkwCurrentExceptionClassName = class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:ClassName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 current:exception:ClassName >>> l_String
[code]  }
  function current_exception_ClassName(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� current:exception:ClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionClassName
 
 TkwCurrentExceptionMessage = class(TtfwGlobalKeyWord)
  {* ����� ������� current:exception:Message
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 current:exception:Message >>> l_String
[code]  }
  function current_exception_Message(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� current:exception:Message }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCurrentExceptionMessage
 
 TkwInc = class(TtfwGlobalKeyWord)
  {* ����� ������� ++
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aValue ++ >>> l_Integer
[code]  }
  function Inc(const aCtx: TtfwContext;
   aValue: Integer): Integer;
   {* ���������� ����� ������� ++ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwInc
 
 TkwDec = class(TtfwGlobalKeyWord)
  {* ����� ������� --
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aValue -- >>> l_Integer
[code]  }
  function Dec(const aCtx: TtfwContext;
   aValue: Integer): Integer;
   {* ���������� ����� ������� -- }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDec
 
 TkwAdd = class(TtfwGlobalKeyWord)
  {* ����� ������� +
*��� ����������:* TtfwStackValue
*������:*
[code]
VAR l_TtfwStackValue
 aA aB + >>> l_TtfwStackValue
[code]  }
  function Add(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): TtfwStackValue;
   {* ���������� ����� ������� + }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwAdd
 
 TkwSub = class(TtfwGlobalKeyWord)
  {* ����� ������� -
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB - >>> l_Integer
[code]  }
  function Sub(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� - }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSub
 
 TkwDivision = class(TtfwGlobalKeyWord)
  {* ����� ������� DIV
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB DIV >>> l_Integer
[code]  }
  function Division(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� DIV }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDivision
 
 TkwMul = class(TtfwGlobalKeyWord)
  {* ����� ������� *
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB * >>> l_Integer
[code]  }
  function Mul(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� * }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMul
 
 TkwDivide = class(TtfwGlobalKeyWord)
  {* ����� ������� /
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB / >>> l_Integer
[code]  }
  function Divide(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� / }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDivide
 
 TkwMul2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2*
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA 2* >>> l_Integer
[code]  }
  function Mul2(const aCtx: TtfwContext;
   aA: Integer): Integer;
   {* ���������� ����� ������� 2* }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMul2
 
 TkwDiv2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2/
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA 2/ >>> l_Integer
[code]  }
  function Div2(const aCtx: TtfwContext;
   aA: Integer): Integer;
   {* ���������� ����� ������� 2/ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDiv2
 
 TkwMulDiv = class(TtfwGlobalKeyWord)
  {* ����� ������� */
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB aC */ >>> l_Integer
[code]  }
  function MulDiv(const aCtx: TtfwContext;
   aC: Integer;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� */ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMulDiv
 
 TkwBoolNot = class(TtfwGlobalKeyWord)
  {* ����� ������� !
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA ! >>> l_Boolean
[code]  }
  function BoolNot(const aCtx: TtfwContext;
   aA: Boolean): Boolean;
   {* ���������� ����� ������� ! }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolNot
 
 TkwModFromDiv = class(TtfwGlobalKeyWord)
  {* ����� ������� MOD
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB MOD >>> l_Integer
[code]  }
  function ModFromDiv(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� MOD }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwModFromDiv
 
 TkwBoolAnd = class(TtfwGlobalKeyWord)
  {* ����� ������� &&
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB && >>> l_Boolean
[code]  }
  function BoolAnd(const aCtx: TtfwContext;
   aB: Boolean;
   aA: Boolean): Boolean;
   {* ���������� ����� ������� && }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolAnd
 
 TkwBoolOr = class(TtfwGlobalKeyWord)
  {* ����� ������� ||
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB || >>> l_Boolean
[code]  }
  function BoolOr(const aCtx: TtfwContext;
   aB: Boolean;
   aA: Boolean): Boolean;
   {* ���������� ����� ������� || }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBoolOr
 
 TkwNotZero = class(TtfwGlobalKeyWord)
  {* ����� ������� !=0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA !=0 >>> l_Boolean
[code]  }
  function NotZero(const aCtx: TtfwContext;
   aA: Integer): Boolean;
   {* ���������� ����� ������� !=0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotZero
 
 TkwEqualZero = class(TtfwGlobalKeyWord)
  {* ����� ������� =0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA =0 >>> l_Boolean
[code]  }
  function EqualZero(const aCtx: TtfwContext;
   aA: Integer): Boolean;
   {* ���������� ����� ������� =0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEqualZero
 
 TkwSWAP = class(TtfwGlobalKeyWord)
  {* ����� ������� SWAP
*������:*
[code]
 SWAP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSWAP
 
 TkwDROP = class(TtfwGlobalKeyWord)
  {* ����� ������� DROP
*������:*
[code]
 DROP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROP
 
 TkwDUP = class(TtfwGlobalKeyWord)
  {* ����� ������� DUP
*������:*
[code]
 DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUP
 
 TkwDUPIfNotZero = class(TtfwGlobalKeyWord)
  {* ����� ������� ?DUP
*������:*
[code]
 ?DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUPIfNotZero
 
 TkwROT = class(TtfwGlobalKeyWord)
  {* ����� ������� ROT
[panel]���������� ��� ������� �������� �����: ( x1 x2 x3 -- x2 x3 x1 )[panel]
*������:*
[code]
 ROT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwROT
 
 TkwPICK = class(TtfwGlobalKeyWord)
  {* ����� ������� PICK
[panel]������: u PICK. 
������� u. �������� xu �� ������� �����. ( xu ... x1 x0 u -- xu ... x1 x0 xu )[panel]
*������:*
[code]
 PICK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPICK
 
 TkwInvertROT = class(TtfwGlobalKeyWord)
  {* ����� ������� -ROT
[panel]���������� ��� ������� �������� �����: ( x1 x2 x3 -- x3 x1 x2 )[panel]
*������:*
[code]
 -ROT
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwInvertROT
 
 TkwSWAP2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2SWAP
[panel]������ ������� ��� ������� ����-�����. ( x1 x2 x3 x4 -- x3 x4 x1 x2 )[panel]
*������:*
[code]
 2SWAP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSWAP2
 
 TkwOVER2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2OVER
[panel]�������� ����-����� x1 x2 �� ������� �����. ( x1 x2 x3 x4 -- x1 x2 x3 x4 x1 x2 )[panel]
*������:*
[code]
 2OVER
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOVER2
 
 TkwDUP2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2DUP
[panel]��������� ����-����� x1 x2. ( x1 x2 -- x1 x2 x1 x2 )[panel]
*������:*
[code]
 2DUP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUP2
 
 TkwDROP2 = class(TtfwGlobalKeyWord)
  {* ����� ������� 2DROP
[panel]������� ����-����� x1 x2 �� �����. ( x1 x2 -- )[panel]
*������:*
[code]
 2DROP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROP2
 
 TkwNIP = class(TtfwGlobalKeyWord)
  {* ����� ������� NIP
[panel]������� ������ ������� ���� ������� �����. ( x1 x2 -- x2 )[panel]
*������:*
[code]
 NIP
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNIP
 
 TkwTUCK = class(TtfwGlobalKeyWord)
  {* ����� ������� TUCK
[panel]�������� ������� ������� ����� ���� ������� �������� �����. ( x1 x2 -- x2 x1 x2 )[panel]
*������:*
[code]
 TUCK
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTUCK
 
 TkwOVER = class(TtfwGlobalKeyWord)
  {* ����� ������� OVER
[panel]�������� ����� x1 �� ������� �����. ( x1 x2 -- x1 x2 x1 )[panel]
*������:*
[code]
 OVER
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOVER
 
 TkwROLL = class(TtfwGlobalKeyWord)
  {* ����� ������� ROLL
[panel]������: u ROLL. 
������ u. ��������� u+1 ������� �� ������� �����. ( xu xu-1 ... x0 u -- xu-1 ... x0 xu )[panel]
*������:*
[code]
 ROLL
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwROLL
 
 TkwNotEquals = class(TtfwGlobalKeyWord)
  {* ����� ������� !=
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB != >>> l_Boolean
[code]  }
  function NotEquals(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* ���������� ����� ������� != }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNotEquals
 
 TkwGREATER = class(TtfwGlobalKeyWord)
  {* ����� ������� GREATER
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB GREATER >>> l_Boolean
[code]  }
  function GREATER(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* ���������� ����� ������� GREATER }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGREATER
 
 TkwLESS = class(TtfwGlobalKeyWord)
  {* ����� ������� LESS
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB LESS >>> l_Boolean
[code]  }
  function LESS(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* ���������� ����� ������� LESS }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLESS
 
 TkwEquals = class(TtfwGlobalKeyWord)
  {* ����� ������� ==
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aA aB == >>> l_Boolean
[code]  }
  function Equals(const aCtx: TtfwContext;
   const aB: TtfwStackValue;
   const aA: TtfwStackValue): Boolean;
   {* ���������� ����� ������� == }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEquals
 
 TkwLessThanZero = class(TtfwGlobalKeyWord)
  {* ����� ������� <0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aB <0 >>> l_Boolean
[code]  }
  function LessThanZero(const aCtx: TtfwContext;
   aB: Integer): Boolean;
   {* ���������� ����� ������� <0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLessThanZero
 
 TkwGreaterThanZero = class(TtfwGlobalKeyWord)
  {* ����� ������� >0
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aB >0 >>> l_Boolean
[code]  }
  function GreaterThanZero(const aCtx: TtfwContext;
   aB: Integer): Boolean;
   {* ���������� ����� ������� >0 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGreaterThanZero
 
 TkwBitAnd = class(TtfwGlobalKeyWord)
  {* ����� ������� &
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB & >>> l_Integer
[code]  }
  function BitAnd(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� & }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitAnd
 
 TkwBitOR = class(TtfwGlobalKeyWord)
  {* ����� ������� |
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aA aB | >>> l_Integer
[code]  }
  function BitOR(const aCtx: TtfwContext;
   aB: Integer;
   aA: Integer): Integer;
   {* ���������� ����� ������� | }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitOR
 
 TkwBitNot = class(TtfwGlobalKeyWord)
  {* ����� ������� ~
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aB ~ >>> l_Integer
[code]  }
  function BitNot(const aCtx: TtfwContext;
   aB: Integer): Integer;
   {* ���������� ����� ������� ~ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwBitNot
 
 TkwStackLevel = class(TtfwGlobalKeyWord)
  {* ����� ������� StackLevel
[panel]������� ������� �����[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 StackLevel >>> l_Integer
[code]  }
  function StackLevel(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� StackLevel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStackLevel
 
 TkwReduceStackLevel = class(TtfwGlobalKeyWord)
  {* ����� ������� ReduceStackLevel
*������:*
[code]
 aValue ReduceStackLevel
[code]  }
  procedure ReduceStackLevel(const aCtx: TtfwContext;
   aValue: Integer);
   {* ���������� ����� ������� ReduceStackLevel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwReduceStackLevel
 
 TkwCtxParserPushString = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushString
*������:*
[code]
 aValue Ctx:Parser:PushString
[code]  }
  procedure Ctx_Parser_PushString(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* ���������� ����� ������� Ctx:Parser:PushString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushString
 
 TkwCtxParserPushSymbol = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushSymbol
*������:*
[code]
 aValue Ctx:Parser:PushSymbol
[code]  }
  procedure Ctx_Parser_PushSymbol(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* ���������� ����� ������� Ctx:Parser:PushSymbol }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushSymbol
 
 TkwCtxParserPushInt = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser:PushInt
*������:*
[code]
 aValue Ctx:Parser:PushInt
[code]  }
  procedure Ctx_Parser_PushInt(const aCtx: TtfwContext;
   aValue: Integer);
   {* ���������� ����� ������� Ctx:Parser:PushInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParserPushInt
 
 TkwCtxParser = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Parser
*��� ����������:* ItfwParserEx
*������:*
[code]
INTERFACE VAR l_ItfwParserEx
 Ctx:Parser >>> l_ItfwParserEx
[code]  }
  function Ctx_Parser(const aCtx: TtfwContext): ItfwParserEx;
   {* ���������� ����� ������� Ctx:Parser }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxParser
 
 TkwAtomicIf = class(TtfwWordWorkerEx)
  {* ����� ������� ?
*������:*
[code]
 aCondition ? aWord
[code]  }
  procedure AtomicIf(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aCondition: Boolean);
   {* ���������� ����� ������� ? }
 end;//TkwAtomicIf
 
 TkwCompileValue = class(TtfwGlobalKeyWord)
  {* ����� ������� CompileValue
*������:*
[code]
 aValue CompileValue
[code]  }
  procedure CompileValue(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� CompileValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileValue
 
 TkwIMMEDIATE = class(TtfwGlobalKeyWord)
  {* ����� ������� IMMEDIATE
*������:*
[code]
 IMMEDIATE
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIMMEDIATE
 
 TkwCtxScriptCaller = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:ScriptCaller
*��� ����������:* ItfwScriptCaller
*������:*
[code]
INTERFACE VAR l_ItfwScriptCaller
 Ctx:ScriptCaller >>> l_ItfwScriptCaller
[code]  }
  function Ctx_ScriptCaller(const aCtx: TtfwContext): ItfwScriptCaller;
   {* ���������� ����� ������� Ctx:ScriptCaller }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxScriptCaller
 
 TkwCtxEngine = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:Engine
*��� ����������:* ItfwScriptEngine
*������:*
[code]
INTERFACE VAR l_ItfwScriptEngine
 Ctx:Engine >>> l_ItfwScriptEngine
[code]  }
  function Ctx_Engine(const aCtx: TtfwContext): ItfwScriptEngine;
   {* ���������� ����� ������� Ctx:Engine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxEngine
 
 TkwCtxStoredValuesStack = class(TtfwGlobalKeyWord)
  {* ����� ������� Ctx:StoredValuesStack
*��� ����������:* ItfwStoredValuesStack
*������:*
[code]
INTERFACE VAR l_ItfwStoredValuesStack
 Ctx:StoredValuesStack >>> l_ItfwStoredValuesStack
[code]  }
  function Ctx_StoredValuesStack(const aCtx: TtfwContext): ItfwStoredValuesStack;
   {* ���������� ����� ������� Ctx:StoredValuesStack }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCtxStoredValuesStack
 
 TkwCreateAndRaise = class(TtfwGlobalKeyWord)
  {* ����� ������� CreateAndRaise
[panel]���������� ���������� ��������� ������ aClass � ���������� aMessage[panel]
*������:*
[code]
 aMessage aClass CreateAndRaise
[code]  }
  procedure CreateAndRaise(const aCtx: TtfwContext;
   aClass: TClass;
   const aMessage: AnsiString);
   {* ���������� ����� ������� CreateAndRaise }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCreateAndRaise
 
 TkwCompileRef = class(TtfwGlobalKeyWord)
  {* ����� ������� CompileRef
*������:*
[code]
 aValue CompileRef
[code]  }
  procedure CompileRef(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� CompileRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileRef
 
 TkwCompileWeakRef = class(TtfwGlobalKeyWord)
  {* ����� ������� CompileWeakRef
*������:*
[code]
 aValue CompileWeakRef
[code]  }
  procedure CompileWeakRef(const aCtx: TtfwContext;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� CompileWeakRef }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompileWeakRef
 
 TkwDUPN = class(TtfwGlobalKeyWord)
  {* ����� ������� DUPN
*������:*
[code]
 aN DUPN
[code]  }
  procedure DUPN(const aCtx: TtfwContext;
   aN: Integer);
   {* ���������� ����� ������� DUPN }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDUPN
 
 TkwDROPN = class(TtfwGlobalKeyWord)
  {* ����� ������� DROPN
*������:*
[code]
 aN DROPN
[code]  }
  procedure DROPN(const aCtx: TtfwContext;
   aN: Integer);
   {* ���������� ����� ������� DROPN }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDROPN
 
end.
