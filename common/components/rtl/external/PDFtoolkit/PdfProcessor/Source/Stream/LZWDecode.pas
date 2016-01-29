{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit LZWDecode;

interface

uses
  Classes, gtObject, gtTypes, DecodeIntf, Stream, Predictor, FilterStream;

  //{$IFDEF LZWDECODE}
type

  TgtLZWDecodeTable = record
    Length: Integer;
    FHead: Integer;
    FTail: AnsiChar;
  end;

  (* The LZWDecode filter decodes data that has been encoded in LZW data
   * compression method encoding and produces binary data.
   *)
  TgtLZWDecode = class(TgtDecode)
  private
    { private declarations }
    FStream: TgtStream;
    FStreamPredictor: TgtStreamPredictor; // predictor
    FEarlyChange: Integer; // early change parameter
    FEof: Boolean; // true if at End-of-file
    FInputBuf: Integer; // input buffer
    FInputBits: Integer;
    FDecodeTable: array[0..4095] of TgtLZWDecodeTable;
    FNextCode: Integer;
    FNextBits: Integer;
    FPrevCode: Integer;
    FNewChar: Integer;
    FSeqBuf: array[0..4095] of AnsiChar;
    FSeqLength: Integer;
    FSeqIndex: Integer;
    FFirst: Boolean;

    function ProcessNextCode: Boolean;
    procedure ClearTable;
    function GetCode: Integer;
  public
    { public declarations }
    constructor Create(LZWStream: TgtFilterStream; AStream: TgtStream;
      APredictor: Integer; AColumns: Integer; AColor: Integer; ABits: Integer;
      AEarlyChange: Integer);
    function LookChar: Integer; override;
    function GetChar: Integer; override;
    function GetPosition: Int64; override;
    function ReadRawChar: Integer; override;
    procedure Reset; override;
    destructor Destroy; override;
  end;
//{$ENDIF}

implementation

uses
  gtConstants, StreamConsts, StreamExceptions, SysUtils
{$IFDEF DEBUG}
  , gtLogger
{$ENDIF};

{ TgtLZWDecoder }

procedure TgtLZWDecode.ClearTable;
begin
  FNextCode := 258;
  FNextBits := 9;
  FSeqLength := 0;
  FSeqIndex := FSeqLength;
  FFirst := True;
end;

(**
 * Constructor
 * @param AStream that need to be decoded
 * @param APredictor A code that selects the predictor algorithm, if any
 * @param AColumns The number of samples in each row. Default value: 1
 * @param AColor The number of interleaved color components per sample
 * @param ABits The number of bits used to represent each color component in a
 *          sample. Default value: 8.
 * @param AEarlyChange An indication of when to increase the code length.
 *)

constructor TgtLZWDecode.Create(LZWStream: TgtFilterStream; AStream: TgtStream;
  APredictor, AColumns, AColor, ABits, AEarlyChange: Integer);
begin
  FStream := AStream;
  if APredictor <> 1 then
    FStreamPredictor := TgtStreamPredictor.Create(LZWStream, APredictor, AColor,
      AColumns, ABits)
  else
    FStreamPredictor := nil;
  FEarlyChange := AEarlyChange;
  FEof := False;
  FInputBits := 0;
  ClearTable;
end;

destructor TgtLZWDecode.Destroy;
begin
  if Assigned(FStreamPredictor) then
    FStreamPredictor.Destroy;
  inherited;
end;

function TgtLZWDecode.GetCode: Integer;
var
  LChar: Integer;
begin
  try
    while FInputBits < FNextBits do
    begin
      LChar := FStream.GetChar;
      if LChar = ENDOFFILE then
      begin
        Result := ENDOFFILE;
        Exit;
      end;
      FInputBuf := (FInputBuf shl 8) or (LChar and $FF);
      FInputBits := FInputBits + 8;
    end;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  LChar := (FInputBuf shr (FInputBits - FNextBits)) and ((1 shl FNextBits) - 1);
  FInputBits := FInputBits - FNextBits;
  Result := LChar;
end;

  (**
   * Gets the position of FStream
   * @return the position of FStream
   * @exception ExInvalidStream if FStream is NULL
   *)

function TgtLZWDecode.GetPosition: Int64;
begin
  try
    Result := FStream.GetPosition;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
end;

  (**
   * Gets a charecter from Fstream
   * @return A charecter(integer value)
   *)

function TgtLZWDecode.LookChar: Integer;
begin
  if (FStreamPredictor <> nil) then
  begin
    Result := FStreamPredictor.LookChar;
    Exit;
  end;
  if FEof then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  if (FSeqIndex >= FSeqLength) then
  begin
    if not (ProcessNextCode) then
    begin
      Result := ENDOFFILE;
      Exit;
    end;
  end;
  // AnsiChar to Integer - Check
  Result := Integer(FSeqBuf[FSeqIndex]);
end;

function TgtLZWDecode.ProcessNextCode: Boolean;
var
  LCode, LNextLength, LI, LJ: Integer;
  LFlag: Boolean;
begin
  // check for EOF
  if FEof then
  begin
    Result := False;
    Exit;
  end;

  // check for eod and clear-table codes
  LFlag := False;
  repeat
    LCode := GetCode;
    if (LCode = ENDOFFILE) or (LCode = 257) then
    begin
      FEof := True;
      Result := False;
      Exit;
    end;
    if LCode = 256 then
      ClearTable
    else
      LFlag := True;
  until (LFlag);
  if (FNextCode >= 4097) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad LZW stream - expected clear-table code');
{$ENDIF}
  end;
  // process the next code
  LNextLength := FSeqLength + 1;
  if LCode < 256 then
  begin
    FSeqBuf[0] := AnsiChar(LCode);
    FSeqLength := 1;
  end
  else if LCode < FNextCode then
  begin
    FSeqLength := FDecodeTable[LCode].Length;
    LJ := LCode;
    LI := FSeqLength - 1;
    while LI > 0 do
    begin
      FSeqBuf[LI] := FDecodeTable[LJ].FTail;
      LJ := FDecodeTable[LJ].FHead;
      Dec(LI);
    end;
    FSeqBuf[0] := AnsiChar(LJ);
  end
  else if LCode = FNextCode then
  begin
    FSeqBuf[FSeqLength] := AnsiChar(FNewChar);
    Inc(FSeqLength);
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Bad LZW stream - unexpected code');
{$ENDIF}
    FEof := True;
    Result := False;
    Exit;
  end;
  FNewChar := Integer(FSeqBuf[0]);
  if FFirst then
    FFirst := False
  else
  begin
    FDecodeTable[FNextCode].Length := LNextLength;
    FDecodeTable[FNextCode].FHead := FPrevCode;
    FDecodeTable[FNextCode].FTail := AnsiChar(FNewChar);
    Inc(FNextCode);
    if (FNextCode + FEarlyChange) = 512 then
      FNextBits := 10
    else if (FNextCode + FEarlyChange) = 1024 then
      FNextBits := 11
    else if (FNextCode + FEarlyChange) = 2048 then
      FNextBits := 12
  end;
  FPrevCode := LCode;

  // reset buffer
  FSeqIndex := 0;
  Result := True;
end;

  (**
   * Gets a charecter from Fstream
   * @return A charecter(integer value)
   *)

function TgtLZWDecode.GetChar: Integer;
begin
  if (FStreamPredictor <> nil) then
  begin
    Result := FStreamPredictor.ReadChar;
    Exit;
  end;
  if FEof then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  if (FSeqIndex >= FSeqLength) then
  begin
    if not (ProcessNextCode) then
    begin
      Result := ENDOFFILE;
      Exit;
    end;
  end;
  // AnsiChar to Integer - Check
  Result := Integer(FSeqBuf[FSeqIndex]);
  Inc(FSeqIndex);
end;

  (**
   * Gets the raw charecter
   * @return the raw charecter(Integer Value)
   *)

function TgtLZWDecode.ReadRawChar: Integer;
begin
  if FEof then
  begin
    Result := ENDOFFILE;
    Exit;
  end;
  if FSeqIndex >= FSeqLength then
    if not ProcessNextCode then
    begin
      Result := ENDOFFILE;
      Exit;
    end;
  Result := Integer(FSeqBuf[FSeqIndex]);
  Inc(FSeqIndex);
end;

(**
 * Resets the Stream to its defaults
 * @exception ExInvalidStream if FStream is NULL
 *)

procedure TgtLZWDecode.Reset;
begin
  try
    FStream.Reset;
  except
    on E: EAccessViolation do
      raise ExInvalidStream.Create(ErrInvalidStream);
  end;
  FEof := False;
  FInputBits := 0;
  ClearTable;
end;

end.
