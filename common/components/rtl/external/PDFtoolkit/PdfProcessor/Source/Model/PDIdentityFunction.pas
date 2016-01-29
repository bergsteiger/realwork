unit PDIdentityFunction;

interface

uses
  PDFunction;

type
  TgtPDIdentityFunction = class(TgtPDFunction)
  public
    constructor Create();
    destructor Destroy; override;

    function Copy: TgtPDFunction; override;
    function GetType: TgtFunctionType; override;
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); override;
    function IsOk: Boolean; override;
  end;

implementation


{ TgtPDIdentityFunction }

function TgtPDIdentityFunction.Copy: TgtPDFunction;
begin
  Result := TgtPDIdentityFunction.Create;
end;

constructor TgtPDIdentityFunction.Create;
var
  LI: Integer;
begin
  // fill these in with arbitrary values just in case they get used
  // somewhere
  FM := FunctionMaxInputs;
  FN := FunctionMaxOutputs;
  for LI := 0 to FunctionMaxInputs - 1 do
  begin
    FDomain[LI][0] := 0;
    FDomain[LI][1] := 1;
  end;
  FHasRange := False;
end;

destructor TgtPDIdentityFunction.Destroy;
begin

  inherited;
end;

function TgtPDIdentityFunction.GetType: TgtFunctionType;
begin
  Result := ftIdentity;
end;

function TgtPDIdentityFunction.IsOk: Boolean;
begin
  Result := True;
end;

procedure TgtPDIdentityFunction.Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray);
var
  LI: Integer;
begin
  for LI := 0 to FunctionMaxOutputs - 1 do
    AOutput[LI] := AInput[LI];
end;

end.
