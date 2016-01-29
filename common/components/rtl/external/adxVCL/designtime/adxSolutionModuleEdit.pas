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

unit adxSolutionModuleEdit;

{$I adxDefs.inc}

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
  Dialogs, ComCtrls, ToolWin, Menus, ImgList, StdCtrls, ExtCtrls, ActiveX, Math, OleServer;

type
  {$IFDEF ADX_VCL5}
  TadxSolutionModuleEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindowActions, IDesignEditQuery)
  {$ELSE}
  TadxSolutionModuleEditor = class(TForm, IUnknown, IDesignNotification, IDesignWindow, IEditHandler, IActivatable)
  {$ENDIF}
    PopupMenu: TPopupMenu;
    ImageList1: TImageList;
    miNewFolder: TMenuItem;
    N1: TMenuItem;
    miDelete: TMenuItem;
    miMoveUp: TMenuItem;
    miMoveDown: TMenuItem;
    panControls: TPanel;
    ToolBar: TToolBar;
    tbNewFolder: TToolButton;
    tbSeparator1: TToolButton;
    tbDelete: TToolButton;
    tbMoveUp: TToolButton;
    tbMoveDown: TToolButton;
    Tree: TTreeView;
    tbSeparator2: TToolButton;
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
    {$IFNDEF ADX_VCL5}
    FDesigner: IDesigner;
    FComponentDesigner: IComponentDesigner;
    {$ELSE}
    FDesigner: IFormDesigner;
    {$ENDIF}
    FCollectionPropertyName: string;
    FClosing: Boolean;
    FSelectionError: Boolean;
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

procedure ShowSolutionModuleEditor(ADesigner: IDesigner; AComponent: TComponent;
  ACollection: TOwnedCollection; const PropertyName: string);

implementation

{$R *.dfm}

uses Registry, DesignConst;

var
  SolutionModuleEditorsList: TList = nil;

type
  TCollectionAccess = class(TCollection);
  TOwnedCollectionAccess = class(TOwnedCollection);
  TPersistentAccess = class(TPersistent);

procedure ShowSolutionModuleEditor(ADesigner: IDesigner; AComponent: TComponent;
  ACollection: TOwnedCollection; const PropertyName: string);
var
  i: Integer;
  frm: TadxSolutionModuleEditor;
begin
  if SolutionModuleEditorsList = nil then SolutionModuleEditorsList := TList.Create;
  for i := 0 to SolutionModuleEditorsList.Count - 1 do begin
    frm := TadxSolutionModuleEditor(SolutionModuleEditorsList[i]);
    with frm do
      if (Designer = ADesigner) and (Component = AComponent)
        and (CompareText(CollectionPropertyName, PropertyName) = 0) then
      begin
        Show;
        BringToFront;
        Exit;
      end;
  end;
  frm := TadxSolutionModuleEditor.Create(Application);
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

{ TadxSolutionModuleEditor }

constructor TadxSolutionModuleEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF ADX_VCL5}
  RegisterDesignNotification(Self);
  FComponentDesigner := ActiveDesigner;
  SetBounds(200, FComponentDesigner.Environment.GetMainWindowSize.Bottom + 2, Width, Height);
  {$ELSE}
  CompLib.RegisterDesignWindow(Self);
  {$ENDIF}
end;

destructor TadxSolutionModuleEditor.Destroy;
begin
  {$IFNDEF ADX_VCL5}
  UnregisterDesignNotification(Self);
  FComponentDesigner := nil;
  {$ELSE}
  CompLib.UnregisterDesignWindow(Self);
  {$ENDIF}
  FDesigner := nil;
  inherited Destroy;
end;

function TadxSolutionModuleEditor.GetEditState: TEditState;
begin
  Result := [];
end;

{$IFDEF ADX_VCL5}
procedure TadxSolutionModuleEditor.EditAction(Action: TEditAction);
begin
end;
{$ELSE}
function TadxSolutionModuleEditor.EditAction(Action: TEditAction): Boolean;
begin
  Result := False;
end;
{$ENDIF}

procedure TadxSolutionModuleEditor.WindowHide;
begin
  if Visible then
    ShowWindow(Handle, SW_HIDE);
end;

procedure TadxSolutionModuleEditor.WindowShow;
const
  ShowCommands: array[TWindowState] of Word =
    (SW_SHOWNOACTIVATE, SW_SHOWMINNOACTIVE, SW_SHOWMAXIMIZED);
