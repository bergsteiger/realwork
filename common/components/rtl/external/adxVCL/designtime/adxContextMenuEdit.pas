{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxContextMenuEdit;

{$I adxDefs.inc}

{$DEFINE ADX_DESIGNER}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, adxAddIn,
  {$IFDEF ADX_VCL5}
  DsgnIntf, MaskProp, DsgnWnds, ToolsAPI, LibIntf,
  {$ELSE}
  Variants,
  DesignIntf,
  DesignEditors,
  ComponentDesigner,
  {$ENDIF}
  Dialogs, ComCtrls, ToolWin, Menus, ImgList, StdCtrls, ExtCtrls, ActiveX, Math, OleServer
  {$IFDEF ADX_DESIGNER}
  , ADXDesign_TLB
  {$ENDIF};

type
  {$IFDEF ADX_VCL5}
  TadxContextMenuEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindowActions, IDesignEditQuery)
  {$ELSE}
  TadxContextMenuEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindow, IEditHandler, IActivatable)
  {$ENDIF}
    PopupMenu: TPopupMenu;
    ImageList1: TImageList;
    miButton: TMenuItem;
    miAdvancedControl: TMenuItem;
    miControl: TMenuItem;
    miEditBox: TMenuItem;
    miCombobox: TMenuItem;
    miDropdown: TMenuItem;
    miPopup: TMenuItem;
    N1: TMenuItem;
    miDelete: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    panDesign: TPanel;
    panControls: TPanel;
    ToolBar: TToolBar;
    tbButton: TToolButton;
    tbAdvancedControl: TToolButton;
    tbControl: TToolButton;
    tbEditBox: TToolButton;
    tbComboBox: TToolButton;
    tbDropDown: TToolButton;
    tbPopup: TToolButton;
    tbSeparator1: TToolButton;
    tbDelete: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    Tree: TTreeView;
    cbOffice: TComboBox;
    tbSeparator2: TToolButton;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CommonClick(Sender: TObject);
    procedure TreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure TreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeKeyPress(Sender: TObject; var Key: Char);
    procedure cbOfficeChange(Sender: TObject);
  private
    FActive: Boolean;
    FNotify: Longword;
    {$IFNDEF ADX_VCL5}
    FDesigner: IDesigner;
    FComponentDesigner: IComponentDesigner;
    {$ELSE}
    FDesigner: IFormDesigner;
    {$ENDIF}
    FCollectionPropertyName: string;
    FClosing: Boolean;
    FSelectionError: Boolean;
    {$IFDEF ADX_DESIGNER}
    FCmdBarDesigner: ADXDesign_TLB.TAdxContextMenu;
    FCmdBarIDs: TStringList;
    procedure UpdateProps(const Ctrl: TadxCommandBarControl; ANode: TTreeNode);
    {$ENDIF}
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure CloseEditor;
    procedure UpdateToolBarAndMenu(Node: TTreeNode);
    procedure BuildControlsList;
    procedure SetCollectionPropertyName(const Value: string);
    function GetRegKey: string;
    procedure DoControlSelect(ASender: TObject; const ControlID: WideString);
  protected
    // IEditHandler
    function GetEditState: TEditState; virtual;
    {$IFDEF ADX_VCL5}
    procedure EditAction(Action: TEditAction); virtual;
    {$ELSE}
    function EditAction(Action: TEditAction): Boolean; virtual;
    {$ENDIF}
    // IDesignWindowActions
    procedure WindowHide; virtual;
    procedure WindowShow; virtual;
    // IDesignNotification
    {$IFDEF ADX_VCL5}
    procedure ItemDeleted(const AItem: IPersistent);
    procedure ItemInserted(const AItem: IPersistent);
    procedure ItemsModified(const ADesigner: IUnknown);
    procedure SelectionChanged(const ASelection: IDesignerSelections);
    procedure DesignerInitialized(const ADesigner: IUnknown);
    procedure DesignerClosed(const ADesigner: IUnknown);
    {$ELSE}
    procedure ItemDeleted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure ItemInserted(const ADesigner: IDesigner; Item: TPersistent); virtual;
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections); virtual;
    procedure DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean); virtual;
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean); virtual;
    procedure ItemsModified(const Designer: IDesigner); virtual;
    {$ENDIF}
    procedure Activated; dynamic;
    procedure WndProc(var Message: TMessage); override;
  public
    Collection: TOwnedCollection;
    Component: TComponent;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure GetSelection;
    procedure SetSelection;

    property Active: Boolean read FActive;
    {$IFNDEF ADX_VCL5}
    property Designer: IDesigner read FDesigner write FDesigner;
    {$ELSE}
    property Designer: IFormDesigner read FDesigner write FDesigner;
    {$ENDIF}
    property CollectionPropertyName: string read FCollectionPropertyName write SetCollectionPropertyName;
  end;

procedure ShowContextMenuEditor(ADesigner: IDesigner; AComponent: TComponent;
  ACollection: TOwnedCollection; const PropertyName: string);

implementation

{$R *.dfm}

uses Registry, DesignConst;

var
  ContextMenuEditorsList: TList = nil;

type
  TCollectionAccess = class(TCollection);
  TOwnedCollectionAccess = class(TOwnedCollection);
  TPersistentAccess = class(TPersistent);

procedure ShowContextMenuEditor(ADesigner: IDesigner; AComponent: TComponent;
  ACollection: TOwnedCollection; const PropertyName: string);
var
  i: Integer;
  frm: TadxContextMenuEditor;
