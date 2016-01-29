{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDFreeTextAnnot;

interface

uses
  PDBaseObject, PDDictionary, gtObject, PDElement, PDAnnot, PDArray, PDRect,
  gtFont, gtMethods, gtConstants;

type

  TgtFreeTextAllign = (ftLeftJustified, ftCentered, ftRightJustified);
  TgtFreeTextIntent = (ftCallout, ftTypeWriter, ftNone);

  TgtPDFreeTextAnnot = class(TgtPDAnnot)
  private
    FFont: TgtFont;
    FIntent: TgtFreeTextIntent;
    FTextAllign: TgtFreeTextAllign;
    function GetIntent: TgtFreeTextIntent;
    function GetTextAllign: TgtFreeTextAllign;
    procedure SetIntent(const Value: TgtFreeTextIntent);
    procedure SetTextAllign(const Value: TgtFreeTextAllign);
    function GetFont: TgtFont;
//    procedure SetFont(const Value: TgtFont);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Intent: TgtFreeTextIntent read GetIntent write SetIntent;
    property TextAllign: TgtFreeTextAllign read GetTextAllign write SetTextAllign;
    property Font: TgtFont read GetFont;// write SetFont;
  end;

implementation

{ TgtPDFreeTextAnnot }

uses
  PDName, PDInteger;

constructor TgtPDFreeTextAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FFont := TgtFont.Create;
  AnnotType := annotFreeText;
  FIntent := ftNone;
  FTextAllign := ftLeftJustified;
end;

constructor TgtPDFreeTextAnnot.Create;
begin
  inherited;
  FFont := TgtFont.Create;
  AnnotType := annotFreeText;
  FIntent := ftNone;
  FTextAllign := ftLeftJustified;
end;

destructor TgtPDFreeTextAnnot.Destroy;
begin
  if Assigned(FFont) then
    FreeObject(FFont);
  inherited;
end;


function TgtPDFreeTextAnnot.GetFont: TgtFont;
begin
  if Assigned(FBaseObject) then
  begin

  end;
  if not assigned(FFont) then
    FFont := TgtFont.Create;
  Result := FFont;
end;

function TgtPDFreeTextAnnot.GetIntent: TgtFreeTextIntent;
var
  LObj: TgtPDBaseObject;
  LIntent: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IT);
    if Assigned(LObj) and LObj.IsName then
    begin
      LIntent := TgtPDName(LObj).Value;
      if LIntent = PDF_FREETEXTCALLOUT then
        FIntent := ftCallout
      else if LIntent = PDF_FREETEXTTYPEWRITER then
        FIntent := ftTypeWriter;
    end;
  end;
  Result := FIntent;
end;

function TgtPDFreeTextAnnot.GetTextAllign: TgtFreeTextAllign;
var
  LObj: TgtPDBaseObject;
  LTextAllign: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_Q);
    if Assigned(LObj) and LObj.IsInteger then
    begin
      LTextAllign := TgtPDInteger(LObj).Value;
      if LTextAllign = 1 then
        FTextAllign := ftCentered
      else if LTextAllign = 2 then
        FTextAllign := ftRightJustified;
    end;
  end;
  Result := FTextAllign;
end;

(*
procedure TgtPDFreeTextAnnot.SetFont(const Value: TgtFont);
begin
  FFont := Value;
  if Assigned(FBaseObject) then
  begin

  end;
end;
*)

procedure TgtPDFreeTextAnnot.SetIntent(const Value: TgtFreeTextIntent);
var
  LObj: TgtPDBaseObject;
  LIntent: AnsiString;
begin
  case Value of
    ftCallout: LIntent := PDF_FREETEXTCALLOUT;
    ftTypeWriter: LIntent := PDF_FREETEXTTYPEWRITER;
    ftNone: LIntent := '';
  end;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_IT);
    if Assigned(LObj) then
    begin
      if LObj.IsName then
        TgtPDName(LObj).Value := LIntent;
    end
    else
    begin
      LObj := TgtPDName.Create(LIntent);
      TgtPDDictionary(FBaseObject).Add(PDF_IT, LObj);
    end;
  end;
  FIntent := Value;
end;


procedure TgtPDFreeTextAnnot.SetTextAllign(const Value: TgtFreeTextAllign);
var
  LObj: TgtPDBaseObject;
  LTextAllign: Integer;
begin
  LTextAllign := Ord(ftLeftJustified);
  case Value of
    ftLeftJustified: LTextAllign := 0;
    ftCentered: LTextAllign := 1;
    ftRightJustified: LTextAllign := 2;
  end;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_Q);
    if Assigned(LObj) then
    begin
      if LObj.IsInteger then
        TgtPDInteger(LObj).Value := LTextAllign;
    end
    else
    begin
      LObj := TgtPDInteger.Create(LTextAllign);
      TgtPDDictionary(FBaseObject).Add(PDF_Q, LObj);
    end;
  end;
  FTextAllign := Value;
end;

end.
