{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBByteBuffer;

interface

uses System.SysUtils;

type
  TDBByteBuffer = class
    strict private
      FBuffer:   TArray<Byte>;
      FOffset:   Integer;
      FUsed:     Integer;

      procedure CheckSpace(SpaceNeeded: Integer);
    public
      constructor Create; overload;
      constructor Create(Buffer: TArray<Byte>); overload;
      constructor Create(Capacity: Integer); overload;
      destructor Destroy; override;
      function  GetBytes: TArray<Byte>;
      procedure SetString(Value: string);
      procedure SetBytes(Value: TArray<Byte>);
      procedure Append(Value: string); overload;
      procedure Append(Value: TArray<Byte>); overload;
      procedure Append(Value: PChar; Count: Integer); overload;
  end;


implementation

{ TDBByteBuffer }

constructor TDBByteBuffer.Create(Buffer: TArray<Byte>);
begin
  inherited Create;
  FBuffer := Buffer;
end;

procedure TDBByteBuffer.CheckSpace(SpaceNeeded: Integer);
begin
   if Length(FBuffer) < FUsed + SpaceNeeded then
   begin
      raise ERangeError.Create('CheckSpace');
   end;
end;

procedure TDBByteBuffer.Append(Value: string);
begin
  CheckSpace(Value.Length);
  Move(PByte(Value)^, PByte(FBuffer)^, Value.Length * SizeOf(Char));
end;

procedure TDBByteBuffer.Append(Value: TArray<Byte>);
begin
  CheckSpace(Length(Value));
  Move(PChar(Value)^, PChar(FBuffer)^, Length(Value));
end;

procedure TDBByteBuffer.Append(Value: PChar; Count: Integer);
begin
  CheckSpace(Count);
  Move(Value^, PChar(FBuffer)^, Count);
end;

constructor TDBByteBuffer.Create(Capacity: Integer);
begin
  inherited Create;
  SetLength(FBuffer, Capacity);
end;

constructor TDBByteBuffer.Create;
begin
  inherited Create;
end;

destructor TDBByteBuffer.Destroy;
begin
  FBuffer := nil;
  inherited;
end;

function TDBByteBuffer.GetBytes: TArray<Byte>;
begin
  Result := FBuffer;
end;

procedure TDBByteBuffer.SetBytes(Value: TArray<Byte>);
begin
  SetLength(FBuffer, Length(Value));
  FOffset := 0;
  Append(Value);
end;

procedure TDBByteBuffer.SetString(Value: string);
begin
  SetLength(FBuffer, Value.Length * SizeOf(Char));
  FOffset := 0;
  Append(Value);
end;

end.
