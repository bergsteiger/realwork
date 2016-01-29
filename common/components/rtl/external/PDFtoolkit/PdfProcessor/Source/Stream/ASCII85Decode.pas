{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit ASCII85Decode;

interface

uses
  Classes, gtObject, gtTypes, DecodeIntf, Stream;

//{$IFDEF ASCII85DECODE}
type
  (* The ASCII85Decode filter decodes data that has been encoded in ASCII
   * base-85 encoding and produces binary data.
   *)
  TgtASCII85Decode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FCharOut: array[0..4] of Integer;
    FBinaryIn: array[0..3] of Integer;
    Findex: Integer;
    Fn: Integer;
    FEof: Boolean;

  public
    { public declarations }
    constructor create(AStream: TgtStream);
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    function GetPosition: Int64; override;
    procedure Reset; override;
  end;


//{$ENDIF}

implementation

uses
  gtConstants, StreamConsts, gtMethods, StreamExceptions, SysUtils;

  { TgtASCII85Decode }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 *)

constructor TgtASCII85Decode.create(AStream: TgtStream);
begin
  FStream := AStream;
  Findex := 0;
  Fn := 0;
  FEof := False;
end;

  (**
   * Gets a charecter from Fstream
   * @return A charecter(integer value)
   *)

function TgtASCII85Decode.GetChar: Integer;
begin
  Result := LookChar;
  Inc(Findex);
end;

  (**
   * Gets the position of FStream
   * @return the position of FStream
   * @exception ExInvalidStream if FStream is NULL
   *)

function TgtASCII85Decode.GetPosition: Int64;
begin
  try
    Result := FStream.GetPosition;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  Inc(Findex);
end;

  (**
   * Gets a charecter from Fstream
   * @return A charecter(integer value)
   * @exception ExInvalidStream if FStream is NULL
   *)

function TgtASCII85Decode.LookChar: Integer;
var
  LK: Integer;
  LT: Int64;
begin
  if (Findex >= Fn) then
  begin
    if FEof then
    begin
      Result := ENDOFFILE;
      Exit;
    end;
    if not Assigned(FStream) then
      raise ExInvalidStream.Create(ErrInvalidStream);
    Findex := 0;
    repeat
      FCharOut[0] := FStream.GetChar;
    until not (IsSpace(FCharOut[0]));
    if ((FCharOut[0] = Ord('~')) or (FCharOut[0] = ENDOFFILE)) then
    begin
      FEof := True;
      Fn := 0;
      Result := ENDOFFILE;
      Exit;
    end
    else if (FCharOut[0] = Ord('z')) then
    begin
      FBinaryIn[0] := 0;
      FBinaryIn[1] := 0;
      FBinaryIn[2] := 0;
      FBinaryIn[3] := 0;
      Fn := 4;
    end
    else
    begin
      for LK := 1 to 4 do
      begin
        repeat
          FCharOut[LK] := FStream.GetChar;
        until not (IsSpace(FCharOut[LK]));
        if ((FCharOut[LK] = Ord('~')) or (FCharOut[LK] = EndofFile)) then break;
      end;
      Fn := LK - 1;
      if ((LK < 5) and ((FCharOut[LK] = Ord('~')) or (FCharOut[LK] = ENDOFFILE)))
        then
      begin
        Inc(LK);
        while LK < 5 do
        begin
          FCharOut[LK] := $21 + 84;
          Inc(LK)
        end;
        FEof := True;
      end;
      LT := 0;
      for LK := 0 to 4 do
        LT := LongWord(LT * 85 + (FCharOut[LK] - $21));
      for LK := 3 downto 0 do
      begin
        FBinaryIn[LK] := (LT and $FF);
        LT := Integer(LT shr 8);
      end;
    end;
  end;
  Result := FBinaryIn[Findex];
end;

(**
 * Resets the Stream to its defaults
 * @exception ExInvalidStream if FStream is NULL
 *)

procedure TgtASCII85Decode.Reset;
begin
  try
    FStream.Reset;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  Findex := 0;
  Fn := 0;
  FEof := False;
end;

end.
