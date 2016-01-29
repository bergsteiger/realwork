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

unit adxBackstageEdit;

{$I adxDefs.inc}

//{$DEFINE ADX_DESIGNER}

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
  TadxBackstageEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindowActions, IDesignEditQuery)
  {$ELSE}
  TadxBackstageEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindow, IEditHandler, IActivatable)
  {$ENDIF}
    PopupMenu: TPopupMenu;
    ImageList1: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    miDelete: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    panDesign: TPanel;
    panControls: TPanel;
    ToolBar: TToolBar;
    tbSeparator2: TToolButton;
    tbDelete: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    Tree: TTreeView;
    tbBackstageFastButton: TToolButton;
    tbBackstageTab: TToolButton;
    ToolButton3: TToolButton;
    miBackstageFastButton: TMenuItem;
    miBackstageTab: TMenuItem;
    tbBackstageTaskFormGroup: TToolButton;
    tbBackstageTaskFormGroupCategory: TToolButton;
    tbBackstageTaskFormGroupTask: TToolButton;
    ToolButton5: TToolButton;
    miBackstageTaskFormGroup: TMenuItem;
    miBackstageTaskFormGroupCategory: TMenuItem;
    miBackstageTaskFormGroupTask: TMenuItem;
    tbBackstageGroup: TToolButton;
    tbBackstageTaskGroup: TToolButton;
    tbBackstageTaskGroupCategory: TToolButton;
    tbBackstageTaskGroupTask: TToolButton;
    miBackstageGroup: TMenuItem;
    miBackstageTaskGroup: TMenuItem;
    miBackstageTaskGroupCategory: TMenuItem;
    miBackstageTaskGroupTask: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    miBackstagePrimaryMenu: TMenuItem;
    miBackstageMenuGroup: TMenuItem;
    miBackstageMenuButton: TMenuItem;
    tbBackstagePrimaryMenu: TToolButton;
    tbBackstageMenuGroup: TToolButton;
    tbBackstageMenuButton: TToolButton;
    ToolButton1: TToolButton;
    tbBackstageRegularButton: TToolButton;
    miBackstageRegularButton: TMenuItem;
    tbBackstageLayoutContainer: TToolButton;
    tbBackstageGroupBox: TToolButton;
    tbBackstageGroupButton: TToolButton;
    tbBackstageCheckBox: TToolButton;
    tbBackstageEditBox: TToolButton;
    tbBackstageDropDown: TToolButton;
    tbBackstageComboBox: TToolButton;
    tbBackstageRadioGroup: TToolButton;
    tbBackstageHyperlink: TToolButton;
    tbBackstageLabel: TToolButton;
    tbBackstageImage: TToolButton;
    miBackstageLayoutContainer: TMenuItem;
    miBackstageGroupBox: TMenuItem;
    miBackstageGroupButton: TMenuItem;
    miBackstageCheckBox: TMenuItem;
    miBackstageEditBox: TMenuItem;
    miBackstageDropDown: TMenuItem;
    miBackstageComboBox: TMenuItem;
    miBackstageRadioGroup: TMenuItem;
    miBackstageHyperlink: TMenuItem;
    miBackstageLabel: TMenuItem;
    miBackstageImage: TMenuItem;
    tbBackstageSubMenu: TToolButton;
    miBackstageSubMenu: TMenuItem;
    miBackstageMenuCheckBox: TMenuItem;
    miBackstageMenuToggleButton: TMenuItem;
    tbBackstageMenuCheckBox: TToolButton;
    tbBackstageMenuToggleButton: TToolButton;
    ToolButton2: TToolButton;
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
    FRibbonDesigner: TAdxRibbon;
    FRibbonIDs: TStringList;
    procedure UpdateProps(const ICtrl: IadxRibbonComponent; ANode: TTreeNode; AObject: TObject);
    procedure DoControlSelect(ASender: TObject; const ControlID: WideString);
    {$ENDIF}
    procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
    procedure CloseEditor;
    procedure UpdateToolBarAndMenu(Node: TTreeNode);
    procedure BuildControlsList;
    procedure SetCollectionPropertyName(const Value: string);
    function GetRegKey: string;
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

procedure ShowBackstageEditor(ADesigner: IDesigner;
  AComponent: TComponent; ACollection: TOwnedCollection; const PropertyName: string);

implementation

{$R *.dfm}

uses Registry, DesignConst;

const
  firstColumn: Pointer = Pointer(1024);
  secondColumn: Pointer = Pointer(1024 + 1);
  primaryItem: Pointer = Pointer(1024 + 2);
  topItems: Pointer = Pointer(1024 + 3);
  bottomItems: Pointer = Pointer(1024 + 4);

var
  BackstageEditorsList: TList = nil;

type
  TCollectionAccess = class(TCollection);
  TOwnedCollectionAccess = class(TOwnedCollection);
  TPersistentAccess = class(TPersistent);

procedure ShowBackstageEditor(ADesigner: IDesigner;
  AComponent: TComponent; ACollection: TOwnedCollection; const PropertyName: string);
var
  i: Integer;
  frm: TadxBackstageEditor;
begin
  if BackstageEditorsList = nil then BackstageEditorsList := TList.Create;
  for i := 0 to BackstageEditorsList.Count - 1 do begin
    frm := TadxBackstageEditor(BackstageEditorsList[i]);
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
  frm := TadxBackstageEditor.Create(Application);
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
    finally
      Free;
    end;
    BuildControlsList;
    Show;
  except
    Free;
  end;
end;

{ TadxBackstageEditor }

constructor TadxBackstageEditor.Create(AOwner: TComponent);
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
    FRibbonIDs := TStringList.Create();
    FRibbonDesigner := TAdxRibbon.Create(nil);
    FRibbonDesigner.OnBarResize := nil;
    FRibbonDesigner.OnControlSelect := DoControlSelect;
    FRibbonDesigner.ConnectKind := ckNewInstance;
    panDesign.Visible := True;
    FRibbonDesigner.CreateRibbon(panDesign.Handle);
  except
    panDesign.Visible := False;
    FRibbonDesigner.OnBarResize := nil;
    FRibbonDesigner.OnControlSelect := nil;
    FRibbonDesigner := nil;
  end
  {$ENDIF}
end;

destructor TadxBackstageEditor.Destroy;
begin
  {$IFNDEF ADX_VCL5}
  UnregisterDesignNotification(Self);
  FComponentDesigner := nil;
  {$ELSE}
  CompLib.UnregisterDesignWindow(Self);
  {$ENDIF}
  FDesigner := nil;
  {$IFDEF ADX_DESIGNER}
  if Assigned(FRibbonIDs) then FRibbonIDs.Free;
  if Assigned(FRibbonDesigner) then begin
    FRibbonDesigner.OnBarResize := nil;
    FRibbonDesigner.OnControlSelect := nil;
    FRibbonDesigner.DestroyRibbon();
    FRibbonDesigner.Disconnect();
    FreeAndNil(FRibbonDesigner);
  end;
  {$ENDIF}
  inherited Destroy;
end;

{$IFDEF ADX_DESIGNER}
procedure TadxBackstageEditor.DoControlSelect(ASender: TObject; const ControlID: WideString);

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
  if (Self.Component is TadxBackstageView) and (TadxBackstageView(Self.Component).Id = ControlID) then
    Node := Tree.Items[0]
  else begin
    Node := nil;
    for i := 0 to FRibbonIDs.Count - 1 do
      if FRibbonIDs[i] = ControlID then begin
        Node := FindNodeByObject(Tree.Items[0], FRibbonIDs.Objects[i]);
        Break;
      end;
  end;
  if Node <> nil then
    Node.Selected := True;
