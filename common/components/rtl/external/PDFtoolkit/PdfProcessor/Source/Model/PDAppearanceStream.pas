unit PDAppearanceStream;

interface

uses
  gtObject, PDBaseObject, PDRect, PDResource, PDStream, PDXObject, PDElement;

type
  TgtPDAppearanceStream = class(TgtPDElement)
  private
    FDestRect: TgtPDRect;
    FXObject: TgtPDXObject;
    FValue: AnsiString;

    function GetDestRect: TgtPDRect;
    function GetXObject: TgtPDXObject;
  public
    constructor Create(aParentDoc: TgtObject; annotBaseObject: TgtPDBaseObject;
      const Value: AnsiString);
    destructor Destroy; override;
    property DestRect: TgtPDRect read GetDestRect;
    property FormXObject: TgtPDXObject read GetXObject;
  end;

implementation

uses
  PDDictionary, gtConstants, PDArray, PDName;

{ TgtPDAppearanceStream }

constructor TgtPDAppearanceStream.Create(aParentDoc: TgtObject;
  annotBaseObject: TgtPDBaseObject; const Value: AnsiString);
begin
  FParentDoc := aParentDoc;
  FBaseObject := annotBaseObject;
  FValue := Value;
end;

destructor TgtPDAppearanceStream.Destroy;
begin
  if Assigned(FDestRect) then FDestRect.Free;
  if Assigned(FXObject) then FXObject.Free;

  inherited;
end;

function TgtPDAppearanceStream.GetDestRect: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FDestRect) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_RECT);
    if Assigned(LObj) and LObj.IsArray then
      FDestRect := TgtPDRect.Create(LObj as TgtPDArray);
  end;
  Result := FDestRect;
end;

function TgtPDAppearanceStream.GetXObject: TgtPDXObject;
var
  LObj1, LObj2, LObj3, LObj4: TgtPDBaseObject;
begin
  if not Assigned(FXObject) then
  begin
    LObj1 := TgtPDDictionary(FBaseObject).LookUp(PDF_AP);
    if Assigned(LObj1) and LObj1.IsDict then
    begin
      LObj2 := TgtPDDictionary(LObj1).LookUp(PDF_N);
      if Assigned(LObj2) and LObj2.IsDict then
      begin
        if FValue = '' then
        begin
          LObj3 := TgtPDDictionary(FBaseObject).LookUp(PDF_AS);
          if Assigned(LObj3) and LObj3.IsName then
            FValue := TgtPDName(LObj3).Value;
        end;

        LObj4 := TgtPDDictionary(LObj2).LookUp(FValue);
        if not Assigned(LObj4) then
          LObj4 := TgtPDDictionary(LObj2).LookUp(PDF_OFF);
        if Assigned(LObj4) then
          FXObject := TgtPDXObject.MakeXObject(FParentDoc, Self, LObj4, '');
      end
      else
      begin
        if Assigned(LObj2) then
          FXObject := TgtPDXObject.MakeXObject(FParentDoc, Self, LObj2, '');
      end;
    end;
  end;
  Result := FXObject;
end;

end.
