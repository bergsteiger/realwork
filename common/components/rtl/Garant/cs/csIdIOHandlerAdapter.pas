unit csIdIOHandlerAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csIdIOHandlerAdapter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Core::TcsIdIOHandlerAdapter
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
  IdIOHandler,
  csIdIOHandlerAbstractAdapter,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsIdIOHandlerAdapter = class(TcsIdIOHandlerAbstractAdapter)
 private
 // private fields
   f_IOHandler : TIdIOHandler;
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
   function Connected: Boolean; override;
   procedure WriteFile(const aFile: AnsiString); override;
   procedure WriteBufferOpen(AThreshhold: Integer); override;
   procedure WriteBufferClose; override;
   procedure WriteBufferClear; override;
   function WaitForReadData(aTimeout: Integer): Boolean; override;
   procedure InputBufferClear; override;
   procedure WriteLargeStr(const aString: AnsiString); override;
   function ReadLargeStr: AnsiString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aIOHandler: TIdIOHandler); reintroduce;
 end;//TcsIdIOHandlerAdapter
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  IdGlobal,
  l3Base,
  l3Memory,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsIdIOHandlerAdapter

constructor TcsIdIOHandlerAdapter.Create(aIOHandler: TIdIOHandler);
//#UC START# *538DB5610283_538DB527006C_var*
//#UC END# *538DB5610283_538DB527006C_var*
begin
//#UC START# *538DB5610283_538DB527006C_impl*
 inherited Create;
 f_IOHandler := aIOHandler;
 f_IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
 f_IOHandler.DefAnsiEncoding := IndyTextEncoding_UTF8;
//#UC END# *538DB5610283_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.Create

procedure TcsIdIOHandlerAdapter.WriteBufferFlush;
//#UC START# *538DB5C7002E_538DB527006C_var*
//#UC END# *538DB5C7002E_538DB527006C_var*
begin
//#UC START# *538DB5C7002E_538DB527006C_impl*
 f_IOHandler.WriteBufferFlush;
//#UC END# *538DB5C7002E_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteBufferFlush

function TcsIdIOHandlerAdapter.ReadChar: AnsiChar;
//#UC START# *538DB5E90386_538DB527006C_var*
//#UC END# *538DB5E90386_538DB527006C_var*
begin
//#UC START# *538DB5E90386_538DB527006C_impl*
 Result := f_IOHandler.ReadChar;
//#UC END# *538DB5E90386_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadChar

function TcsIdIOHandlerAdapter.ReadCardinal: Cardinal;
//#UC START# *538DB61100CA_538DB527006C_var*
//#UC END# *538DB61100CA_538DB527006C_var*
begin
//#UC START# *538DB61100CA_538DB527006C_impl*
 Result := f_IOHandler.ReadUInt32;
//#UC END# *538DB61100CA_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadCardinal

function TcsIdIOHandlerAdapter.ReadDateTime: TDateTime;
//#UC START# *538DB62D02C7_538DB527006C_var*
var
 l_Bytes: TIdBytes;
//#UC END# *538DB62D02C7_538DB527006C_var*
begin
//#UC START# *538DB62D02C7_538DB527006C_impl*
 f_IOHandler.ReadBytes(l_Bytes, SizeOf(TDateTime));
 Result := PDateTime(@l_Bytes[0])^;
//#UC END# *538DB62D02C7_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadDateTime

function TcsIdIOHandlerAdapter.ReadLn: AnsiString;
//#UC START# *538DB6520024_538DB527006C_var*
//#UC END# *538DB6520024_538DB527006C_var*
begin
//#UC START# *538DB6520024_538DB527006C_impl*
 Result := f_IOHandler.ReadLn;
//#UC END# *538DB6520024_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadLn

function TcsIdIOHandlerAdapter.ReadInt64: Int64;
//#UC START# *538DB66D02EB_538DB527006C_var*
//#UC END# *538DB66D02EB_538DB527006C_var*
begin
//#UC START# *538DB66D02EB_538DB527006C_impl*
 Result := f_IOHandler.ReadInt64;
//#UC END# *538DB66D02EB_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadInt64

procedure TcsIdIOHandlerAdapter.ReadStream(aStream: TStream;
  aSize: Int64 = -1);
//#UC START# *538DB69000E7_538DB527006C_var*
//#UC END# *538DB69000E7_538DB527006C_var*
begin
//#UC START# *538DB69000E7_538DB527006C_impl*
 f_IOHandler.ReadStream(aStream, aSize);
//#UC END# *538DB69000E7_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadStream

