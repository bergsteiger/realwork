{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDFunction;

interface

uses
  gtObject, PDBaseObject;

const
  FunctionMaxInputs = 32;
  FunctionMaxOutputs = 32;
  SampledFuncMaxInputs = 16;

type
  TgtFunctionType = (ftIdentity, ftSampled, ftExponential, ftStitching, ftPostScript);
  TgtDoubleArray = array[0..FunctionMaxInputs - 1] of Double;
  TgtArrayOfDouble = array of Double;

  TgtPDFunction = class(TgtObject)
  protected
    FM: Integer; // size of input tuples
    FN: Integer; // size of output tuples

    // min and max values for function domain
    FDomain: array[0..FunctionMaxInputs - 1, 0..1] of Double;

    // min and max values for function range
    FRange: array[0..FunctionMaxOutputs - 1, 0..1] of Double;

    FHasRange: Boolean;
  public
    class function MakeFunction(AFuncObj: TgtPDBaseObject): TgtPDFunction;

    destructor Destroy; override;

    // Initialize the entries common to all function types.
    function Init(ADict: TgtPDBaseObject): Boolean;

    function Copy: TgtPDFunction; virtual;
    function GetType: TgtFunctionType; virtual;

    // Return size of input and output tuples.
    function GetInputSize: Integer;
    function GetOutputSize: Integer;

    function GetDomainMin(Index: Integer): Double;
    function GetDomainMax(Index: Integer): Double;
    function GetRangeMin(Index: Integer): Double;
    function GetRangeMax(Index: Integer): Double;
    function HasRange: Boolean;

    // Transform an input tuple into an output tuple.
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); virtual;

    function IsOk: Boolean; virtual; // set if range is defined
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, gtMethods, PDStream, PDDictionary, PDIdentityFunction,
  PDSampledFunction, PDExponentialFunction, PDStitchingFunction,
  PDPostScriptFunction, PDArray, PDReal, PDInteger;
{ TgtPDFunction }

function TgtPDFunction.Copy: TgtPDFunction;
begin
  Result := nil;
end;

destructor TgtPDFunction.Destroy;
begin

  inherited;
end;

function TgtPDFunction.GetDomainMax(Index: Integer): Double;
begin
  Result := FDomain[Index][1];
end;

function TgtPDFunction.GetDomainMin(Index: Integer): Double;
begin
  Result := FDomain[Index][0];
end;

function TgtPDFunction.GetInputSize: Integer;
begin
  Result := FM;
end;

function TgtPDFunction.GetOutputSize: Integer;
begin
  Result := FN;
end;

function TgtPDFunction.GetRangeMax(Index: Integer): Double;
begin
  Result := FRange[Index][1];
end;

function TgtPDFunction.GetRangeMin(Index: Integer): Double;
begin
  Result := FRange[Index][0];
end;

function TgtPDFunction.GetType: TgtFunctionType;
begin
  Result := ftIdentity;
end;

function TgtPDFunction.HasRange: Boolean;
begin
  Result := FHasRange;
end;

function TgtPDFunction.Init(ADict: TgtPDBaseObject): Boolean;
var
  LObj1, Lobj2: TgtPDBaseObject;
  LI: Integer;