end;
{$ENDIF}

procedure TadxBackstageEditor.WndProc(var Message: TMessage);
begin
  if Message.Msg = FNotify then
    panDesign.Height := Message.LParam;
  inherited WndProc(Message);
end;

function TadxBackstageEditor.GetEditState: TEditState;
begin
  Result := [];
end;

{$IFDEF ADX_VCL5}
procedure TadxBackstageEditor.EditAction(Action: TEditAction);
begin
end;
{$ELSE}
function TadxBackstageEditor.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;
{$ENDIF}

procedure TadxBackstageEditor.WindowHide;
begin
  if Visible then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TadxBackstageEditor.WindowShow;
const
  ShowCommands: array[TWindowState] of Word =
    (SW_SHOWNOACTIVATE, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if Visible then
    ShowWindow(Handle, ShowCommands[WindowState]);
end;

{$IFDEF ADX_VCL5}
procedure TadxBackstageEditor.ItemDeleted(const AItem: IPersistent);

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

procedure TadxBackstageEditor.ItemInserted(const AItem: IPersistent);
begin
end;

procedure TadxBackstageEditor.SelectionChanged(const ASelection: IDesignerSelections);
begin
end;

procedure TadxBackstageEditor.DesignerInitialized(const ADesigner: IUnknown);
begin
end;

procedure TadxBackstageEditor.DesignerClosed(const ADesigner: IUnknown);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxBackstageEditor.ItemsModified(const ADesigner: IUnknown);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if CompLib.GetActiveForm.Designer <> Designer then Exit;
    GetSelection;
  end;
end;

{$ELSE}
procedure TadxBackstageEditor.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);

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

procedure TadxBackstageEditor.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
end;

procedure TadxBackstageEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
end;

procedure TadxBackstageEditor.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TadxBackstageEditor.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxBackstageEditor.ItemsModified(const Designer: IDesigner);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if ActiveRoot <> nil then
      if ActiveRoot.GetDesigner <> Designer then Exit;
    GetSelection;
  end;
end;
{$ENDIF}

procedure TadxBackstageEditor.Activated;
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

procedure TadxBackstageEditor.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then Activated;
end;

procedure TadxBackstageEditor.CloseEditor;
begin
  FClosing := True;
  Collection := nil;
  Component := nil;
  Close;
end;

{$IFDEF ADX_DESIGNER}
procedure TadxBackstageEditor.UpdateProps(const ICtrl: IadxRibbonComponent; ANode: TTreeNode; AObject: TObject);
var
  i: Integer;
  id: string;
  ImgList: TCustomImageList;
  ImgIndex: TImageIndex;
  PictureDesc: TPictDesc;
  bmp: TBitmap;
  IPict: IPictureDisp;
  Item: IadxRibbonComponent;
begin
  if panDesign.Visible and Assigned(FRibbonDesigner) then begin
    if FRibbonIDs.IndexOfObject(AObject) >= 0 then begin
      id := FRibbonIDs[FRibbonIDs.IndexOfObject(AObject)];
      if id <> ICtrl.GetID() then begin
        FRibbonDesigner.Tabs.UpdateProp(id, tp_ID, ICtrl.GetID()); // tp_ID
        FRibbonIDs[FRibbonIDs.IndexOfObject(AObject)] := ICtrl.GetID();
      end;
    end;
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Caption, ICtrl.GetCaption()); // tp_Caption
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Description, ICtrl.GetDescription()); // tp_Description
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Enabled, ICtrl.GetEnabled()); // tp_Enabled
    if (ICtrl.GetType() = rctButton) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ToggleButton, TadxRibbonButton(ANode.Data).ToggleButton); // tp_ToggleButton
    if (ICtrl.GetType() = rctSplitButton) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ToggleButton, TadxRibbonSplitButton(ANode.Data).ToggleButton); // tp_ToggleButton
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), {tp_ButtonPressed}tp_Pressed, ICtrl.GetPressed()); // tp_ButtonPressed
    IPict := nil;
    if ICtrl.GetGlyph() <> nil then begin
      if not ICtrl.GetGlyph().Empty then begin
        Bmp := TBitmap.Create;
        Bmp.PixelFormat := pf24bit;
        try
          Bmp.Assign(ICtrl.GetGlyph());
          Bmp.Transparent := True;
          PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
          PictureDesc.picType := PICTYPE_BITMAP;
          PictureDesc.hBitmap := Bmp.ReleaseHandle;
          PictureDesc.hpal := Bmp.ReleasePalette;
          OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, IPict);
        finally
          Bmp.Free;
        end;
      end else begin
        ImgIndex := ICtrl.GetImageIndex();
        if Self.Component is TadxBackstageView then
          ImgList := TadxBackstageView(Self.Component).Images
        else
          ImgList := nil;
        if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
          Bmp := TBitmap.Create;
          Bmp.PixelFormat := pf24bit;
          try
            ImgList.GetBitmap(ImgIndex, Bmp);
            Bmp.Transparent := True;
            PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
            PictureDesc.picType := PICTYPE_BITMAP;
            PictureDesc.hbitmap := Bmp.ReleaseHandle;
            PictureDesc.hpal := Bmp.ReleasePalette;
            OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, IPict);
          finally
            Bmp.Free;
          end;
        end;
      end;
    end;
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Glyph, IPict); // tp_Glyph

    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ScreenTip, ICtrl.GetScreenTip()); // tp_ScreenTip
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SuperTip, ICtrl.GetSuperTip()); // tp_SuperTip
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_KeyTip, ICtrl.GetKeyTip()); // tp_KeyTip
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Size, ICtrl.GetSize()); // tp_Size
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Title, ICtrl.GetTitle()); // tp_Title
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ShowCaption, ICtrl.GetShowCaption()); // tp_ShowCaption
    if (ICtrl.GetType() = rctEditBox) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SizeString, TadxRibbonEditBox(ANode.Data).SizeString); // tp_SizeString
    if (ICtrl.GetType() = rctComboBox) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SizeString, TadxRibbonComboBox(ANode.Data).SizeString); // tp_SizeString
    if (ICtrl.GetType() = rctDropDown) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SizeString, TadxRibbonDropDown(ANode.Data).SizeString); // tp_SizeString
    if (ICtrl.GetType() = rctEditBox) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_MaxLength, TadxRibbonEditBox(ANode.Data).MaxLength); // tp_MaxLength
    if (ICtrl.GetType() = rctComboBox) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_MaxLength, TadxRibbonComboBox(ANode.Data).MaxLength); // tp_MaxLength
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Text, ICtrl.GetText()); // tp_Text
    if (ICtrl.GetType() = rctGallery) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Rows, TadxRibbonGallery(ANode.Data).Rows); // tp_Rows
    if (ICtrl.GetType() = rctGallery) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Columns, TadxRibbonGallery(ANode.Data).Columns); // tp_Columns
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SelectedItemID, ICtrl.GetSelectedItemId()); // tp_SelectedItemID
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_SelectedItemIndex, ICtrl.GetSelectedItemIndex()); // tp_SelectedItemIndex
    if (ICtrl.GetItems <> nil) then begin
      FRibbonDesigner.Tabs.DeleteControl(ICtrl.GetID() + 'Items');
      if ICtrl.GetItems().Count > 0 then begin
        FRibbonDesigner.Tabs.AddControl(tc_Items, ICtrl.GetID(), ICtrl.GetID() + 'Items', '');
        for i := 0 to ICtrl.GetItems().Count - 1 do begin
          Item := IadxRibbonComponent(ICtrl.GetItems()[i]);
          FRibbonDesigner.Tabs.AddControl(tc_Item, ICtrl.GetID() + 'Items',
            Item.GetID(), Item.GetCaption());
          IPict := nil;
          if Item.GetGlyph() <> nil then begin
            if not Item.GetGlyph().Empty then begin
              Bmp := TBitmap.Create;
              Bmp.PixelFormat := pf24bit;
              try
                Bmp.Assign(Item.GetGlyph());
                Bmp.Transparent := True;
                PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
                PictureDesc.picType := PICTYPE_BITMAP;
                PictureDesc.hBitmap := Bmp.ReleaseHandle;
                PictureDesc.hpal := Bmp.ReleasePalette;
                OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, IPict);
              finally
                Bmp.Free;
              end;
            end else begin
              ImgIndex := Item.GetImageIndex();
              if Self.Component is TadxBackstageView then
                ImgList := TadxBackstageView(Self.Component).Images
              else
                ImgList := nil;
              if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
                Bmp := TBitmap.Create;
                Bmp.PixelFormat := pf24bit;
                try
                  ImgList.GetBitmap(ImgIndex, Bmp);
                  Bmp.Transparent := True;
                  PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
                  PictureDesc.picType := PICTYPE_BITMAP;
                  PictureDesc.hbitmap := Bmp.ReleaseHandle;
                  PictureDesc.hpal := Bmp.ReleasePalette;
                  OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, IPict);
                finally
                  Bmp.Free;
                end;
              end;
            end;
          end;
          FRibbonDesigner.Tabs.UpdateProp(Item.GetID(), tp_Glyph, IPict);
          FRibbonDesigner.Tabs.UpdateProp(Item.GetID(), tp_ScreenTip, Item.GetScreenTip());
          FRibbonDesigner.Tabs.UpdateProp(Item.GetID(), tp_SuperTip, Item.GetSuperTip());
        end;
      end;
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ItemWidth, ICtrl.GetItemWidth()); // tp_ItemWidth
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ItemHeight, ICtrl.GetItemHeight()); // tp_ItemHeight
      if AObject is TadxRibbonDropDown then
        FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ShowItemCaption, (AObject as TadxRibbonDropDown).ShowItemCaption); // tp_ShowItemCaption
      if AObject is TadxRibbonGallery then
        FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_ShowItemCaption, (AObject as TadxRibbonGallery).ShowItemCaption); // tp_ShowItemCaption
    end;
    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_Visible, ICtrl.GetVisible());
    if (ICtrl.GetType() = rctBox) then
      FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_BoxStyle, TadxRibbonBox(ANode.Data).BoxStyle);
  end;
