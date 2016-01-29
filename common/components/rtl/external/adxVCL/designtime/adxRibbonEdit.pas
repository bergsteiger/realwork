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

unit adxRibbonEdit;

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
  TadxRibbonEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindowActions, IDesignEditQuery)
  {$ELSE}
  TadxRibbonEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindow, IEditHandler, IActivatable)
  {$ENDIF}
    PopupMenu: TPopupMenu;
    miRibbonGroup: TMenuItem;
    miRibbonBox: TMenuItem;
    miRibbonButtonGroup: TMenuItem;
    N1: TMenuItem;
    miRibbonButton: TMenuItem;
    miRibbonSplitButton: TMenuItem;
    miRibbonLabel: TMenuItem;
    miRibbonCheckBox: TMenuItem;
    miRibbonEditBox: TMenuItem;
    miRibbonCombobox: TMenuItem;
    miRibbonDropdown: TMenuItem;
    miRibbonGallery: TMenuItem;
    miRibbonMenu: TMenuItem;
    N2: TMenuItem;
    miRibbonSeparator: TMenuItem;
    miRibbonMenuSeparator: TMenuItem;
    miRibbonDialogBoxLauncher: TMenuItem;
    N3: TMenuItem;
    miDelete: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    panDesign: TPanel;
    panControls: TPanel;
    ToolBar: TToolBar;
    tbRibbonGroup: TToolButton;
    tbRibbonBox: TToolButton;
    tbRibbonButtonGroup: TToolButton;
    tbSeparator1: TToolButton;
    tbRibbonButton: TToolButton;
    tbRibbonSplitButton: TToolButton;
    tbRibbonLabel: TToolButton;
    tbRibbonCheckBox: TToolButton;
    tbRibbonEditBox: TToolButton;
    tbRibbonComboBox: TToolButton;
    tbRibbonDropDown: TToolButton;
    tbRibbonGallery: TToolButton;
    tbRibbonMenu: TToolButton;
    tbSeparator3: TToolButton;
    tbRibbonSeparator: TToolButton;
    tbRibbonMenuSeparator: TToolButton;
    tbRibbonDialogBoxLauncher: TToolButton;
    tbSeparator2: TToolButton;
    tbDelete: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    Tree: TTreeView;
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

procedure ShowRibbonEditor(ADesigner: IDesigner;
  AComponent: TComponent; ACollection: TOwnedCollection; const PropertyName: string);

implementation

{$R *.dfm}

uses Registry, DesignConst;

var
  RibbonEditorsList: TList = nil;

type
  TCollectionAccess = class(TCollection);
  TOwnedCollectionAccess = class(TOwnedCollection);
  TPersistentAccess = class(TPersistent);

procedure ShowRibbonEditor(ADesigner: IDesigner;
  AComponent: TComponent; ACollection: TOwnedCollection; const PropertyName: string);
var
  i: Integer;
  frm: TadxRibbonEditor;
begin
  if RibbonEditorsList = nil then RibbonEditorsList := TList.Create;
  for i := 0 to RibbonEditorsList.Count - 1 do begin
    frm := TadxRibbonEditor(RibbonEditorsList[i]);
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
  frm := TadxRibbonEditor.Create(Application);
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

{ TadxRibbonEditor }

constructor TadxRibbonEditor.Create(AOwner: TComponent);
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

destructor TadxRibbonEditor.Destroy;
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

procedure TadxRibbonEditor.DoControlSelect(ASender: TObject; const ControlID: WideString);

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
  if (Self.Component is TadxRibbonTab) and (TadxRibbonTab(Self.Component).Id = ControlID) then
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

procedure TadxRibbonEditor.WndProc(var Message: TMessage);
begin
  if Message.Msg = FNotify then
    panDesign.Height := Message.LParam;
  inherited WndProc(Message);
end;

function TadxRibbonEditor.GetEditState: TEditState;
begin
  Result := [];
end;

{$IFDEF ADX_VCL5}
procedure TadxRibbonEditor.EditAction(Action: TEditAction);
begin
end;
{$ELSE}
function TadxRibbonEditor.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;
{$ENDIF}

procedure TadxRibbonEditor.WindowHide;
begin
  if Visible then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TadxRibbonEditor.WindowShow;
