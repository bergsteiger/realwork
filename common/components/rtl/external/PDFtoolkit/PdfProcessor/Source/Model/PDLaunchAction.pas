{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDLaunchAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtLaunchActionType = (ltOpen, ltPrint);

  TgtPDLaunchAction = class(TgtPDAction)
  private
    FOpenInNewWindow: Boolean;
    FLaunchActionType: TgtLaunchActionType;
    FApplicationParameter: AnsiString;
    FDefaultDirectory: AnsiString;

    function GetApplicationToLaunch: AnsiString;
    function GetOpenInNewWindow: Boolean;
    function GetLaunchActionType: TgtLaunchActionType;
    function GetApplicationParameter: AnsiString;
    function GetDefaultDirectory: AnsiString;

    procedure SetApplicationToLaunch(Value: AnsiString);
    procedure SetOpenInNewWindow(Value: Boolean);
    procedure SetLaunchActionType(Value: TgtLaunchActionType);
    procedure SetApplicationParameter(Value: AnsiString);
    procedure SetDefaultDirectory(Value: AnsiString);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;

    property ApplicationToLaunch: AnsiString read GetApplicationToLaunch
      write SetApplicationToLaunch;
    property OpenInNewWindow: Boolean read GetOpenInNewWindow
      write SetOpenInNewWindow;
    property LaunchActionType: TgtLaunchActionType read GetLaunchActionType
      write SetLaunchActionType;
    property ApplicationParameter: AnsiString read GetApplicationParameter
      write SetApplicationParameter;
    property DefaultDirectory: AnsiString read GetDefaultDirectory
      write SetDefaultDirectory;
  end;

implementation

uses
  PDDictionary, gtConstants, PDFileSpec, PDString, PDDocument, PDBoolean;

{ TgtPDLaunchAction }

constructor TgtPDLaunchAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionLaunch;
end;

constructor TgtPDLaunchAction.Create;
begin
  ActionType := actionLaunch;
  FFileSpec := TgtPDFileSpec.Create;
end;

function TgtPDLaunchAction.GetApplicationParameter: AnsiString;
var
  LWinObj, LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LwinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LwinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_P);
      if Assigned(LObj) then
        FApplicationParameter := TgtPDString(LObj).Value;
    end;
  end;
  Result := FApplicationParameter;
end;

function TgtPDLaunchAction.GetApplicationToLaunch: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
    begin
      if LObj.IsString then
      begin
        FFileSpec := TgtPDFileSpec.Create(nil);
        FFileSpec.FileName := TgtPDString(LObj).Value;
      end
      else if LObj.IsDict then
      begin
        FFileSpec := TgtPDFileSpec.Create(LObj);
      end;
    end;
  end;

  Result := FFileSpec.FileName;
end;

function TgtPDLaunchAction.GetDefaultDirectory: AnsiString;
var
  LWinObj, LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LWinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LWinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_D);
      if Assigned(LObj) then
        FDefaultDirectory := TgtPDString(LObj).Value;
    end;
  end;

  Result := FDefaultDirectory
end;

function TgtPDLaunchAction.GetLaunchActionType: TgtLaunchActionType;
var
  LWinObj, LObj: TgtPDBaseObject;
  LLaunchType: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LWinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LWinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_O);
      if Assigned(LObj) then
      begin
        LLaunchType := TgtPDString(LObj).Value;
        if LLaunchType = 'open' then
          FLaunchActionType := ltOpen
        else if LLaunchType = 'print' then
          FLaunchActionType := ltPrint;
      end;
    end;
  end;
  Result := FLaunchActionType;
end;

function TgtPDLaunchAction.GetOpenInNewWindow: Boolean;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEWWINDOW);
    if Assigned(LObj) then
      FOpenInNewWindow := TgtPDBoolean(LObj).Value;
  end;

  Result := FOpenInNewWindow;
end;

procedure TgtPDLaunchAction.SetApplicationParameter(Value: AnsiString);
var
  LWinObj, LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LWinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LWinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_P);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := Value
      else
      begin
        LObj := TgtPDString.Create(Value);
        TgtPDDictionary(LWinObj).Add(PDF_P, LObj);
      end;
    end
    else
    begin
      LWinObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_WIN, LWinObj);
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(LWinObj).Add(PDF_P, LObj);
    end;
  end;
  FApplicationParameter := Value;
end;

procedure TgtPDLaunchAction.SetApplicationToLaunch(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
    begin
      if LObj.IsString then
      begin
        if not Assigned(FFileSpec) then
          FFileSpec := TgtPDFileSpec.Create(nil);

        TgtPDString(LObj).Value := Value;
      end
      else if LObj.IsDict then
      begin
        FFileSpec := TgtPDFileSpec.Create(LObj);
      end;
    end;
  end;

  FFileSpec.FileName := Value;
end;

procedure TgtPDLaunchAction.SetDefaultDirectory(Value: AnsiString);
var
  LWinObj, LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LWinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LWinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_D);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := Value
      else
      begin
        LObj := TgtPDString.Create(Value);
        TgtPDDictionary(LWinObj).Add(PDF_D, LObj);
      end;
    end
    else
    begin
      LWinObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_WIN, LWinObj);
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(LWinObj).Add(PDF_D, LObj);
    end;
  end;
  FDefaultDirectory := Value;
end;

procedure TgtPDLaunchAction.SetLaunchActionType(Value: TgtLaunchActionType);
var
  LWinObj, LObj: TgtPDBaseObject;
  LLaunchType: AnsiString;
begin
  case Value of
    ltOpen: LLaunchType := 'open';
    ltPrint: LLaunchType := 'print';
  end;

  if Assigned(FBaseObject) then
  begin
    LWinObj := TgtPDDictionary(FBaseObject).LookUp(PDF_WIN);
    if Assigned(LWinObj) then
    begin
      LObj := TgtPDDictionary(LWinObj).LookUp(PDF_O);
      if Assigned(LObj) then
      begin
        TgtPDString(LObj).Value := LLaunchType;
      end
      else
      begin
        LObj := TgtPDString.Create(LLaunchType);
        TgtPDDictionary(LWinObj).Add(PDF_O, LObj);
      end;
    end
    else
    begin
      LWinObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_WIN, LWinObj);
      LObj := TgtPDString.Create(LLaunchType);
      TgtPDDictionary(LWinObj).Add(PDF_O, LObj);
    end;
  end;
  FLaunchActionType := Value;
end;

procedure TgtPDLaunchAction.SetOpenInNewWindow(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEWWINDOW);
    if Assigned(LObj) then
      TgtPDBoolean(LObj).Value := Value
    else
    begin
      LObj := TgtPDBoolean.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_NEWWINDOW, LObj);
    end;
  end;
  FOpenInNewWindow := Value;
end;

end.