end;
{$ENDIF}

procedure TadxBackstageEditor.GetSelection;
{$IFDEF ADX_DESIGNER}
var
  Tab: TadxBackstageView;
  ICtrl: IadxRibbonComponent;
{$ENDIF}
begin
  if Tree.Selected <> nil then begin
    // root
    if Tree.Selected.Data = nil then begin
      if Component is TadxBackstageView then begin
        Tree.Selected.Text := TadxBackstageView(Component).ClassName;
        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FRibbonDesigner) then begin
          Tab := TadxBackstageView(Component);
          FRibbonDesigner.Tabs.BeginUpdate(Tab.Id);
          UpdateProps(Tab, Tree.Selected, Tab);
          FRibbonDesigner.Tabs.EndUpdate(Tab.Id);
        end;
        {$ENDIF}
      end;
    end
    // collectionitem
    else begin
      if (Tree.Selected.Data = firstColumn) or (Tree.Selected.Data = secondColumn) or
        (Tree.Selected.Data = primaryItem) or (Tree.Selected.Data = topItems) or (Tree.Selected.Data = bottomItems) then
        Exit;
      Tree.Selected.Text := TadxRibbonCustomControl(Tree.Selected.Data).DisplayName;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        ICtrl := IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data));
        FRibbonDesigner.Tabs.BeginUpdate(ICtrl.GetID());
        UpdateProps(ICtrl, Tree.Selected, TadxRibbonCustomControl(Tree.Selected.Data));
        FRibbonDesigner.Tabs.EndUpdate(ICtrl.GetID());
      end;
      {$ENDIF}
    end;
  end;
end;

procedure TadxBackstageEditor.SetSelection;
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
          {$IFDEF ADX_DESIGNER}
          if panDesign.Visible then begin
            if (Component is TadxBackstageView) then
              FRibbonDesigner.Tabs.SelectControl(TadxBackstageView(Component).Id);
          end;
          {$ENDIF}
        end;
        Exit;
      end;
      {$IFDEF ADX_VCL5}
      List := TDesignerSelectionList.Create;
      {$ELSE}
      List := CreateSelectionList;
      {$ENDIF}
      if (Tree.Selected.Data = firstColumn) or (Tree.Selected.Data = secondColumn) or
        (Tree.Selected.Data = primaryItem) or (Tree.Selected.Data = topItems) or (Tree.Selected.Data = bottomItems) then
        List.Add(TadxRibbonCustomControl(Tree.Selected.Parent.Data))
      else
        List.Add(TadxRibbonCustomControl(Tree.Selected.Data));
      if Designer <> nil then begin
        Designer.SetSelections(List);
        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible then
          FRibbonDesigner.Tabs.SelectControl(IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetID());
        {$ENDIF}
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

procedure TadxBackstageEditor.SetCollectionPropertyName(const Value: string);
const
  SEditorCaption = 'Editing %s%s%s';
begin
  if Value <> FCollectionPropertyName then begin
    FCollectionPropertyName := Value;
    Caption := Format(SEditorCaption, [Component.Name, '.', Value]);
  end;
end;

function TadxBackstageEditor.GetRegKey: string;
begin
  {$IFDEF ADX_VCL5}
  Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
  {$ELSE}
  Result := FComponentDesigner.Environment.GetBaseRegKey + '\' +
    sIniEditorsName + '\Collection Editor';
  {$ENDIF}
end;