const
  ShowCommands: array[TWindowState] of Word =
    (SW_SHOWNOACTIVATE, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if Visible then
    ShowWindow(Handle, ShowCommands[WindowState]);
end;

{$IFDEF ADX_VCL5}
procedure TadxRibbonEditor.ItemDeleted(const AItem: IPersistent);

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

procedure TadxRibbonEditor.ItemInserted(const AItem: IPersistent);
begin
end;

procedure TadxRibbonEditor.SelectionChanged(const ASelection: IDesignerSelections);
begin
end;

procedure TadxRibbonEditor.DesignerInitialized(const ADesigner: IUnknown);
begin
end;

procedure TadxRibbonEditor.DesignerClosed(const ADesigner: IUnknown);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxRibbonEditor.ItemsModified(const ADesigner: IUnknown);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if CompLib.GetActiveForm.Designer <> Designer then Exit;
    GetSelection;
  end;
end;

{$ELSE}
procedure TadxRibbonEditor.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);

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

procedure TadxRibbonEditor.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
end;

procedure TadxRibbonEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
end;

procedure TadxRibbonEditor.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TadxRibbonEditor.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxRibbonEditor.ItemsModified(const Designer: IDesigner);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if ActiveRoot <> nil then
      if ActiveRoot.GetDesigner <> Designer then Exit;
    GetSelection;
  end;
end;
{$ENDIF}

procedure TadxRibbonEditor.Activated;
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

procedure TadxRibbonEditor.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then Activated;
end;

procedure TadxRibbonEditor.CloseEditor;
begin
  FClosing := True;
  Collection := nil;
  Component := nil;
  Close;
end;

{$IFDEF ADX_DESIGNER}
procedure TadxRibbonEditor.UpdateProps(const ICtrl: IadxRibbonComponent; ANode: TTreeNode; AObject: TObject);
var
  i: Integer;
  id: string;
  ImgList: TCustomImageList;
  ImgIndex: TImageIndex;
  PictureDesc: TPictDesc;
  bmp: TBitmap;
  IPict: IPicture;
  Item: IadxRibbonComponent;
  bkColor: TColor;
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
    bkColor:= clNone;
    if ICtrl.GetGlyph() <> nil then begin
      if not ICtrl.GetGlyph().Empty then begin
        Bmp := TBitmap.Create;
        //Bmp.Transparent := True;
        //Bmp.PixelFormat := pf32bit;
        try
          Bmp.Assign(ICtrl.GetGlyph());
          Bmp.Transparent := True;
          bkColor:= Bmp.TransparentColor;
          PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
          PictureDesc.picType := PICTYPE_BITMAP;
          PictureDesc.hBitmap := Bmp.ReleaseHandle;
          PictureDesc.hpal := Bmp.ReleasePalette;
          OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, false, IPict);
        finally
          Bmp.Free;
        end;
      end else begin
        ImgIndex := ICtrl.GetImageIndex();
        if Self.Component is TadxRibbonTab then
          ImgList := TadxRibbonTab(Self.Component).Images
        else
          ImgList := nil;
        if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
          Bmp := TBitmap.Create;
          //Bmp.Transparent := True;
          //Bmp.PixelFormat := pf32bit;
          try
            ImgList.GetBitmap(ImgIndex, Bmp);
            bkColor:= Bmp.TransparentColor;
            PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
            PictureDesc.picType := PICTYPE_BITMAP;
            PictureDesc.hbitmap := Bmp.ReleaseHandle;
            PictureDesc.hpal := Bmp.ReleasePalette;
            OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, false, IPict);
          finally
            Bmp.Free;
          end;
        end;
      end;
    end;

    FRibbonDesigner.Tabs.UpdateProp(ICtrl.GetID(), tp_TransparentColor, bkColor); // tp_TransparentColor
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
              Bmp.PixelFormat := pf32bit;
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
              if Self.Component is TadxRibbonTab then
                ImgList := TadxRibbonTab(Self.Component).Images
              else
                ImgList := nil;
              if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
                Bmp := TBitmap.Create;
                Bmp.PixelFormat := pf32bit;
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

