unit fcCollectionEditor;
{
//
// Components : TfcCollectionEditorForm
//
// Copyright (c) 1998 by Woll2Woll Software
//
}

{ This collection editor may only support the navigator currently due to
  only having one global collection editor }
  
interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  {$IfDef fcDelphi6Up}
  DesignIntf,
  {$Else  fcDelphi6Up}
  dsgnintf,
  {$EndIf fcDelphi6Up}
  fcCommon, fcCollection, ComCtrls, Buttons,
  {$ifdef fcDelphi4Up}ImgList,{$endif} ToolWin, Menus;

const
  sfcInvalidParameter = 'Parameter %s of %s cannot be %s';

type
  TfcCollectionEditorForm = class(TForm)
    ItemsList: TListView;
    ToolBar: TToolBar;
    AddButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    ToolButton1: TToolButton;
    MoveUpButton: TSpeedButton;
    MoveDownButton: TSpeedButton;
    ToolButton2: TToolButton;
    UserButton1: TSpeedButton;
    UserButton2: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    SelectAll1: TMenuItem;
    N1: TMenuItem;
    ShowToolbarMenu: TMenuItem;
    procedure MoveButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure ItemsListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure ItemsListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ItemsListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ItemsListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ItemsListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure ShowToolbarMenuClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  protected
    IgnoreChange: Boolean;
    function GetSelectedComponent(Index: Integer): TfcCollectionItem;
    function GetItemText(Item: TfcCollectionItem): string;
    procedure ItemUpdateSelection(Item: TfcCollectionItem);
    procedure ItemRefreshDesign(Sender: TObject);
    procedure ResetForm;
  public
    Collection: TfcCollection;
    Designer:
    {$IfDef fcDelphi6Up}
     IDesigner
    {$Else  fcDelphi6Up}
     {$ifdef fcDelphi4Up}
      IFormDesigner
     {$else}
      TFormDesigner
     {$endif}
    {$EndIf fcDelphi6Up};
    PropertyName: string;  // Name of property being edited
    Component: TComponent; // Handle to component being edited
    procedure Reload;
    procedure SetSelection(Instance: TPersistent; Selected: Boolean); virtual;
    procedure Update; override;
    destructor Destroy; override;
  end;

  TfcCollectionCustomizeEvent = procedure(EditorForm: TfcCollectionEditorForm) of object;

  procedure fcExecuteCollectionEditor(ACaption: string; ADesigner:
    {$IfDef fcDelphi6Up}
     IDesigner
    {$Else  fcDelphi6Up}
     {$ifdef fcDelphi4Up}
      IFormDesigner
     {$else}
      TFormDesigner
     {$endif}
    {$EndIf fcDelphi6Up};
    APropertyName: string; ACollection: TfcCollection; CustomizeEvent: TfcCollectionCustomizeEvent);

var
  fcCollectionEditorForm: TfcCollectionEditorForm = nil;

implementation

{$R *.DFM}

// This function executes our Collection Editor.  The
// meaning of the parameters are as follows:
//
// ACaption -    The Caption of the Collection Editor form.
//               i.e. 'fcDBNavigator1.Buttons'
// ADesigner -   The Designer property of TComponentEditor,
//               TPropertyEditor, etc.
// AComponent -  The actual component getting edited.
//               i.e. In the context of TComponentEditor,
//               just pass the Component property.
// ACollection - The property that implements ICollection.
//               i.e. fcDBNavigator1.Buttons as IfcCollection
// -ksw (7/3/98)

procedure fcExecuteCollectionEditor(ACaption: string; ADesigner:
    {$IfDef fcDelphi6Up}
     IDesigner
    {$Else  fcDelphi6Up}
     {$ifdef fcDelphi4Up}
      IFormDesigner
     {$else}
      TFormDesigner
     {$endif};
    {$EndIf fcDelphi6Up}
;
  APropertyName: string; ACollection: TfcCollection; CustomizeEvent: TfcCollectionCustomizeEvent);
begin
  // ACollection and AComponent cannot be nil.
  if ACollection = nil then raise EInvalidOperation.Create(Format(sfcInvalidParameter, ['ACollection', 'fcExecuteCollectionEditor', 'nil']));

  if fcCollectionEditorForm = nil then
    fcCollectionEditorForm := TfcCollectionEditorForm.Create(Application)
  else fcCollectionEditorForm.ResetForm;

  with fcCollectionEditorForm do
  begin
    PropertyName := APropertyName;
    ACollection.Designer := fcCollectionEditorForm;

    Designer := ADesigner;
    if (ACollection<>Collection) and (Collection<>nil) then
       Collection.Designer:= nil; { Detach previous collection }

    Collection := ACollection;
    Reload;
    Caption := ACaption;
    if Assigned(CustomizeEvent) then CustomizeEvent(fcCollectionEditorForm);
    Show;
  end
end;

procedure TfcCollectionEditorForm.ResetForm;
begin
  IgnoreChange := True;
  ItemsList.Items.Clear;
  IgnoreChange := False;