procedure TadxBackstageEditor.FormCreate(Sender: TObject);
begin
  BackstageEditorsList.Add(Self);
  tbBackstageTab.Tag := Integer(rctBackstageTab);
  miBackstageTab.Tag := tbBackstageTab.Tag;
  tbBackstageFastButton.Tag := Integer(rctBackstageFastCommandButton);
  miBackstageFastButton.Tag := tbBackstageFastButton.Tag;

  tbBackstageTaskFormGroup.Tag := Integer(rctBackstageTaskFormGroup);
  miBackstageTaskFormGroup.Tag := tbBackstageTaskFormGroup.Tag;
  tbBackstageTaskFormGroupCategory.Tag := Integer(rctBackstageTaskFormGroupCategory);
  miBackstageTaskFormGroupCategory.Tag := tbBackstageTaskFormGroupCategory.Tag;
  tbBackstageTaskFormGroupTask.Tag := Integer(rctBackstageTaskFormGroupTask);
  miBackstageTaskFormGroupTask.Tag := tbBackstageTaskFormGroupTask.Tag;

  tbBackstageGroup.Tag := Integer(rctBackstageGroup);
  miBackstageGroup.Tag := tbBackstageGroup.Tag;
  tbBackstageTaskGroup.Tag := Integer(rctBackstageTaskGroup);
  miBackstageTaskGroup.Tag := tbBackstageTaskGroup.Tag;
  tbBackstageTaskGroupCategory.Tag := Integer(rctBackstageTaskGroupCategory);
  miBackstageTaskGroupCategory.Tag := tbBackstageTaskGroupCategory.Tag;
  tbBackstageTaskGroupTask.Tag := Integer(rctBackstageTaskGroupTask);
  miBackstageTaskGroupTask.Tag := tbBackstageTaskGroupTask.Tag;

  tbBackstagePrimaryMenu.Tag := Integer(rctBackstagePrimaryMenu);
  miBackstagePrimaryMenu.Tag := tbBackstagePrimaryMenu.Tag;
  tbBackstageSubMenu.Tag := Integer(rctBackstageSubMenu);
  miBackstageSubMenu.Tag := tbBackstageSubMenu.Tag;
  tbBackstageMenuGroup.Tag := Integer(rctBackstageMenuGroup);
  miBackstageMenuGroup.Tag := tbBackstageMenuGroup.Tag;
  tbBackstageMenuButton.Tag := Integer(rctBackstageMenuButton);
  miBackstageMenuButton.Tag := tbBackstageMenuButton.Tag;
  tbBackstageMenuCheckBox.Tag := Integer(rctBackstageMenuCheckBox);
  miBackstageMenuCheckBox.Tag := tbBackstageMenuCheckBox.Tag;
  tbBackstageMenuToggleButton.Tag := Integer(rctBackstageMenuToggleButton);
  miBackstageMenuToggleButton.Tag := tbBackstageMenuToggleButton.Tag;

  tbBackstageRegularButton.Tag := Integer(rctBackstageRegularButton);
  miBackstageRegularButton.Tag := tbBackstageRegularButton.Tag;
  tbBackstageCheckBox.Tag := Integer(rctBackstageCheckBox);
  miBackstageCheckBox.Tag := tbBackstageCheckBox.Tag;
  tbBackstageGroupButton.Tag := Integer(rctBackstageGroupButton);
  miBackstageGroupButton.Tag := tbBackstageGroupButton.Tag;
  tbBackstageEditBox.Tag := Integer(rctBackstageEditBox);
  miBackstageEditBox.Tag := tbBackstageEditBox.Tag;
  tbBackstageComboBox.Tag := Integer(rctBackstageComboBox);
  miBackstageComboBox.Tag := tbBackstageComboBox.Tag;
  tbBackstageDropDown.Tag := Integer(rctBackstageDropDown);
  miBackstageDropDown.Tag := tbBackstageDropDown.Tag;
  tbBackstageRadioGroup.Tag := Integer(rctBackstageRadioGroup);
  miBackstageRadioGroup.Tag := tbBackstageRadioGroup.Tag;
  tbBackstageHyperlink.Tag := Integer(rctBackstageHyperlink);
  miBackstageHyperlink.Tag := tbBackstageHyperlink.Tag;
  tbBackstageLabel.Tag := Integer(rctBackstageLabelControl);
  miBackstageLabel.Tag := tbBackstageLabel.Tag;
  tbBackstageImage.Tag := Integer(rctBackstageImageControl);
  miBackstageImage.Tag := tbBackstageImage.Tag;
  tbBackstageGroupBox.Tag := Integer(rctBackstageGroupBox);
  miBackstageGroupBox.Tag := tbBackstageGroupBox.Tag;
  tbBackstageLayoutContainer.Tag := Integer(rctBackstageLayoutContainer);
  miBackstageLayoutContainer.Tag := tbBackstageLayoutContainer.Tag;
end;

procedure TadxBackstageEditor.FormDestroy(Sender: TObject);
begin
  if BackstageEditorsList <> nil then
    BackstageEditorsList.Remove(Self);
end;

procedure TadxBackstageEditor.FormClose(Sender: TObject; var Action: TCloseAction);
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
    finally
      Free;
    end;
  Action := caFree;
end;

procedure TadxBackstageEditor.BuildControlsList;

  procedure ProcessChildren(ANode: TTreeNode; ACtrls: TadxRibbonControls);
  var
    i: Integer;
    Ctrls: TadxRibbonControls;
    Node, Node2: TTreeNode;
  begin
    for i := 0 to ACtrls.Count - 1 do begin
      Node := Tree.Items.AddChildObject(ANode, ACtrls[i].DisplayName, ACtrls[i]);
      Node.ImageIndex := Integer(IadxRibbonComponent(ACtrls[i]).GetType) - 22 + 3;
      Node.SelectedIndex := Node.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        FRibbonDesigner.Tabs.AddControl(
          Integer(IadxRibbonComponent(ACtrls[i]).GetType()),
          IadxRibbonComponent(TadxRibbonCustomControl(ANode.Data)).GetID(),
          IadxRibbonComponent(ACtrls[i]).GetID(),
          IadxRibbonComponent(ACtrls[i]).GetCaption());
        FRibbonIDs.AddObject(IadxRibbonComponent(ACtrls[i]).GetID(), ACtrls[i]);
        UpdateProps(IadxRibbonComponent(ACtrls[i]), Node, ACtrls[i]);
      end;
      {$ENDIF}
      if ACtrls[i] is TadxBackstageGroup then begin
        Node2 := Tree.Items.AddChildObject(Node, 'Primary Item', primaryItem);
        Node2.ImageIndex := 33;
        Node2.SelectedIndex := Node2.ImageIndex;
        Ctrls := TadxBackstageGroup(ACtrls[i]).PrimaryItem;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node2, Ctrls);

        Node2 := Tree.Items.AddChildObject(Node, 'Top Items', topItems);
        Node2.ImageIndex := 34;
        Node2.SelectedIndex := Node2.ImageIndex;
        Ctrls := TadxBackstageGroup(ACtrls[i]).TopItems;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node2, Ctrls);

        Node2 := Tree.Items.AddChildObject(Node, 'Bottom Items', bottomItems);
        Node2.ImageIndex := 35;
        Node2.SelectedIndex := Node2.ImageIndex;
        Ctrls := TadxBackstageGroup(ACtrls[i]).BottomItems;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node2, Ctrls);
      end;

      Ctrls := IadxRibbonComponent(ACtrls[i]).GetControls;
      if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node, Ctrls);
    end;
  end;

var
  i: Integer;
  Ctrls: TadxRibbonControls;
  Root, Node, NodeFirstColumn, NodeSecondColumn: TTreeNode;
  RootID: WideString;
  {$IFDEF ADX_DESIGNER}
  ICtrl: IadxRibbonComponent;
  {$ENDIF}
