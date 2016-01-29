{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDExponentialFunction;

interface

uses
  PDBaseObject, PDFunction;

type
  TgtExpArray = array[0..FunctionMaxOutputs - 1] of Double;

  TgtPDExponentialFunction = class(TgtPDFunction)
  private
    FC0: TgtExpArray;
    FC1: TgtExpArray;
    FE: Double;
    FOk: Boolean;

    constructor Create(AFunc: TgtPDExponentialFunction); overload;
  public
    constructor Create(AFunctObj: TgtPDBaseObject; ADict: TgtPDBaseObject); overload;
    function Copy: TgtPDFunction; override;
    function GetType: TgtFunctionType; override;
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); override;
    function IsOk: Boolean; override;
    function GetC0: TgtExpArray;
    function GetC1: TgtExpArray;
    function GetE: Double;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  Math, gtConstants, PDDictionary, PDArray, PDReal, PDInteger;

{ TgtPDExponentialFunction }

function TgtPDExponentialFunction.Copy: TgtPDFunction;
begin
  Result := TgtPDExponentialFunction.Create(Self);
end;

constructor TgtPDExponentialFunction.Create(AFunctObj, ADict: TgtPDBaseObject);
var
  LObj, LObj2: TgtPDBaseObject;
  LI: Integer;
begin
  FOk := False;
  if not Init(ADict) then
    Exit;

  if (FM <> 1) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Exponential function with more than one input');
    {$ENDIF}
    Exit;
  end;

  //----- C0
  LObj := TgtPDDictionary(ADict).LookUp(PDF_C0);
  if Assigned(LObj) then
  begin
    if LObj.IsArray then
    begin
      if (FHasRange and (TgtPDArray(LObj).GetLength <> FN)) then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Function''''s C0 array is wrong length');
        {$ENDIF}
        Exit;
      end;
      FN := TgtPDArray(LObj).GetLength;
      for LI := 0 to FN - 1 do
      begin
        LObj2 := TgtPDArray(LObj).Get(LI);
        if Assigned(LObj2) then
        begin
          if not LObj2.IsNumber then
          begin
            {$IFDEF DEBUG}
            Logger.LogError('Illegal value in function C0 array');
            {$ENDIF}
            Exit;
          end;
        end;
        if LObj2.IsReal then
          FC0[LI] := TgtPDReal(LObj2).Value
        else
          FC0[LI] := TgtPDInteger(LObj2).Value;
      end;
    end
    else
    begin
      if FHasRange and (FN <> 1) then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Function''''s C0 array is wrong length');
        {$ENDIF}
        Exit;
      end;
      FN := 1;
      FC0[0] := 0;
    end;
  end;

  //----- C1
  LObj := TgtPDDictionary(ADict).LookUp(PDF_C1);
  if Assigned(LObj) then
  begin
    if LObj.IsArray then
    begin
      if TgtPDArray(LObj).GetLength <> FN then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Function''''s C1 array is wrong length');
        {$ENDIF}
        Exit;
      end;
      for LI := 0 to FN - 1 do
      begin
        LObj2 := TgtPDArray(LObj).Get(LI);
        if not LObj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function C1 array');
          {$ENDIF}
          Exit;
        end;
        if LObj2.IsReal then
          FC1[LI] := TgtPDReal(LObj2).Value
        else
          FC1[LI] := TgtPDInteger(LObj2).Value;
      end;
    end
    else
    begin
      if (FN <> 1) then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Function''''s C1 array is wrong length');
        {$ENDIF}
        Exit;
      end;
      FC1[0] := 1;
    end;
  end;

  //----- N (exponent)
  LObj := TgtPDDictionary(ADict).LookUp(PDF_N);
  if Assigned(LObj) then
  begin
    if not LObj.IsNumber then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Function has missing or invalid N');
      {$ENDIF}
      Exit;
    end;
  end;
  if LObj.IsReal then
    FE := TgtPDReal(LObj).Value
  else
    FE := TgtPDInteger(LObj).Value;

  FOk := True;
end;

constructor TgtPDExponentialFunction.Create(AFunc: TgtPDExponentialFunction);
begin

end;

function TgtPDExponentialFunction.GetC0: TgtExpArray;
begin
  Result := FC0;
end;

function TgtPDExponentialFunction.GetC1: TgtExpArray;
begin
  Result := FC1;
end;

function TgtPDExponentialFunction.GetE: Double;
begin
  Result := FE;
end;

function TgtPDExponentialFunction.GetType: TgtFunctionType;
begin
  Result := ftExponential;
end;

function TgtPDExponentialFunction.IsOk: Boolean;
begin
  Result := FOk;
end;

procedure TgtPDExponentialFunction.Transform(AInput: TgtDoubleArray;
  var AOutput: TgtDoubleArray);
var
  LX: Double;
  LI: Integer;
begin
  if AInput[0] < FDomain[0][0] then
    LX := FDomain[0][0]
  else if AInput[0] > FDomain[0][1] then
    LX := FDomain[0][1]
  else
    LX := AInput[0];

  for LI := 0 to FN - 1 do
  begin
    AOutput[LI] := FC0[LI] + Power(LX, FE) * (FC1[LI] - FC0[LI]);
    if FHasRange then
    begin
      if (AOutput[LI] < FRange[LI][0]) then
        AOutput[LI] := FRange[LI][0]
      else if AOutput[LI] > FRange[LI][1] then
        AOutput[LI] := FRange[LI][1];
    end;
  end;
end;

end.