procedure TadxRibbonEditor.GetSelection;
{$IFDEF ADX_DESIGNER}
var
  Tab: TadxRibbonTab;
  ICtrl: IadxRibbonComponent;
{$ENDIF}
begin
  if Tree.Selected <> nil then begin
    // root
    if Tree.Selected.Data = nil then begin
      if Component is TadxRibbonTab then begin
        Tree.Selected.Text := TadxRibbonTab(Component).Caption + ' (' + TadxRibbonTab(Component).ClassName + ')';
        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FRibbonDesigner) then begin
          Tab := TadxRibbonTab(Component);
          FRibbonDesigner.Tabs.BeginUpdate(Tab.Id);
          UpdateProps(Tab, Tree.Selected, Tab);
          FRibbonDesigner.Tabs.EndUpdate(Tab.Id);
        end;
        {$ENDIF}
      end;
    end
    // collectionitem
    else begin
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

procedure TadxRibbonEditor.SetSelection;
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

          if panDesign.Visible then begin
            if (Component is TadxRibbonTab) then
              FRibbonDesigner.Tabs.SelectControl(TadxRibbonTab(Component).Id);
          end;
        end;
        Exit;
      end;
      {$IFDEF ADX_VCL5}
      List := TDesignerSelectionList.Create;
      {$ELSE}
      List := CreateSelectionList;
      {$ENDIF}
      List.Add(TadxRibbonCustomControl(Tree.Selected.Data));
      if Designer <> nil then begin
        Designer.SetSelections(List);

        if panDesign.Visible then
          FRibbonDesigner.Tabs.SelectControl(IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetID());
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

procedure TadxRibbonEditor.SetCollectionPropertyName(const Value: string);
const
  SEditorCaption = 'Editing %s%s%s';
begin
  if Value <> FCollectionPropertyName then begin
    FCollectionPropertyName := Value;
    Caption := Format(SEditorCaption, [Component.Name, '.', Value]);
  end;
end;

function TadxRibbonEditor.GetRegKey: string;
begin
  {$IFDEF ADX_VCL5}
  Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
  {$ELSE}
  Result := FComponentDesigner.Environment.GetBaseRegKey + '\' +
    sIniEditorsName + '\Collection Editor';
  {$ENDIF}
end;

procedure TadxRibbonEditor.FormCreate(Sender: TObject);
begin
  RibbonEditorsList.Add(Self);

  tbRibbonGroup.Tag := Integer(rctGroup);
  miRibbonGroup.Tag := Integer(rctGroup);
  tbRibbonBox.Tag := Integer(rctBox);
  miRibbonBox.Tag := Integer(rctBox);
  tbRibbonButtonGroup.Tag := Integer(rctButtonGroup);
  miRibbonButtonGroup.Tag := Integer(rctButtonGroup);

  tbRibbonButton.Tag := Integer(rctButton);
  miRibbonButton.Tag := Integer(rctButton);
  tbRibbonSplitButton.Tag := Integer(rctSplitButton);
  miRibbonSplitButton.Tag := Integer(rctSplitButton);
  tbRibbonLabel.Tag := Integer(rctLabel);
  miRibbonLabel.Tag := Integer(rctLabel);
  tbRibbonCheckBox.Tag := Integer(rctCheckBox);
  miRibbonCheckBox.Tag := Integer(rctCheckBox);
  tbRibbonEditBox.Tag := Integer(rctEditBox);
  miRibbonEditBox.Tag := Integer(rctEditBox);
  tbRibbonComboBox.Tag := Integer(rctComboBox);
  miRibbonComboBox.Tag := Integer(rctComboBox);
  tbRibbonDropDown.Tag := Integer(rctDropDown);
  miRibbonDropDown.Tag := Integer(rctDropDown);
  tbRibbonGallery.Tag := Integer(rctGallery);
  miRibbonGallery.Tag := Integer(rctGallery);
  tbRibbonMenu.Tag := Integer(rctMenu);
  miRibbonMenu.Tag := Integer(rctMenu);

  tbRibbonSeparator.Tag := Integer(rctSeparator);
  miRibbonSeparator.Tag := Integer(rctSeparator);
  tbRibbonMenuSeparator.Tag := Integer(rctMenuSeparator);
  miRibbonMenuSeparator.Tag := Integer(rctMenuSeparator);
  tbRibbonDialogBoxLauncher.Tag := Integer(rctDialogBoxLauncher);
  miRibbonDialogBoxLauncher.Tag := Integer(rctDialogBoxLauncher);
end;

procedure TadxRibbonEditor.FormDestroy(Sender: TObject);
begin
  if RibbonEditorsList <> nil then
    RibbonEditorsList.Remove(Self);
end;

