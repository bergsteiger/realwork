{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit RunLengthEncode;

interface

uses gtTypes, EncodeIntf, Stream;

type

 (**
  * This class is responsible for encoding of stream into RunLength Encoded stream
  *)

  TgtRunLengthEncode = class(TgtEncode)
  private
    FStream: TgtStream;
    FBuffer: array[0..130] of AnsiChar;
    FBuffPtr: Integer;
    FBuffEnd: Integer;
    FNextEnd: Integer;
    FEof: Boolean;

    function FillBuff: Boolean;
//    procedure Reset;
    function GetChar: Integer;
//    function LookChar: Integer;
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; override;
  end;

implementation

uses Classes, SysUtils, StreamConsts, StreamExceptions;

{ TgtRunLengthEncode }

(**
 * Constructor
 * @param AStream the stream that need to be encoded
 *)

constructor TgtRunLengthEncode.Create(AStream: TgtStream);
begin
  FStream := AStream;
  FBuffPtr := 0;
  FBuffEnd := 0;
  FNextEnd := 0;
  FEof := False;
end;

(**
 * Destructor
 *)

destructor TgtRunLengthEncode.Destroy;
begin
  inherited;
end;

function TgtRunLengthEncode.FillBuff: Boolean;
var
  LChar1: Integer;
  LChar2: Integer;
  LChar: Integer;
  LNo: Integer;
begin
  if (FStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  // already hit EOF?
  if FEof then
  begin
    Result := False;
    Exit;
  end;

  // grab two bytes
  if (FNextEnd < (FBuffEnd + 1)) then
  begin
    LChar1 := FStream.GetChar;
    if (LChar1 = ENDOFFILE) then
    begin
      FEof := True;
      Result := False;
      Exit;
    end;
  end
  else
  begin
    LChar1 := (Integer(FBuffer[FBuffEnd]) and $FF);
  end;
  if (FNextEnd < (FBuffEnd + 2)) then
  begin
    LChar2 := FStream.GetChar;
    if (LChar2 = ENDOFFILE) then
    begin
      FEof := True;
      FBuffer[0] := AnsiChar(0);
      FBuffer[1] := AnsiChar(LChar1);
      FBuffPtr := 1;
      FBuffEnd := 2;
      Result := True;
      Exit;
    end;
  end
  else
  begin
    LChar2 := (Integer(FBuffer[FBuffEnd + 1]) and $FF);
  end;

  // check for repeat
  if (LChar1 = LChar2) then
  begin
    LNo := 2;
    LChar := FStream.GetChar;
    while ((LNo < 128) and (LChar = LChar1)) do
    begin
      Inc(LNo);
    end;
    FBuffer[0] := AnsiChar(257 - LNo);
    FBuffer[1] := AnsiChar(LChar1);
    FBuffEnd := 2;
    if (LChar = ENDOFFILE) then
    begin
      FEof := True;
    end
    else if (LNo < 128) then
    begin
      FBuffer[2] := AnsiChar(LChar);
      FNextEnd := 3;
    end
    else
    begin
      FNextEnd := FBuffEnd;
    end;
  end
  else // get up to 128 chars
  begin
    FBuffer[1] := AnsiChar(LChar1);
    FBuffer[2] := AnsiChar(LChar2);
    LNo := 2;
    while (LNo < 128) do
    begin
      LChar := FStream.GetChar;
      if (LChar = ENDOFFILE) then
      begin
        FEof := True;
        Break;
      end;
      Inc(LNo);
      FBuffer[LNo] := AnsiChar(LChar);
      if (FBuffer[LNo] = FBuffer[LNo - 1]) then
      begin
        Break;
      end;
    end;
    if (FBuffer[LNo] = FBuffer[LNo - 1]) then
    begin
      FBuffer[0] := AnsiChar(LNo - 2 - 1);
      FBuffEnd := LNo - 1;
      FNextEnd := LNo + 1;
    end
    else
    begin
      FBuffer[0] := AnsiChar(LNo - 1);
      FBuffEnd := LNo + 1;
      FNextEnd := LNo + 1;
    end;
  end;
  FBuffPtr := 0;
  Result := True;
end;

function TgtRunLengthEncode.GetChar: Integer;
begin
  if FStream = nil then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  if ((FBuffPtr >= FBuffEnd) and (not FillBuff)) then
    Result := ENDOFFILE
  else
  begin
    Result := (Integer(FBuffer[FBuffPtr]) and $FF);
    Inc(FBuffPtr);
  end;
end;

(*
function TgtRunLengthEncode.LookChar: Integer;
begin
  if ((FBuffPtr >= FBuffEnd) and (not FillBuff)) then
    Result := ENDOFFILE
  else
     Result := (FBuffPtr and $FF);
end;
*)

(*
procedure TgtRunLengthEncode.Reset;
begin
  if FStream = nil then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  FStream.Reset;

  FBuffPtr := 0;
  FBuffEnd := 0;
  FNextEnd := 0;
  FEof := False;
end;
*)

(**
 * Writes the stream into the output stream after encoding it with RunLength
 *
 * @param InStream the stream that is to be encoded
 * @param OutStream the resulting stream after encoding
 * @param Count number of bytes that need to be encoded
 *
 * @return The number of bytes written into the output stream
 *
 * @exception ExOutofMemory will be raised on allocation out of memory
 * @exception ExInvalidBuffer if Buffer is not assigned
 * @exception ExInvalidStream will raised if FStream is nil
 *)

function TgtRunLengthEncode.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
var
  LI: Integer;
  LChar: Integer;
  LBuffer: Bytes;
begin
  LI := 0;
  LChar := GetChar;

  try
    SetLength(LBuffer, Count);
  except
  // Catch Out of Memory Exception
    on E: EOutOfResources do
      raise ExOutofMemory.Create(ErrOutofMemory);
  end;

  try
    while (LI < Count) and (LChar <> ENDOFFILE) do
    begin
      LBuffer[LI] := LChar;
      Inc(LI);
      LChar := GetChar;
//      Result := LI;
    end;
  except
  // Buffer is not assigned
    on E: EAccessViolation do
      raise ExInvalidBuffer.Create(ErrInvalidBuffer);
  end;
  Result := OutStream.Write(LBuffer, Count);
  SetLength(LBuffer, 0);
end;

end.
