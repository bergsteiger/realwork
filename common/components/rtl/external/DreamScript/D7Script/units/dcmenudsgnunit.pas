{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCMenuDsgnUnit;

interface

{$I dc.inc}

uses
  Classes, Controls, Forms,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  Menus, Messages,
  DCGen, DCdreamLib, DCSystem, DCConsts,
  DCMenuEditor, DCSelMenuUnit, dccommon;

type
  TDCMenuDesigner = class(TForm)
    PopupMenu: TPopupMenu;
    InsertItem: TMenuItem;
    DeleteItem: TMenuItem;
    CreateSubMenuItem: TMenuItem;
    N2: TMenuItem;
    SelectMenuItem: TMenuItem;
    N1: TMenuItem;
    DCPropStore: TDCPropStore;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuEditorSelectionChanged(ASender: TObject; AOldItem,
      ANewItem: TDCMenuItem);
    procedure MenuEditorClick(Sender: TObject);
    procedure MenuEditorDblClick(Sender: TObject);

    procedure PopupMenuPopup(Sender: TObject);
    procedure InsertItemClick(Sender: TObject);
    procedure DeleteItemClick(Sender: TObject);
    procedure CreateSubMenuItemClick(Sender: TObject);
    procedure SelectMenuItemClick(Sender: TObject);
  private
    MenuEditor: TDCMenuEditor;
    function GetDesignMenu: TMenu;
    procedure SetDesignMenu(AValue: TMenu);

    procedure CMPropChanged(var Msg: TMessage); message CM_PropChanged;

    procedure ValidateItemChanges(AMenuItem: TDCMenuItem);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure InitCaption;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DesignMenu: TMenu read GetDesignMenu write SetDesignMenu;
  end;

  {------------------------------------------------------------------}

  TDCMenuDsgnEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(AIndex: Integer); override;
    function GetVerb(AIndex: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {------------------------------------------------------------------}

  TDCMenuPropEditor = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  {------------------------------------------------------------------}

procedure DCRegisterMenuEditor;

implementation

uses SysUtils, TypInfo;

{$R *.DFM}

type
  TMMenuItem = class(TDCMenuItem);
  TMMenu = class(TMenu);

{------------------------------------------------------------------}

var
  MenuDesigner: TDCMenuDesigner;

{------------------------------------------------------------------}

procedure DCInitMenuDesigner;
begin
  if Assigned(MenuDesigner) then
    Exit;
  MenuDesigner := TDCMenuDesigner.Create(Application);
end;

{------------------------------------------------------------------}

procedure DCRegisterMenuEditor;
begin
  RegisterComponentEditor(TMainMenu, TDCMenuDsgnEditor);
  RegisterComponentEditor(TPopupMenu, TDCMenuDsgnEditor);
  RegisterPropertyEditor(TypeInfo(TMenuItem), TMainMenu, 'Items', TDCMenuPropEditor);
  RegisterPropertyEditor(TypeInfo(TMenuItem), TPopupMenu, 'Items', TDCMenuPropEditor);
end;

{------------------------------------------------------------------}

{ TDCMenuDesigner }

procedure TDCMenuDsgnEditor.Edit;
begin
  DCInitMenuDesigner;
  MenuDesigner.DesignMenu := TMenu(Component);
  MenuDesigner.Show;
end;

{------------------------------------------------------------------}

procedure TDCMenuDsgnEditor.ExecuteVerb(AIndex: Integer);
begin
  Edit;
end;

{------------------------------------------------------------------}

function TDCMenuDsgnEditor.GetVerb(AIndex: Integer): string;
begin
  Result := sDCMenuDesigner;
end;

{------------------------------------------------------------------}

function TDCMenuDsgnEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{------------------------------------------------------------------}

function TDCMenuDesigner.GetDesignMenu: TMenu;
begin
  Result := MenuEditor.Menu;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.SetDesignMenu(AValue: TMenu);
begin
  if MenuEditor.Menu <> nil then
    {$IFDEF D5}
    MenuEditor.Menu.RemoveFreeNotification(Self);
    {$ELSE}
    //TMMenu(MenuEditor.Menu).Notification(Self, opRemove);
    {$ENDIF}
    if Assigned(AValue) then
      AValue.FreeNotification(Self);
  MenuEditor.Menu := AValue;
  InitCaption;
  if Assigned(AValue) then
    ValidateItemChanges(MenuEditor.SelectedItem);
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.ValidateItemChanges(AMenuItem: TDCMenuItem);
var
  CurrentDesigner: TFormDesigner;
begin
  if not Assigned(AMenuItem) then
    Exit;

  CurrentDesigner := GetFormDesigner(DesignMenu.Owner);
  if CurrentDesigner <> nil then
    CurrentDesigner.SelectComponent(AMenuItem.MenuItem);
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDestroying in ComponentState then
    Exit;
  if (Operation = opRemove) and
    ((MenuEditor.Menu = nil) or (csDestroying in MenuEditor.Menu.ComponentState)) then
  begin
    MenuEditor.Menu := nil;
    Close;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.CMPROPCHANGED(var Msg: TMessage);
var
  I: Integer;
begin
  if not Assigned(DesignMenu) then
    Exit;
  with TList(Msg.wParam) do
    for I := 0 to Count - 1 do
      if (Items[I] = DesignMenu) or (Items[I] = DesignMenu.Owner) then
      begin
        InitCaption;
        Exit;
      end;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.InitCaption;
begin
  if not Assigned(DesignMenu) then
    Exit;
  Caption := DesignMenu.Owner.Name + '.' + DesignMenu.Name;
end;

{ TDCMenuPropEditor }

procedure TDCMenuPropEditor.Edit;
begin
  DCInitMenuDesigner;
  MenuDesigner.DesignMenu := TMenu(GetComponent(0));
  MenuDesigner.Show;
end;

{------------------------------------------------------------------}

function TDCMenuPropEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------}

function TDCMenuPropEditor.GetValue: string;
begin
  Result := sDCMenuValue;
end;

{------------------------------------------------------------------}

{ TDCMenuDesigner }

constructor TDCMenuDesigner.Create(AOwner: TComponent);
begin
  inherited;

  MenuEditor := TDCMenuEditor.Create(Self);
  with MenuEditor do
  begin
    Parent := Self;
    Align := alClient;
    TabStop := True;
    TabOrder := 0;
    PopupMenu := Self.PopupMenu;
    OnSelectionChanged := MenuEditorSelectionChanged;
    OnClick := MenuEditorClick;
    OnDblClick := MenuEditorDblClick; // by Volkoff

  end;

  InsertItem.Caption := sDCInsertMenuItemCaption;
  DeleteItem.Caption := sDCDeleteMenuItemCaption;
  CreateSubMenuItem.Caption := sDCCreateSubMenuMenuItemCaption;
  SelectMenuItem.Caption := sDCSelectMenuItemCaption;

  MenuDesigner.Free;
  MenuDesigner := Self;

  RegisterNotifier(Self);
end;

{------------------------------------------------------------------}

destructor TDCMenuDesigner.Destroy;
begin
  UnregisterNotifier(Self);

  MenuDesigner := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.MenuEditorSelectionChanged(ASender: TObject;
  AOldItem, ANewItem: TDCMenuItem);
begin
  ValidateItemChanges(ANewItem);
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.MenuEditorClick(Sender: TObject);
begin
  ValidateItemChanges(MenuEditor.SelectedItem);
end;

procedure FillTypeData(var tdata: TTypeData);
var
  s: TMemoryStream;
  mk: TMethodKind;
  restype, paramname, typename: ShortString;
  flags: TParamFlags;
  pcount: integer;

  procedure writestring(const st: ShortString);
  begin
    s.Write(st, length(st) + 1);
  end;

  procedure writeparam;
  begin
    s.Write(Flags, sizeof(Flags));
    WriteString(ParamName);
    WriteString(TypeName);
  end;

begin
  restype := '';
  mk := mkProcedure;
  flags := [];
  paramname := 'Sender';
  typename := 'TObject';

  s := TMemoryStream.Create;
  try
    s.WriteBuffer(mk, sizeof(mk));
    pcount := 1;
    s.Write(pCount, sizeof(byte));

    writeparam;

    WriteString(restype);
    Move(s.Memory^, tdata, s.Size);
  finally
    s.Free;
  end;
end;

{------------------------}

{$IFNDEF D5}
function GetMethodProp(Instance: TObject; const PropName: string): TMethod;
begin
  Result := TypInfo.GetMethodProp(Instance, GetPropInfo(Instance.ClassInfo, PropName));
end;
{$ENDIF}

{------------------------}

procedure TDCMenuDesigner.MenuEditorDblClick(Sender: TObject);
var
  typedata: TTypeData;
  CurrentDesigner: TFormDesigner;
  EvName: string;
  MProp: TMethod;
begin
  if not Assigned(MenuEditor.SelectedItem) then
    Exit;
  ValidateItemChanges(MenuEditor.SelectedItem);

  CurrentDesigner := GetFormDesigner(DesignMenu.Owner);
  if CurrentDesigner <> nil then
  begin
    MProp := GetMethodProp(MenuEditor.SelectedItem.MenuItem, 'OnClick');
    EvName := CurrentDesigner.GetMethodName(MProp);
    if EvName = '' then
      EvName := MenuEditor.SelectedItem.MenuItem.Name + 'Click';
    if not CurrentDesigner.MethodExists(EvName) then
    begin
      FillTypeData(typedata);
      CurrentDesigner.CreateMethod(EvName, @typedata);
    end;
    CurrentDesigner.ShowMethod(EvName);
  end;
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.PopupMenuPopup(Sender: TObject);
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}

