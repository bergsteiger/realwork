unit ActnPopup;

interface

uses Classes, Controls, Menus, ActnMenus, XPActnCtrls, ActnMan, ActnList;

type

{ TCustomActionPopupMenuEx }

  TPopupActionBar = class;

  TCustomActionPopupMenuEx = class(TXPStylePopupMenu)
  private
    FPopupActionBar: TPopupActionBar;
  protected
    procedure DoPopup(Item: TCustomActionControl); override;
    function GetPopupClass: TCustomPopupClass; override;
    procedure ExecAction(Action: TContainedAction); override;
  public
    procedure LoadMenu(Clients: TActionClients; AMenu: TMenuItem);
  end;

{ TPopupActionBar }

  TPopupActionBar = class(TPopupMenu)
  private
    FPopupMenu: TCustomActionPopupMenuEx;
    FActionManager: TCustomActionManager;
    function GetMenuActive: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(X: Integer; Y: Integer); override;
    property MenuActive: Boolean read GetMenuActive;
  published
    property PopupMenu: TCustomActionPopupMenuEx read FPopupMenu write FPopupMenu;
  end;

function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; const Items: array of TMenuItem): TPopupMenu;

implementation

uses SysUtils, Windows, Messages, Forms;

type
  TMenuAction = class(TCustomAction)
  private
    FMenuItem: TMenuItem;
  public
    function Execute: Boolean; override;
    constructor Create(AOwner: TComponent; AMenuItem: TMenuItem); reintroduce;
  end;

procedure InitMenuItems(AMenu: TMenu; const Items: array of TMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TMenuItem);
  var
    I: Integer;
  begin
    if Item.Owner = nil then AMenu.Owner.InsertComponent(Item);
    for I := 0 to Item.Count - 1 do
      SetOwner(Item[I]);
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    AMenu.Items.Add(Items[I]);
  end;
end;

function NewPopupMenu(Owner: TComponent; const AName: string;
  Alignment: TPopupAlignment; AutoPopup: Boolean; const Items: array of TMenuItem): TPopupMenu;
begin
  Result := TPopupActionBar.Create(Owner);
  Result.Name := AName;
  Result.AutoPopup := AutoPopup;
  Result.Alignment := Alignment;
  InitMenuItems(Result, Items);
end;

{ TPopupActionBar }

type
  TCustomActionPopupMenuClass = class(TCustomActionPopupMenu);

constructor TPopupActionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FActionManager := TActionManager.Create(Self);
end;

function TPopupActionBar.GetMenuActive: Boolean;
begin
  Result := Assigned(FPopupMenu);
end;

resourcestring
  sActionManagerNotAssigned = '%s ActionManager property has not been assigned';

procedure TPopupActionBar.Popup(X, Y: Integer);
begin
  if Assigned(FPopupMenu) then exit;
  DoPopup(Self);
  FPopupMenu := TCustomActionPopupMenuEx.Create(nil);
  try
    FActionManager.ActionBars.Clear;
    FPopupMenu.Designable := False;
    FPopupMenu.AnimationStyle := asNone;
    FPopupMenu.FPopupActionBar := Self;
//    FPopupMenu.Name := 'InternalPopup';
    FActionManager.Images := Images;
    with FActionManager.ActionBars.Add do
    begin
       ActionBar := FPopupMenu;
       ActionBar.Orientation := boTopToBottom;
       AutoSize := False;
    end;
    FPopupMenu.AutoSize := True;
    if not Assigned(FPopupMenu.ActionClient) then
      raise Exception.CreateFmt(sActionManagerNotAssigned, [Name]);
    FPopupMenu.ActionClient.Items.Clear;
    FPopupMenu.LoadMenu(FPopupMenu.ActionClient.Items, Self.Items);
    FPopupMenu.RecreateControls;
    FPopupMenu.Popup(X, Y);
  finally
    FreeAndNil(FPopupMenu);
  end;
end;

{ TCustomActionPopupMenuEx }

procedure TCustomActionPopupMenuEx.DoPopup(Item: TCustomActionControl);
begin
  inherited;
  // Check to see if we've already built this submenu this time around
  if Item.ActionClient.Items[0].Tag <> 0 then exit;
  // If we haven't then call the actual TMenuItem's OnClick event (if assigned)
  // which causing any dynamically created menus to populate
  if Assigned(TMenuItem(Item.ActionClient.Tag).OnClick) then
    TMenuItem(Item.ActionClient.Tag).OnClick(TMenuItem(Item.ActionClient.Tag));
  // Since submenus are always recreated clear any old items...
  Item.ActionClient.Items.Clear;
  // ...and reload the actual TMenuItem
  LoadMenu(Item.ActionClient.Items, TMenuItem(Item.ActionClient.Tag));
end;

type
  TActionListCracker = class(TCustomActionManager);
  TActionBarCracker = class(TCustomActionBar);

procedure TCustomActionPopupMenuEx.ExecAction(Action: TContainedAction);
begin
  PostMessage(PopupList.Window, WM_COMMAND, TMenuItem(FSelectedItem.Tag).Command, 0);
end;

function TCustomActionPopupMenuEx.GetPopupClass: TCustomPopupClass;
begin
  Result := TXPStylePopupMenu;
end;

procedure TCustomActionPopupMenuEx.LoadMenu(Clients: TActionClients; AMenu: TMenuItem);
var
  I: Integer;
  AC: TActionClientItem;
begin
  Clients.AutoHotKeys := False;
  for I := 0 to AMenu.Count - 1 do
  begin
    AC := Clients.Add;
    AC.Caption := AMenu.Items[I].Caption;
    AC.Tag := Integer(AMenu.Items[I]);
    AC.Action := TContainedAction(AMenu.Items[I].Action);
    if (AMenu.Items[I].Count > 0) and (AMenu.Items[I].Visible) then
      AC.Items.Add
    else
      if ((AMenu.Items[I].Caption <> '') and (AMenu.Items[I].Action = nil) and
          (AMenu.Items[I].Caption <> '-')) then
      begin
        AC.Action := TMenuAction.Create(Self, AMenu.Items[I]);
        AC.Action.ActionList := FPopupActionBar.FActionManager;
        AC.Action.Tag := AMenu.Items[I].Tag;
        TCustomAction(AC.Action).ImageIndex := AMenu.Items[I].ImageIndex;
        TCustomAction(AC.Action).Visible := AMenu.Items[I].Visible;
        TCustomAction(AC.Action).Checked := AMenu.Items[I].Checked;
        TCustomAction(AC.Action).Caption := AMenu.Items[I].Caption;
        TCustomAction(AC.Action).ShortCut := AMenu.Items[I].ShortCut;
        TCustomAction(AC.Action).Enabled := AMenu.Items[I].Enabled;
        AC.ImageIndex := AMenu.Items[I].ImageIndex;
        AC.ShortCut := AMenu.Items[I].ShortCut;
      end;
    AC.Caption := AMenu.Items[I].Caption;
    AC.ShortCut := AMenu.Items[I].ShortCut;
    AC.HelpContext := AMenu.Items[I].HelpContext;
    AC.ImageIndex := AMenu.Items[I].ImageIndex;
    AC.Visible := AMenu.Items[I].Visible;            
  end;
end;

{ TMenuAction }

constructor TMenuAction.Create(AOwner: TComponent; AMenuItem: TMenuItem);
begin
  inherited Create(AOwner);
  FMenuItem := AMenuItem;
end;

function TMenuAction.Execute: Boolean;
begin
  Result := True;
  if (FMenuItem <> nil) and Assigned(FMenuItem.OnClick) then
    FMenuItem.OnClick(FMenuItem);
end;

end.