end;

procedure TfcCollectionEditorForm.Update;
begin
  inherited Update;
  Reload;
end;

procedure TfcCollectionEditorForm.Reload;
var i: integer;
begin
  ItemsList.Items.BeginUpdate;
  ItemsList.Items.Clear;
  for i:= 0 to Collection.Count - 1 do
  begin
    ItemsList.Items.Add.Caption := GetItemText(Collection.Items[i]);
    Collection.Items[i].SelectionMethod := ItemUpdateSelection;
    Collection.Items[i].OnRefreshDesign := ItemRefreshDesign; { RSW - 4/27/99 (Refresh collection editor on text change) }
  end;
  ItemsList.Items.EndUpdate;
end;

destructor TfcCollectionEditorForm.Destroy;
begin
  Collection.Designer := nil;
  fcCollectionEditorForm := nil;
  inherited Destroy;
end;

function TfcCollectionEditorForm.GetSelectedComponent(Index: Integer): TfcCollectionItem;
begin
  result := Collection.Items[Index];
  if result = nil then raise EInvalidOperation.Create('GetSelectedComponent is returning nil');
end;

procedure TfcCollectionEditorForm.MoveButtonClick(Sender: TObject);
var Item: TfcCollectionItem;
    Button: TComponent;
begin
  if ItemsList.Selected = nil then Exit;
  Item := GetSelectedComponent(ItemsList.Selected.Index);
  Button := Sender as TComponent;
  if (Item <> nil) and
     (((Button.Tag = -1) and (Item.Index > 0)) or
      ((Button.Tag = 1) and (Item.Index < Collection.Count - 1))) then
  begin
    Item.Index := Item.Index + Button.Tag;
    Reload;
    ItemsList.Items[Item.Index].Selected := True;
    if Designer <> nil then Designer.Modified;
  end
end;


{$ifndef fcDelphi5Up}
function ExtractPersistent(Component: TPersistent): TPersistent; //Component;
begin
   result:= Component as TPersistent;
end;
{$endif}

procedure TfcCollectionEditorForm.DeleteButtonClick(Sender: TObject);
var i, OldItemIndex: integer;
    {$ifdef fcDelphi5Up}
    Selections, NoSel: IDesignerSelections;
    {$else}
    Selections, NoSel: TComponentList;
    {$endif}

    OldSel: TListItem;
begin
  // Prevent OnChange event from firing.
  IgnoreChange := True;

  if ItemsList.Selected = nil then Exit;
  OldItemIndex := ItemsList.Selected.Index;

  {$ifndef fcDelphi5Up}
  Selections := TComponentList.Create;
  {$else}
  Selections := CreateSelectionList;
  {$endif}
  if Designer <> nil then
  begin
    Designer.GetSelections(Selections);

    {$ifndef fcDelphi5Up}
    NoSel := TComponentList.Create;
    {$else}
    NoSel := CreateSelectionList;
    {$endif}

    Designer.SetSelections(NoSel);

    {$ifndef fcDelphi5Up}
    NoSel.Free;
    {$endif}
  end;
  {$IfDef fcDelphi6Up}
  for i := 0 to Selections.Count - 1 do Selections[i].Free;
  {$Else  fcDelphi6Up}
  for i := 0 to Selections.Count - 1 do ExtractPersistent(Selections[i]).Free;
  {$EndIf fcDelphi6Up}
  {$ifndef fcDelphi5Up}
  Selections.Free;
  {$endif}

  Reload;

  OldSel := ItemsList.Items[fcMin(OldItemIndex, ItemsList.Items.Count - 1)];
  if OldSel <> nil then OldSel.Selected := True;

  // Allow OnChange event to fire.
  IgnoreChange := False;

  // Set the currently selected ListView item to be selected
  ItemsListMouseUp(ItemsList, mbLeft, [], 0, 0);

  if Designer <> nil then Designer.Modified;
end;

procedure TfcCollectionEditorForm.AddButtonClick(Sender: TObject);
begin
  Collection.AddItem;
  Reload;
  if Designer <> nil then Designer.Modified;
end;

function TfcCollectionEditorForm.GetItemText(Item: TfcCollectionItem): string;
var DisplayName: string;
begin
  DisplayName := Item.DisplayName;
  if (DisplayName = '') and (Item.GetInstance(PropertyName) is TComponent) then
    DisplayName := (Item.GetInstance(PropertyName) as TComponent).Name;
  result := InttoStr(Item.Index) + ' - ' + DisplayName;
end;

procedure TfcCollectionEditorForm.ItemRefreshDesign(Sender: TObject);
begin
  Reload;
end;

procedure TfcCollectionEditorForm.ItemUpdateSelection(Item: TfcCollectionItem);
begin
  ItemsList.Selected := ItemsList.Items[Item.Index];
end;