begin
  if ContextMenuEditorsList = nil then ContextMenuEditorsList := TList.Create;
  for i := 0 to ContextMenuEditorsList.Count - 1 do begin
    frm := TadxContextMenuEditor(ContextMenuEditorsList[i]);
    with frm do
      if (Designer = ADesigner) and (Component = AComponent)
        and (Collection = ACollection)
        and (CompareText(CollectionPropertyName, PropertyName) = 0) then
      begin
        Show;
        BringToFront;
        Exit;
      end;
  end;
  frm := TadxContextMenuEditor.Create(Application);
  with frm do
  try
    {$IFDEF ADX_VCL5}
    Designer := ADesigner as IFormDesigner;
    {$ELSE}
    Designer := ADesigner;
    {$ENDIF}
    Collection := ACollection;
    Component := AComponent;
    CollectionPropertyName := PropertyName;

    with TRegIniFile.Create(GetRegKey) do
    try
      Left := ReadInteger(Collection.ClassName + '_internal', 'Left', Left);
      Top := ReadInteger(Collection.ClassName + '_internal', 'Top', Top);
      Width := ReadInteger(Collection.ClassName + '_internal', 'Width', Width);
      Height := ReadInteger(Collection.ClassName + '_internal', 'Height', Height);
      panDesign.Width := ReadInteger(Collection.ClassName + '_internal', 'DesignWidth', panDesign.Width);
    finally
      Free;
    end;
    BuildControlsList;
    Show;
  except
    Free;
  end;
end;

{ TadxContextMenuEditor }

constructor TadxContextMenuEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF ADX_VCL5}
  RegisterDesignNotification(Self);
  FComponentDesigner := ActiveDesigner;
  SetBounds(200, FComponentDesigner.Environment.GetMainWindowSize.Bottom + 2, Width, Height);
  {$ELSE}
  CompLib.RegisterDesignWindow(Self);
  {$ENDIF}

  panDesign.Visible := False;
  {$IFDEF ADX_DESIGNER}
  try
    FNotify := RegisterWindowMessage('WM_ADXREGION_POSCHANGED');
    FCmdBarIDs := TStringList.Create();

    FCmdBarDesigner := ADXDesign_TLB.TAdxContextMenu.Create(nil);
    FCmdBarDesigner.OnBarResize := nil;
    FCmdBarDesigner.OnControlSelect := DoControlSelect;
    FCmdBarDesigner.ConnectKind := ckNewInstance;
    panDesign.Visible := True;
    FCmdBarDesigner.CreateMenu(panDesign.Handle);
    cbOffice.ItemIndex := 0;
  except
    panDesign.Visible := False;
    FCmdBarDesigner := nil;
  end
  {$ENDIF}
end;

destructor TadxContextMenuEditor.Destroy;
begin
  {$IFNDEF ADX_VCL5}
  UnregisterDesignNotification(Self);
  FComponentDesigner := nil;
  {$ELSE}
  CompLib.UnregisterDesignWindow(Self);
  {$ENDIF}
  FDesigner := nil;
  {$IFDEF ADX_DESIGNER}
  if Assigned(FCmdBarIDs) then FCmdBarIDs.Free;
  if Assigned(FCmdBarDesigner) then begin
    FCmdBarDesigner.OnBarResize := nil;
    FCmdBarDesigner.OnControlSelect := nil;
    FCmdBarDesigner.DestroyMenu();
    FCmdBarDesigner.Disconnect();
    FreeAndNil(FCmdBarDesigner);
  end;
  {$ENDIF}
  inherited Destroy;
end;

procedure TadxContextMenuEditor.DoControlSelect(ASender: TObject; const ControlID: WideString);

  function FindNodeByObject(Item: TTreeNode; Value: TObject): TTreeNode;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to Item.Count - 1 do begin
      if Item.Item[i].HasChildren then
        Result := FindNodeByObject(Item.Item[i], Value);
      if Assigned(Result) then Break;
      if Item.Item[i].Data = Value then begin
        Result := Item.Item[i];
        Break;
      end;
    end;
  end;

var
  i: Integer;
  Node: TTreeNode;
begin
  if ControlID = 'ROOT' then
    Node := Tree.Items[0]
  else begin
    Node := nil;
    for i := 0 to FCmdBarIDs.Count - 1 do
      if FCmdBarIDs[i] = ControlID then begin
        Node := FindNodeByObject(Tree.Items[0], FCmdBarIDs.Objects[i]);
        Break;
      end;
  end;
  if Node <> nil then
    Node.Selected := True;
end;

procedure TadxContextMenuEditor.WndProc(var Message: TMessage);
begin
  if Message.Msg = FNotify then
    panDesign.Height := Message.LParam;
  inherited WndProc(Message);
end;

function TadxContextMenuEditor.GetEditState: TEditState;
begin
  Result := [];
end;

{$IFDEF ADX_VCL5}
procedure TadxContextMenuEditor.EditAction(Action: TEditAction);
begin
end;
{$ELSE}
function TadxContextMenuEditor.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;
{$ENDIF}

procedure TadxContextMenuEditor.WindowHide;
begin
  if Visible then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TadxContextMenuEditor.WindowShow;
