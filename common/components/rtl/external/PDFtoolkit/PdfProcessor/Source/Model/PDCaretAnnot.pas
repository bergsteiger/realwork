unit PDCaretAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot, gtConstants;

type
  //Enumeration defining different Caret symbols
  TgtCaretSymbol = (csParagraph, csNone);

  TgtPDCaretAnnot = class(TgtPDAnnot)
  private
    FSymbol: TgtCaretSymbol;

    function GetCaretSymbol: TgtCaretSymbol;

    procedure SetCaretSymbol(const Value: TgtCaretSymbol);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property CaretSymbol: TgtCaretSymbol read GetCaretSymbol write SetCaretSymbol;
  end;

implementation

{ TgtPDCaretAnnot }

uses
  PDDictionary, PDName;

constructor TgtPDCaretAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotCaret;
end;

constructor TgtPDCaretAnnot.Create;
begin
  inherited;
  AnnotType := annotCaret;
  FSymbol := csNone;
end;

destructor TgtPDCaretAnnot.Destroy;
begin

  inherited;
end;

function TgtPDCaretAnnot.GetCaretSymbol: TgtCaretSymbol;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SY);
    if Assigned(LObj) and LObj.IsName then
    begin
      if TgtPDName(LObj).Value = PDF_P then
        FSymbol := csParagraph;
    end;
  end;
  Result := FSymbol;
end;

procedure TgtPDCaretAnnot.SetCaretSymbol(const Value: TgtCaretSymbol);
var
  LObj: TgtPDBaseObject;
  LValue: AnsiString;
begin
  if Value = csParagraph then
    LValue := PDF_p
  else
    LValue := PDF_NONE;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SY);
    if Assigned(LObj) and LObj.IsName then
    begin
      TgtPDName(LObj).Value := LValue;
    end
    else
    begin
      LObj := TgtPDName.Create(LValue);
      TgtPDDictionary(FBaseObject).Add(PDF_SY, LObj);
    end;
  end;
  FSymbol := Value;
end;

end.
