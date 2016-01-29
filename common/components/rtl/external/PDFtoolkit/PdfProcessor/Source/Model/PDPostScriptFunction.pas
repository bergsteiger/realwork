unit PDPostScriptFunction;

interface

uses
  PDBaseObject, PDFunction;

type
  TgtPDPostScriptFunction = class(TgtPDFunction)
  private
//    FCodeString: AnsiString;

//    constructor Create(APostScriptFunc: TgtPDFunction); overload;
  public
    constructor Create(AFunctObj: TgtPDBaseObject; ADict: TgtPDBaseObject); overload;
    function Copy: TgtPDFunction; override;
    function GetType: TgtFunctionType; override;
    procedure Transform(AInput: TgtDoubleArray; var AOutput: TgtDoubleArray); override;
    function IsOk: Boolean; override;
    function GetCodeString: AnsiString;
  end;

implementation

{ TgtPDPostScriptFunction }

function TgtPDPostScriptFunction.Copy: TgtPDFunction;
begin
  Result := nil;
end;

(*
constructor TgtPDPostScriptFunction.Create(APostScriptFunc: TgtPDFunction);
begin

end;
*)

constructor TgtPDPostScriptFunction.Create(AFunctObj, ADict: TgtPDBaseObject);
begin

end;

function TgtPDPostScriptFunction.GetCodeString: AnsiString;
begin
  Result := '';
end;

function TgtPDPostScriptFunction.GetType: TgtFunctionType;
begin
  Result := ftPostScript;
end;

function TgtPDPostScriptFunction.IsOk: Boolean;
begin
  Result := False;
end;

procedure TgtPDPostScriptFunction.Transform(AInput: TgtDoubleArray;
  var AOutput: TgtDoubleArray);
begin
  inherited;

end;

end.