begin
  Tree.Items.BeginUpdate;
  try
    Root := nil;
    {$IFDEF ADX_DESIGNER}
    if Assigned(FRibbonDesigner) then FRibbonDesigner.Tabs.BeginUpdate('');
    {$ENDIF}
    if TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner is TadxBackstageView then begin
      Root := Tree.Items.AddChildFirst(nil, TadxBackstageView(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).ClassName);
      RootID := TadxBackstageView(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).Id;
      Root.ImageIndex := 30;
      Root.SelectedIndex := Root.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        ICtrl := TadxBackstageView(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner);
        FRibbonDesigner.Tabs.AddControl(Integer(ICtrl.GetType()), '', ICtrl.GetID(), ICtrl.GetCaption());
        FRibbonIDs.AddObject(ICtrl.GetID(), TadxBackstageView(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner));
        UpdateProps(ICtrl, Root, TadxBackstageView(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner));
      end;
      {$ENDIF}
    end;

    for i := 0 to TadxRibbonControls(Collection).Count - 1 do begin
      Node := Tree.Items.AddChildObject(Root, TadxRibbonControls(Collection)[i].DisplayName, TadxRibbonControls(Collection)[i]);
      Node.ImageIndex := Integer(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetType) - 22 + 3;
      Node.SelectedIndex := Node.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        FRibbonDesigner.Tabs.AddControl(
          Integer(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetType()),
          RootID,
          IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetID(),
          IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetCaption());

        FRibbonIDs.AddObject(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetID(), TadxRibbonControls(Collection)[i]);
        UpdateProps(IadxRibbonComponent(TadxRibbonControls(Collection)[i]), Node, TadxRibbonControls(Collection)[i]);
      end;
      {$ENDIF}
      if TadxRibbonControls(Collection)[i] is TadxBackstageTab then begin
        NodeFirstColumn := Tree.Items.AddChildObject(Node, 'First Column', firstColumn);
        NodeFirstColumn.ImageIndex := 31;
        NodeFirstColumn.SelectedIndex := NodeFirstColumn.ImageIndex;
        Ctrls := TadxBackstageTab(TadxRibbonControls(Collection)[i]).FirstColumn;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(NodeFirstColumn, Ctrls);

        NodeSecondColumn := Tree.Items.AddChildObject(Node, 'Second Column', secondColumn);
        NodeSecondColumn.ImageIndex := 32;
        NodeSecondColumn.SelectedIndex := NodeSecondColumn.ImageIndex;
        Ctrls := TadxBackstageTab(TadxRibbonControls(Collection)[i]).SecondColumn;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(NodeSecondColumn, Ctrls);
      end
      else begin
        Ctrls := IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetControls;
        if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node, Ctrls);
      end;
    end;
    UpdateToolBarAndMenu(Tree.Selected);
    Tree.FullExpand;
    Root.MakeVisible;
  finally
    {$IFDEF ADX_DESIGNER}
    if Assigned(FRibbonDesigner) then FRibbonDesigner.Tabs.EndUpdate('');
    {$ENDIF}
    Tree.Items.EndUpdate;
  end;
end;

procedure TadxBackstageEditor.CommonClick(Sender: TObject);
var
  Item: TadxRibbonCustomControl;
  Coll: TCollection;
  Node, NodeFirstColumn, NodeSecondColumn: TTreeNode;
  isExpanded: Boolean;
  {$IFDEF ADX_DESIGNER}
  ParentID: string;
  {$ENDIF}