begin
  if Visible then
    ShowWindow(Handle, ShowCommands[WindowState]);
end;

{$IFDEF ADX_VCL5}
procedure TadxSolutionModuleEditor.ItemDeleted(const AItem: IPersistent);

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

procedure TadxSolutionModuleEditor.ItemInserted(const AItem: IPersistent);
begin
end;

procedure TadxSolutionModuleEditor.SelectionChanged(const ASelection: IDesignerSelections);
begin
end;

procedure TadxSolutionModuleEditor.DesignerInitialized(const ADesigner: IUnknown);
begin
end;

procedure TadxSolutionModuleEditor.DesignerClosed(const ADesigner: IUnknown);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxSolutionModuleEditor.ItemsModified(const ADesigner: IUnknown);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if CompLib.GetActiveForm.Designer <> Designer then Exit;
    GetSelection;
  end;
end;

{$ELSE}
procedure TadxSolutionModuleEditor.ItemDeleted(const ADesigner: IDesigner; Item: TPersistent);

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

procedure TadxSolutionModuleEditor.ItemInserted(const ADesigner: IDesigner; Item: TPersistent);
begin
end;

procedure TadxSolutionModuleEditor.SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
begin
end;

procedure TadxSolutionModuleEditor.DesignerOpened(const Designer: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TadxSolutionModuleEditor.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  if Designer = ADesigner then
    CloseEditor;
end;

procedure TadxSolutionModuleEditor.ItemsModified(const Designer: IDesigner);
begin
  if FClosing then Exit;
  if Collection <> nil then begin
    if ActiveRoot <> nil then
      if ActiveRoot.GetDesigner <> Designer then Exit;
    GetSelection;
  end;
end;
{$ENDIF}

procedure TadxSolutionModuleEditor.Activated;
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

procedure TadxSolutionModuleEditor.WMActivate(var Msg: TWMActivate);
begin
  inherited;
  FActive := Msg.Active <> 0;
  if FActive then Activated;
end;

procedure TadxSolutionModuleEditor.CloseEditor;
begin
  FClosing := True;
  Collection := nil;
  Component := nil;
  Close;
end;

type
  TadxCustomCommandBarAccess = class(TadxCustomCommandBar);

function GetImageIndex(const Sender: TadxOLSolutionFolder): Integer;
begin
  Result := Integer(Sender.FolderType) + 5;
end;

procedure TadxSolutionModuleEditor.GetSelection;
var
  Item: TadxOLSolutionFolder;
  ImgIndex: Integer;
begin
  if Tree.Selected <> nil then begin
    // root
    if Tree.Selected.Data = nil then begin
      if Component is TadxOLSolutionModule then
        Tree.Selected.Text := TadxOLSolutionModule(Component).ClassName;
    end
    // collection item
    else begin
      Item := TadxOLSolutionFolder(Tree.Selected.Data);
      Tree.Selected.Text := Item.DisplayName;
      if Item.Glyph.Empty then begin
        Tree.Selected.ImageIndex := GetImageIndex(Item);
        Tree.Selected.SelectedIndex := Tree.Selected.ImageIndex;
      end
      else begin
        if Tree.Selected.ImageIndex <= 11 then begin
          if Item.GlyphTransparentColor = clDefault then
            ImgIndex := Self.ImageList1.AddMasked(Item.Glyph, Item.Glyph.Canvas.Pixels[0, Item.Glyph.Height - 1])
          else
            ImgIndex := Self.ImageList1.AddMasked(Item.Glyph, Item.GlyphTransparentColor);
          Tree.Selected.ImageIndex := ImgIndex;
          Tree.Selected.SelectedIndex := Tree.Selected.ImageIndex;
        end;
      end;
    end;
  end;
end;

procedure TadxSolutionModuleEditor.SetSelection;
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
        if Designer <> nil then
          Designer.SelectComponent(Component);
        Exit;
      end;
      {$IFDEF ADX_VCL5}
      List := TDesignerSelectionList.Create;
      {$ELSE}
      List := CreateSelectionList;
      {$ENDIF}
      List.Add(TadxOLSolutionFolder(Tree.Selected.Data));
      if Designer <> nil then
        Designer.SetSelections(List);
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

procedure TadxSolutionModuleEditor.SetCollectionPropertyName(const Value: string);
const
  SEditorCaption = 'Editing %s%s%s';
begin
  if Value <> FCollectionPropertyName then begin
    FCollectionPropertyName := Value;
    Caption := Format(SEditorCaption, [Component.Name, '.', Value]);
  end;
end;

function TadxSolutionModuleEditor.GetRegKey: string;
begin
  {$IFDEF ADX_VCL5}
  Result := DelphiIDE.GetBaseRegKey + '\' + sIniEditorsName + '\Collection Editor';
  {$ELSE}
  Result := FComponentDesigner.Environment.GetBaseRegKey + '\' +
    sIniEditorsName + '\Collection Editor';
  {$ENDIF}
end;

procedure TadxSolutionModuleEditor.FormCreate(Sender: TObject);
begin
  SolutionModuleEditorsList.Add(Self);
end;

procedure TadxSolutionModuleEditor.FormDestroy(Sender: TObject);
begin
  if SolutionModuleEditorsList <> nil then
    SolutionModuleEditorsList.Remove(Self);
end;

procedure TadxSolutionModuleEditor.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TadxSolutionModuleEditor.BuildControlsList;

  procedure ProcessChildren(ANode: TTreeNode; ACtrls: TadxOLSolutionFolders);
  var
    i: Integer;
    Node: TTreeNode;
    ImgIndex: Integer;
  begin
    for i := 0 to ACtrls.Count - 1 do begin
      Node := Tree.Items.AddChildObject(ANode, ACtrls[i].DisplayName, ACtrls[i]);
      if ACtrls[i].Glyph.Empty then begin
        Node.ImageIndex := GetImageIndex(ACtrls[i]);
        Node.SelectedIndex := Node.ImageIndex;
      end
      else begin
        if ACtrls[i].GlyphTransparentColor = clDefault then
          ImgIndex := Self.ImageList1.AddMasked(ACtrls[i].Glyph, ACtrls[i].Glyph.Canvas.Pixels[0, ACtrls[i].Glyph.Height - 1])
        else
          ImgIndex := Self.ImageList1.AddMasked(ACtrls[i].Glyph, ACtrls[i].GlyphTransparentColor);
        Node.ImageIndex := ImgIndex;
        Node.SelectedIndex := Node.ImageIndex;
      end;
      ProcessChildren(Node, ACtrls[i].Folders);
    end;
  end;

var
  i: Integer;
  Root, Node: TTreeNode;
  Item: TadxOLSolutionFolder;
  ImgIndex: Integer;
begin
  Tree.Items.BeginUpdate;
  try
    Root := Tree.Items.AddChildFirst(nil, TadxOLSolutionModule(TOwnedCollectionAccess(TadxOLSolutionFolders(Collection)).GetOwner).ClassName);
    Root.ImageIndex := 4;
    Root.SelectedIndex := 4;

    for i := 0 to TadxOLSolutionFolders(Collection).Count - 1 do begin
      Item := TadxOLSolutionFolders(Collection)[i];
      Node := Tree.Items.AddChildObject(Root, Item.DisplayName, Item);
      if Item.Glyph.Empty then begin
        Node.ImageIndex := GetImageIndex(Item);
        Node.SelectedIndex := Node.ImageIndex;
      end
      else begin
        if Item.GlyphTransparentColor = clDefault then
          ImgIndex := Self.ImageList1.AddMasked(Item.Glyph, Item.Glyph.Canvas.Pixels[0, Item.Glyph.Height - 1])
        else
          ImgIndex := Self.ImageList1.AddMasked(Item.Glyph, Item.GlyphTransparentColor);
        Node.ImageIndex := ImgIndex;
        Node.SelectedIndex := Node.ImageIndex;
      end;
      ProcessChildren(Node, (TadxOLSolutionFolders(Collection)[i]).Folders);
    end;
    UpdateToolBarAndMenu(Tree.Selected);
    Tree.FullExpand;
    Root.MakeVisible;
  finally
    Tree.Items.EndUpdate;
  end;
end;

procedure TadxSolutionModuleEditor.CommonClick(Sender: TObject);
var
  Item: TadxOLSolutionFolder;
  Coll: TCollection;
  Node: TTreeNode;
  isExpanded: Boolean;
begin
  case (Sender as TComponent).Tag of
    // Delete
    110: if MessageDlg('Are you sure you want to delete the selected item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
           Coll := TadxOLSolutionFolder(Tree.Selected.Data).Collection;
           Coll.BeginUpdate;
           try
             Coll.Delete(TadxOLSolutionFolder(Tree.Selected.Data).Index);
             Tree.Selected.Delete;
             UpdateToolBarAndMenu(Tree.Selected);
           finally
             Coll.EndUpdate;
           end;
         end;
    // Move Up
    120: begin
           TadxOLSolutionFolder(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxOLSolutionFolder(Tree.Selected.Data).Index := TadxOLSolutionFolder(Tree.Selected.Data).Index - 1;
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
             TadxOLSolutionFolder(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // Move Down
    130: begin
           TadxOLSolutionFolder(Tree.Selected.Data).Collection.BeginUpdate;
           try
             TadxOLSolutionFolder(Tree.Selected.Data).Index := TadxOLSolutionFolder(Tree.Selected.Data).Index + 1;
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
             TadxOLSolutionFolder(Tree.Selected.Data).Collection.EndUpdate;
           end;
         end;
    // add a control
    else begin
      try
        if (Tree.Selected = nil) or (Tree.Selected.Data = nil) then
          Item := TadxOLSolutionFolders(Collection).Add() as TadxOLSolutionFolder
        else begin
          Item := TadxOLSolutionFolder(Tree.Selected.Data).Folders.Add() as TadxOLSolutionFolder;
        end;
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

procedure TadxSolutionModuleEditor.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := False;
end;

procedure TadxSolutionModuleEditor.TreeChange(Sender: TObject; Node: TTreeNode);
begin
  SetSelection;
  UpdateToolBarAndMenu(Node);
end;

procedure TadxSolutionModuleEditor.UpdateToolBarAndMenu(Node: TTreeNode);

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
  Item: TadxOLSolutionFolder;
begin
  for i := 0 to ToolBar.ButtonCount - 2 do
    if ToolBar.Buttons[i].Style = tbsButton then
      ToolBar.Buttons[i].Enabled := False;
  for i := 0 to PopupMenu.Items.Count - 1 do
    if PopupMenu.Items[i].Caption <> '-' then
      PopupMenu.Items[i].Enabled := False;
  if (Node = nil) or (Node.Data = nil) then begin
    if TadxOLSolutionModule(Self.Component).Folders.Count = 0 then begin
      EnableControls([tbNewFolder]);
      EnableMenuItems([miNewFolder]);
    end;
  end else begin
    Item := TadxOLSolutionFolder(Node.Data);
    // Delete
    tbDelete.Enabled := True;
    miDelete.Enabled := tbDelete.Enabled;
    // Move Up
    tbMoveUp.Enabled := Item.Index > 0;
    miMoveUp.Enabled := tbMoveUp.Enabled;
    // Move Down
    tbMoveDown.Enabled := Item.Index < Item.Collection.Count - 1;
    miMoveDown.Enabled := tbMoveDown.Enabled;
    //
    EnableControls([tbNewFolder]);
    EnableMenuItems([miNewFolder]);
  end;
end;

procedure TadxSolutionModuleEditor.TreeContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node: TTreeNode;
begin
  Node := Tree.GetNodeAt(MousePos.X, MousePos.Y);
  if Assigned(Node) then
    Tree.Selected := Node;
end;

procedure TadxSolutionModuleEditor.TreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
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

  Accept := Tree.DropTarget <> Tree.Selected;
  if Accept then
    Accept := not Tree.DropTarget.HasAsParent(Tree.Selected);

  if Accept then
    Accept := Tree.DropTarget.Level <> 0;
end;

procedure TadxSolutionModuleEditor.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  isExpanded: Boolean;
  SrcCtrl, DstCtrl: TadxOLSolutionFolder;
  DstCollection: TOwnedCollection;
begin
  if Assigned(Tree.DropTarget) and Assigned(Tree.Selected) then begin
    if (Tree.Selected.Data = nil) then Exit;
    SrcCtrl := TadxOLSolutionFolder(Tree.Selected.Data);
    DstCtrl := TadxOLSolutionFolder(Tree.DropTarget.Data);
    DstCollection := TOwnedCollection(DstCtrl.Folders);

    SrcCtrl.Collection := DstCollection;
    Tree.Items.BeginUpdate;
    try
      isExpanded := Tree.Selected.Expanded;
      Tree.Selected.MoveTo(Tree.DropTarget, naAddChild);
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

procedure TadxSolutionModuleEditor.TreeKeyPress(Sender: TObject; var Key: Char);
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
  if Assigned(SolutionModuleEditorsList) then begin
    SolutionModuleEditorsList.Free;
    SolutionModuleEditorsList := nil;
  end;

end.
