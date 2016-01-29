{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit RunLengthDecode;

interface

uses Stream, DecodeIntf;

type

 (**
  * This class is used for decoding a stream from RunLength encoded stream
  *)

  TgtRunLengthDecode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FBuffer: array[1..128] of AnsiChar;
    FNextChar: Integer;
    FBufEnd: Integer;
    FEof: Boolean;

    function FillBuffer: Boolean;
  public
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;
    procedure Reset; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
  end;

implementation

uses StreamConsts, StreamExceptions, SysUtils;

{ TgtRunLengthDecode }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 *)

constructor TgtRunLengthDecode.Create(AStream: TgtStream);
begin
  FStream := AStream;
  FNextChar := 0;
  FBufEnd := 0;
  FEof := False;
end;

(**
 * Destructor
 *)

destructor TgtRunLengthDecode.Destroy;
begin

  inherited;
end;

function TgtRunLengthDecode.FillBuffer: Boolean;
var
  LChar, LN, LI: Integer;
begin
  if FStream = nil then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  if FEof then
  begin
    Result := False;
    Exit;
  end;
  LChar := FStream.GetChar;
  if (LChar = $80) or (LChar = ENDOFFILE) then
  begin
    FEof := True;
    Result := False;
    Exit;
  end;
  if (LChar < $80) then
  begin
    LN := LChar + 1;
    for LI := 1 to LN do
    begin
      FBuffer[LI] := AnsiChar(FStream.GetChar);
    end;
  end
  else
  begin
    LN := $101 - LChar;
    LChar := FStream.GetChar;
    for LI := 1 to LN do
    begin
      FBuffer[LI] := AnsiChar(LChar);
    end;
  end;
  FNextChar := 1;
  FBufEnd := LN + 1;
  Result := True;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtRunLengthDecode.GetChar: Integer;
begin
  if ((FNextChar >= FBufEnd) and (not FillBuffer)) then
  begin
    Result := EndofFile;
  end
  else
  begin
    Result := integer(FBuffer[FNextChar]) and $FF;
    Inc(FNextChar);
  end;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtRunLengthDecode.LookChar: Integer;
begin
  if ((FNextChar >= FBufEnd) and (not FillBuffer)) then
  begin
    Result := EndofFile;
  end
  else
  begin
    Result := integer(FBuffer[FNextChar]) and $FF;
  end;
end;

(**
 * Resets the Stream to its defaults
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

procedure TgtRunLengthDecode.Reset;
begin
  inherited;
  try
    FStream.Reset;
    FNextChar := 0;
    FBufEnd := 0;
    FEof := False;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
end;

end.