begin
  case (Sender as TComponent).Tag of
    // Delete
    110: if MessageDlg('Are you sure you want to delete the selected item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
           Coll := TadxRibbonCustomControl(Tree.Selected.Data).Collection;
           Coll.BeginUpdate;
           try
            {$IFDEF ADX_DESIGNER}
            if panDesign.Visible and Assigned(FRibbonDesigner) then begin
              FRibbonDesigner.Tabs.BeginUpdate('');
              FRibbonDesigner.Tabs.DeleteControl(IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetID());
              FRibbonDesigner.Tabs.EndUpdate('');
            end;
            {$ENDIF}
             Coll.Delete(TadxRibbonCustomControl(Tree.Selected.Data).Index);
             Tree.Selected.Delete;
             UpdateToolBarAndMenu(Tree.Selected);
           finally
             Coll.EndUpdate;
           end;
         end;
    // Move Up
    120: begin
           TadxRibbonCustomControl(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxRibbonCustomControl(Tree.Selected.Data).Index := TadxRibbonCustomControl(Tree.Selected.Data).Index - 1;
             {$IFDEF ADX_DESIGNER}
             if panDesign.Visible and Assigned(FRibbonDesigner) then begin
               if TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner is TadxBackstageView then
                 ParentID := TadxBackstageView(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner).Id
               else
                 ParentID := IadxRibbonComponent(TadxRibbonCustomControl(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner)).GetID();
               FRibbonDesigner.Tabs.BeginUpdate(ParentID);
               FRibbonDesigner.Tabs.SetParent(ParentID,
                 IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetID(),
                 TadxRibbonCustomControl(Tree.Selected.Data).Index);
               FRibbonDesigner.Tabs.EndUpdate(ParentID);
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
             TadxRibbonCustomControl(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // Move Down
    130: begin
           TadxRibbonCustomControl(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxRibbonCustomControl(Tree.Selected.Data).Index := TadxRibbonCustomControl(Tree.Selected.Data).Index + 1;
             {$IFDEF ADX_DESIGNER}
             if panDesign.Visible and Assigned(FRibbonDesigner) then begin
               if TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner is TadxBackstageView then
                 ParentID := TadxBackstageView(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner).Id
               else
                 ParentID := IadxRibbonComponent(TadxRibbonCustomControl(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner)).GetID();
               FRibbonDesigner.Tabs.BeginUpdate(ParentID);
               FRibbonDesigner.Tabs.SetParent(ParentID,
                 IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetID(),
                 TadxRibbonCustomControl(Tree.Selected.Data).Index);
               FRibbonDesigner.Tabs.EndUpdate(ParentID);
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
             TadxRibbonCustomControl(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // add a control
    else begin
      try
        if (Tree.Selected = nil) or (Tree.Selected.Data = nil) then
          Item := TadxRibbonControls(Collection).Add(TadxRibbonControlType((Sender as TComponent).Tag))
        else begin
          if Tree.Selected.Data = firstColumn then
            Item := TadxBackstageTab(Tree.Selected.Parent.Data).FirstColumn.Add(TadxRibbonControlType((Sender as TComponent).Tag))
          else
          if Tree.Selected.Data = secondColumn then
            Item := TadxBackstageTab(Tree.Selected.Parent.Data).SecondColumn.Add(TadxRibbonControlType((Sender as TComponent).Tag))
          else
          if Tree.Selected.Data = primaryItem then
            Item := TadxBackstageGroup(Tree.Selected.Parent.Data).PrimaryItem.Add(TadxRibbonControlType((Sender as TComponent).Tag))
          else
          if Tree.Selected.Data = topItems then
            Item := TadxBackstageGroup(Tree.Selected.Parent.Data).TopItems.Add(TadxRibbonControlType((Sender as TComponent).Tag))
          else
          if Tree.Selected.Data = bottomItems then
            Item := TadxBackstageGroup(Tree.Selected.Parent.Data).BottomItems.Add(TadxRibbonControlType((Sender as TComponent).Tag))
          else
            Item := IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetControls.Add(TadxRibbonControlType((Sender as TComponent).Tag));
        end;

        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FRibbonDesigner) then begin
          if TOwnedCollectionAccess(Item.Collection).GetOwner is TadxBackstageView then
            ParentID := TadxBackstageView(TOwnedCollectionAccess(Item.Collection).GetOwner).Id
          else
            ParentID := IadxRibbonComponent(TadxRibbonCustomControl(TOwnedCollectionAccess(Item.Collection).GetOwner)).GetID();
          FRibbonDesigner.Tabs.BeginUpdate(ParentID);
          FRibbonDesigner.Tabs.AddControl(
            Integer(IadxRibbonComponent(Item).GetType()), ParentID, IadxRibbonComponent(Item).GetID(),
            IadxRibbonComponent(Item).GetCaption());
          FRibbonIDs.AddObject(IadxRibbonComponent(Item).GetID(), Item);
          if isLauncher then
            FRibbonDesigner.Tabs.SetParent(ParentID, IadxRibbonComponent(Item).GetID(), Item.Index);
          if TadxRibbonControlType((Sender as TComponent).Tag) = rctSplitButton then begin
            FRibbonDesigner.Tabs.AddControl(
              Integer(IadxRibbonComponent(TadxRibbonSplitButton(Item).Controls[0]).GetType()),
              IadxRibbonComponent(Item).GetID(),
              IadxRibbonComponent(TadxRibbonSplitButton(Item).Controls[0]).GetID(),
              IadxRibbonComponent(TadxRibbonSplitButton(Item).Controls[0]).GetCaption());
            FRibbonIDs.AddObject(IadxRibbonComponent(TadxRibbonSplitButton(Item).Controls[0]).GetID(), TadxRibbonSplitButton(Item).Controls[0]);
          end;
          FRibbonDesigner.Tabs.EndUpdate(ParentID);
        end;
        {$ENDIF}

        Node := Tree.Items.AddChildObject(Tree.Selected, Item.DisplayName, Item);

        Node.ImageIndex := Integer(IadxRibbonComponent(Item).GetType) - 22 + 3;
        Node.SelectedIndex := Node.ImageIndex;
        //Node.Selected := True;
        if Assigned(Tree.Selected) and Tree.Selected.HasChildren then Tree.Selected.Expand(False);

        // backstage tab
        if Item is TadxBackstageTab then begin
          NodeFirstColumn := Tree.Items.AddChildObject(Node, 'First Column', firstColumn);
          NodeFirstColumn.ImageIndex := 31;
          NodeFirstColumn.SelectedIndex := NodeFirstColumn.ImageIndex;

          NodeSecondColumn := Tree.Items.AddChildObject(Node, 'Second Column', secondColumn);
          NodeSecondColumn.ImageIndex := 32;
          NodeSecondColumn.SelectedIndex := NodeSecondColumn.ImageIndex;
          Node.Expand(False);
        end;                                        
        // backstage group
        if Item is TadxBackstageGroup then begin
          NodeFirstColumn := Tree.Items.AddChildObject(Node, 'Primary Item', primaryItem);
          NodeFirstColumn.ImageIndex := 33;
          NodeFirstColumn.SelectedIndex := NodeFirstColumn.ImageIndex;

          NodeSecondColumn := Tree.Items.AddChildObject(Node, 'Top Items', topItems);
          NodeSecondColumn.ImageIndex := 34;
          NodeSecondColumn.SelectedIndex := NodeSecondColumn.ImageIndex;

          NodeSecondColumn := Tree.Items.AddChildObject(Node, 'Bottom Items', bottomItems);
          NodeSecondColumn.ImageIndex := 35;
          NodeSecondColumn.SelectedIndex := NodeSecondColumn.ImageIndex;
          Node.Expand(False);
        end;
        UpdateToolBarAndMenu(Tree.Selected);
      except
        on E: SysUtils.Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
  Designer.Modified;
end;

procedure TadxBackstageEditor.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TadxBackstageEditor.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  SetSelection;
  UpdateToolBarAndMenu(Node);
end;

procedure TadxBackstageEditor.UpdateToolBarAndMenu(Node: TTreeNode);

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
  Item: TadxRibbonCustomControl;
begin
  for i := 0 to ToolBar.ButtonCount - 1 do
    if ToolBar.Buttons[i].Style <> tbsSeparator then
      ToolBar.Buttons[i].Enabled := False;
  for i := 0 to PopupMenu.Items.Count - 1 do
    if PopupMenu.Items[i].Caption <> '-' then
      PopupMenu.Items[i].Enabled := False;

  if (Node = nil) or (Node.Data = nil) then begin
    EnableControls([tbBackstageTab, tbBackstageFastButton]);
    EnableMenuItems([miBackstageTab, miBackstageFastButton]);
  end else begin
    if (Node.Data = firstColumn) or (Node.Data = secondColumn) or
      (Tree.Selected.Data = primaryItem) or (Tree.Selected.Data = topItems) or (Tree.Selected.Data = bottomItems) then
      Item := TadxRibbonCustomControl(Node.Parent.Data)
    else
      Item := TadxRibbonCustomControl(Node.Data);

    // Delete
    tbDelete.Enabled := True;
    if (Item is TadxRibbonMenu) and (TOwnedCollectionAccess(Item.Collection).GetOwner is TadxRibbonSplitButton) then
      tbDelete.Enabled := False;
    if (Node.Data = firstColumn) or (Node.Data = secondColumn) or
      (Node.Data = primaryItem) or (Node.Data = topItems) or (Node.Data = bottomItems) then
      tbDelete.Enabled := False;
    miDelete.Enabled := tbDelete.Enabled;
    // Move Up
    tbMoveUp.Enabled := Item.Index > 0;
    if (Node.Data = firstColumn) or (Node.Data = secondColumn) or
      (Node.Data = primaryItem) or (Node.Data = topItems) or (Node.Data = bottomItems) then
      tbMoveUp.Enabled := False;
    miMoveUp.Enabled := tbMoveUp.Enabled;

    // Move Down
    tbMoveDown.Enabled := Item.Index < Item.Collection.Count - 1;
    if (Node.Data = firstColumn) or (Node.Data = secondColumn) or
      (Node.Data = primaryItem) or (Node.Data = topItems) or (Node.Data = bottomItems) then
      tbMoveDown.Enabled := False;
    miMoveDown.Enabled := tbMoveDown.Enabled;

    // Backstage Tab
    if Item is TadxBackstageTab then begin
      // First Column
      if Node.Data = firstColumn then begin
        if TadxBackstageTab(Item).FirstColumn.Count >= 1 then begin
          if not (TadxBackstageTab(Item).FirstColumn[0] is TadxBackstageTaskFormGroup) then begin
            EnableControls([tbBackstageGroup, tbBackstageTaskGroup]);
            EnableMenuItems([miBackstageGroup, miBackstageTaskGroup]);
          end;
        end
        else begin
          EnableControls([tbBackstageTaskFormGroup, tbBackstageGroup, tbBackstageTaskGroup]);
          EnableMenuItems([miBackstageTaskFormGroup, miBackstageGroup, miBackstageTaskGroup]);
        end;
      end;
      // Second Column
      if Node.Data = secondColumn then begin
        EnableControls([tbBackstageGroup, tbBackstageTaskGroup]);
        EnableMenuItems([miBackstageGroup, miBackstageTaskGroup]);
      end;
    end;

    // Task FORM group
    if Item is TadxBackstageTaskFormGroup then begin
      EnableControls([tbBackstageTaskFormGroupCategory]);
      EnableMenuItems([miBackstageTaskFormGroupCategory]);
    end;
    if Item is TadxBackstageTaskFormGroupCategory then begin
      EnableControls([tbBackstageTaskFormGroupTask]);
      EnableMenuItems([miBackstageTaskFormGroupTask]);
    end;
    if Item is TadxBackstageTaskFormGroupTask then begin
      EnableControls([tbBackstageGroup]);
      EnableMenuItems([miBackstageGroup]);
    end;

    // Task group
    if Item is TadxBackstageTaskGroup then begin
      EnableControls([tbBackstageTaskGroupCategory]);
      EnableMenuItems([miBackstageTaskGroupCategory]);
    end;
    if Item is TadxBackstageTaskGroupCategory then begin
      EnableControls([tbBackstageTaskGroupTask]);
      EnableMenuItems([miBackstageTaskGroupTask]);
    end;

    // Backstage Group
    if Item is TadxBackstageGroup then begin
      if Node.Data = primaryItem then begin
        if TadxBackstageGroup(Item).PrimaryItem.Count = 0 then begin
          EnableControls([tbBackstageRegularButton, tbBackstagePrimaryMenu]);
          EnableMenuItems([miBackstageRegularButton, miBackstagePrimaryMenu]);
        end;
      end;
      if (Node.Data = topItems) or (Node.Data = bottomItems) then begin
        EnableControls([tbBackstageCheckBox, tbBackstageGroupButton, tbBackstageEditBox,
          tbBackstageComboBox, tbBackstageDropDown, tbBackstageRadioGroup,
          tbBackstageHyperlink, tbBackstageLabel, tbBackstageImage,
          tbBackstageGroupBox, tbBackstageLayoutContainer]);
        EnableMenuItems([miBackstageCheckBox, miBackstageGroupButton, miBackstageEditBox,
          miBackstageComboBox, miBackstageDropDown, miBackstageRadioGroup,
          miBackstageHyperlink, miBackstageLabel, miBackstageImage,
          miBackstageGroupBox, miBackstageLayoutContainer]);
      end;
    end;

    // Backstage Menu
    if Item is TadxBackstageMenuBase then begin
      EnableControls([tbBackstageMenuGroup]);
      EnableMenuItems([miBackstageMenuGroup]);
    end;

    // Backstage Menu Group
    if Item is TadxBackstageMenuGroup then begin
      EnableControls([tbBackstageSubMenu, tbBackstageMenuButton, tbBackstageMenuCheckBox, tbBackstageMenuToggleButton]);
      EnableMenuItems([miBackstageSubMenu, miBackstageMenuButton, miBackstageMenuCheckBox, miBackstageMenuToggleButton]);
    end;

    //
    if (Item is TadxBackstageGroupBox) or (Item is TadxBackstageLayoutContainer) then begin
      EnableControls([tbBackstageCheckBox, tbBackstageGroupButton, tbBackstageEditBox,
        tbBackstageComboBox, tbBackstageDropDown, tbBackstageRadioGroup,
        tbBackstageHyperlink, tbBackstageLabel, tbBackstageImage,
        tbBackstageGroupBox, tbBackstageLayoutContainer]);
      EnableMenuItems([miBackstageCheckBox, miBackstageGroupButton, miBackstageEditBox,
        miBackstageComboBox, miBackstageDropDown, miBackstageRadioGroup,
        miBackstageHyperlink, miBackstageLabel, miBackstageImage,
        miBackstageGroupBox, miBackstageLayoutContainer]);
    end;
  end;
end;

procedure TadxBackstageEditor.TreeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node: TTreeNode;
begin
  Node := Tree.GetNodeAt(MousePos.X, MousePos.Y);
  if Assigned(Node) then
    Tree.Selected := Node;
end;

procedure TadxBackstageEditor.TreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  DstParent: TPersistent;
  SrcType, DstType, DstParentType: TadxRibbonControlType;
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
  DstParentType := rctCommand;
  if Tree.Selected = nil then Exit;
  if Tree.Selected.Data = nil then Exit;
  if (Tree.Selected.Data = firstColumn) or (Tree.Selected.Data = secondColumn) or
    (Tree.Selected.Data = primaryItem) or (Tree.Selected.Data = topItems) or (Tree.Selected.Data = bottomItems) then Exit;
  if Tree.DropTarget = nil then Exit;
  if Tree.Selected.Parent = Tree.DropTarget then Exit;

  if Tree.DropTarget.Data = nil then begin
    if Component is TadxBackstageView then DstType := rctBackstageView
    else Exit;
  end
  else begin
    if (Tree.DropTarget.Data = firstColumn) or (Tree.DropTarget.Data = secondColumn) then begin
      DstType := rctBackstageTab;
      DstParent := TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.DropTarget.Parent.Data).Collection).GetOwner;
    end
    else
    if (Tree.DropTarget.Data = primaryItem) or (Tree.DropTarget.Data = topItems) or (Tree.DropTarget.Data = bottomItems) then begin
      DstType := rctBackstageGroup;
      DstParent := TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.DropTarget.Parent.Data).Collection).GetOwner;
    end
    else begin
      DstType := IadxRibbonComponent(TadxRibbonCustomControl(Tree.DropTarget.Data)).GetType();
      DstParent := TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.DropTarget.Data).Collection).GetOwner;
    end;
    if DstParent is TadxBackstageView then DstParentType := rctBackstageView
    else
    if DstParent is TadxBackstageTab then DstParentType := rctBackstageTab
    else
    if DstParent is TadxBackstageGroup then DstParentType := rctBackstageGroup
    else
      DstParentType := IadxRibbonComponent(TadxRibbonCustomControl(DstParent)).GetType();
  end;

  SrcType := IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetType();
  Accept := Tree.DropTarget <> Tree.Selected;
  if Accept then
    Accept := not Tree.DropTarget.HasAsParent(Tree.Selected);

  if Accept then begin
    case SrcType of
      rctBackstageTab,
      rctBackstageFastCommandButton: Accept :=
        (DstType in [rctBackstageTab, rctBackstageFastCommandButton]) and
        ((Tree.DropTarget.Data <> firstColumn) and (Tree.DropTarget.Data <> secondColumn));

      rctBackstageTaskFormGroup: Accept :=
        (DstType = rctBackstageTab) and (Tree.DropTarget.Data = firstColumn) and
        (TadxBackstageTab(Tree.DropTarget.Parent.Data).FirstColumn.Count = 0);
      rctBackstageTaskFormGroupCategory: Accept :=
        (DstType = rctBackstageTaskFormGroup) or
        (DstParentType = rctBackstageTaskFormGroup);
      rctBackstageTaskFormGroupTask: Accept :=
        (DstType = rctBackstageTaskFormGroupCategory) or
        (DstParentType = rctBackstageTaskFormGroupCategory);

      rctBackstageGroup,
      rctBackstageTaskGroup: begin
        Accept := (DstType in [rctBackstageGroup, rctBackstageTaskGroup, rctBackstageTaskFormGroupTask]) or
          ((Tree.DropTarget.Data = firstColumn) or (Tree.DropTarget.Data = secondColumn));
        if Accept then begin
          Accept := (Tree.DropTarget.Data <> primaryItem) and (Tree.DropTarget.Data <> topItems) and (Tree.DropTarget.Data <> bottomItems);
          if Accept then begin
            if Tree.DropTarget.Data = firstColumn then begin
              if (TadxBackstageTab(Tree.DropTarget.Parent.Data).FirstColumn.Count = 1) and
                (TadxBackstageTab(Tree.DropTarget.Parent.Data).FirstColumn.Items[0] is TadxBackstageTaskFormGroup) then
                Accept := False;
            end;
          end;
        end;
      end;

      rctBackstageTaskGroupCategory: Accept :=
        (DstType = rctBackstageTaskGroup) or
        (DstParentType = rctBackstageTaskGroup);
      rctBackstageTaskGroupTask: Accept :=
        (DstType = rctBackstageTaskGroupCategory) or
        (DstParentType = rctBackstageTaskGroupCategory);

      rctBackstageMenuGroup: Accept :=
        (DstType in [rctBackstagePrimaryMenu, rctBackstageSubMenu]) or
        (DstParentType in [rctBackstagePrimaryMenu, rctBackstageSubMenu]);

      rctBackstageSubMenu,
      rctBackstageMenuButton,
      rctBackstageMenuCheckBox,
      rctBackstageMenuToggleButton: Accept :=
        (DstType = rctBackstageMenuGroup) or
        (DstParentType = rctBackstageMenuGroup);

      rctBackstagePrimaryMenu,
      rctBackstageRegularButton: Accept :=
        (DstType = rctBackstageGroup) and (Tree.DropTarget.Data = primaryItem) and
        (TadxBackstageGroup(Tree.DropTarget.Parent.Data).PrimaryItem.Count = 0);

      rctBackstageCheckBox,
      rctBackstageGroupButton,
      rctBackstageEditBox,
      rctBackstageComboBox,
      rctBackstageDropDown,
      rctBackstageRadioGroup,
      rctBackstageHyperlink,
      rctBackstageLabelControl,
      rctBackstageImageControl,
      rctBackstageGroupBox,
      rctBackstageLayoutContainer: begin
        Accept :=
        (DstType in [rctBackstageGroup, rctBackstageGroupBox, rctBackstageLayoutContainer]) or
        (DstParentType in [rctBackstageGroup, rctBackstageGroupBox, rctBackstageLayoutContainer]);
        if Accept and (DstType = rctBackstageGroup) then begin
          Accept := (Tree.DropTarget.Data = topItems) or (Tree.DropTarget.Data = bottomItems);
        end;
        if Accept and (DstParentType = rctBackstageGroup) then begin
          Accept := DstType in [rctBackstageCheckBox, rctBackstageGroupButton,
            rctBackstageEditBox, rctBackstageComboBox, rctBackstageDropDown,
            rctBackstageRadioGroup, rctBackstageHyperlink, rctBackstageLabelControl,
            rctBackstageImageControl, rctBackstageGroupBox, rctBackstageLayoutContainer];
        end;
      end;
    end;
  end;
