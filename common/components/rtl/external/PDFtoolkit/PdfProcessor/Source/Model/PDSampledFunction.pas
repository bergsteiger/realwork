{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDSampledFunction;

interface

uses
  PDBaseObject, PDFunction;

type
  TgtSampleArray = array of Double;
  TgtPDSampledFunction = class(TgtPDFunction)
  private
    // number of samples for each domain element
    FSampleSize: array[0..FunctionMaxInputs - 1] of Integer;

    // min and max values for domain encoder
    FEncode: array[0..FunctionMaxInputs - 1, 0..1] of Double;

    // min and max values for range decoder
    FDecode: array[0..FunctionMaxOutputs - 1, 0..1] of Double;

    // input multipliers
    FInputMul: array[0..FunctionMaxInputs - 1] of Double;

    // sample array index multipliers
    FIdxMul: array[0..FunctionMaxInputs - 1] of Integer;

    FSamples: TgtSampleArray; // the samples
    FNSamples: Integer; // size of the samples array
    FSBuff: array of Double; // buffer for the transform function
    FOk: Boolean;

//    procedure Create(AFunc: TgtPDSampledFunction); overload;
  public
    constructor Create(AFunctionObj: TgtPDBaseObject; ADict: TgtPDBaseObject); overload;
    destructor Destroy; override;

    function Copy: TgtPDFunction; override;
    function GetType: TgtFunctionType; override;
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); override;
    function IsOk: Boolean; override;

    function GetSampleSize(Index: Integer): Integer;
    function GetEncodingMin(Index: Integer): Double;
    function GetEncodingMax(Index: Integer): Double;
    function GetDecodingMin(Index: Integer): Double;
    function GetDecodingMax(Index: Integer): Double;
    function GetSamples: TgtSampleArray;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  Math, gtConstants, Stream, PDStream, PDDictionary, PDArray,
  PDInteger, PDReal;

{ TgtPDSampledFunction }

function TgtPDSampledFunction.Copy: TgtPDFunction;
begin
  Result := TgtPDSampledFunction.Create(nil, nil);
end;

constructor TgtPDSampledFunction.Create(AFunctionObj, ADict: TgtPDBaseObject);
var
  LStream: TgtStream;
  LObj, LObj2: TgtPDBaseObject;
  LI, LBuff, LBits, LBitMask, LSampleBits, LS: Integer;
  LSampleMul: Double;
