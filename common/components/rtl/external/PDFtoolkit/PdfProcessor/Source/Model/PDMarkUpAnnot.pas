unit PDMarkUpAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, gtConstants, Classes,
  SysUtils;

type

  TgtMarkUpType = (maHighlight, maUnderline, maSquiggly, maStrikeOut);

  TgtPDMarkUpAnnot = class(TgtPDAnnot)
  private
    FQuadPoints: WideString;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create(AMarkupType: TgtMarkUpType); overload;
    destructor Destroy; override;
    procedure SetQuadPoints(AFX1, AFY1, AFX2, AFY2, AFX3, AFY3, AFX4, AFY4: Double);
    function GetQuadPoints: WideString;
  end;

implementation

{ TgtPDMarkUpAnnot }

uses
  PDDictionary, PDArray, PDInteger, PDReal, PDPage, gtMethods;

constructor TgtPDMarkUpAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FQuadPoints := '';
end;

constructor TgtPDMarkUpAnnot.Create(AMarkupType: TgtMarkUpType);
begin
  inherited Create;
  FQuadPoints := '';
  case AMarkupType of
    maHighlight:
      AnnotType := annotHighlight;
    maUnderline:
      AnnotType := annotUnderline;
    maSquiggly:
      AnnotType := annotSquiggly;
    maStrikeOut:
      AnnotType := annotStrikeOut;
  end;
end;

destructor TgtPDMarkUpAnnot.Destroy;
begin
  inherited;
end;

function TgtPDMarkUpAnnot.GetQuadPoints: WideString;
begin
  Result := FQuadPoints;
end;

procedure TgtPDMarkUpAnnot.SetQuadPoints(AFX1, AFY1, AFX2, AFY2, AFX3, AFY3,
  AFX4, AFY4: Double);
var
  LObj: TgtPDBaseObject;
  LPoint: TgtPDBaseObject;
  LPageHt: Double;
  LStringList: TStringList;
  I: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_QUADPOINTS);
    if Assigned(LObj) and LObj.IsArray then
    begin
      LPageHt := 0;
      if Assigned(Page) then
        LPageHt := TgtPDPage(Page).GetPageHeight;
      LPoint := TgtPDArray(LObj).Get(0);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := AFX1
      else
      begin
        LPoint := TgtPDReal.Create(AFX1);
        TgtPDArray(LObj).Remove(0);
        TgtPDArray(LObj).Insert(LPoint, 0);
      end;

      LPoint := TgtPDArray(LObj).Get(1);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := LPageHt - AFY1
      else
      begin
        LPoint := TgtPDReal.Create(LPageHt - AFY1);
        TgtPDArray(LObj).Remove(1);
        TgtPDArray(LObj).Insert(LPoint, 1);
      end;

      LPoint := TgtPDArray(LObj).Get(2);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := AFX2
      else
      begin
        LPoint := TgtPDReal.Create(AFX2);
        TgtPDArray(LObj).Remove(2);
        TgtPDArray(LObj).Insert(LPoint, 2);
      end;

      LPoint := TgtPDArray(LObj).Get(3);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := LPageHt - AFY2
      else
      begin
        LPoint := TgtPDReal.Create(LPageHt - AFY2);
        TgtPDArray(LObj).Remove(3);
        TgtPDArray(LObj).Insert(LPoint, 3);
      end;

      LPoint := TgtPDArray(LObj).Get(4);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := AFX3
      else
      begin
        LPoint := TgtPDReal.Create(AFX3);
        TgtPDArray(LObj).Remove(4);
        TgtPDArray(LObj).Insert(LPoint, 4);
      end;

      LPoint := TgtPDArray(LObj).Get(5);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := LPageHt - AFY3
      else
      begin
        LPoint := TgtPDReal.Create(LPageHt - AFY3);
        TgtPDArray(LObj).Remove(5);
        TgtPDArray(LObj).Insert(LPoint, 5);
      end;

      LPoint := TgtPDArray(LObj).Get(6);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := AFX4
      else
      begin
        LPoint := TgtPDReal.Create(AFX4);
        TgtPDArray(LObj).Remove(6);
        TgtPDArray(LObj).Insert(LPoint, 6);
      end;

      LPoint := TgtPDArray(LObj).Get(7);
      if LPoint.IsReal then
        TgtPDreal(LPoint).Value := LPageHt - AFY4
      else
      begin
        LPoint := TgtPDReal.Create(LPageHt - AFY4);
        TgtPDArray(LObj).Remove(7);
        TgtPDArray(LObj).Add(LPoint);
      end;
    end;
  end;
  LStringList := TStringList.Create;
  LStringList.Add(FloatToStringLocale(AFX1));
  LStringList.Add(FloatToStringLocale(AFY1));
  LStringList.Add(FloatToStringLocale(AFX2));
  LStringList.Add(FloatToStringLocale(AFY2));
  LStringList.Add(FloatToStringLocale(AFX3));
  LStringList.Add(FloatToStringLocale(AFY3));
  LStringList.Add(FloatToStringLocale(AFX4));
  LStringList.Add(FloatToStringLocale(AFY4));
  FQuadPoints := LStringList.CommaText;
  LStringList.Free;
end;

end.
