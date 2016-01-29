{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ActnList;

{$T-,H+,X+}

interface

uses
  System.Classes, System.SysUtils, System.Actions, Winapi.Messages, Vcl.ImgList;

type

  /// <summary> The usual list of actions (without published properties) in VCL </summary>
  TCustomActionList = class(TContainedActionList)
  private
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    procedure ImageListChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
    procedure SetImages(Value: TCustomImageList); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsShortCut(var Message: TWMKey): Boolean;
    property Images: TCustomImageList read FImages write SetImages;
  end;

  /// <summary> The usual list of actions (with published properties) in VCL </summary>
  TActionList = class(TCustomActionList)
  published
    property Images;
    property State;
    property OnChange;
    property OnExecute;
    property OnStateChange;
    property OnUpdate;
  end;

  /// <summary> This class is designed to communicate with some of the object in VCL </summary>
  TActionLink = class(TContainedActionLink)
  protected
  end;

  TActionLinkClass = class of TActionLink;

  /// <summary> List of additional combinations of hot keys in VCL </summary>
  TShortCutList = class(TCustomShortCutList)
  public
    function Add(const S: String): Integer; override;
  end;

  /// <summary> The usual action (without published properties) in VCL </summary>
  TCustomAction = class(TContainedAction)
  private
    //FActionList: TContainedActionList;
    function GetImages: TCustomImageList;
    function GetCustomActionList: TCustomActionList; inline;
    procedure SetCustomActionList(const Value: TCustomActionList); inline;
  protected
    FImage: TObject;
    FMask: TObject;
    procedure AssignTo(Dest: TPersistent); override;
    function CreateShortCutList: TCustomShortCutList; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    function Update: Boolean; override;
    property Images: TCustomImageList read GetImages;
    property ActionList: TCustomActionList read GetCustomActionList write SetCustomActionList;
    { Property access for design time support in .NET }
{$IF DEFINED(CLR)}
    property Image: TObject read FImage write FImage;
    property Mask: TObject read FMask write FMask;
{$ENDIF}
  end;

  /// <summary> The usual action (with published properties) in VCL </summary>
  TAction = class(TCustomAction)
  private
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoCheck;
    property Caption;
    property Checked;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property Hint;
    property ImageIndex;
    property SecondaryShortCuts;
    property ShortCut  default 0;
    property Visible;
    property OnExecute;
    property OnHint;
    property OnUpdate;
  end;
implementation

uses
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Security.Permissions,
{$ENDIF}
  Winapi.Windows, Vcl.Forms, Vcl.Menus, Vcl.Consts, Vcl.Controls;

{ TCustomVCLActionList }

procedure TCustomActionList.Change;
begin
  inherited;
  if ActionsCreated and (csDesigning in ComponentState) then
  begin
    if (Owner is TForm) and (TForm(Owner).Designer <> nil) then
      TForm(Owner).Designer.Modified;
  end;
end;

constructor TCustomActionList.Create(AOwner: TComponent);
begin
  inherited;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
end;

destructor TCustomActionList.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  inherited;
end;

procedure TCustomActionList.ImageListChange(Sender: TObject);
begin
  if Sender = Images then
    Change;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TCustomActionList.IsShortCut(var Message: TWMKey): Boolean;
var
  I: Integer;
  ShortCut: TShortCut;
  ShiftState: TShiftState;
  Action: TContainedAction;
  CustAction: TCustomAction;
begin
{$IF NOT DEFINED(CLR)}
  Result := False;
  if Vcl.Menus.IsAltGRPressed then Exit;
{$ENDIF}
  ShiftState := KeyDataToShiftState(Message.KeyData);
  ShortCut := Vcl.Menus.ShortCut(Message.CharCode, ShiftState);
  if ShortCut <> scNone then
    for I := 0 to ActionCount - 1 do
    begin
      Action := Actions[I];
      if Action is TCustomAction then
      begin
        CustAction := TCustomAction(Action);
        if (CustAction.ShortCut = ShortCut) or (Assigned(CustAction.SecondaryShortCuts) and
           (CustAction.SecondaryShortCuts.IndexOfShortCut(ShortCut) <> -1)) then
        begin
          Result := CustAction.HandleShortCut;
          Exit;
        end;
      end;
    end;
{$IF DEFINED(CLR)}
  Result := False;
{$ENDIF}
end;

procedure TCustomActionList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
    if AComponent = Images then
      Images := nil;
end;

procedure TCustomActionList.SetImages(Value: TCustomImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
  end;
end;

{ TShortCutList }

function TShortCutList.Add(const S: String): Integer;
begin
  Result := inherited Add(S);
  Objects[Result] := TObject(TextToShortCut(S));
end;

{ TCustomAction }

constructor TCustomAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TCustomAction.CreateShortCutList: TCustomShortCutList;
begin
  Result := TShortCutList.Create;
end;

destructor TCustomAction.Destroy;
begin
  FImage.Free;
  FMask.Free;
  inherited Destroy;
end;

procedure TCustomAction.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TCustomAction then
  begin
  end;
end;


//function TContainedAction.Execute: Boolean;
//begin
//{$IF DEFINED(CLR)}
//  Result := (ActionList <> nil) and ActionList.ExecuteAction(Self) or
//    Application.ExecuteAction(Self) or inherited Execute;
//  if not Result then
//    if Assigned(Application) then
//      Result := Application.DispatchAction(True, self, False);
//{$ELSE}
//  Result := (ActionList <> nil) and ActionList.ExecuteAction(Self) or
//    Application.ExecuteAction(Self) or inherited Execute or
//    (SendAppMessage(CM_ACTIONEXECUTE, 0, LPARAM(Self)) = 1);
//{$ENDIF}
//end;
//function TCustomAction.Execute: Boolean;
//begin
//  Result := False;
//  if Assigned(ActionList) and (ActionList.State <> asNormal) then Exit;
//  Update;
//  if Enabled and FAutoCheck then
//    if not Checked or Checked and (GroupIndex = 0) then
//      Checked := not Checked;
//  Result := Enabled and inherited Execute;
//end;
function TCustomAction.Execute: Boolean;
begin
  Result := False;
  if Assigned(ActionList) and (ActionList.State <> asNormal) then
    exit;
  Update;
  if Enabled and AutoCheck then
    if not Checked or Checked and (GroupIndex = 0) then
      Checked := not Checked;
  Result := Enabled;
  if Result then
  begin
  {$IF DEFINED(CLR)}
    Result := ((ActionList <> nil) and ActionList.ExecuteAction(Self)) or
               (Application.ExecuteAction(Self)) or
               (inherited Execute);
    if (not Result) and
       (Assigned(Application)) then
      Result := Application.DispatchAction(True, self, False);
  {$ELSE}
    Result := ((ActionList <> nil) and ActionList.ExecuteAction(Self)) or
               (Application.ExecuteAction(Self)) or
               (inherited Execute) or
               (SendAppMessage(CM_ACTIONEXECUTE, 0, LPARAM(Self)) = 1);
  {$ENDIF}
  end;
end;

function TCustomAction.GetCustomActionList: TCustomActionList;
begin
  Result := TCustomActionList(inherited ActionList);
end;

procedure TCustomAction.SetCustomActionList(const Value: TCustomActionList);
begin
  inherited ActionList := Value;
end;

function TCustomAction.GetImages: TCustomImageList;
begin
  if ActionList <> nil then
    Result := ActionList.Images
  else
    Result := nil;
end;

//function TContainedAction.Update: Boolean;
//begin
//{$IF DEFINED(CLR)}
//  Result := (ActionList <> nil) and ActionList.UpdateAction(Self) or
//    Application.UpdateAction(Self) or inherited Update;
//   if not Result then
//     if Assigned(Application) then
//       Result := Application.DispatchAction(False, self, False);
//{$ELSE}
//  Result := (ActionList <> nil) and ActionList.UpdateAction(Self) or
//    Application.UpdateAction(Self) or inherited Update or
//    (SendAppMessage(CM_ACTIONUPDATE, 0, LPARAM(Self)) = 1);
//{$ENDIF}
//end;
function TCustomAction.Update: Boolean;
begin
  {$IF DEFINED(CLR)}
    Result := (ActionList <> nil) and ActionList.UpdateAction(Self) or
      Application.UpdateAction(Self) or inherited Update;
     if not Result then
       if Assigned(Application) then
         Result := Application.DispatchAction(False, self, False);
  {$ELSE}
    Result := (ActionList <> nil) and ActionList.UpdateAction(Self) or
      Application.UpdateAction(Self) or inherited Update or
      (SendAppMessage(CM_ACTIONUPDATE, 0, LPARAM(Self)) = 1);
  {$ENDIF}
end;

{ TAction }

constructor TAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DisableIfNoHandler := True;
end;

{$IF NOT DEFINED(CLR)}

initialization

StartClassGroup(TControl);
ActivateClassGroup(TControl);
GroupDescendentsWith(TCustomActionList, TControl);
GroupDescendentsWith(TCustomAction, TControl);
{$ENDIF}

end.
