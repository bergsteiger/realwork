{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBPlatform;


interface

uses System.SysUtils, Data.FMTBcd, Data.DB;

type

  TPlatformBytes = class
    class procedure StringToBytes(Value: string; Bytes: array of byte); static;
    class procedure Int16ToBytes(Value: SmallInt; Bytes: array of byte); static;
    class procedure Int32ToBytes(Value: Integer; Bytes: array of byte); static;
    class procedure Int64ToBytes(Value: Int64; Bytes: array of byte); static;
    class procedure DoubleToBytes(Value: Double; Bytes: array of byte); static;
    class procedure BcdToBytes(Value: TBcd; Bytes: array of byte); static;
    class procedure TimeStampToBytes(Value: TBcd; Bytes: array of byte); static;
  end;

  TPlatformRecBuf = class
    class function CreateRecordBuffer(Length: Integer): TRecBuf; static;
    class procedure Free(Buffer: TRecBuf); static;
    class procedure SetFMTBcd(Buffer: TRecBuf; value: TBcd); static;
    class procedure GetFMTBcd(Buffer: TRecBuf; var value: TBcd); static;
    class procedure FillChar(Buffer: TRecBuf; Length: Integer; value: Byte); static;
    class procedure Copy(Buffer: TRecBuf; Dest: TArray<Byte>; Offset: Integer; Length: Integer); static;
  end;

{$IFNDEF NEXTGEN}
  TPlatformRecordBuffer = class
    class function CreateRecordBuffer(Length: Integer): TRecordBuffer; static;
    class procedure Free(Buffer: TRecordBuffer); static;
    class procedure SetFMTBcd(Buffer: TRecordBuffer; value: TBcd); static;
    class procedure GetFMTBcd(Buffer: TRecordBuffer; var value: TBcd); static;
    class procedure FillChar(Buffer: TRecordBuffer; Length: Integer; value: Byte); static;
    class procedure Copy(Buffer: TRecordBuffer; Dest: TArray<Byte>; Offset: Integer; Length: Integer); static;
  end;
{$ENDIF !NEXTGEN}

  TPlatformValueBuffer = class
    class function CreateValueBuffer(Length:  Integer): TValueBuffer; static;
    class procedure Free(Buffer: TValueBuffer); static;
    class procedure Copy(Buffer: TValueBuffer; Dest: TArray<Byte>; Offset: Integer; Count: Integer); overload; static; inline;
    class procedure Copy(Source: TArray<Byte>; Offset: Integer; Buffer: TValueBuffer; Count: Integer); overload; static; inline;
  end;

implementation

{ TPlatformRecordBuffer }

class function TPlatformRecBuf.CreateRecordBuffer(
  Length: Integer): TRecBuf;
begin
  SetLength(TArray<Byte>(Result), Length);
end;

class procedure TPlatformRecBuf.Free(Buffer: TRecBuf);
begin
  TArray<Byte>(Buffer) := nil;
end;

class procedure TPlatformRecBuf.FillChar(Buffer: TRecBuf;
  Length: Integer; value: Byte);
begin
  System.FillChar(TArray<Byte>(Buffer)[0], Length, value);
end;

class procedure TPlatformRecBuf.SetFMTBcd(Buffer: TRecBuf;
  value: TBcd);
begin
  TBitConverter.FromBcd(value, TArray<Byte>(Buffer));
end;

class procedure TPlatformRecBuf.GetFMTBcd(Buffer: TRecBuf;
  var value: TBcd);
begin
  value := TBitConverter.ToBcd(TArray<Byte>(Buffer));
end;

class procedure TPlatformRecBuf.Copy(Buffer: TRecBuf;
  Dest: TArray<Byte>; Offset, Length: Integer);
begin
  Move(TArray<Byte>(Buffer)[0], Dest[Offset], Length);
end;

{$IFNDEF NEXTGEN}
class function TPlatformRecordBuffer.CreateRecordBuffer(
  Length: Integer): TRecordBuffer;
begin
  Result := AllocMem(Length);
end;

class procedure TPlatformRecordBuffer.Free(Buffer: TRecordBuffer);
begin
  FreeMem(Buffer);
end;

class procedure TPlatformRecordBuffer.FillChar(Buffer: TRecordBuffer;
  Length: Integer; value: Byte);
begin
  System.FillChar(Buffer^, Length, value);
end;

class procedure TPlatformRecordBuffer.SetFMTBcd(Buffer: TRecordBuffer;
  value: TBcd);
begin
  TBcd(Pointer(Buffer)^) := value;
end;

class procedure TPlatformRecordBuffer.GetFMTBcd(Buffer: TRecordBuffer;
  var value: TBcd);
var
  SBcd: string;
begin
  SBcd := BcdToStr(PBcd(Buffer)^);
  value := StrToBcd(SBcd);
end;

class procedure TPlatformRecordBuffer.Copy(Buffer: TRecordBuffer;
  Dest: TArray<Byte>; Offset, Length: Integer);
begin
  Move(Buffer^, Dest[Offset], Length);
end;
{$ENDIF !NEXTGEN}

{ TPlatformValueBuffer }

class function TPlatformValueBuffer.CreateValueBuffer(
  Length: Integer): TValueBuffer;
begin
  SetLength(Result, Length);
end;

class procedure TPlatformValueBuffer.Free(Buffer: TValueBuffer);
begin
  Buffer := nil;
end;

class procedure TPlatformValueBuffer.Copy(Buffer: TValueBuffer;
  Dest: TArray<Byte>; Offset, Count: Integer);
begin
  Move(Buffer[0], Dest[Offset], Count);
end;

class procedure TPlatformValueBuffer.Copy(Source: TArray<Byte>;
  Offset: Integer; Buffer: TValueBuffer; Count: Integer);
begin
  Move(Source[Offset], Buffer[0], Count);
end;


{ TPlatformBytes }

class procedure TPlatformBytes.BcdToBytes(Value: TBcd; Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.DoubleToBytes(Value: Double;
  Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.Int16ToBytes(Value: SmallInt;
  Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.Int32ToBytes(Value: Integer;
  Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.Int64ToBytes(Value: Int64; Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.StringToBytes(Value: string;
  Bytes: array of byte);
begin
  Assert(False);
end;

class procedure TPlatformBytes.TimeStampToBytes(Value: TBcd;
  Bytes: array of byte);
begin
  Assert(False);
end;

end.