begin
  //----- initialize the generic stuff
  if not Init(ADict) then
    Exit;

  if not FHasRange then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Type 0 function is missing range');
    {$ENDIF}
    Exit;
  end;

  if (FM > SampledFuncMaxInputs) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Sampled functions with more than %d inputs are unsupported',
      [SampledFuncMaxInputs]);
    {$ENDIF}
    Exit;
  end;

  //----- buffer
  SetLength(FSBuff, (1 shl FM));

  //----- get the stream
  if not AFunctionObj.IsStream then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Type 0 function isn''''t a stream');
    {$ENDIF}
    Exit;
  end;

  LStream := TgtPDStream(AFunctionObj).GetStream;

  LObj := TgtPDDictionary(ADict).LookUp(PDF_SIZE);
  if Assigned(LObj) then
  begin
    if (not LObj.IsArray) or (TgtPDArray(LObj).GetLength <> FM) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Function has missing or invalid size array');
      {$ENDIF}
      Exit;
    end;
  end;

  for LI := 0 to FM - 1 do
  begin
    LObj2 := TgtPDArray(LObj).Get(LI);
    if not LObj2.IsInteger then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Illegal value in function size array');
      {$ENDIF}
      Exit;
    end;
    FSampleSize[LI] := TgtPDInteger(LObj2).Value;
  end;
  FIdxMul[0] := FN;
  for LI := 1 to FM - 1 do
    FIdxMul[LI] := FIdxMul[LI - 1] * FSampleSize[LI - 1];

  //----- BitsPerSample
  LObj := TgtPDDictionary(ADict).LookUp(PDF_BITSPERSAMPLE);
  if Assigned(LObj) then
  begin
    if not LObj.IsInteger then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Function has missing or invalid BitsPerSample');
      {$ENDIF}
      Exit;
    end;
  end;

  LSampleBits := TgtPDInteger(LObj).Value;
  LSampleMul := 1.0 / (Power(2, LSampleBits) - 1);

  //----- Encode
  LObj := TgtPDDictionary(ADict).LookUp(PDF_ENCODE);
  if Assigned(LObj) then
  begin
    if (LObj.IsArray and (TgtPDArray(LObj).GetLength = 2 * FM)) then
    begin
      for LI := 0 to FM - 1 do
      begin
        LObj2 := TgtPDArray(LObj).Get(2 * LI);
        if not LObj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function encode array');
          {$ENDIF}
          Exit;
        end;
        if LObj2.IsReal then
          FEncode[LI][0] := TgtPDReal(LObj2).Value
        else
          FEncode[LI][0] := TgtPDInteger(LObj2).Value;
        LObj2 := TgtPDArray(LObj).Get(2 * LI + 1);
        if not LObj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function encode array');
          {$ENDIF}
          Exit;
        end;
        if LObj2.IsReal then
          FEncode[LI][1] := TgtPDReal(LObj2).Value
        else
          FEncode[LI][1] := TgtPDInteger(LObj2).Value;
      end;
    end;
  end
  else
  begin
    for LI := 0 to FM - 1 do
    begin
      FEncode[LI][0] := 0;
      FEncode[LI][1] := FSampleSize[LI] - 1;
    end;
  end;
  for LI := 0 to FM - 1 do
    FInputMul[LI] := (FEncode[LI][1] - FEncode[LI][0]) / (FDomain[LI][1] -
      FDomain[LI][0]);

  //----- Decode
  LObj := TgtPDDictionary(ADict).LookUp(PDF_DECODE);
  if Assigned(LObj) then
  begin
    if (LObj.IsArray) and (TgtPDArray(LObj).GetLength = (2 * FN)) then
    begin
      for LI := 0 to FN - 1 do
      begin
        LObj2 := TgtPDArray(LObj).Get(2 * LI);
        if not LObj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function decode array');
          {$ENDIF}
          Exit;
        end;
        if LObj2.IsReal then
          FDecode[LI][0] := TgtPDReal(LObj2).Value
        else
          FDecode[LI][0] := TgtPDInteger(LObj2).Value;
        LObj2 := TgtPDArray(LObj).Get(2 * LI + 1);
        if not LObj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function decode array');
          {$ENDIF}
          Exit;
        end;
        if LObj2.IsReal then
          FDecode[LI][1] := TgtPDReal(LObj2).Value
        else
          FDecode[LI][1] := TgtPDInteger(LObj2).Value;
      end;
    end;
  end
  else
  begin
    for LI := 0 to FN - 1 do
    begin
      FDecode[LI][0] := FRange[LI][0];
      FDecode[LI][1] := FRange[LI][1];
    end;
  end;

  //----- samples
  FNSamples := FN;
  for LI := 0 to FM - 1 do
    FNSamples := FNSamples * FSampleSize[LI];

  SetLength(FSamples, FNSamples);
  LBuff := 0;
  LBits := 0;

  LBitMask := (1 shl LSampleBits) - 1;
  LStream.Reset;
  for LI := 0 to FNSamples - 1 do
  begin
    if (LSampleBits = 8) then
    begin
      LS := LStream.GetChar;
    end
    else if (LSampleBits = 16) then
    begin
      LS := LStream.GetChar;
      LS := (LS shl 8) + LStream.GetChar;
    end
    else if (LSampleBits = 32) then
    begin
      LS := LStream.GetChar;
      LS := (LS shl 8) + LStream.GetChar;
      LS := (LS shl 8) + LStream.GetChar;
      LS := (LS shl 8) + LStream.GetChar;
    end
    else
    begin
      while (LBits < LSampleBits) do
      begin
        LBuff := (LBuff shl 8) or (LStream.GetChar and $FF);
        LBits := LBits + 8;
      end;
      LS := ((LBuff shr (LBits - LSampleBits)) and LBitMask);
      LBits := LBits - LSampleBits;
    end;
    FSamples[LI] := LS * LSampleMul;
  end;
  LStream.Close;
  FOk := True;
end;

(*
procedure TgtPDSampledFunction.Create(AFunc: TgtPDSampledFunction);
begin

end;
*)

destructor TgtPDSampledFunction.Destroy;
begin
  SetLength(FSamples, 0);
  SetLength(FSBuff, 0);
end;

function TgtPDSampledFunction.GetDecodingMax(Index: Integer): Double;
begin
  Result := FDecode[Index][1];
end;

function TgtPDSampledFunction.GetDecodingMin(Index: Integer): Double;
begin
  Result := FDecode[Index][0];
end;

function TgtPDSampledFunction.GetEncodingMax(Index: Integer): Double;
begin
  Result := FEncode[Index][1];
end;

function TgtPDSampledFunction.GetEncodingMin(Index: Integer): Double;
begin
  Result := FEncode[Index][0];
end;

function TgtPDSampledFunction.GetSamples: TgtSampleArray;
begin
  Result := FSamples;
end;

function TgtPDSampledFunction.GetSampleSize(Index: Integer): Integer;
begin
  Result := FSampleSize[Index];
end;

function TgtPDSampledFunction.GetType: TgtFunctionType;
begin
  Result := ftSampled;
end;

function TgtPDSampledFunction.IsOk: Boolean;
begin
  Result := FOk;
end;

procedure TgtPDSampledFunction.Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray);
var
  LI, LJ: Integer;
  LX: Double;
  LE: array[0..FunctionMaxInputs - 1, 0..1] of Integer;
  LEFrac0, LEFrac1: array[0..FunctionMaxInputs - 1] of Double;
  LIdx: Integer;
  LK: Integer;
  LT: Integer;
begin
  // map input values into sample array
  for LI := 0 to FM - 1 do
  begin
    LX := (AInput[LI] - FDomain[LI][0]) * FInputMul[LI] + FEncode[LI][0];
    if (LX < 0) then
      LX := 0
    else if (LX > FSampleSize[LI] - 1) then
    begin
      LX := FSampleSize[LI] - 1;
    end;
    LE[LI][0] := Round(LX);
    LE[LI][1] := LE[LI][0] + 1;
    if (LE[LI][1] >= FSampleSize[LI]) then
    begin
      LE[LI][1] := LE[LI][0];
    end;
    LEFrac1[LI] := LX - LE[LI][0];
    LEFrac0[LI] := 1 - LEFrac1[LI];
  end;

  // for each output, do m-linear interpolation
  for LI := 0 to FN - 1 do
  begin
    // pull 2^m values out of the sample array
    for LJ := 0 to (1 shl FM) - 1 do
    begin
      LIdx := LI;
      LT := LJ;
      for LK := 0 to FM - 1 do
      begin
        LIdx := LIdx + FIdxMul[LK] * (LE[LK][LT and 1]);
        LT := (LT shr 1);
      end;
      FSBuff[LJ] := FSamples[LIdx];
    end;
    // do m sets of interpolations
    LT := (1 shl FM);
    for LJ := 0 to FM - 1 do
    begin
      LK := 0;
      while (LK < LT) do
      begin
        FSBuff[LK shr 1] := LEFrac0[LJ] * FSBuff[LK] + LEFrac1[LJ] * FSBuff[LK + 1];
        LK := LK + 2;
      end;
      LT := (LT shr 1);
    end;

    // map output value to range
    AOutput[LI] := FSBuff[0] * (FDecode[LI][1] - FDecode[LI][0]) + FDecode[LI][0];
    if (AOutput[LI] < FRange[LI][0]) then
      AOutput[LI] := FRange[LI][0]
    else if (AOutput[LI] > FRange[LI][1]) then
      AOutput[LI] := FRange[LI][1];
  end;
end;

end.
