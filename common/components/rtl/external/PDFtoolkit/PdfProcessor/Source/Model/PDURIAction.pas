{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }
{$I ..\Utils\gtCompilerDefines.inc}
unit PDURIAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDURIAction = class(TgtPDAction)
  private
    FURI: AnsiString;
    FTrackMousePointer: Boolean;

    function GetURI: AnsiString;
    function GetTrackMousePointer: Boolean;

    procedure SetURI(Value: AnsiString);
    procedure SetTrackMousePointer(Value: Boolean);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    constructor Create(AURI: AnsiString); overload;

    property URI: AnsiString read GetURI write SetURI;
    property TrackMousePointer: Boolean read GetTrackMousePointer
      write SetTrackMousePointer;
  end;

implementation

uses
  PDDictionary, PDString, PDBoolean, gtConstants;

{ TgtPDURIAction }

constructor TgtPDURIAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionURI;
end;

constructor TgtPDURIAction.Create;
begin
  inherited;
  ActionType := actionURI;
end;

constructor TgtPDURIAction.Create(AURI: AnsiString);
begin
  {$IFDEF DELPHI13}
   ActionType := actionURI;
   FURI := AURI;
  {$ELSE}
   inherited;
   ActionType := actionURI;
   FURI := AURI;
  {$ENDIF}
end;

function TgtPDURIAction.GetTrackMousePointer: Boolean;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ISMAP);
    if Assigned(LObj) then
      FTrackMousePointer := TgtPDBoolean(LObj).Value;
  end;
  Result := FTrackMousePointer;
end;

function TgtPDURIAction.GetURI: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_URI);
    if Assigned(LObj) then
      FURI := TgtPDString(LObj).Value;
  end;

  Result := FURI;
end;

procedure TgtPDURIAction.SetTrackMousePointer(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ISMAP);
    if Assigned(LObj) then
    begin
      TgtPDBoolean(LObj).Value := Value;
    end
    else
    begin
      LObj := TgtPDBoolean.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_ISMAP, LObj);
    end;
  end;
  FTrackMousePointer := Value;
end;

procedure TgtPDURIAction.SetURI(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_URI);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := Value
    else
    begin
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_URI, LObj);
    end;
  end;

  FURI := Value;
end;

end.
