{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDGoToRemoteAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction, PDDestination;

type
  TgtPDGoToRemoteAction = class(TgtPDAction)
  private
//    FFileName: AnsiString;
    FOpenInNewWindow: Boolean;
    FPAgeNum: Integer;

    function GetFileName: AnsiString;
    function GetOpenInNewWindow: Boolean;

    procedure SetFileName(Value: AnsiString);
    procedure SetOpenInNewWindow(Value: Boolean);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create(ADestination: TgtPDDestination); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Destination;
    property ActionType;
    property FileName: AnsiString read GetFileName write SetFileName;
    property OpenInNewWindow: Boolean read GetOpenInNewWindow
      write SetOpenInNewWindow;
    property PageNum: Integer read FPageNum write FPageNum;
  end;

implementation

uses
  PDDictionary, PDName, PDString, gtConstants, PDFileSpec, PDBoolean, gtMethods,
  PDRect;

{ TgtPDGoToRemoteAction }

constructor TgtPDGoToRemoteAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionGoToR;
end;

constructor TgtPDGoToRemoteAction.Create(ADestination: TgtPDDestination);
begin
  FViewDestination := ADestination;
  ActionType := actionGoToR;
  FFileSpec := TgtPDFileSpec.Create(nil);
end;

constructor TgtPDGoToRemoteAction.Create;
begin
  inherited;
  ActionType := actionGoToR;
  FViewDestination := TgtPDDestination.Create;
  FFileSpec := TgtPDFileSpec.Create(nil);
end;

destructor TgtPDGoToRemoteAction.Destroy;
begin
  if Assigned(FFileSpec) then
    FreeObject(FFileSpec);
//  if Assigned(FViewDestination.Rect) then
//    FreeObject(FViewDestination.Rect);
  inherited;
end;

function TgtPDGoToRemoteAction.GetFileName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FFileSpec) then
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
  end;
  Result := FFileSpec.FileName;
end;

function TgtPDGoToRemoteAction.GetOpenInNewWindow: Boolean;
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

procedure TgtPDGoToRemoteAction.SetFileName(Value: AnsiString);
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
        FFileSpec.FileName := Value;
      end
      else if LObj.IsDict then
      begin
        if not Assigned(FFileSpec) then
          FFileSpec := TgtPDFileSpec.Create(LObj);
      end;
    end
    else
    begin
      LObj := TgtPDString.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_F, LObj);
    end;
  end;
  FFileSpec.FileName := Value;
end;

procedure TgtPDGoToRemoteAction.SetOpenInNewWindow(Value: Boolean);
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