const
  ShowCommands: array[TWindowState] of Word =
    (SW_SHOWNOACTIVATE, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if Visible then
    ShowWindow(Handle, ShowCommands[WindowState]);
end;

{$IFDEF ADX_VCL5}
procedure TadxContextMenuEditor.ItemDeleted(const AItem: IPersistent);

  function IsOwnedBy(Owner, Child: TPersistent): Boolean;
  begin
    Result := False;
    if Owner = nil then Exit;
    while (Child <> nil) and (Child <> Owner) and not (Child is TComponent) do
      Child := TPersistentAccess(Child).GetOwner;
    Result := Child = Owner;
  end;

var
  Temp: TPersistent;
begin
  Temp := TryExtractPersistent(AItem);
  if Temp = nil then Exit;
  if (Self.Component = nil) or (csDestroying in Self.Component.ComponentState) or
    (Temp = Self.Component) or IsOwnedBy(Temp, Collection) then
  begin
    Collection := nil;  // Component is already in its destructor; collection is gone
    Self.Component := nil;
    CloseEditor;
  end;
end;

procedure TadxContextMenuEditor.ItemInserted(const AItem: IPersistent);
begin
end;

procedure TadxContextMenuEditor.SelectionChanged(const ASelection: IDesignerSelections);
begin
end;

procedure TadxContextMenuEditor.DesignerInitialized(const ADesigner: IUnknown);
begin
end;

procedure TadxContextMenuEditor.DesignerClosed(const ADesigner: IUnknown);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxContextMenuEditor.ItemsModified(const ADesigner: IUnknown);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if CompLib.GetActiveForm.Designer <> Designer then Exit;
    GetSelection;
  end;
end;

{$ELSE}
procedure TadxContextMenuEditor.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);

  function IsOwnedBy(Owner, Child: TPersistent): Boolean;
  begin
    Result := False;
    if Owner = nil then Exit;
    while (Child <> nil) and (Child <> Owner) and not (Child is TComponent) do
      Child := TPersistentAccess(Child).GetOwner;
    Result := Child = Owner;
  end;

begin
  if (Item = nil) or FClosing then Exit;
  if (Component = nil) or (csDestroying in Component.ComponentState) or
     (Item = Component) or (Item = Collection) or IsOwnedBy(Item, Collection) then
    CloseEditor;
end;

procedure TadxContextMenuEditor.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
end;

procedure TadxContextMenuEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
end;

procedure TadxContextMenuEditor.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TadxContextMenuEditor.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxContextMenuEditor.ItemsModified(const Designer: IDesigner);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if ActiveRoot <> nil then
      if ActiveRoot.GetDesigner <> Designer then Exit;
    GetSelection;
  end;
end;
{$ENDIF}

procedure TadxContextMenuEditor.Activated;
{$IFDEF ADX_VCL5}
var
  Msg: TMessage;
{$ENDIF}
begin
  {$IFDEF ADX_VCL5}
  Msg.Msg := WM_ACTIVATE;
  Msg.WParam := 1;
  Designer.IsDesignMsg(Designer.Form, Msg);
  {$ELSE}
  Designer.Activate;
  {$ENDIF}
  SetSelection;
end;

procedure TadxContextMenuEditor.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then Activated;
end;

procedure TadxContextMenuEditor.CloseEditor;
begin
  FClosing := True;
  Collection := nil;
  Component := nil;
  Close;
end;

{$IFDEF ADX_DESIGNER}
type
  TadxCustomCommandBarComboBoxAccess = class(TadxCustomCommandBarComboBox);

procedure TadxContextMenuEditor.UpdateProps(const Ctrl: TadxCommandBarControl; ANode: TTreeNode);
var
  id: string;
  PictureDesc: TPictDesc;
  bmp: TBitmap;
  IPict: IPictureDisp;
begin
  if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
    if FCmdBarIDs.IndexOfObject(Ctrl) >= 0 then begin
      id := FCmdBarIDs[FCmdBarIDs.IndexOfObject(Ctrl)];
      if id <> Ctrl.OfficeTag then begin
        FCmdBarDesigner.Items.UpdateProp(id, tp_ID, Ctrl.OfficeTag); // tp_ID
        FCmdBarIDs[FCmdBarIDs.IndexOfObject(Ctrl)] := Ctrl.OfficeTag;
      end;
    end;
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_BeginGroup, Ctrl.BeginGroup);
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Caption, Ctrl.Caption);
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Enabled, Ctrl.Enabled);
    if not (Ctrl is TadxCustomCommandBarComboBox) then
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Height, Ctrl.Height);
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_ToolTip, Ctrl.TooltipText);
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Visible, Ctrl.Visible);
    FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Width, Ctrl.Width);

    if (Ctrl is TadxCommandBarButton) then begin
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Pressed, Ctrl.AsButton.State);
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Style, Ctrl.AsButton.Style);
      IPict := nil;
      if Ctrl.AsButton.Glyph <> nil then begin
        if not Ctrl.AsButton.Glyph.Empty then begin
          Bmp := TBitmap.Create;
          Bmp.PixelFormat := pf24bit;
          try
            Bmp.Assign(Ctrl.AsButton.Glyph);
            Bmp.Transparent := True;
            PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
            PictureDesc.picType := PICTYPE_BITMAP;
            PictureDesc.hBitmap := Bmp.ReleaseHandle;
            PictureDesc.hpal := Bmp.ReleasePalette;
            OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, IPict);
          finally
            Bmp.Free;
          end;
        end;
      end;
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Glyph, IPict);
    end;

    if (Ctrl is TadxCustomCommandBarComboBox) then begin
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Style, TadxCustomCommandBarComboBoxAccess(Ctrl).Style);
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Text, TadxCustomCommandBarComboBoxAccess(Ctrl).Text);
    end;
    if (Ctrl is TadxCommandBarDropdownList) or (Ctrl is TadxCommandBarComboBox) then begin
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_Items, TadxCustomCommandBarComboBoxAccess(Ctrl).Items.Text);
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_SelectedItemIndex, TadxCustomCommandBarComboBoxAccess(Ctrl).ListIndex);
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_DropDownLines, TadxCustomCommandBarComboBoxAccess(Ctrl).DropdownLines);
      FCmdBarDesigner.Items.UpdateProp(Ctrl.OfficeTag, tp_DropDownWidth, TadxCustomCommandBarComboBoxAccess(Ctrl).DropdownWidth);
    end;
  end;
