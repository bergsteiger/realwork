unit System;

interface

uses
 l3IntfUses
;

type
 TObject = class
  function NewInstance: TObject;
  procedure FreeInstance;
  procedure Create;
  procedure BeforeDestruction;
  procedure Destroy;
  procedure AfterConstruction;
   {* AfterConstruction is called automatically after the object’s last constructor has executed. Do not call it explicitly in your applications.

The AfterConstruction method implemented in TObject does nothing. Override this method when creating a class that takes some action after the object is created. For example, TCustomForm overrides AfterConstruction to generate an OnCreate event. }
 end;//TObject
 
 TInterfacedObject = class(TObject)
 end;//TInterfacedObject
 
 Text = record
 end;//Text
 
 // TObject
 
 TClass = class of TObject;
  {* Сылка на RTTI класса. }
 
 Variant = record
 end;//Variant
 
 HResult = Cardinal;
 
 hResult = HResult;
 
 Longword = Cardinal;
 
 WideString = a-wstring;
 
 Integer = Integer;
 
 Pointer = pointer;
 
 Cardinal = Cardinal;
  {* Беззнаковое 32-битное целое. }
 
 LongWord = Cardinal;
 
 Boolean = Boolean;
 
 array [Boolean] of Integer = array [Boolean] of Integer;
 
 PBoolean = ^Boolean;
 
 AnsiChar = AnsiChar;
 
 ShortInt = AnsiChar;
 
 TDateTime = double;
  {* дата/время }
 
 Double = double;
 
 IUnknown = IUnknown;
  {* Базовый интерфейс. }
 
 array of IUnknown = array of IUnknown;
 
 IDispatch = interface
 end;//IDispatch
 
 WordBool = Boolean;
 
 TGUID = record
  {* GUID. }
 end;//TGUID
 
 PGUID = ^TGUID;
 
 PLongint = ^Integer;
 
 Int64 = Int64;
  {* 64-битное целое. }
 
 byte = octet;
  {* байт }
 
 Byte = octet;
  {* байт }
 
 Word = unsigned short;
 
 AnsiString = AnsiString;
  {* Стандартный строковый тип Delphi. }
 
 PAnsiChar = PAnsiChar;
  {* Нуль-терминированная строка. }
 
 AnsiString = AnsiString;
 
 OleVariant = record
  {* The OleVariant type exists on both the Windows and Linux platforms. The main difference between Variant and OleVariant is that Variant can contain data types that only the current application knows what to do with. OleVariant can only contain the data types defined as compatible with OLE Automation which means that the data types that can be passed between programs or across the network without worrying about whether the other end will know how to handle the data.

When you assign a Variant that contains custom data (such as a Delphi string, or a one of the new custom variant types) to an OleVariant, the runtime library tries to convert the Variant into one of the OleVariant standard data types (such as a Delphi string converts to an OLE BSTR string). For example, if a variant containing an AnsiString is assigned to an OleVariant, the AnsiString becomes a WideString. The same is true when passing a Variant to an OleVariant function parameter. }
 end;//OleVariant
 
 array of AnsiString = array of AnsiString;
  {* открытый массив строк }
 
 (*
 MIUnknown = interface
  function __AddRef: Integer; stdcall;
   {* Увеличивает счетчик ссылок. }
  function __Release: Integer; stdcall;
   {* Уменьшает счетчик ссылок. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//MIUnknown
 *)
 
 SmallInt = short;
 
 TResStringRec = record
 end;//TResStringRec
 
 PResStringRec = ^TResStringRec;
 
 TVarRec = record
 end;//TVarRec
 
 array of const = array of ;
 
 TextFile = (
 );//TextFile
 
 ANSIString = AnsiString;
 
 single = ;
 
 WideChar = wchar;
 
 array of WideString = array of WideString;
 
 LongInt = Integer;
 
 ByteBool = ;
 
 LongBool = Boolean;
 
 PWideChar = ^WideChar;
 
 String = AnsiString;
 
 PChar = PAnsiChar;
 
 array of String = array of String;
 
 Char = WideChar;
 
 IUnknown = interface
  {* Реальная реализация интерфейса IUnknown. }
  function __AddRef: Integer; stdcall;
   {* Увеличивает счетчик ссылок. }
  function __Release: Integer; stdcall;
   {* Уменьшает счетчик ссылок. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//IUnknown
 
 PANSIChar = PAnsiChar;
 
 ShortString = ;
 
 array of TClass = array of TClass;
 
 Single = float;
 
 PAnsiChar = PANSIChar;
 
implementation

uses
 l3ImplUses
 , ObjectFromstackWords
;

end.