procedure TadxRibbonEditor.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TadxRibbonEditor.BuildControlsList;

  procedure ProcessChildren(ANode: TTreeNode; ACtrls: TadxRibbonControls);
  var
    i: Integer;
    Ctrls: TadxRibbonControls;
    Node: TTreeNode;
  begin
    for i := 0 to ACtrls.Count - 1 do begin
      Node := Tree.Items.AddChildObject(ANode, ACtrls[i].DisplayName, ACtrls[i]);
      Node.ImageIndex := Integer(IadxRibbonComponent(ACtrls[i]).GetType) - 1;
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

      Ctrls := IadxRibbonComponent(ACtrls[i]).GetControls;
      if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node, Ctrls);
    end;
  end;

var
  i: Integer;
  Ctrls: TadxRibbonControls;
  Root, Node: TTreeNode;
  RootID: WideString;
  {$IFDEF ADX_DESIGNER}
  ICtrl: IadxRibbonComponent;
  {$ENDIF}
begin
  Tree.Items.BeginUpdate;
  try
    {$IFDEF ADX_DESIGNER}
    if Assigned(FRibbonDesigner) then FRibbonDesigner.Tabs.BeginUpdate('');
    {$ENDIF}
    if TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner is TadxRibbonTab then begin
      Root := Tree.Items.AddChildFirst(nil, TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).Caption + ' (' + TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).ClassName + ')');
      RootID := TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).Id;
      Root.ImageIndex := 18;
      Root.SelectedIndex := 18;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        ICtrl := TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner);
        FRibbonDesigner.Tabs.AddControl(Integer(ICtrl.GetType()), '', ICtrl.GetID(), ICtrl.GetCaption());
        FRibbonIDs.AddObject(ICtrl.GetID(), TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner));
        UpdateProps(ICtrl, Root, TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner));
      end;
      {$ENDIF}
    end
    else
    if TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner is TadxRibbonOfficeMenu then begin
      Root := Tree.Items.AddChildFirst(nil, '(' + TadxRibbonOfficeMenu(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).ClassName + ')');
      RootID := IadxRibbonComponent(TadxRibbonOfficeMenu(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner)).GetID();
      Root.ImageIndex := 19;
      Root.SelectedIndex := 19;
      panDesign.Visible := False;
    end
    else
    if TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner is TadxRibbonContextMenu then begin
      Root := Tree.Items.AddChildFirst(nil, '(' + TadxRibbonContextMenu(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).ClassName + ')');
      RootID := IadxRibbonComponent(TadxRibbonContextMenu(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner)).GetID();
      Root.ImageIndex := 14;
      Root.SelectedIndex := 14;
      panDesign.Visible := False;
    end
    else
    begin
      Root := Tree.Items.AddChildFirst(nil, '(' + TadxRibbonQAT(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).ClassName + ')');
      RootID := IadxRibbonComponent(TadxRibbonQAT(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner)).GetID();
      Root.ImageIndex := 20;
      Root.SelectedIndex := 20;
      panDesign.Visible := False;
    end;

    for i := 0 to TadxRibbonControls(Collection).Count - 1 do begin
      Node := Tree.Items.AddChildObject(Root, TadxRibbonControls(Collection)[i].DisplayName, TadxRibbonControls(Collection)[i]);
      Node.ImageIndex := Integer(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetType) - 1;
      Node.SelectedIndex := Node.ImageIndex;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        FRibbonDesigner.Tabs.AddControl(
          Integer(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetType()),
          //TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonControls(Collection)).GetOwner).Id,
          RootID,
          IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetID(),
          IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetCaption());

        FRibbonIDs.AddObject(IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetID(), TadxRibbonControls(Collection)[i]);
        UpdateProps(IadxRibbonComponent(TadxRibbonControls(Collection)[i]), Node, TadxRibbonControls(Collection)[i]);
      end;
      {$ENDIF}
      Ctrls := IadxRibbonComponent(TadxRibbonControls(Collection)[i]).GetControls;
      if Assigned(Ctrls) and (Ctrls.Count > 0) then ProcessChildren(Node, Ctrls);
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

procedure TadxRibbonEditor.CommonClick(Sender: TObject);
var
  i: Integer;
  Item: TadxRibbonCustomControl;
  Coll: TCollection;
  Node, NodeMenu: TTreeNode;
  isLauncher, isExpanded: Boolean;
  {$IFDEF ADX_DESIGNER}
  ParentID: string;
  {$ENDIF}