end;

procedure TadxBackstageEditor.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);

  function CheckInsert(SrcType, DstType: TadxRibbonControlType): boolean;
  begin
    Result := False;
    case SrcType of
      rctBackstageTab,
      rctBackstageFastCommandButton: ;

      rctBackstageTaskFormGroup: Result := DstType in [rctBackstageTab];
      rctBackstageTaskFormGroupCategory: Result := DstType in [rctBackstageTaskFormGroup];
      rctBackstageTaskFormGroupTask: Result := DstType in [rctBackstageTaskFormGroupCategory];

      rctBackstageGroup: Result := DstType in [rctBackstageTab, rctBackstageTaskFormGroupTask];

      rctBackstageTaskGroup: Result := DstType in [rctBackstageTab];
      rctBackstageTaskGroupCategory: Result := DstType in [rctBackstageTaskGroup];
      rctBackstageTaskGroupTask: Result := DstType in [rctBackstageTaskGroupCategory];

      rctBackstagePrimaryMenu,
      rctBackstageRegularButton: Result := True;

      rctBackstageMenuGroup: Result := DstType in [rctBackstagePrimaryMenu, rctBackstageSubMenu];

      rctBackstageSubMenu,
      rctBackstageMenuButton,
      rctBackstageMenuCheckBox,
      rctBackstageMenuToggleButton: Result := DstType in [rctBackstageMenuGroup];

      rctBackstageCheckBox,
      rctBackstageGroupButton,
      rctBackstageEditBox,
      rctBackstageComboBox,
      rctBackstageDropDown,
      rctBackstageRadioGroup,
      rctBackstageHyperlink,
      rctBackstageLabelControl,
      rctBackstageImageControl,
      rctBackstageGroupBox,
      rctBackstageLayoutContainer: Result := DstType in [rctBackstageGroup, rctBackstageGroupBox, rctBackstageLayoutContainer];
    end;
  end;