procedure TfcCollectionEditorForm.ItemsListBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  // F11 is the default character keystroke to bring up the
  // object inspector.  If that keystroke is overridable,
  // then this code becomes unpredictable.  -!- Need to look
  // into that.  -ksw (7/3/98)
  case Key of
    VK_INSERT: AddButtonClick(AddButton);
    VK_DELETE: DeleteButtonClick(DeleteButton);
    VK_UP, VK_DOWN: if ssCtrl in Shift then
    begin
      if Key = VK_UP then
        MoveButtonClick(MoveUpButton)
      else MoveButtonClick(MoveDownButton);
      Key := 0;
    end;
    VK_RETURN: fcPlayKeystroke(Handle, VK_F11, 0);
  end;
end;

procedure TfcCollectionEditorForm.FormResize(Sender: TObject);
begin
  // The Items list is a TListView.  It is in the Report viewstyle
  // and has one column.  This "aligns" that column to the client
  // width of the list view.
  with ItemsList.ClientRect do
    ItemsList.Columns[0].Width := Right - Left;
end;

procedure TfcCollectionEditorForm.ItemsListDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source <> nil) and (Source is TListView) and (Source = Sender) and ((Sender as TListView).GetItemAt(X,Y) <> (Sender as TListView).Selected);
end;

procedure TfcCollectionEditorForm.ItemsListDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var Item: TListItem;
    Index: Integer;
    SelItem: TfcCollectionItem;
begin
  Item := (Sender as TListView).GetItemAt(X,Y);
  if Item = nil then Index := (Sender as TListView).Items.Count - 1
  else Index := Item.Index;

  SelItem := GetSelectedComponent(ItemsList.Selected.Index);
  SelItem.Index := Index;
  Reload;
  ItemsList.Items[SelItem.Index].Selected := True;
  if Designer <> nil then Designer.Modified;
end;

procedure TfcCollectionEditorForm.SetSelection(Instance: TPersistent; Selected: Boolean);
var i: Integer;
begin
  IgnoreChange := True;
  for i := 0 to ItemsList.Items.Count - 1 do
    if Collection.Items[i].GetInstance(PropertyName) = Instance then
    begin
      ItemsList.Items[i].Selected := Selected;
      Break;
    end;
  IgnoreChange := False;
end;

procedure TfcCollectionEditorForm.ItemsListKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN, VK_HOME, VK_END, VK_NEXT, VK_PRIOR, VK_SPACE] then
    ItemsListMouseUp(ItemsList, mbLeft, [], 0, 0);
end;

procedure TfcCollectionEditorForm.ItemsListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    {$ifdef fcDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}
    i: Integer;
begin
  if (csDestroying in ComponentState) then Exit;

  DeleteButton.Enabled := ItemsList.Selected <> nil;
  MoveUpButton.Enabled := ItemsList.Selected <> nil;
  MoveDownButton.Enabled := ItemsList.Selected <> nil;

  if (Designer = nil) or IgnoreChange then Exit;

  {$ifndef fcDelphi5Up}
  Selections := TComponentList.Create;
  {$else}
  Selections := CreateSelectionList;
  {$endif}
  for i:= 0 to ItemsList.Items.Count - 1 do
    if ItemsList.Items[i].Selected then
      {$ifdef fcDelphi6Up}
        Selections.Add(GetSelectedComponent(i).GetInstance(PropertyName));
      {$Else  fcDelphi5Up}
        {$ifdef fcDelphi5Up}
        Selections.Add(MakeIPersistent(GetSelectedComponent(i).GetInstance(PropertyName)));
        {$else}
        Selections.Add(GetSelectedComponent(i).GetInstance(Propertyname));
        {$endif}
      {$endif fcDelphi5Up}

  if Selections.Count > 0 then
    Designer.SetSelections(Selections);

  {$ifndef fcDelphi5Up}
  Selections.Free;
  {$endif}

  if ItemsList.SelCount = 1 then
    GetSelectedComponent(ItemsList.Selected.Index).GotSelected;
end;

procedure TfcCollectionEditorForm.FormShow(Sender: TObject);
begin
  ItemsListMouseUp(ItemsList, mbLeft, [], 0, 0);
end;

procedure TfcCollectionEditorForm.SelectAll1Click(Sender: TObject);
var i: Integer;
begin
  for i := 0 to ItemsList.Items.Count - 1 do
    ItemsList.Items[i].Selected := True;
end;

procedure TfcCollectionEditorForm.ShowToolbarMenuClick(Sender: TObject);
begin
  ShowToolBarMenu.Checked := not ShowToolBarMenu.Checked;
  ToolBar.Visible := ShowToolBarMenu.Checked;
end;

procedure TfcCollectionEditorForm.PopupMenu1Popup(Sender: TObject);
begin
  ShowToolBarMenu.Checked := ToolBar.Visible;
end;

procedure TfcCollectionEditorForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
    fcHelp(Handle, 'TfcCollection');
end;

initialization
finalization
  fcCollectionEditorForm.Free;
  fcCollectionEditorForm := nil;
end.