end;
{$ENDIF}

type
  TadxCustomCommandBarAccess = class(TadxCustomCommandBar);

procedure TadxContextMenuEditor.GetSelection;
{$IFDEF ADX_DESIGNER}
var
  Ctrl: TadxCommandBarControl;
{$ENDIF}
begin
  if Tree.Selected <> nil then begin
    // root
    if Tree.Selected.Data = nil then begin
      if Component is adxAddin.TadxCustomCommandBar then
        Tree.Selected.Text := TadxCustomCommandBarAccess(Component).CommandBarName + ' (' + adxAddin.TadxCustomCommandBar(Component).ClassName + ')';
    end
    // collectionitem
    else begin
      Tree.Selected.Text := TadxCommandBarControl(Tree.Selected.Data).DisplayName;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
        Ctrl := TadxCommandBarControl(Tree.Selected.Data);
        FCmdBarDesigner.Items.BeginUpdate(Ctrl.OfficeTag);
        UpdateProps(Ctrl, Tree.Selected);
        FCmdBarDesigner.Items.EndUpdate(Ctrl.OfficeTag);
      end;
      {$ENDIF}
    end;
  end;
end;

procedure TadxContextMenuEditor.SetSelection;
var
  {$IFDEF ADX_VCL5}
  List: TDesignerSelectionList;
  {$ELSE}
  List: IDesignerSelections;
  {$ENDIF}
begin
  if FSelectionError then Exit;
  try
    {$IFDEF ADX_VCL5}
    if Tree.Selected <> nil then
    {$ELSE}
    if Tree.SelectionCount > 0 then
    {$ENDIF}
    begin
      if Tree.Selected.Data = nil then begin
        if Designer <> nil then begin
          Designer.SelectComponent(Component);

          if panDesign.Visible then
            FCmdBarDesigner.Items.SelectControl('ROOT');
        end;
        Exit;
      end;
      {$IFDEF ADX_VCL5}
      List := TDesignerSelectionList.Create;
      {$ELSE}
      List := CreateSelectionList;
      {$ENDIF}
      List.Add(TadxCommandBarControl(Tree.Selected.Data));
      if Designer <> nil then begin
        Designer.SetSelections(List);

        if panDesign.Visible then
          FCmdBarDesigner.Items.SelectControl(TadxCommandBarControl(Tree.Selected.Data).OfficeTag);
      end;
    end
    else
      if Assigned(Designer) then
        Designer.SelectComponent(Component);
  except
    FSelectionError := True;
    Application.HandleException(ExceptObject);
    Close;
  end;
end;

procedure TadxContextMenuEditor.SetCollectionPropertyName(const Value: string);
const
  SEditorCaption = 'Editing %s%s%s';
begin
  if Value <> FCollectionPropertyName then begin
    FCollectionPropertyName := Value;
    Caption := Format(SEditorCaption, [Component.Name, '.', Value]);
  end;
end;

function TadxContextMenuEditor.GetRegKey: string;
begin
  {$IFDEF ADX_VCL5}
  Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
  {$ELSE}
  Result := FComponentDesigner.Environment.GetBaseRegKey + '\' +
    sIniEditorsName + '\Collection Editor';
  {$ENDIF}
end;

procedure TadxContextMenuEditor.FormCreate(Sender: TObject);
begin
  ContextMenuEditorsList.Add(Self);

  tbButton.Tag := Integer(adxButton);
  miButton.Tag := Integer(adxButton);
  tbEditBox.Tag := Integer(adxEdit);
  miEditBox.Tag := Integer(adxEdit);
  tbDropDown.Tag := Integer(adxDropDown);
  miDropDown.Tag := Integer(adxDropDown);
  tbComboBox.Tag := Integer(adxComboBox);
  miComboBox.Tag := Integer(adxComboBox);
  tbPopup.Tag := Integer(adxPopup);
  miPopup.Tag := Integer(adxPopup);
  tbControl.Tag := Integer(adxControl);
  miControl.Tag := Integer(adxControl);
  tbAdvancedControl.Tag := Integer(adxAdvancedControl);
  miAdvancedControl.Tag := Integer(adxAdvancedControl);
end;

procedure TadxContextMenuEditor.FormDestroy(Sender: TObject);
begin
  if ContextMenuEditorsList <> nil then
    ContextMenuEditorsList.Remove(Self);
end;

procedure TadxContextMenuEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Component <> nil then
    Designer.SelectComponent(Component);
  if Collection <> nil then
    with TRegIniFile.Create(GetRegKey) do
    try
      EraseSection(Collection.ClassName + '_internal');
      WriteInteger(Collection.ClassName + '_internal', 'Left', Left);
      WriteInteger(Collection.ClassName + '_internal', 'Top', Top);
      WriteInteger(Collection.ClassName + '_internal', 'Width', Width);
      WriteInteger(Collection.ClassName + '_internal', 'Height', Height);
      WriteInteger(Collection.ClassName + '_internal', 'DesignWidth', panDesign.Width);
    finally
      Free;
    end;
  Action := caFree;
end;

