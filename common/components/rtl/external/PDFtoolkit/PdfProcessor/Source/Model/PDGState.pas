unit PDGState;

interface

uses
  gtObject, PDElement, PDBaseObject;

type
  TgtPDGState = class(TgtPDElement)
  private
    FTag: AnsiString;
    FStrokeAlpha: Extended;
    FNonStrokeAlpha: Extended;

    function GetLineCap: Extended;
    function GetLineWidth: Extended;
    function GetNonStrokeAlpha: Extended;
    function GetStrokeAlpha: Extended;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject; const ATag: AnsiString);
    destructor Destroy; override;
    procedure Update; override;

    property LineWidth: Extended read GetLineWidth;
    property LineCapStyle: Extended read GetLineCap;
    property StrokeAlpha: Extended read GetStrokeAlpha;
    property NonStrokeAlpha: Extended read GetNonStrokeAlpha;


    property Tag: AnsiString read FTag;
  end;

implementation

uses
  gtConstants, PDDictionary, PDInteger, PDReal;


{ TgtPDGState }

constructor TgtPDGState.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject;
  const ATag: AnsiString);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FTag := ATag;

  FStrokeAlpha := -1.0;
  FNonStrokeAlpha := -1.0;
end;

destructor TgtPDGState.Destroy;
begin

  inherited;
end;

function TgtPDGState.GetLineCap: Extended;
begin
  Result := 0;
end;

function TgtPDGState.GetLineWidth: Extended;
begin
  Result := 0;
end;

function TgtPDGState.GetNonStrokeAlpha: Extended;
var
  LObj: TgtPDBaseObject;
begin
  if FNonStrokeAlpha = -1 then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SMALLCA);
    if Assigned(LObj) and LObj.IsNumber then
    begin
      if LObj.IsInteger then
        FNonStrokeAlpha := TgtPDInteger(LObj).Value
      else
        FNonStrokeAlpha := TgtPDReal(LObj).Value
    end;
  end;
  Result := FNonStrokeAlpha;
end;

function TgtPDGState.GetStrokeAlpha: Extended;
var
  LObj: TgtPDBaseObject;
begin
  if FStrokeAlpha = -1 then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CA);
    if Assigned(LObj) and LObj.IsNumber then
    begin
      if LObj.IsInteger then
        FStrokeAlpha := TgtPDInteger(LObj).Value
      else
        FStrokeAlpha := TgtPDReal(LObj).Value
    end;
  end;
  Result := FStrokeAlpha;
end;

procedure TgtPDGState.Update;
begin
  inherited;

end;

end.
