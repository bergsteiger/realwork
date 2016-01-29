{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit Predictor;

interface

uses FilterStream, Stream;

type
  {
    TgtStreamPredictor
      StreamPredictor class implements the Predictor alogorithms.
      This enables to read the Characters from the stream with respect to the
      algorithm.
  }

  TgtStreamPredictor = class(TObject)
  private
    { private declarations }
    FStream: TgtFilterStream; // filter stream
    FPredictor: Integer; // predictor
    FWidth: Integer; // pixels per line
    FComps: Integer; // components per pixel
    FBits: Integer; // bits per component
    FValues: Integer; // components per line
    FPixBytes: Integer; // bytes per pixel
    FLineIndex: Integer; // current index in line buffer
    FRowBytes: Integer; // bytes per line
    FLine: array of Byte; // line buffer
    FOk: Boolean;
    FIsEOF: Boolean;  //True on end of file
    function ReadNextLine: Boolean;

  public
    { public declarations }
    constructor Create(AStream: TgtStream; APredictor: Integer;
      AComponents: Integer; AWidth: Integer; ABits: Integer);
    destructor Destroy; override;
    function IsOk: Boolean;
    function LookChar: Integer;
    function ReadChar: Integer;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  Classes, StreamConsts, StreamExceptions;


{ TgtStreamPredictor }

(**
 * Constructor
 * @param AStream the stream that need to be decoded
 * @param APredictor a code that selects the predictor algorithm
 * @param AComponents The number of interleaved color components per sample.
 * @param AWidth The number of samples in each row.
 * @param ABits The number of bits used to represent each color component in a
          sample. Valid values are 1, 2, 4, 8, 16
 *
 * @exception ExOutofMemory will be raised on allocation out of memory
 *)

constructor TgtStreamPredictor.Create(AStream: TgtStream; APredictor,
  AComponents, AWidth: Integer; ABits: Integer);
begin
  FStream := TgtFilterStream(AStream);
  FPredictor := APredictor;
  FWidth := AWidth;
  FComps := AComponents;
  FBits := ABits;
  FOk := False;
  FIsEOF := False;

  FValues := FWidth * FComps;
  if ((FWidth <= 0) or (FComps <= 0) or (FBits <= 0) or
    (FComps >= MaxInt div FBits) or (FWidth >= MaxInt div FComps div FBits) or
    ((FValues * FBits + 7) < 0)) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Invalid Input value');
{$ENDIF}
    Exit;
  end;

  FPixBytes := (FComps * FBits + 7) shr 3;
  FRowBytes := ((FValues * FBits + 7) shr 3) + FPixBytes;
  if (FRowBytes <= 0) then
  begin
{$IFDEF DEBUG}
    Logger.LogInfo('Constant expression violates subrange bounds');
{$ENDIF}
    Exit;
  end
  else
  begin
    try
      SetLength(FLine, FRowBytes);
    except
    // Catch Out of Memory Exception
      on E: EOutOfResources do
        raise ExOutofMemory.Create(ErrOutofMemory);
    end;
    FLineIndex := FRowBytes;
  end;
  FOk := True;
end;

(**
 * Destructor
 *)

destructor TgtStreamPredictor.Destroy;
begin
  SetLength(FLine, 0);
  inherited;
end;

function TgtStreamPredictor.IsOk: Boolean;
begin
  Result := FOk;
end;

(**
 * Reads next charecter from the stream without changing the current position
 * @return The charecter after decoding it using the curresponding algorithm
 *
 * @exception ExInvalidStream will be raise if the stream is nil
 *)

function TgtStreamPredictor.LookChar: Integer;
begin
  if FLineIndex >= FRowBytes then
  begin
    if not (ReadNextLine) then
    begin
      Result := EndofFile;
      Exit;
    end
  end;
  Result := FLine[FLineIndex + 1];
end;

(**
 * Reads next charecter from the stream after decoding using curresponding algorithm
 * @return The charecter after decoding it using the curresponding algorithm
 *
 * @exception ExInvalidStream will be raise if the stream is nil
 *)

function TgtStreamPredictor.ReadChar: Integer;
begin
  if FLineIndex >= FRowBytes then
  begin
    if not (ReadNextLine) then
    begin
      Result := EndofFile;
      Exit;
    end
  end;
  if FIsEOF then
    Result := EndofFile
  else
    Result := FLine[FLineIndex];
  Inc(FLineIndex);
end;

function TgtStreamPredictor.ReadNextLine: Boolean;
var
  LCurrPreditor, LLeft, LUp, LUpLeft,
    LI, LJ, LK, LKk, LC, LP, LPa, LPb, LPc,
    LInBits, LOutBits: Integer;
  LUpLeftBuff: array[0..64] of Integer;
  LInBuff, LOutBuff, LBitMask: Longint;
begin
  if (FStream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  // get PNG optimum predictor number
  if (FPredictor > 10) then
  begin
    LCurrPreditor := FStream.ReadRawChar;
    if (LCurrPreditor = EndofFile) then
    begin
      Result := False;
      Exit;
    end;
    LCurrPreditor := LCurrPreditor + 10;
  end
  else
    LCurrPreditor := FPredictor;

  for LI := 0 to FPixBytes do
    LUpLeftBuff[LI] := 0;

  for LI := FPixBytes to FRowBytes - 1 do
  begin
    LJ := FPixBytes;
    while LJ > 0 do
    begin
      LUpLeftBuff[LJ] := LUpLeftBuff[LJ - 1];
      Dec(LJ);
    end;
    LUpLeftBuff[0] := FLine[LI];
    LC := FStream.ReadRawChar;
    if LC = EndofFile then
    begin
      FIsEOF := True;
      if LI > FPixBytes then
        Break;
    end;
    case LCurrPreditor of
      // PNG sub
      11: FLine[LI] := FLine[LI - FPixBytes] + LC;
      // PNG up
      12: FLine[LI] := FLine[LI] + LC;
      // PNG average
      13: FLine[LI] := ((FLine[LI - FPixBytes] + FLine[LI]) shr 1) + LC;
      // PNG Paeth
      14:
        begin
          LLeft := FLine[LI - FPixBytes];
          LUp := FLine[LI];
          LUpLeft := LUpLeftBuff[FPixBytes];
          LP := LLeft + LUp - LUpLeft;
          LPa := LP - LLeft;
          if LPa < 0 then
            LPa := -(LPa);
          LPb := LP - LUp;
          if LPb < 0 then
            LPb := -(LPb);
          LPc := LP - LUpLeft;
          if LPc < 0 then
            LPc := -(LPc);
          if ((LPa <= LPb) and (LPa <= LPc)) then
            FLine[LI] := LLeft + LC
          else if LPb <= LPc then
            FLine[LI] := LUp + LC
          else
            FLine[LI] := LUpLeft + LC;
        end;
      // PNG none
      10: FLine[LI] := LC;
    else
      FLine[LI] := LC; // no predictor or TIFF predictor
    end; // Case
  end; // For loop

  // apply TIFF (component) predictor
  if (FPredictor = 2) then
  begin
    if (FBits = 1) then
    begin
      LInBuff := FLine[FPixBytes - 1];
      LI := FPixBytes;
      while (LI < FRowBytes) do
      begin
        LInBuff := (LInBuff shl 8) or FLine[LI]; // 1-bit add is just xor
        FLine[LI] := FLine[LI] xor LInBuff shr FComps;
        Inc(LI, 8);
      end;
    end
    else if FBits = 8 then
    begin
      for LI := FPixBytes to FRowBytes - 1 do
      begin
        FLine[LI] := FLine[LI] + FLine[LI - FComps];
      end;
    end
    else
    begin
      for LI := 0 to FComps + 1 do
        LUpLeftBuff[LI] := 0;
      LBitMask := (1 shl FBits) - 1;
      LInBuff := 0;
      LOutBuff := 0;
      LInBits := 0;
      LOutBits := 0;
      LJ := FPixBytes;
      LK := FPixBytes;
      for LI := 0 to FWidth - 1 do
      begin
        for LKk := 0 to FComps - 1 do
        begin
          if LInBits < FBits then
          begin
            LInBuff := (LInBuff shl 8) or (FLine[LJ] and $FF);
            Inc(LJ);
            LInBits := LInBits + 8;
          end;
          LUpLeftBuff[LKk] := (LUpLeftBuff[LKk] + (LInBuff shr (LInBits - FBits))) and LBitMask;
          LInBits := LInBits - FBits;
          LOutBuff := (LOutBuff shl FBits) or LUpLeftBuff[LKk];
          LOutBits := LOutBits + FBits;
          if (LOutBits >= 8) then
          begin
            FLine[LK] := LOutBuff shr (LOutBits - 8);
            Inc(LK);
            LOutBits := LOutBits - 8;
          end;
        end;
      end;
      if LOutBits > 0 then
      begin
        FLine[LK] := ((LOutBuff shl (8 - LOutBits)) + (LInBuff and ((1 shl (8 - LOutBits))) - 1));
      end;
    end;
  end;
  // reset to start of line
  FLineIndex := FPixBytes;
  Result := True;
end;

end.