begin
  isLauncher := False;
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
               if TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner is TadxRibbonTab then
                 ParentID := TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner).Id
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
               if TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner is TadxRibbonTab then
                 ParentID := TadxRibbonTab(TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.Selected.Data).Collection).GetOwner).Id
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
          if IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetType = rctGroup then begin
            for i := 0 to TadxRibbonGroup(Tree.Selected.Data).Controls.Count - 1 do
              if TadxRibbonGroup(Tree.Selected.Data).Controls[i] is TadxRibbonDialogBoxLauncher then begin
                isLauncher := True;
                Break;
              end;
          end;
          Item := IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetControls.Add(TadxRibbonControlType((Sender as TComponent).Tag));
        end;

        {$IFDEF ADX_DESIGNER}
        if panDesign.Visible and Assigned(FRibbonDesigner) then begin
          if TOwnedCollectionAccess(Item.Collection).GetOwner is TadxRibbonTab then
            ParentID := TadxRibbonTab(TOwnedCollectionAccess(Item.Collection).GetOwner).Id
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

        if isLauncher then begin
          Node := Tree.Items.InsertObject(Tree.Selected.GetLastChild, Item.DisplayName, Item);
        end
        else begin
          Node := Tree.Items.AddChildObject(Tree.Selected, Item.DisplayName, Item);
        end;
        Node.ImageIndex := Integer(IadxRibbonComponent(Item).GetType) - 1;
        Node.SelectedIndex := Node.ImageIndex;
        //Node.Selected := True;
        if Assigned(Tree.Selected) and Tree.Selected.HasChildren then Tree.Selected.Expand(False);
        // menu
        if TadxRibbonControlType((Sender as TComponent).Tag) = rctSplitButton then begin
          NodeMenu := Tree.Items.AddChildObject(Node, TadxRibbonSplitButton(Item).Controls[0].DisplayName, TadxRibbonSplitButton(Item).Controls[0]);
          NodeMenu.ImageIndex := Integer(rctMenu) - 1;
          NodeMenu.SelectedIndex := Integer(rctMenu) - 1;
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

procedure TadxRibbonEditor.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TadxRibbonEditor.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  SetSelection;
  UpdateToolBarAndMenu(Node);
end;

