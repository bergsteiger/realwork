unit CsDataPipePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsDataPipePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Core::TCsDataPipePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  CsCommon,
  IdIOHandler,
  csIdIOHandlerAbstractAdapterPrim,
  csIdIOHandlerAbstractAdapter,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
const
  { Constants }
 c_MaxDataStringLength = 4 * 1024;
 c_NoMoreFiles = '<>';

type
 TCsDataPipePrim = class(TcsIdIOHandlerAbstractAdapterPrim)
 private
 // private fields
   f_ClientID : TCsClientId;
    {* Поле для свойства ClientID}
   f_IOHandler : TcsIdIOHandlerAbstractAdapter;
    {* Поле для свойства IOHandler}
 protected
 // realized methods
   procedure WriteBufferFlush; override;
   function ReadChar: AnsiChar; override;
   function ReadCardinal: Cardinal; override;
   function ReadDateTime: TDateTime; override;
   function ReadLn: AnsiString; override;
   function ReadInt64: Int64; override;
   procedure ReadStream(aStream: TStream;
     aSize: Int64 = -1); override;
   function ReadInteger: Integer; override;
   function ReadSmallInt: SmallInt; override;
   procedure WriteLn(const aString: AnsiString); override;
   procedure WriteCardinal(aValue: Cardinal); override;
   procedure WriteInt64(aValue: Int64); override;
   procedure WriteStream(aStream: TStream;
     aByteCount: Int64 = 0); override;
   procedure WriteChar(aValue: AnsiChar); override;
   procedure WriteSmallInt(aValue: SmallInt); override;
   procedure WriteInteger(aValue: Integer); override;
   procedure WriteDateTime(aValue: TDateTime); override;
   function WaitForReadData(aTimeout: Integer): Boolean; override;
   procedure WriteLargeStr(const aString: AnsiString); override;
   function ReadLargeStr: AnsiString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aIOHandler: TcsIdIOHandlerAbstractAdapter); reintroduce; overload; 
   constructor Create(aIOHandler: TIdIOHandler); overload; 
 public
 // public properties
   property ClientID: TCsClientId
     read f_ClientID
     write f_ClientID;
   property IOHandler: TcsIdIOHandlerAbstractAdapter
     read f_IOHandler;
     {* Пока торчит наружу до перехода на постоянно живущее соединение (для подделки протокола) }
 end;//TCsDataPipePrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csIdIOHandlerAdapter,
  SysUtils,
  StrUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TCsDataPipePrim

constructor TCsDataPipePrim.Create(aIOHandler: TcsIdIOHandlerAbstractAdapter);
//#UC START# *538DC49700E1_538DC31F03A5_var*
//#UC END# *538DC49700E1_538DC31F03A5_var*
begin
//#UC START# *538DC49700E1_538DC31F03A5_impl*
 Assert(aIOHandler <> nil);
 inherited Create;
 aIOHandler.SetRefTo(f_IOHandler);
//#UC END# *538DC49700E1_538DC31F03A5_impl*
end;//TCsDataPipePrim.Create

constructor TCsDataPipePrim.Create(aIOHandler: TIdIOHandler);
//#UC START# *538DC4BB019F_538DC31F03A5_var*
var
 l_IOHandler : TcsIdIOHandlerAdapter;
//#UC END# *538DC4BB019F_538DC31F03A5_var*
begin
//#UC START# *538DC4BB019F_538DC31F03A5_impl*
 Assert(aIOHandler <> nil);
 l_IOHandler := TcsIdIOHandlerAdapter.Create(aIOHandler);
 try
  Create(l_IOHandler);
 finally
  FreeAndNil(l_IOHandler);
 end;//try..finally
//#UC END# *538DC4BB019F_538DC31F03A5_impl*
end;//TCsDataPipePrim.Create

procedure TCsDataPipePrim.WriteBufferFlush;
//#UC START# *538DB5C7002E_538DC31F03A5_var*
//#UC END# *538DB5C7002E_538DC31F03A5_var*
begin
//#UC START# *538DB5C7002E_538DC31F03A5_impl*
 f_IOHandler.WriteBufferFlush;
//#UC END# *538DB5C7002E_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteBufferFlush

function TCsDataPipePrim.ReadChar: AnsiChar;
//#UC START# *538DB5E90386_538DC31F03A5_var*
//#UC END# *538DB5E90386_538DC31F03A5_var*
begin
//#UC START# *538DB5E90386_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadChar;
//#UC END# *538DB5E90386_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadChar

function TCsDataPipePrim.ReadCardinal: Cardinal;
//#UC START# *538DB61100CA_538DC31F03A5_var*
//#UC END# *538DB61100CA_538DC31F03A5_var*
begin
//#UC START# *538DB61100CA_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadCardinal;
//#UC END# *538DB61100CA_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadCardinal

function TCsDataPipePrim.ReadDateTime: TDateTime;
//#UC START# *538DB62D02C7_538DC31F03A5_var*
//#UC END# *538DB62D02C7_538DC31F03A5_var*
begin
//#UC START# *538DB62D02C7_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadDateTime;
//#UC END# *538DB62D02C7_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadDateTime

function TCsDataPipePrim.ReadLn: AnsiString;
//#UC START# *538DB6520024_538DC31F03A5_var*
//#UC END# *538DB6520024_538DC31F03A5_var*
begin
//#UC START# *538DB6520024_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadLn;
 Result:= AnsiReplaceStr(Result, '#softbreak#', #10);
 Result:= AnsiReplaceStr(Result, '#hardbreak#', #13);
//#UC END# *538DB6520024_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadLn

function TCsDataPipePrim.ReadInt64: Int64;
//#UC START# *538DB66D02EB_538DC31F03A5_var*
//#UC END# *538DB66D02EB_538DC31F03A5_var*
begin
//#UC START# *538DB66D02EB_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadInt64;
//#UC END# *538DB66D02EB_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadInt64

procedure TCsDataPipePrim.ReadStream(aStream: TStream;
  aSize: Int64 = -1);
//#UC START# *538DB69000E7_538DC31F03A5_var*
//#UC END# *538DB69000E7_538DC31F03A5_var*
begin
//#UC START# *538DB69000E7_538DC31F03A5_impl*
 WriteBufferFlush;
 f_IOHandler.ReadStream(aStream, aSize);
 aStream.Seek(0, soFromBeginning);
//#UC END# *538DB69000E7_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadStream

function TCsDataPipePrim.ReadInteger: Integer;
//#UC START# *538DB78C01B0_538DC31F03A5_var*
//#UC END# *538DB78C01B0_538DC31F03A5_var*
begin
//#UC START# *538DB78C01B0_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadInteger;
//#UC END# *538DB78C01B0_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadInteger

function TCsDataPipePrim.ReadSmallInt: SmallInt;
//#UC START# *538DB7A4016D_538DC31F03A5_var*
//#UC END# *538DB7A4016D_538DC31F03A5_var*
begin
//#UC START# *538DB7A4016D_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadSmallInt;
//#UC END# *538DB7A4016D_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadSmallInt

procedure TCsDataPipePrim.WriteLn(const aString: AnsiString);
//#UC START# *538DB7E00144_538DC31F03A5_var*
(*const
 c_MaxDataStringLength = 4 * 1024;*)
var
 l_Str: String;
//#UC END# *538DB7E00144_538DC31F03A5_var*
begin
//#UC START# *538DB7E00144_538DC31F03A5_impl*
 Assert(Length(aString) <= c_MaxDataStringLength);
 l_Str := aString;
 l_Str:= AnsiReplaceStr(l_Str, #10, '#softbreak#');
 l_Str:= AnsiReplaceStr(l_Str, #13, '#hardbreak#');
 f_IOHandler.WriteLn(l_Str);
//#UC END# *538DB7E00144_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteLn

procedure TCsDataPipePrim.WriteCardinal(aValue: Cardinal);
//#UC START# *538DB804015E_538DC31F03A5_var*
//#UC END# *538DB804015E_538DC31F03A5_var*
begin
//#UC START# *538DB804015E_538DC31F03A5_impl*
 f_IOHandler.WriteCardinal(aValue);
//#UC END# *538DB804015E_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteCardinal

procedure TCsDataPipePrim.WriteInt64(aValue: Int64);
//#UC START# *538DB83B021B_538DC31F03A5_var*
//#UC END# *538DB83B021B_538DC31F03A5_var*
begin
//#UC START# *538DB83B021B_538DC31F03A5_impl*
 f_IOHandler.WriteInt64(aValue);
//#UC END# *538DB83B021B_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteInt64

procedure TCsDataPipePrim.WriteStream(aStream: TStream;
  aByteCount: Int64 = 0);
//#UC START# *538DB86700DB_538DC31F03A5_var*
//#UC END# *538DB86700DB_538DC31F03A5_var*
begin
//#UC START# *538DB86700DB_538DC31F03A5_impl*
 f_IOHandler.WriteStream(aStream, aByteCount);
//#UC END# *538DB86700DB_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteStream

procedure TCsDataPipePrim.WriteChar(aValue: AnsiChar);
//#UC START# *538DB8970317_538DC31F03A5_var*
//#UC END# *538DB8970317_538DC31F03A5_var*
begin
//#UC START# *538DB8970317_538DC31F03A5_impl*
 f_IOHandler.WriteChar(aValue);
//#UC END# *538DB8970317_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteChar

procedure TCsDataPipePrim.WriteSmallInt(aValue: SmallInt);
//#UC START# *538DB8BA00D1_538DC31F03A5_var*
//#UC END# *538DB8BA00D1_538DC31F03A5_var*
begin
//#UC START# *538DB8BA00D1_538DC31F03A5_impl*
 f_IOHandler.WriteSmallInt(aValue);
//#UC END# *538DB8BA00D1_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteSmallInt

procedure TCsDataPipePrim.WriteInteger(aValue: Integer);
//#UC START# *538DB8DF029E_538DC31F03A5_var*
//#UC END# *538DB8DF029E_538DC31F03A5_var*
begin
//#UC START# *538DB8DF029E_538DC31F03A5_impl*
 f_IOHandler.WriteInteger(aValue);
//#UC END# *538DB8DF029E_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteInteger

procedure TCsDataPipePrim.WriteDateTime(aValue: TDateTime);
//#UC START# *538DB9070097_538DC31F03A5_var*
//#UC END# *538DB9070097_538DC31F03A5_var*
begin
//#UC START# *538DB9070097_538DC31F03A5_impl*
 f_IOHandler.WriteDateTime(aValue);
//#UC END# *538DB9070097_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteDateTime

function TCsDataPipePrim.WaitForReadData(aTimeout: Integer): Boolean;
//#UC START# *54536C8F036B_538DC31F03A5_var*
//#UC END# *54536C8F036B_538DC31F03A5_var*
begin
//#UC START# *54536C8F036B_538DC31F03A5_impl*
 Result := f_IOHandler.WaitForReadData(aTimeOut);
//#UC END# *54536C8F036B_538DC31F03A5_impl*
end;//TCsDataPipePrim.WaitForReadData

procedure TCsDataPipePrim.WriteLargeStr(const aString: AnsiString);
//#UC START# *54F5C07302CC_538DC31F03A5_var*
//#UC END# *54F5C07302CC_538DC31F03A5_var*
begin
//#UC START# *54F5C07302CC_538DC31F03A5_impl*
 f_IOHandler.WriteLargeStr(aString);
//#UC END# *54F5C07302CC_538DC31F03A5_impl*
end;//TCsDataPipePrim.WriteLargeStr

function TCsDataPipePrim.ReadLargeStr: AnsiString;
//#UC START# *54F5C09C0302_538DC31F03A5_var*
//#UC END# *54F5C09C0302_538DC31F03A5_var*
begin
//#UC START# *54F5C09C0302_538DC31F03A5_impl*
 WriteBufferFlush;
 Result := f_IOHandler.ReadLargeStr;
//#UC END# *54F5C09C0302_538DC31F03A5_impl*
end;//TCsDataPipePrim.ReadLargeStr

procedure TCsDataPipePrim.Cleanup;
//#UC START# *479731C50290_538DC31F03A5_var*
//#UC END# *479731C50290_538DC31F03A5_var*
begin
//#UC START# *479731C50290_538DC31F03A5_impl*
 FreeAndNil(f_IOHandler);
 inherited;
//#UC END# *479731C50290_538DC31F03A5_impl*
end;//TCsDataPipePrim.Cleanup

{$IfEnd} //not Nemesis

end.