begin
  //----- Domain
  Result := False;
  LObj1 := TgtPDDictionary(ADict).LookUp(PDF_DOMAIN);
  if Assigned(LObj1) then
  begin
    if not LObj1.IsArray then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Function is missing domain');
      {$ENDIF}
      Result := False;
      Exit;
    end;
  end;

  FM := TgtPDArray(LObj1).GetLength div 2;
  if (FM > FunctionMaxInputs) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Functions with more than %d inputs are unsupported', [FunctionMaxInputs]);
    {$ENDIF}
    Result := False;
    Exit;
  end;

  for LI := 0 to FM - 1 do
  begin
    Lobj2 := TgtPDArray(LObj1).Get(2 * LI);
    if not Lobj2.IsNumber then
    begin
      Result := False;
      {$IFDEF DEBUG}
      Logger.LogError('Illegal value in function domain array');
      {$ENDIF}
      Exit;
    end;
    if LObj2.IsReal then
      FDomain[LI][0] := TgtPDReal(Lobj2).Value
    else
      FDomain[LI][0] := TgtPDInteger(Lobj2).Value;
    Lobj2 := TgtPDArray(LObj1).Get(2 * LI + 1);
    if not Lobj2.IsNumber then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Illegal value in function domain array');
      {$ENDIF}
      Exit;
    end;
    if LObj2.IsReal then
      FDomain[LI][1] := TgtPDReal(Lobj2).Value
    else
      FDomain[LI][1] := TgtPDInteger(Lobj2).Value;
  end;

  //----- Range
  FHasRange := False;
  FN := 0;
  LObj1 := TgtPDDictionary(ADict).LookUp(PDF_RANGE);
  if Assigned(LObj1) then
  begin
    if LObj1.IsArray then
    begin
      FHasRange := True;
      FN := TgtPDArray(LObj1).GetLength div 2;
      if FN > FunctionMaxOutputs then
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Functions with more than %d outputs are unsupported',
          [FunctionMaxOutputs]);
        {$ENDIF}
        Result := False;
        Exit;
      end;
      for LI := 0 to FN - 1 do
      begin
        Lobj2 := TgtPDArray(LObj1).Get(2 * LI);
        if not Lobj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function range array');
          {$ENDIF}
          Exit;
        end;
        if Lobj2.IsReal then
          FRange[LI][0] := TgtPDReal(Lobj2).Value
        else
          FRange[LI][0] := TgtPDInteger(Lobj2).Value;
        Lobj2 := TgtPDArray(LObj1).Get(2 * LI + 1);
        if not Lobj2.IsNumber then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Illegal value in function range array');
          {$ENDIF}
          Exit;
        end;
        if Lobj2.IsReal then
          FRange[LI][1] := TgtPDReal(Lobj2).Value
        else
          FRange[LI][1] := TgtPDInteger(Lobj2).Value;
      end;
    end;
  end;
  Result := True;
end;

function TgtPDFunction.IsOk: Boolean;
begin
  Result := False;
end;

class function TgtPDFunction.MakeFunction(
  AFuncObj: TgtPDBaseObject): TgtPDFunction;
var
  LDictObj, LObj: TgtPDBaseObject;
  LFuncType: Integer;
  LFunction: TgtPDFunction;
begin
  Result := nil;
  LDictObj := nil;
  if AFuncObj.IsStream then
    LDictObj := TgtPDStream(AFuncObj).GetDict
  else if AFuncObj.IsDict then
    LDictObj := AFuncObj
  else if AFuncObj.IsName(PDF_IDENTITY) then
    Result := TgtPDIdentityFunction.Create
  else
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Expected function dictionary or stream');
    {$ENDIF}
    Exit;
  end;
  if Assigned(LDictObj) then
  begin
    LObj := TgtPDDictionary(LDictObj).LookUp(PDF_FUNCTIONTYPE);
    if not LObj.IsInteger then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Function type is missing or wrong type');
      {$ENDIF}
      Exit;
    end;

    LFuncType := TgtPDInteger(LObj).Value;

    case LFuncType of
      0: LFunction := TgtPDSampledFunction.Create(AFuncObj, LDictObj);
      2: LFunction := TgtPDExponentialFunction.Create(AFuncObj, LDictObj);
      3: LFunction := TgtPDStitchingFunction.Create(AFuncObj, LDictObj);
      4: LFunction := TgtPDPostScriptFunction.Create(AFuncObj, LDictObj);
    else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Unimplemented function type (%d)', [LFuncType]);
        {$ENDIF}
        Exit;
      end;
    end;
  end;

  if not LFunction.IsOk then
  begin
    FreeObject(LFunction);
    Exit;
  end;

  Result := LFunction;
end;

procedure TgtPDFunction.Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray);
begin

end;

end.
