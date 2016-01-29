unit tfwValueStack;

interface

uses
 l3IntfUses
 , tfwValueList
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , l3Interfaces
 , l3Variant
 , Types
 , TypInfo
;

type
 TtfwValueStack = class(TtfwValueList)
  {* Стек переменных. Сюда помещаются/выводятся переменные при исполнении скрипта. }
  function PrevTop(aDelta: Integer;
   aNeedPop: Boolean): TtfwStackValue;
   {* Получить значение предшествующее верхнему. }
  function pLast: PtfwStackValue;
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
  procedure PushString(const aString: AnsiString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(aString: Tl3PrimString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  procedure Dup;
  procedure Drop;
  procedure Swap;
  procedure Push(const aValue: TtfwStackValue);
  function Pop: TtfwStackValue;
  function IsTopType(aType: TtfwValueType): Boolean;
  procedure PushObj(aValue: TObject);
  function PopObj: TObject;
  procedure DupIfNotZero;
  procedure Rot;
  procedure Pick;
  procedure InvertRot;
  procedure Swap2;
  procedure Over2;
  procedure Dup2;
  procedure Drop2;
  procedure Nip;
  procedure Tuck;
  procedure Over;
  procedure Roll;
  function PopIntf(const aGUID: TGUID): IUnknown; overload;
  function PopIntf: IUnknown; overload;
  function IsTopIntf: Boolean;
   {* Определяет - лежит ли на верхушке стека интерфейс }
  function ValuesCount: Integer;
  procedure PushString(const aString: Tl3WString); overload;
  procedure PushFile(const aFile: ItfwFile);
  function PopFile: ItfwFile;
  function IsTopObj: Boolean;
  function IsTopChar: Boolean;
  procedure PushChar(aChar: AnsiChar);
  function PopChar: AnsiChar;
  procedure PushWStr(const aStr: Tl3WString);
  function PopPrintable: Il3CString;
  procedure PushClass(aClass: TClass);
  function PopClass: TClass;
  function IsTopClass: Boolean;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
 end;//TtfwValueStack
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3StringEx
;

end.
