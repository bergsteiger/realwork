{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit ASCIIHexDecode;

interface

uses
  Classes, gtTypes, Stream, gtObject, DecodeIntf;

//{$IFDEF ASCIIHEXDECODE}
type
 (**
  * This class is used for decoding a stream from ASCIIHex encoded stream
  *)

  TgtASCIIHexDecode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FBuffer: Integer;
    FEof: Boolean;
  public
    { public declarations }
    constructor Create(AStream: TgtStream);
    destructor Destroy; override;

    function LookChar: Integer; override;
    function GetChar: Integer; override;
    procedure Reset; override;
  end;
//{$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtMethods, StreamConsts, StreamExceptions, SysUtils;

{ TgtASCIIHexDecode }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 *)

constructor TgtASCIIHexDecode.Create(AStream: TgtStream);
begin
  FStream := AStream;
  FBuffer := -1;
  FEof := False;
end;

(**
 * Destructor
 *)

destructor TgtASCIIHexDecode.Destroy;
begin
  try
    FStream.Destroy;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  inherited;
end;

(**
 * Gets each charecter on request after decoding
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtASCIIHexDecode.GetChar: Integer;
begin
  Result := LookChar;
  FBuffer := -1;
end;

(**
 * Gets each charecter on request after decoding without increamenting the location
 * @return The charecter(integer value) after decoding
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

function TgtASCIIHexDecode.LookChar: Integer;
var
  LC1, LC2, LX: Integer;
begin
  if (FBuffer <> -1) then
  begin
    Result := FBuffer;
    Exit;
  end;
  if (FEof) then
  begin
    FBuffer := -1;
    Result := FBuffer;
    Exit;
  end;
  try
    repeat
      LC1 := FStream.GetChar();
    until not (IsSpace(LC1));
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  if (LC1 = Ord('>')) then
  begin
    FEof := True;
    FBuffer := -1;
    Result := FBuffer;
    Exit;
  end;
  try
    repeat
      LC2 := FStream.GetChar;
    until not (IsSpace(LC2));
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  if (LC2 = Ord('>')) then
  begin
    FEof := True;
    LC2 := Ord('0');
  end;
  if (LC1 >= Ord('0')) and (LC1 <= Ord('9')) then
    LX := (LC1 - Ord('0')) shl 4
  else if (LC1 >= Ord('A')) and (LC1 <= Ord('F')) then
    LX := (LC1 - Ord('A') + 10) shl 4
  else if (LC1 >= Ord('a')) and (LC1 <= Ord('f')) then
    LX := (LC1 - Ord('a') + 10) shl 4
  else if (LC1 = -1) then
  begin
    FEof := True;
    LX := 0;
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Illegal character < %s in ASCIIHex stream', [AnsiChar(LC1)]);
{$ENDIF}
    LX := 0;
  end;

  if (LC2 >= Ord('0')) and (LC2 <= Ord('9')) then
    LX := LX + LC2 - Ord('0')
  else if (LC2 >= Ord('A')) and (LC2 <= Ord('F')) then
    LX := LX + LC2 - Ord('A') + 10
  else if (LC2 >= Ord('a')) and (LC2 <= Ord('f')) then
    LX := LX + LC2 - Ord('a') + 10
  else if LC2 = -1 then
  begin
    FEof := True;
    LX := 0;
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Illegal character < %s in ASCIIHex stream', [AnsiChar(LC2)]);
{$ENDIF}
  end;
  FBuffer := LX and $FF;
  Result := FBuffer;
end;

(**
 * Resets the Stream to its defaults
 *
 * @exception ExInvalidStream will be raised if FStream is nil
 *)

procedure TgtASCIIHexDecode.Reset;
begin
  inherited;
  try
    FStream.Reset;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  FBuffer := -1;
  FEof := False;
end;

end.