procedure TadxRibbonEditor.UpdateToolBarAndMenu(Node: TTreeNode);

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
    if Component is TadxRibbonOfficeMenu then begin
      EnableControls([tbRibbonButton, tbRibbonGallery,
        tbRibbonMenu, tbRibbonSplitButton, tbRibbonCheckBox, tbRibbonMenuSeparator]);
      EnableMenuItems([miRibbonButton, miRibbonGallery,
        miRibbonMenu, miRibbonSplitButton, miRibbonCheckBox, miRibbonMenuSeparator]);
    end;
    if Component is TadxRibbonQAT then begin
      EnableControls([tbRibbonButton, tbRibbonSeparator]);
      EnableMenuItems([miRibbonButton, miRibbonSeparator]);
    end;
    if Component is TadxRibbonContextMenu then begin
      EnableControls([tbRibbonButton, tbRibbonGallery,
        tbRibbonMenu, tbRibbonSplitButton, tbRibbonCheckBox, tbRibbonMenuSeparator]);
      EnableMenuItems([miRibbonButton, miRibbonGallery,
        miRibbonMenu, miRibbonSplitButton, miRibbonCheckBox, miRibbonMenuSeparator]);
    end;
    if Component is TadxRibbonTab then begin
      EnableControls([tbRibbonGroup]);
      EnableMenuItems([miRibbonGroup]);
    end;
  end else begin
    Item := TadxRibbonCustomControl(Node.Data);
    // Delete
    tbDelete.Enabled := True;
    if (Item is TadxRibbonMenu) and (TOwnedCollectionAccess(Item.Collection).GetOwner is TadxRibbonSplitButton) then
      tbDelete.Enabled := False;
    miDelete.Enabled := tbDelete.Enabled;
    // Move Up
    if Item is TadxRibbonDialogBoxLauncher then begin
      tbMoveUp.Enabled := False;
      miMoveUp.Enabled := False;
    end else begin
      tbMoveUp.Enabled := Item.Index > 0;
      miMoveUp.Enabled := tbMoveUp.Enabled;
    end;
    // Move Down
    if (TOwnedCollectionAccess(Item.Collection).GetOwner is TadxRibbonGroup) then begin
      if Item.Index < Item.Collection.Count - 1 then
        tbMoveDown.Enabled := not (Item.Collection.Items[Item.Index + 1] is TadxRibbonDialogBoxLauncher);
      miMoveDown.Enabled := tbMoveDown.Enabled;
    end else begin
      tbMoveDown.Enabled := Item.Index < Item.Collection.Count - 1;
      miMoveDown.Enabled := tbMoveDown.Enabled;
    end;

    if (Item is TadxRibbonSplitButton) or (IadxRibbonComponent(Item).GetControls = nil) then Exit;
    if (Item is TadxRibbonDropDown) or (Item is TadxRibbonGallery) then begin
      tbRibbonButton.Enabled := True;
      miRibbonButton.Enabled := True;
    end;
    if (Item is TadxRibbonGroup) or
       (Item is TadxRibbonButtonGroup) or
       (Item is TadxRibbonMenu) or
       (Item is TadxRibbonBox) then
    begin
      EnableControls([tbRibbonButton, tbRibbonGallery, tbRibbonMenu, tbRibbonSplitButton]);
      EnableMenuItems([miRibbonButton, miRibbonGallery, miRibbonMenu, miRibbonSplitButton]);
      // Office 2010 scheme
      if Item is TadxRibbonButtonGroup then begin
        EnableControls([tbRibbonSeparator]);
        EnableMenuItems([miRibbonSeparator]);
      end;
      if Item is TadxRibbonGroup then begin
        EnableControls([tbRibbonCheckBox, tbRibbonLabel, tbRibbonSeparator, tbRibbonEditBox,
          tbRibbonComboBox, tbRibbonDropDown, tbRibbonBox, tbRibbonButtonGroup, tbRibbonDialogBoxLauncher]);
        EnableMenuItems([miRibbonCheckBox, miRibbonLabel, miRibbonSeparator, miRibbonEditBox,
          miRibbonComboBox, miRibbonDropDown, miRibbonBox, miRibbonButtonGroup, miRibbonDialogBoxLauncher]);
        for i := 0 to TadxRibbonGroup(Item).Controls.Count - 1 do
          if TadxRibbonGroup(Item).Controls[i] is TadxRibbonDialogBoxLauncher then begin
            tbRibbonDialogBoxLauncher.Enabled := False;
            miRibbonDialogBoxLauncher.Enabled := False;
            Break;
          end;
      end;
      if Item is TadxRibbonMenu then begin
        EnableControls([tbRibbonCheckBox, tbRibbonMenuSeparator]);
        EnableMenuItems([miRibbonCheckBox, miRibbonMenuSeparator]);
      end;
      if Item is TadxRibbonBox then begin
        EnableControls([tbRibbonCheckBox, tbRibbonLabel, tbRibbonEditBox, tbRibbonComboBox, tbRibbonDropDown,
          tbRibbonBox, tbRibbonButtonGroup]);
        EnableMenuItems([miRibbonCheckBox, miRibbonLabel, miRibbonEditBox, miRibbonComboBox, miRibbonDropDown,
          miRibbonBox, miRibbonButtonGroup]);
      end;
    end;
  end;
end;

procedure TadxRibbonEditor.TreeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node: TTreeNode;
begin
  Node := Tree.GetNodeAt(MousePos.X, MousePos.Y);
  if Assigned(Node) then
    Tree.Selected := Node;
end;

