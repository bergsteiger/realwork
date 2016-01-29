{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDSubmitFormAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction, PDFileSpec, gtConstants;

type

  TgtFormSubmitFormat = (fsfHTML, fsfFDF, fsfXML);

  TgtPDSubmitFormAction = class(TgtPDAction)
  private
    FURL: AnsiString;
    FFileSpec: TgtPDFileSpec;
    FFormat: TgtFormSubmitFormat;
    function GetURL: AnsiString;
    procedure SetURL(const Value: AnsiString);
    function GetFormat: TgtFormSubmitFormat;
    procedure SetFormat(AValue: TgtFormSubmitFormat);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property Format: TgtFormSubmitFormat read GetFormat write SetFormat;
    property URL: AnsiString read GetURL write SetURL;
  end;

implementation

{ TgtPDSubmitFormAction }

uses
  PDDictionary, PDName;

constructor TgtPDSubmitFormAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  ActionType := actionSubmitForm;
end;

constructor TgtPDSubmitFormAction.Create;
begin
  inherited;
  ActionType := actionSubmitForm;
end;

destructor TgtPDSubmitFormAction.Destroy;
begin

  inherited;
end;

function TgtPDSubmitFormAction.GetFormat: TgtFormSubmitFormat;
begin
  Result := FFormat;
end;

function TgtPDSubmitFormAction.GetURL: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  if Assigned(FBaseObject) then
  begin
    if Assigned(FFileSpec) then
    begin
      FURL := FFileSpec.FileName;
    end
    else
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
      if Assigned(LObj) then
      begin
        FFileSpec := TgtPDFileSpec.Create(LObj);
        FURL := FFileSpec.FileName;
      end;
    end;
  end;
  Result := FURL;
end;

procedure TgtPDSubmitFormAction.SetFormat(AValue: TgtFormSubmitFormat);
begin
  FFormat := AValue;
end;

procedure TgtPDSubmitFormAction.SetURL(const Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
//  LObj := nil;
  if Assigned(FBaseObject) then
  begin
    if Assigned(FFileSpec) then
    begin
      FFileSpec.FileName := Value;
    end
    else
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
      FFileSpec := TgtPDFileSpec.Create(LObj);
      FFileSpec.FileName := Value;
    end;
  end;
  FURL := Value;
end;

end.