function GetType(const Sender: TadxCommandBarControl): Integer;
begin
  if Sender is TadxCommandBarButton then Result := tc_Button
  else if Sender is TadxCommandBarEdit then Result := tc_EditBox
  else if Sender is TadxCommandBarDropdownList then Result := tc_DropDown
  else if Sender is TadxCommandBarComboBox then Result := tc_ComboBox
  else if Sender is TadxCommandBarPopup then Result := tc_Menu
  else Result := tc_Control;
end;

function GetImageIndex(const Sender: TadxCommandBarControl): Integer;
begin
  if Sender is TadxCommandBarButton then Result := 3
  else if Sender is TadxCommandBarEdit then Result := 4
  else if Sender is TadxCommandBarDropdownList then Result := 5
  else if Sender is TadxCommandBarComboBox then Result := 6
  else if Sender is TadxCommandBarPopup then Result := 7
  else if Sender is TadxCommandBarAdvancedControl then Result := 9
  else Result := 8
end;

procedure TadxContextMenuEditor.BuildControlsList;

  procedure ProcessChildren(ANode: TTreeNode; ACtrls: TadxCommandBarControls);
  var
    i: Integer;
    Node: TTreeNode;
  begin
    for i := 0 to ACtrls.Count - 1 do begin
      Node := Tree.Items.AddChildObject(ANode, ACtrls[i].DisplayName, ACtrls[i]);
      Node.ImageIndex := GetImageIndex(ACtrls[i]);
      Node.SelectedIndex := Node.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
        FCmdBarDesigner.Items.AddControl(
          GetType(ACtrls[i]),
          TadxCommandBarControl(ANode.Data).OfficeTag,
          ACtrls[i].OfficeTag,
          ACtrls[i].Caption);
        FCmdBarIDs.AddObject(ACtrls[i].OfficeTag, ACtrls[i]);
        UpdateProps(ACtrls[i], Node);
      end;
      {$ENDIF}

      if ACtrls[i] is TadxCommandBarPopup then
        if ACtrls[i].AsPopup.Controls.Count > 0 then
          ProcessChildren(Node, ACtrls[i].AsPopup.Controls);
    end;
  end;
  
var
  i: Integer;
  Root, Node: TTreeNode;
  Obj: TPersistent;
begin
  if (Component is adxAddin.TadxContextMenu) then begin
    tbEditBox.Visible := False;
    miEditBox.Visible := False;
    tbComboBox.Visible := False;
    miCombobox.Visible := False;
    tbDropDown.Visible := False;
    miDropdown.Visible := False;
    tbAdvancedControl.Visible := False;
    miAdvancedControl.Visible := False;
  end;

  Tree.Items.BeginUpdate;
  try
    {$IFDEF ADX_DESIGNER}
    if Assigned(FCmdBarDesigner) then FCmdBarDesigner.Items.BeginUpdate('');
    {$ENDIF}
    Root := Tree.Items.AddChildFirst(nil, TadxCustomCommandBarAccess(TOwnedCollectionAccess(TadxCommandBarControls(Collection)).GetOwner).CommandBarName + ' (' + adxAddin.TadxCustomCommandBar(TOwnedCollectionAccess(TadxCommandBarControls(Collection)).GetOwner).ClassName + ')');
    Root.ImageIndex := 10;
    Root.SelectedIndex := 10;
    {$IFDEF ADX_DESIGNER}
    if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
      Obj := TOwnedCollectionAccess(TadxCommandBarControls(Collection)).GetOwner;
      if (Obj is TadxMainMenu) or (Obj is TadxOlExplorerMainMenu) or (Obj is TadxOlInspectorMainMenu) then
        FCmdBarDesigner.Items.AddControl(tc_MainMenu, '', 'ROOT', '')
      else
        FCmdBarDesigner.Items.AddControl(tc_Group, '', 'ROOT', '');
      FCmdBarIDs.AddObject('ROOT', adxAddin.TadxCustomCommandBar(TOwnedCollectionAccess(TadxCommandBarControls(Collection)).GetOwner));
    end;
    {$ENDIF}
    for i := 0 to TadxCommandBarControls(Collection).Count - 1 do begin
      Node := Tree.Items.AddChildObject(Root, TadxCommandBarControls(Collection)[i].DisplayName, TadxCommandBarControls(Collection)[i]);
      Node.ImageIndex := GetImageIndex(TadxCommandBarControls(Collection)[i]);
      Node.SelectedIndex := Node.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FCmdBarDesigner) then begin

        FCmdBarDesigner.Items.AddControl(
          GetType(TadxCommandBarControls(Collection)[i]),
          'ROOT',
          (TadxCommandBarControls(Collection)[i]).OfficeTag,
          (TadxCommandBarControls(Collection)[i]).Caption);
        FCmdBarIDs.AddObject((TadxCommandBarControls(Collection)[i]).OfficeTag, TadxCommandBarControls(Collection)[i]);
        UpdateProps(TadxCommandBarControls(Collection)[i], Node);
      end;
      {$ENDIF}
      if TadxCommandBarControls(Collection)[i] is TadxCommandBarPopup then
        if (TadxCommandBarControls(Collection)[i]).AsPopup.Controls.Count > 0 then
          ProcessChildren(Node, (TadxCommandBarControls(Collection)[i]).AsPopup.Controls);
    end;
    UpdateToolBarAndMenu(Tree.Selected);
    Tree.FullExpand;
    Root.MakeVisible;
  finally
    {$IFDEF ADX_DESIGNER}
    if Assigned(FCmdBarDesigner) then FCmdBarDesigner.Items.EndUpdate('');
    {$ENDIF}
    Tree.Items.EndUpdate;
  end;