procedure TadxRibbonEditor.TreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  i: Integer;
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
  if Tree.DropTarget = nil then Exit;
  if Tree.Selected.Parent = Tree.DropTarget then Exit;
  if Tree.DropTarget.Data = nil then begin
    if Component is TadxRibbonTab then DstType := rctTab
    else
      if Component is TadxRibbonOfficeMenu then DstType := rctOfficeMenu
      else
        if Component is TadxRibbonQAT then DstType := rctQAT
        else Exit;
  end
  else begin
    DstType := IadxRibbonComponent(TadxRibbonCustomControl(Tree.DropTarget.Data)).GetType();
    DstParent := TOwnedCollectionAccess(TadxRibbonCustomControl(Tree.DropTarget.Data).Collection).GetOwner;
    if DstParent is TadxRibbonTab then DstParentType := rctTab
    else
      if DstParent is TadxRibbonOfficeMenu then DstParentType := rctOfficeMenu
      else
        if DstParent is TadxRibbonQAT then DstParentType := rctQAT
        else
          DstParentType := IadxRibbonComponent(TadxRibbonCustomControl(DstParent)).GetType();
  end;

  SrcType := IadxRibbonComponent(TadxRibbonCustomControl(Tree.Selected.Data)).GetType();
  Accept := Tree.DropTarget <> Tree.Selected;
  if Accept then begin
    if TObject(Tree.Selected.Data) is TadxRibbonMenu then
      if TOwnedCollectionAccess(TadxRibbonMenu(Tree.Selected.Data).Collection).GetOwner is TadxRibbonSplitButton then
        Accept := False;
  end;
  if Accept then
    Accept := not Tree.DropTarget.HasAsParent(Tree.Selected);

  if Accept then begin
    case SrcType of
      rctGroup: Accept := (DstType in [rctTab, rctGroup]);
      rctBox: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctButtonGroup: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctButton: Accept :=
        (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctDropDown, rctGallery, rctOfficeMenu, rctQAT]) or
        (DstParentType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctDropDown, rctGallery, rctOfficeMenu, rctQAT]);
      rctSplitButton: Accept :=
        (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]) or
        (DstParentType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]);
      rctLabel: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctCheckBox: Accept :=
        (DstType in [rctGroup, rctBox, rctMenu, rctOfficeMenu]) or
        (DstParentType in [rctGroup, rctBox, rctMenu, rctOfficeMenu]); 
      rctEditBox: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctComboBox: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctDropDown: Accept :=
        (DstType in [rctGroup, rctBox]) or
        (DstParentType in [rctGroup, rctBox]);
      rctGallery: Accept :=
        (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]) or
        (DstParentType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]); 
      rctMenu: Accept :=
        (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]) or
        (DstParentType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]); 
      rctSeparator: Accept :=
        (DstType in [rctGroup, rctQAT, rctButtonGroup]) or
        (DstParentType in [rctGroup, rctQAT, rctButtonGroup]);
      rctMenuSeparator: Accept :=
        (DstType in [rctMenu, rctOfficeMenu]) or
        (DstParentType in [rctMenu, rctOfficeMenu]); 
      rctDialogBoxLauncher:
        begin
          Accept := (DstType = rctGroup);
          if Accept then
            for i := 0 to TadxRibbonGroup(Tree.DropTarget.Data).Controls.Count - 1 do
              if TadxRibbonGroup(Tree.DropTarget.Data).Controls[i] is TadxRibbonDialogBoxLauncher then begin
                Accept := False;
                Break;
              end;
        end;
    end;
  end;
end;

procedure TadxRibbonEditor.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);

  function CheckInsert(SrcType, DstType: TadxRibbonControlType): boolean;
  begin
    Result := False;
    case SrcType of
      rctGroup: ;
      rctBox: Result := (DstType in [rctGroup, rctBox]);
      rctButtonGroup: Result := (DstType in [rctGroup, rctBox]);
      rctButton: Result := (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctDropDown, rctGallery, rctOfficeMenu, rctQAT]);
      rctSplitButton: Result := (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]);
      rctLabel: Result := (DstType in [rctGroup, rctBox]);
      rctCheckBox: Result := (DstType in [rctGroup, rctBox, rctMenu, rctOfficeMenu]);
      rctEditBox: Result := (DstType in [rctGroup, rctBox]);
      rctComboBox: Result := (DstType in [rctGroup, rctBox]);
      rctDropDown: Result := (DstType in [rctGroup, rctBox]);
      rctGallery: Result := (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]);
      rctMenu: Result := (DstType in [rctGroup, rctBox, rctButtonGroup, rctMenu, rctOfficeMenu]);
      rctSeparator: Result := (DstType in [rctGroup, rctQAT, rctButtonGroup]);
      rctMenuSeparator: Result := (DstType in [rctMenu, rctOfficeMenu]);
      rctDialogBoxLauncher: Result := True;
    end;                                                    
  end;

var
  i: Integer;
  isNodeDown, isExpanded: Boolean;
  SrcType, DstType: TadxRibbonControlType;
  SrcCtrl, DstCtrl: TadxRibbonCustomControl;
  DstCollection: TOwnedCollection;