function _Has2Menus(AControl: TComponent): Boolean;
  var
    I, Count: Integer;
  begin
    Result := True;
    Count := 0;
    with AControl do
      for I := 0 to ComponentCount - 1 do
        if Components[I].InheritsFrom(TMenu) then
        begin
          Inc(Count);
          if Count = 2 then
            Exit;
        end;
    Result := False;
  end;
  {- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
begin
  CreateSubMenuItem.Enabled := (MenuEditor.SelectedItem <> nil) and
    TMMenuItem(MenuEditor.SelectedItem).ItemInMenu;
  DeleteItem.Enabled := CreateSubMenuItem.Enabled;
  SelectMenuItem.Enabled := (DesignMenu <> nil) and (_Has2Menus(DesignMenu.Owner));
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.InsertItemClick(Sender: TObject);
begin
  if MenuEditor.SelectedItem = nil then
    Exit;
  with TMMenuItem(MenuEditor.SelectedItem).MenuFolder do
    InsertItem(SelectedItem);
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.DeleteItemClick(Sender: TObject);
begin
  if MenuEditor.SelectedItem = nil then
    Exit;
  with TMMenuItem(MenuEditor.SelectedItem).MenuFolder do
    DeleteItem(SelectedItem, False);
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.CreateSubMenuItemClick(Sender: TObject);
begin
  if MenuEditor.SelectedItem = nil then
    Exit;
  with TMMenuItem(MenuEditor.SelectedItem).MenuFolder do
    CreateSubMenu(SelectedItem)
end;

{------------------------------------------------------------------}

procedure TDCMenuDesigner.SelectMenuItemClick(Sender: TObject);
begin
  DesignMenu := ChooseMenu(DesignMenu.Owner, DesignMenu);
end;

{------------------------------------------------------------------}

initialization

finalization
  MenuDesigner.Free;
end.