end;

procedure TadxContextMenuEditor.CommonClick(Sender: TObject);

var
  Item: TadxCommandBarControl;
  Coll: TCollection;
  Node: TTreeNode;
  isExpanded: Boolean;
  {$IFDEF ADX_DESIGNER}
  ParentID: string;
  {$ENDIF}
begin
  case (Sender as TComponent).Tag of
    // Delete
    110: if MessageDlg('Are you sure you want to delete the selected item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
           Coll := TadxCommandBarControl(Tree.Selected.Data).Collection;
           Coll.BeginUpdate;
           try
            {$IFDEF ADX_DESIGNER}
            if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
              FCmdBarDesigner.Items.BeginUpdate('');
              FCmdBarDesigner.Items.DeleteControl(TadxCommandBarControl(Tree.Selected.Data).OfficeTag);
              FCmdBarDesigner.Items.EndUpdate('');
            end;
            {$ENDIF}
             Coll.Delete(TadxCommandBarControl(Tree.Selected.Data).Index);
             Tree.Selected.Delete;
             UpdateToolBarAndMenu(Tree.Selected);
           finally
             Coll.EndUpdate;
           end;
         end;
    // Move Up
    120: begin
           TadxCommandBarControl(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxCommandBarControl(Tree.Selected.Data).Index := TadxCommandBarControl(Tree.Selected.Data).Index - 1;
             {$IFDEF ADX_DESIGNER}
             if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
               if TOwnedCollectionAccess(TadxCommandBarControl(Tree.Selected.Data).Collection).GetOwner is adxAddin.TadxCustomCommandBar then
                 ParentID := 'ROOT'
               else
                 ParentID := TadxCommandBarControl(TOwnedCollectionAccess(TadxCommandBarControl(Tree.Selected.Data).Collection).GetOwner).OfficeTag;
               FCmdBarDesigner.Items.BeginUpdate(ParentID);
               FCmdBarDesigner.Items.SetParent(ParentID,
                 TadxCommandBarControl(Tree.Selected.Data).OfficeTag,
                 TadxCommandBarControl(Tree.Selected.Data).Index);
               FCmdBarDesigner.Items.EndUpdate(ParentID);
             end;
             {$ENDIF}
             Tree.Items.BeginUpdate;
             try
               isExpanded := Tree.Selected.Expanded;
               Tree.Selected.MoveTo(Tree.Selected.getPrevSibling, naInsert);
               if Tree.Selected.HasChildren and isExpanded then
                 Tree.Selected.Expand(True);
               UpdateToolBarAndMenu(Tree.Selected);
             finally
               Tree.Items.EndUpdate;
             end;
           finally
             TadxCommandBarControl(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // Move Down
    130: begin
           TadxCommandBarControl(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxCommandBarControl(Tree.Selected.Data).Index := TadxCommandBarControl(Tree.Selected.Data).Index + 1;
             {$IFDEF ADX_DESIGNER}
             if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
               if TOwnedCollectionAccess(TadxCommandBarControl(Tree.Selected.Data).Collection).GetOwner is adxAddin.TadxCustomCommandBar then
                 ParentID := 'ROOT'
               else
                 ParentID := TadxCommandBarControl(TOwnedCollectionAccess(TadxCommandBarControl(Tree.Selected.Data).Collection).GetOwner).OfficeTag;
               FCmdBarDesigner.Items.BeginUpdate(ParentID);
               FCmdBarDesigner.Items.SetParent(ParentID,
                 TadxCommandBarControl(Tree.Selected.Data).OfficeTag,
                 TadxCommandBarControl(Tree.Selected.Data).Index);
               FCmdBarDesigner.Items.EndUpdate(ParentID);
             end;
             {$ENDIF}
             Tree.Items.BeginUpdate;
             try
               isExpanded := Tree.Selected.Expanded;
               if Tree.Selected.getNextSibling.getNextSibling = nil then
                 Tree.Selected.getNextSibling.MoveTo(Tree.Selected, naInsert)
               else
                 Tree.Selected.MoveTo(Tree.Selected.getNextSibling.getNextSibling, naInsert);
               if Tree.Selected.HasChildren and isExpanded then
                 Tree.Selected.Expand(True);
               UpdateToolBarAndMenu(Tree.Selected);
             finally
               Tree.Items.EndUpdate;
             end;
           finally
             TadxCommandBarControl(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // add a control
    else begin
      try
        if (Tree.Selected = nil) or (Tree.Selected.Data = nil) then
          Item := TadxCommandBarControls(Collection).Add(TadxControlType((Sender as TComponent).Tag))
        else begin
          Item := TadxCommandBarControl(Tree.Selected.Data).AsPopup.Controls.Add(TadxControlType((Sender as TComponent).Tag));
        end;

        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
          if TOwnedCollectionAccess(Item.Collection).GetOwner is adxAddin.TadxCustomCommandBar then
            ParentID := 'ROOT'
          else
            ParentID := TadxCommandBarControl(TOwnedCollectionAccess(Item.Collection).GetOwner).OfficeTag;
          FCmdBarDesigner.Items.BeginUpdate(ParentID);
          FCmdBarDesigner.Items.AddControl(GetType(Item), ParentID, Item.OfficeTag, Item.Caption);
          FCmdBarIDs.AddObject(Item.OfficeTag, Item);
          FCmdBarDesigner.Items.EndUpdate(ParentID);
        end;
        {$ENDIF}

        Node := Tree.Items.AddChildObject(Tree.Selected, Item.DisplayName, Item);
        Node.ImageIndex := GetImageIndex(Item);
        Node.SelectedIndex := Node.ImageIndex;
        if Assigned(Tree.Selected) and Tree.Selected.HasChildren then Tree.Selected.Expand(False);
        UpdateToolBarAndMenu(Tree.Selected);
      except
        on E: SysUtils.Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
  Designer.Modified;
end;

procedure TadxContextMenuEditor.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TadxContextMenuEditor.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  SetSelection;
  UpdateToolBarAndMenu(Node);
end;

procedure TadxContextMenuEditor.UpdateToolBarAndMenu(Node: TTreeNode);

  procedure EnableControls(Ctrls: array of TControl);
  var
    i: Integer;
  begin
    for i := Low(Ctrls) to High(Ctrls) do
      Ctrls[i].Enabled := True;
  end;

  procedure EnableMenuItems(Items: array of TMenuItem);
  var
    i: Integer;
  begin
    for i := Low(Items) to High(Items) do
      Items[i].Enabled := True;
  end;

var
  i: Integer;
  Item: TadxCommandBarControl;
begin
  for i := 0 to ToolBar.ButtonCount - 2 do
    if ToolBar.Buttons[i].Style = tbsButton then
      ToolBar.Buttons[i].Enabled := False;
  for i := 0 to PopupMenu.Items.Count - 1 do
    if PopupMenu.Items[i].Caption <> '-' then
      PopupMenu.Items[i].Enabled := False;
  if (Node = nil) or (Node.Data = nil) then begin
    EnableControls([tbButton, tbEditBox, tbDropDown, tbComboBox, tbPopup, tbControl, tbAdvancedControl]);
    EnableMenuItems([miButton, miEditBox, miDropDown, miComboBox, miPopup, miControl, miAdvancedControl]);
  end else begin
    Item := TadxCommandBarControl(Node.Data);
    // Delete
    tbDelete.Enabled := True;
    miDelete.Enabled := tbDelete.Enabled;
    // Move Up
    tbMoveUp.Enabled := Item.Index > 0;
    miMoveUp.Enabled := tbMoveUp.Enabled;
    // Move Down
    tbMoveDown.Enabled := Item.Index < Item.Collection.Count - 1;
    miMoveDown.Enabled := tbMoveDown.Enabled;
    // Popup
    if (Item is TadxCommandBarPopup) then begin
      EnableControls([tbButton, tbEditBox, tbDropDown, tbComboBox, tbPopup, tbControl]);
      EnableMenuItems([miButton, miEditBox, miDropDown, miComboBox, miPopup, miControl]);
    end;
  end;
end;

procedure TadxContextMenuEditor.TreeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node: TTreeNode;
begin
  Node := Tree.GetNodeAt(MousePos.X, MousePos.Y);
  if Assigned(Node) then
    Tree.Selected := Node;
end;

type
  TadxControlTypeEditor = (adxButton, adxEdit, adxDropdown, adxComboBox, adxPopup,
    adxControl, adxAdvancedControl, adxCommandBar, adxDummy);

function GetADXType(const Sender: TadxCommandBarControl): TadxControlTypeEditor;
begin
  if Sender is TadxCommandBarButton then Result := adxButton
  else if Sender is TadxCommandBarEdit then Result := adxEdit
  else if Sender is TadxCommandBarDropdownList then Result := adxDropdown
  else if Sender is TadxCommandBarComboBox then Result := adxComboBox
  else if Sender is TadxCommandBarPopup then Result := adxPopup
  else if Sender is TadxCommandBarAdvancedControl then Result := adxAdvancedControl
  else Result := adxControl;
end;

procedure TadxContextMenuEditor.TreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  DstParent: TPersistent;
  SrcType, DstType, DstParentType: TadxControlTypeEditor;
begin
  if Y < 15 then begin
    SendMessage(Tree.Handle, WM_VSCROLL, SB_LINEUP, 0);
    Tree.Repaint;
  end
  else
    if Tree.Height - Y < 15 then begin
      SendMessage(Tree.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
      Tree.Repaint;
    end;

  Accept := False;
  if Tree.Selected = nil then Exit;
  if Tree.Selected.Data = nil then Exit;
  if Tree.DropTarget = nil then Exit;
  if Tree.Selected.Parent = Tree.DropTarget then Exit;

  DstParentType := adxDummy;
  if Tree.DropTarget.Data = nil then
    DstType := adxCommandBar
  else begin
    DstType := GetADXType(TadxCommandBarControl(Tree.DropTarget.Data));
    DstParent := TOwnedCollectionAccess(TadxCommandBarControl(Tree.DropTarget.Data).Collection).GetOwner;
    if DstParent is adxAddin.TadxCustomCommandBar then
      DstParentType := adxCommandBar
    else
      DstParentType := GetADXType(TadxCommandBarControl(DstParent));
  end;
  SrcType := GetADXType(TadxCommandBarControl(Tree.Selected.Data));
  Accept := Tree.DropTarget <> Tree.Selected;
  if Accept then
    Accept := not Tree.DropTarget.HasAsParent(Tree.Selected);

  if Accept then begin
    case SrcType of
      adxButton,
      adxEdit,
      adxDropdown,
      adxComboBox,
      adxPopup,
      adxControl: Accept := (DstType in [adxCommandBar, adxPopup]) or (DstParentType in [adxCommandBar, adxPopup]);
      adxAdvancedControl: Accept := (DstType = adxCommandBar) or (DstParentType = adxCommandBar);
    end;
  end;
end;

procedure TadxContextMenuEditor.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);

  function CheckInsert(SrcType, DstType: TadxControlTypeEditor): boolean;
  begin
    Result := False;
    case SrcType of
      adxButton,
      adxEdit,
      adxDropdown,
      adxComboBox,
      adxControl: Result := (DstType = adxPopup);
      adxPopup: Result := (DstType in [adxCommandBar, adxPopup]);
      adxAdvancedControl: ;
    end;                                                    
  end;

var
  isNodeDown, isExpanded: Boolean;
  SrcType, DstType: TadxControlTypeEditor;
  SrcCtrl, DstCtrl: TadxCommandBarControl;
  DstCollection: TOwnedCollection;
begin
  if Assigned(Tree.DropTarget) and Assigned(Tree.Selected) then begin
    if (Tree.Selected.Data = nil) then Exit;
    SrcCtrl := TadxCommandBarControl(Tree.Selected.Data);
    SrcType := GetADXType(SrcCtrl);
    if Tree.DropTarget.Data = nil then begin
      if Component is adxAddin.TadxCustomCommandBar then begin
        DstCtrl := nil;
        DstType := adxCommandBar;
        DstCollection := TadxCustomCommandbarAccess(Component).Controls;
      end
      else Exit;
    end
    else begin
      DstCtrl := TadxCommandBarControl(Tree.DropTarget.Data);
      DstType := GetADXType(DstCtrl);
      DstCollection := TOwnedCollection(DstCtrl.Collection);
    end;

    // root
    if DstCtrl = nil then begin
      SrcCtrl.Collection := DstCollection;
      Tree.Items.BeginUpdate;
      try
        Tree.Selected.MoveTo(Tree.DropTarget, naAddChild);
        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
          FCmdBarDesigner.Items.BeginUpdate('ROOT');
          FCmdBarDesigner.Items.SetParent('ROOT', SrcCtrl.OfficeTag, SrcCtrl.Index);
          FCmdBarDesigner.Items.EndUpdate('ROOT');
        end;
        {$ENDIF}
        Designer.Modified;
        SetSelection;
        UpdateToolBarAndMenu(Tree.Selected);
      finally
        Tree.Items.EndUpdate;
      end;
    end
    else begin
      isNodeDown := False;
      if CheckInsert(SrcType, DstType) then begin
        isNodeDown := True;
        DstCollection := DstCtrl.AsPopup.Controls;
      end;

      SrcCtrl.Collection := DstCollection;
      if not isNodeDown then begin
        if SrcCtrl.Index < DstCtrl.Index then
          SrcCtrl.Index := DstCtrl.Index - 1
        else
          SrcCtrl.Index := DstCtrl.Index;
      end;

      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FCmdBarDesigner) then begin
        FCmdBarDesigner.Items.BeginUpdate(DstCtrl.OfficeTag);
        if isNodeDown then
          FCmdBarDesigner.Items.SetParent(DstCtrl.OfficeTag, SrcCtrl.OfficeTag, SrcCtrl.Index)
        else begin
          if TOwnedCollectionAccess(DstCtrl.Collection).GetOwner is adxAddin.TadxCustomCommandBar then
            FCmdBarDesigner.Items.SetParent('ROOT', SrcCtrl.OfficeTag, SrcCtrl.Index)
          else
            FCmdBarDesigner.Items.SetParent(
              TadxCommandBarControl(TOwnedCollectionAccess(DstCtrl.Collection).GetOwner).OfficeTag,
              SrcCtrl.OfficeTag, SrcCtrl.Index);
        end;
        FCmdBarDesigner.Items.EndUpdate(DstCtrl.OfficeTag);
      end;
      {$ENDIF}

      Tree.Items.BeginUpdate;
      try
        isExpanded := Tree.Selected.Expanded;
        
        if isNodeDown then
          Tree.Selected.MoveTo(Tree.DropTarget, naAddChild)
        else
          Tree.Selected.MoveTo(Tree.DropTarget, naInsert);

        if Tree.Selected.HasChildren and isExpanded then
          Tree.Selected.Expand(True);

        Designer.Modified;
        SetSelection;
        UpdateToolBarAndMenu(Tree.Selected);
      finally
        Tree.Items.EndUpdate;
      end;
    end;
  end;
end;

procedure TadxContextMenuEditor.TreeKeyPress(Sender: TObject; var Key: Char);
begin
  {$IFDEF UNICODE}
  if AnsiChar(Key) in ['!'..'~'] then
  {$ELSE}
  if Key in ['!'..'~'] then
  {$ENDIF}
  begin
    {$IFDEF ADX_VCL5}
    DelphiIDE.ModalEdit(Key, Self);
    {$ELSE}
    FComponentDesigner.Environment.ModalEdit(Key, Self);
    {$ENDIF}
    Key := #0;
  end;
end;

procedure TadxContextMenuEditor.cbOfficeChange(Sender: TObject);
begin
  {$IFDEF ADX_DESIGNER}
  if panDesign.Visible and Assigned(FCmdBarDesigner) then 
    case cbOffice.ItemIndex of
      0: FCmdBarDesigner.Items.UpdateProp('', tp_Style, 4);
      1: FCmdBarDesigner.Items.UpdateProp('', tp_Style, 2);
      2: FCmdBarDesigner.Items.UpdateProp('', tp_Style, 1);
    end;
  {$ENDIF}
end;

initialization

finalization
  if Assigned(ContextMenuEditorsList) then begin
    ContextMenuEditorsList.Free;
    ContextMenuEditorsList := nil;
  end;

end.