var
  isNodeDown, isExpanded: Boolean;
  SrcType, DstType: TadxRibbonControlType;
  SrcCtrl, DstCtrl: TadxRibbonCustomControl;
  DstCollection: TOwnedCollection;
begin
  if Assigned(Tree.DropTarget) and Assigned(Tree.Selected) then begin
    if (Tree.Selected.Data = nil) then Exit;
    SrcCtrl := TadxRibbonCustomControl(Tree.Selected.Data);
    SrcType := IadxRibbonComponent(SrcCtrl).GetType();

    if Tree.DropTarget.Data = firstColumn then begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Parent.Data);
      DstType := rctBackstageTab;
      DstCollection := TadxBackstageTab(Tree.DropTarget.Parent.Data).FirstColumn;
    end
    else
    if Tree.DropTarget.Data = secondColumn then begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Parent.Data);
      DstType := rctBackstageTab;
      DstCollection := TadxBackstageTab(Tree.DropTarget.Parent.Data).SecondColumn;
    end
    else
    if Tree.DropTarget.Data = primaryItem then begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Parent.Data);
      DstType := rctBackstageGroup;
      DstCollection := TadxBackstageGroup(Tree.DropTarget.Parent.Data).PrimaryItem;
    end
    else
    if Tree.DropTarget.Data = topItems then begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Parent.Data);
      DstType := rctBackstageGroup;
      DstCollection := TadxBackstageGroup(Tree.DropTarget.Parent.Data).TopItems;
    end
    else
    if Tree.DropTarget.Data = bottomItems then begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Parent.Data);
      DstType := rctBackstageGroup;
      DstCollection := TadxBackstageGroup(Tree.DropTarget.Parent.Data).BottomItems;
    end
    else begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Data);
      DstType := IadxRibbonComponent(DstCtrl).GetType();
      DstCollection := TOwnedCollection(DstCtrl.Collection);
    end;

    isNodeDown := False;
    if CheckInsert(SrcType, DstType) then begin
      isNodeDown := True;
      if not (DstCtrl is TadxBackstageTab) and not (DstCtrl is TadxBackstageGroup) then
        DstCollection := IadxRibbonComponent(DstCtrl).GetControls();
    end;

    SrcCtrl.Collection := DstCollection;
    if not isNodeDown then begin
      if SrcCtrl.Index < DstCtrl.Index then
        SrcCtrl.Index := DstCtrl.Index - 1
      else
        SrcCtrl.Index := DstCtrl.Index;
    end;
    
    Tree.Items.BeginUpdate;
    try
      isExpanded := Tree.Selected.Expanded;

      if isNodeDown then begin
        Tree.Selected.MoveTo(Tree.DropTarget, naAddChild);
      end
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

procedure TadxBackstageEditor.TreeKeyPress(Sender: TObject; var Key: Char);
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

initialization

finalization
  if Assigned(BackstageEditorsList) then begin
    BackstageEditorsList.Free;
    BackstageEditorsList := nil;
  end;

end.
