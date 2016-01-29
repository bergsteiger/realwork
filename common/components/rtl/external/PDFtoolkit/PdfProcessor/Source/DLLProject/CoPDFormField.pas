unit CoPDFormField;

interface

uses
  PDFormFieldIntf, PDFormField, CoPDAnnot, PDTypes;

type
  TgtCoPDFormField = class(TgtCoPDAnnot, IgtPDFormField)
  private
    FPDFormField: TgtPDFormField;
  public
    function GetRotationAngle: Integer;
    function GetBorderColor: TPDColorValue;
    function GetBackGroundColor: TPDColorValue;
    //function GetNormalCaption: WideString;
    function GetHighlightMode: Integer;

    procedure SetRotationAngle(Value: Integer);
    procedure SetBorderColor(Value: TPDColorValue);
    procedure SetBackGroundColor(Value: TPDColorValue);
    //procedure SetNormalCaption(Value: WideString);
    procedure SetHighlightMode(Value: Integer);
  end;

implementation

{ TgtCoPDFormField }

function TgtCoPDFormField.GetBackGroundColor: TPDColorValue;
var
  LPDColorValue: TgtPDColorValue;
  LI: Integer;
begin
  LPDColorValue := FPDFormField.BackGroundColor;
  Result.ColorSpace := Ord(LPDColorValue.ColorSpace);
  for LI := 0 to 3 do
  begin
    Result.Value[LI] := LPDColorValue.Value[LI];
  end;
end;

function TgtCoPDFormField.GetBorderColor: TPDColorValue;
var
  LPDColorValue: TgtPDColorValue;
  LI: Integer;
begin
  LPDColorValue := FPDFormField.BorderColor;
  Result.ColorSpace := Ord(LPDColorValue.ColorSpace);
  for LI := 0 to 3 do
  begin
    Result.Value[LI] := LPDColorValue.Value[LI];
  end;
end;

function TgtCoPDFormField.GetHighlightMode: Integer;
begin
  Result := Ord(FPDFormField.HighlightMode);
end;
{*
function TgtCoPDFormField.GetNormalCaption: WideString;
begin
  Result := FPDFormField.NormalCaption;
end;
*}
function TgtCoPDFormField.GetRotationAngle: Integer;
begin
  Result := FPDFormField.RotationAngle;
end;

procedure TgtCoPDFormField.SetBackGroundColor(Value: TPDColorValue);
var
  LI: Integer;
  LPDColorValue: TgtPDColorValue;
begin
  LPDColorValue := FPDFormField.BackGroundColor;
  LPDColorValue.ColorSpace := TgtPDColorSpaceType(Value.ColorSpace);
  for LI := 0 to 3 do
  begin
    LPDColorValue.Value[LI] := Value.Value[LI];
  end;
end;

procedure TgtCoPDFormField.SetBorderColor(Value: TPDColorValue);
var
  LI: Integer;
  LPDColorValue: TgtPDColorValue;
begin
  LPDColorValue := FPDFormField.BorderColor;
  LPDColorValue.ColorSpace := TgtPDColorSpaceType(Value.ColorSpace);
  for LI := 0 to 3 do
  begin
    LPDColorValue.Value[LI] := Value.Value[LI];
  end;
end;

procedure TgtCoPDFormField.SetHighlightMode(Value: Integer);
begin
  FPDFormField.HighlightMode := TgtFormHighlightMode(Value);
end;
{*
procedure TgtCoPDFormField.SetNormalCaption(Value: WideString);
begin
  FPDFormField.NormalCaption := Value;
end;
*}
procedure TgtCoPDFormField.SetRotationAngle(Value: Integer);
begin
  FPDFormField.RotationAngle := Value;
end;

end.
