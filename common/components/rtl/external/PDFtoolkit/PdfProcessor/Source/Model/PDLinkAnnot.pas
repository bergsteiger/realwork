{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDLinkAnnot;

interface

uses
  PDArray, PDBaseObject, PDDictionary, gtObject, PDElement, PDAnnot, gtConstants,
  PDAction;

type

  TgtLinkHighlightType = (lhInvert, lhOutline, lhPush, lhNone);

  TgtPDLinkAnnot = class(TgtPDAnnot)
  private
    FHighLightType: TgtLinkHighlightType;
    FAction: TgtPDAction;
    function GetDest: TgtPDDictionary;
    function GetHighLightType: TgtLinkHighlightType;
    procedure SetHighLightType(const Value: TgtLinkHighlightType);
    function GetQuadPoints: TgtPDArray;
    function GetAction: TgtPDAction;
    procedure SetAction(const Value: TgtPDAction);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Dest: TgtPDDictionary read GetDest;
    property HighLightType: TgtLinkHighlightType read GetHighLightType write SetHighLightType;
    property QuadPoints: TgtPDArray read GetQuadPoints;
    property Action: TgtPDAction read GetAction write SetAction;
  end;

implementation

{ TgtPDLinkAnnot }

uses
  PDName, PDDocument;

constructor TgtPDLinkAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

constructor TgtPDLinkAnnot.Create;
begin
  inherited;
  AnnotType := annotLink;
  FHighLightType := lhInvert;
end;

destructor TgtPDLinkAnnot.Destroy;
begin

  inherited;
end;

function TgtPDLinkAnnot.GetAction: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_PA);
    if Assigned(LObj) and LObj.IsDict then
    begin
      FAction := TgtPDAction.MakeAction(TgtPDDocument(FParentDoc).BaseDoc,
        TgtPDElement(FParentElement).ParentElement, LObj);
    end;
  end;
  Result := FAction;
end;

function TgtPDLinkAnnot.GetDest: TgtPDDictionary;
begin
  Result := nil;
end;

function TgtPDLinkAnnot.GetHighLightType: TgtLinkHighlightType;
var
  LObj: TgtPDBaseObject;
  LValue: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_H);
    if Assigned(LObj) and Lobj.IsName then
    begin
      LValue := TgtPDName(LObj).Value;
      if LValue = PDF_N then
        FHighLightType := lhNone
      else if LValue = PDF_I then
        FHighLightType := lhInvert
      else if LValue = PDF_O then
        FHighLightType := lhOutline
      else if LValue = PDF_P then
        FHighLightType := lhPush;
    end;
  end;
  Result := FHighLightType;
end;

function TgtPDLinkAnnot.GetQuadPoints: TgtPDArray;
begin
  Result := nil;
end;

procedure TgtPDLinkAnnot.SetAction(const Value: TgtPDAction);
begin
  FAction := Value;
end;

procedure TgtPDLinkAnnot.SetHighLightType(const Value: TgtLinkHighlightType);
var
  LObj: TgtPDBaseObject;
  LVal: string;
begin
  FHighLightType := Value;
  if Assigned(FBaseObject) then
  begin
    case Value of
      lhInvert: LVal := PDF_I;
      lhOutline: LVal := PDF_O;
      lhPush: LVal := PDF_P;
      lhNone: LVal := PDF_N;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_H);
    if Assigned(LObj) and LObj.IsName then
      TgtPDName(LObj).Value := LVal
    else
    begin
      TgtPDDictionary(FBaseObject).Add(PDF_H, TgtPDName.Create(LVal));
    end;
  end;
end;

end.