function TcsIdIOHandlerAdapter.ReadInteger: Integer;
//#UC START# *538DB78C01B0_538DB527006C_var*
//#UC END# *538DB78C01B0_538DB527006C_var*
begin
//#UC START# *538DB78C01B0_538DB527006C_impl*
 Result := f_IOHandler.ReadInt32;
//#UC END# *538DB78C01B0_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadInteger

function TcsIdIOHandlerAdapter.ReadSmallInt: SmallInt;
//#UC START# *538DB7A4016D_538DB527006C_var*
//#UC END# *538DB7A4016D_538DB527006C_var*
begin
//#UC START# *538DB7A4016D_538DB527006C_impl*
 Result := f_IOHandler.ReadSmallInt;
//#UC END# *538DB7A4016D_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadSmallInt

procedure TcsIdIOHandlerAdapter.WriteLn(const aString: AnsiString);
//#UC START# *538DB7E00144_538DB527006C_var*
//#UC END# *538DB7E00144_538DB527006C_var*
begin
//#UC START# *538DB7E00144_538DB527006C_impl*
 f_IOHandler.WriteLn(aString);
//#UC END# *538DB7E00144_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteLn

procedure TcsIdIOHandlerAdapter.WriteCardinal(aValue: Cardinal);
//#UC START# *538DB804015E_538DB527006C_var*
//#UC END# *538DB804015E_538DB527006C_var*
begin
//#UC START# *538DB804015E_538DB527006C_impl*
 f_IOHandler.Write(aValue);
//#UC END# *538DB804015E_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteCardinal

procedure TcsIdIOHandlerAdapter.WriteInt64(aValue: Int64);
//#UC START# *538DB83B021B_538DB527006C_var*
//#UC END# *538DB83B021B_538DB527006C_var*
begin
//#UC START# *538DB83B021B_538DB527006C_impl*
 f_IOHandler.Write(aValue);
//#UC END# *538DB83B021B_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteInt64

procedure TcsIdIOHandlerAdapter.WriteStream(aStream: TStream;
  aByteCount: Int64 = 0);
//#UC START# *538DB86700DB_538DB527006C_var*
//#UC END# *538DB86700DB_538DB527006C_var*
begin
//#UC START# *538DB86700DB_538DB527006C_impl*
 f_IOHandler.Write(aStream, aByteCount, True);
//#UC END# *538DB86700DB_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteStream

procedure TcsIdIOHandlerAdapter.WriteChar(aValue: AnsiChar);
//#UC START# *538DB8970317_538DB527006C_var*
//#UC END# *538DB8970317_538DB527006C_var*
begin
//#UC START# *538DB8970317_538DB527006C_impl*
 f_IOHandler.Write(aValue);
//#UC END# *538DB8970317_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteChar

procedure TcsIdIOHandlerAdapter.WriteSmallInt(aValue: SmallInt);
//#UC START# *538DB8BA00D1_538DB527006C_var*
//#UC END# *538DB8BA00D1_538DB527006C_var*
begin
//#UC START# *538DB8BA00D1_538DB527006C_impl*
 f_IOHandler.Write(aValue);
//#UC END# *538DB8BA00D1_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteSmallInt

procedure TcsIdIOHandlerAdapter.WriteInteger(aValue: Integer);
//#UC START# *538DB8DF029E_538DB527006C_var*
//#UC END# *538DB8DF029E_538DB527006C_var*
begin
//#UC START# *538DB8DF029E_538DB527006C_impl*
 f_IOHandler.Write(aValue);
//#UC END# *538DB8DF029E_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteInteger

procedure TcsIdIOHandlerAdapter.WriteDateTime(aValue: TDateTime);
//#UC START# *538DB9070097_538DB527006C_var*
var
 l_Bytes: TIdBytes;
//#UC END# *538DB9070097_538DB527006C_var*
begin
//#UC START# *538DB9070097_538DB527006C_impl*
 SetLength(l_Bytes, SizeOf(aValue));
 try
  l3Move(aValue, l_Bytes[0], SizeOf(aValue));
  f_IOHandler.Write(l_Bytes);
 finally
  l_Bytes := nil;
 end;//try..finally
//#UC END# *538DB9070097_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteDateTime

function TcsIdIOHandlerAdapter.Connected: Boolean;
//#UC START# *538DB93002B5_538DB527006C_var*
//#UC END# *538DB93002B5_538DB527006C_var*
begin
//#UC START# *538DB93002B5_538DB527006C_impl*
 Result := f_IOHandler.Connected;
