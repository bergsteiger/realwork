{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDStitchingFunction;

interface

uses
  PDBaseObject, PDFunction;

type
  TgtPDStitchingFunction = class(TgtPDFunction)
  private
    FFuncs: array of TgtPDFunction;
    FK: Integer;
    FBounds: TgtArrayOfDouble;
    FEncode: TgtArrayOfDouble;
    FScale: TgtArrayOfDouble;
    FOk: Boolean;

    constructor Create(AStitchingFunc: TgtPDStitchingFunction); overload;
  public
    constructor Create(AFunctObj: TgtPDBaseObject; ADict: TgtPDBaseObject); overload;
    function Copy: TgtPDFunction; override;
    function GetType: TgtFunctionType; override;
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); override;
    function IsOk: Boolean; override;
    function GetNoOfFunctions: Integer;
    function GetFunc(Index: Integer): TgtPDFunction;
    function GetBounds: TgtArrayOfDouble;
    function GetEncode: TgtArrayOfDouble;
    function GetScale: TgtArrayOfDouble;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDDictionary, PDArray, PDReal, PDInteger;

{ TgtPDStitchingFunction }

function TgtPDStitchingFunction.Copy: TgtPDFunction;
begin
  Result := TgtPDStitchingFunction.Create(Self);
end;

constructor TgtPDStitchingFunction.Create(
  AStitchingFunc: TgtPDStitchingFunction);
begin

end;

constructor TgtPDStitchingFunction.Create(AFunctObj, ADict: TgtPDBaseObject);
var
  LObj, LObj2: TgtPDBaseObject;
  LI: Integer;
  LTempFunc: TgtPDFunction;
begin
//  LTempFunc := nil;
  FOk := False;
  FFuncs := nil;

  //----- initialize the generic stuff
  if not Init(ADict) then
    Exit;

  if (FM <> 1) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Stitching function with more than one input');
    {$ENDIF}
    Exit;
  end;

  //----- Functions
  LObj := TgtPDDictionary(ADict).LookUp(PDF_FUNCTIONS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Missing ''''Functions'''' entry in stitching function');
      {$ENDIF}
      Exit;
    end;
  end;

  FK := TgtPDArray(LObj).GetLength;
  SetLength(FFuncs, FK);
  SetLength(FBounds, FK + 1);
  SetLength(FEncode, 2 * FK);
  SetLength(FScale, FK);

  for LI := 0 to FK - 1 do
    FFuncs[LI] := nil;

  for LI := 0 to FK - 1 do
  begin
    LObj2 := TgtPDArray(LObj).Get(LI);
    LTempFunc := TgtPDFunction.MakeFunction(LObj2);
    if Assigned(LTempFunc) then
      FFuncs[LI] := LTempFunc
    else
      Exit;

    if (LI > 0) and ((FFuncs[LI].GetInputSize <> 1) or
      (FFuncs[LI].GetOutputSize <> FFuncs[0].GetOutputSize)) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Incompatible subfunctions in stitching function');
      {$ENDIF}
      Exit;
    end;
//    LObj2 := nil;
  end;
//  LObj := nil;

  //----- Bounds
  LObj := TgtPDDictionary(ADict).LookUp(PDF_BOUNDS);
  if Assigned(LObj) then
  begin
    if (not LObj.IsArray) or (TgtPDArray(LObj).GetLength <> FK - 1) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Missing or invalid ''''Bounds'''' entry in stitching function');
      {$ENDIF}
      Exit;
    end;
  end;
  FBounds[0] := FDomain[0][0];
  for LI := 0 to FK - 1 do
  begin
    LObj2 := TgtPDArray(LObj).Get(LI);
    if not LObj2.IsNumber then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid type in ''''Bounds'''' array in stitching function');
      {$ENDIF}
      Exit;
    end;
    if LObj2.IsReal then
      FBounds[LI] := TgtPDReal(LObj2).Value
    else
      FBounds[LI] := TgtPDInteger(LObj2).Value;
//    LObj2 := nil;
  end;
  FBounds[FK] := FDomain[0][1];
//  LObj := nil;

  //----- Encode
  LObj := TgtPDDictionary(ADict).LookUp(PDF_ENCODE);
  if Assigned(LObj) then
  begin
    if (not LObj.IsArray) or (TgtPDArray(LObj).GetLength <> (2 * FK)) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Missing or invalid ''''Encode'''' entry in stitching function');
      {$ENDIF}
    end;
  end;

  for LI := 0 to (2 * FK) - 1 do
  begin
    LObj2 := TgtPDArray(LObj).Get(LI);
    if not LObj2.IsNumber then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid type in ''''Encode'''' array in stitching function');
      {$ENDIF}
      Exit;
    end;
    if LObj2.IsReal then
      FEncode[LI] := TgtPDReal(LObj2).Value
    else
      FEncode[LI] := TgtPDInteger(LObj2).Value;
//    LObj2 := nil;
  end;
//  LObj := nil;

  //----- pre-compute the scale factors
  for LI := 0 to FK - 1 do
  begin
    if FBounds[LI] = FBounds[LI + 1] then
    begin
      // avoid a divide-by-zero -- in this situation, function i will
      // never be used anyway
      FScale[LI] := 0;
    end
    else
      FScale[LI] := (FEncode[2 * LI + 1] - FEncode[2 * LI]) / (FBounds[LI + 1] - FBounds[LI]);
  end;

  FOk := True;
end;

function TgtPDStitchingFunction.GetBounds: TgtArrayOfDouble;
begin
  Result := FBounds;
end;

function TgtPDStitchingFunction.GetEncode: TgtArrayOfDouble;
begin
  Result := FEncode;
end;

function TgtPDStitchingFunction.GetFunc(Index: Integer): TgtPDFunction;
begin
  Result := FFuncs[Index];
end;

function TgtPDStitchingFunction.GetNoOfFunctions: Integer;
begin
  Result := FK;
end;

function TgtPDStitchingFunction.GetScale: TgtArrayOfDouble;
begin
  Result := FScale;
end;

function TgtPDStitchingFunction.GetType: TgtFunctionType;
begin
  Result := ftStitching;
end;

function TgtPDStitchingFunction.IsOk: Boolean;
begin
  Result := FOk;
end;

procedure TgtPDStitchingFunction.Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray);
var
  LX: TgtDoubleArray;
  LI: Integer;
begin
  if (AInput[0] < FDomain[0][0]) then
    LX[0] := FDomain[0][0]
  else if (AInput[0] > FDomain[0][1]) then
    LX[0] := FDomain[0][1]
  else
    LX[0] := AInput[0];

  for LI := 0 to FK - 2 do
  begin
    if LX[0] < FBounds[LI + 1] then
      Break;
  end;

  LX[0] := FEncode[2 * LI] + (LX[0] - FBounds[LI]) * FScale[LI];
  FFuncs[LI].Transform(LX, AOutput);
end;

end.
