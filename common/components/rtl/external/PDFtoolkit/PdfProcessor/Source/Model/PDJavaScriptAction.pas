{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDJavaScriptAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDJavaScriptAction = class(TgtPDAction)
  private
    FJavaScript: AnsiString;

    function GetJavaScript: AnsiString;

    procedure SetJavaScript(Value: AnsiString);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;
    property JavaScript: AnsiString read GetJavaScript write SetJavaScript;
  end;

implementation

uses
  PDDictionary, PDString, gtConstants;

{ TgtPDJavaScriptAction }

constructor TgtPDJavaScriptAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionJavaScript;
end;

constructor TgtPDJavaScriptAction.Create;
begin
  inherited;
  ActionType := actionJavaScript;
end;

destructor TgtPDJavaScriptAction.Destroy;
begin

  inherited;
end;

function TgtPDJavaScriptAction.GetJavaScript: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_JS);
    if Assigned(LObj) then
      FJavaScript := TgtPDString(LObj).Value;
  end;

  Result := FJavaScript;
end;

procedure TgtPDJavaScriptAction.SetJavaScript(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_JS);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := Value
    else
    begin
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_JS, LObj);
    end;
  end;
  FJavaScript := Value;
end;

end.