begin
  if Assigned(Tree.DropTarget) and Assigned(Tree.Selected) then begin
    if (Tree.Selected.Data = nil) then Exit;
    SrcCtrl := TadxRibbonCustomControl(Tree.Selected.Data);
    SrcType := IadxRibbonComponent(SrcCtrl).GetType();
    if Tree.DropTarget.Data = nil then begin
      if Component is TadxRibbonTab then begin
        DstCtrl := nil;
        DstType := rctTab;
        DstCollection := TadxRibbonTab(Component).Controls;
      end
      else
        if Component is TadxRibbonOfficeMenu then begin
          DstCtrl := nil;
          DstType := rctOfficeMenu;
          DstCollection := TadxRibbonOfficeMenu(Component).Controls;
        end
        else
          if Component is TadxRibbonQAT then begin
            DstCtrl := nil;
            DstType := rctQAT;
            DstCollection := TadxRibbonQAT(Component).Controls;
          end
          else Exit;
    end
    else begin
      DstCtrl := TadxRibbonCustomControl(Tree.DropTarget.Data);
      DstType := IadxRibbonComponent(DstCtrl).GetType();
      DstCollection := TOwnedCollection(DstCtrl.Collection);
    end;

    // root (TAB, Office Menu, QAT)
    if DstCtrl = nil then begin
      SrcCtrl.Collection := DstCollection;
      Tree.Items.BeginUpdate;
      try
        Tree.Selected.MoveTo(Tree.DropTarget, naAddChild);
        Designer.Modified;
        SetSelection;
        UpdateToolBarAndMenu(Tree.Selected);
      finally
        Tree.Items.EndUpdate;
      end;
    end
    // TAB
    else begin
      isNodeDown := False;
      if CheckInsert(SrcType, DstType) then begin
        isNodeDown := True;
        DstCollection := IadxRibbonComponent(DstCtrl).GetControls();
      end;

      SrcCtrl.Collection := DstCollection;
      if not isNodeDown then begin
        if SrcCtrl.Index < DstCtrl.Index then
          SrcCtrl.Index := DstCtrl.Index - 1
        else
          SrcCtrl.Index := DstCtrl.Index;
      end;
      {$IFDEF ADX_DESIGNER}
      if panDesign.Visible and Assigned(FRibbonDesigner) then begin
        FRibbonDesigner.Tabs.BeginUpdate(IadxRibbonComponent(DstCtrl).GetID());
        if isNodeDown then
          FRibbonDesigner.Tabs.SetParent(IadxRibbonComponent(DstCtrl).GetID(), IadxRibbonComponent(SrcCtrl).GetID(), SrcCtrl.Index)
        else begin
          if TOwnedCollectionAccess(DstCtrl.Collection).GetOwner is TadxRibbonTab then
            FRibbonDesigner.Tabs.SetParent(
              IadxRibbonComponent(TadxRibbonTab(TOwnedCollectionAccess(DstCtrl.Collection).GetOwner)).GetID(),
              IadxRibbonComponent(SrcCtrl).GetID(), SrcCtrl.Index)
          else
            FRibbonDesigner.Tabs.SetParent(
              IadxRibbonComponent(TadxRibbonCustomControl(TOwnedCollectionAccess(DstCtrl.Collection).GetOwner)).GetID(),
              IadxRibbonComponent(SrcCtrl).GetID(), SrcCtrl.Index);
        end;
        FRibbonDesigner.Tabs.EndUpdate(IadxRibbonComponent(DstCtrl).GetID());
      end;
      {$ENDIF}

      Tree.Items.BeginUpdate;
      try
        isExpanded := Tree.Selected.Expanded;
        
        if isNodeDown then begin
          Tree.Selected.MoveTo(Tree.DropTarget, naAddChild);
          // check the Launcher
          if (DstType = rctGroup) and (SrcType <> rctDialogBoxLauncher) then begin
            for i := TadxRibbonGroup(DstCtrl).Controls.Count - 1 downto 0 do
              if TadxRibbonGroup(DstCtrl).Controls[i] is TadxRibbonDialogBoxLauncher then begin
                Tree.Selected.MoveTo(Tree.Selected.getPrevSibling, naInsert);
                Break;
              end;
          end;
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
end;

procedure TadxRibbonEditor.TreeKeyPress(Sender: TObject; var Key: Char);
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
  if Assigned(RibbonEditorsList) then begin
    RibbonEditorsList.Free;
    RibbonEditorsList := nil;
  end;

end.