//#UC END# *538DB93002B5_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.Connected

procedure TcsIdIOHandlerAdapter.WriteFile(const aFile: AnsiString);
//#UC START# *538DB9810192_538DB527006C_var*
//#UC END# *538DB9810192_538DB527006C_var*
begin
//#UC START# *538DB9810192_538DB527006C_impl*
 f_IOHandler.WriteFile(aFile, false);
//#UC END# *538DB9810192_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteFile

procedure TcsIdIOHandlerAdapter.WriteBufferOpen(AThreshhold: Integer);
//#UC START# *538DB9C40271_538DB527006C_var*
//#UC END# *538DB9C40271_538DB527006C_var*
begin
//#UC START# *538DB9C40271_538DB527006C_impl*
 f_IOHandler.WriteBufferOpen(AThreshhold);
//#UC END# *538DB9C40271_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteBufferOpen

procedure TcsIdIOHandlerAdapter.WriteBufferClose;
//#UC START# *538DB9F30058_538DB527006C_var*
//#UC END# *538DB9F30058_538DB527006C_var*
begin
//#UC START# *538DB9F30058_538DB527006C_impl*
 f_IOHandler.WriteBufferClose;
//#UC END# *538DB9F30058_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteBufferClose

procedure TcsIdIOHandlerAdapter.WriteBufferClear;
//#UC START# *538DBA0B009F_538DB527006C_var*
//#UC END# *538DBA0B009F_538DB527006C_var*
begin
//#UC START# *538DBA0B009F_538DB527006C_impl*
 f_IOHandler.WriteBufferClear;
//#UC END# *538DBA0B009F_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteBufferClear

function TcsIdIOHandlerAdapter.WaitForReadData(aTimeout: Integer): Boolean;
//#UC START# *54536C8F036B_538DB527006C_var*
//#UC END# *54536C8F036B_538DB527006C_var*
begin
//#UC START# *54536C8F036B_538DB527006C_impl*
 Result := (f_IOHandler.InputBuffer.Size > 0) or f_IOHandler.Readable(aTimeOut);
//#UC END# *54536C8F036B_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WaitForReadData

procedure TcsIdIOHandlerAdapter.InputBufferClear;
//#UC START# *5476EDF200B5_538DB527006C_var*
//#UC END# *5476EDF200B5_538DB527006C_var*
begin
//#UC START# *5476EDF200B5_538DB527006C_impl*
 if Assigned(f_IOHandler.InputBuffer) then
  f_IOHandler.InputBuffer.Clear;
//#UC END# *5476EDF200B5_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.InputBufferClear

procedure TcsIdIOHandlerAdapter.WriteLargeStr(const aString: AnsiString);
//#UC START# *54F5C07302CC_538DB527006C_var*
var
 l_Stream: TStream;
//#UC END# *54F5C07302CC_538DB527006C_var*
begin
//#UC START# *54F5C07302CC_538DB527006C_impl*
 WriteCardinal(Length(aString));
 if Length(aString) > 0 then
 begin
  l_Stream := Tl3ConstMemoryStream.Create(@AString[1], Length(aString)*SizeOf(aString[1]));
  try
   WriteStream(l_Stream);
  finally
   FreeAndNil(l_Stream);
  end;
 end;
//#UC END# *54F5C07302CC_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.WriteLargeStr

function TcsIdIOHandlerAdapter.ReadLargeStr: AnsiString;
//#UC START# *54F5C09C0302_538DB527006C_var*
var
 l_Stream: TStream;
 l_Size: Integer;
//#UC END# *54F5C09C0302_538DB527006C_var*
begin
//#UC START# *54F5C09C0302_538DB527006C_impl*
 l_Size := ReadCardinal;
 SetLength(Result, l_Size);
 if Length(Result) > 0 then
 begin
  l_Stream := Tl3ConstMemoryStream.Create(@Result[1], Length(Result)*SizeOf(Result[1]));
  try
   ReadStream(l_Stream);
  finally
   FreeAndNil(l_Stream);
  end;
 end; 
//#UC END# *54F5C09C0302_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.ReadLargeStr

procedure TcsIdIOHandlerAdapter.Cleanup;
//#UC START# *479731C50290_538DB527006C_var*
//#UC END# *479731C50290_538DB527006C_var*
begin
//#UC START# *479731C50290_538DB527006C_impl*
 f_IOHandler := nil;
 inherited;
//#UC END# *479731C50290_538DB527006C_impl*
end;//TcsIdIOHandlerAdapter.Cleanup

{$IfEnd} //not Nemesis

end.