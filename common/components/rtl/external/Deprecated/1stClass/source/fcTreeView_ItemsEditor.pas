unit fcTreeView_ItemsEditor;

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, fcTreeView, ExtCtrls, checklst, fcCommon, Buttons, 
  {$ifdef fcDelphi6Up}
  DesignIntf
  {$else  fcDelphi6Up}
  dsgnintf
  {$endif fcDelphi6Up}
  ;

type
  TfcTreeViewItemsEditor = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    TextEdit: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ImageIndexEdit: TEdit;
    SelectedIndexEdit: TEdit;
    StateIndexEdit: TEdit;
    ShowCheckBox: TCheckBox;
    CheckListBox: TCheckListBox;
    TreeView: TfcTreeView;
    StringData1Edit: TEdit;
    Label5: TLabel;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Label6: TLabel;
    StringData2Edit: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Panel2: TPanel;
    NewItemButton: TSpeedButton;
    NewSubitemButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    MoveUpButton: TSpeedButton;
    MoveDownButton: TSpeedButton;
    LoadButton: TSpeedButton;
    SpeedButton1: TSpeedButton;
    CheckboxRadioGroup: TGroupBox;
    CheckboxButton: TRadioButton;
    RadioButton: TRadioButton;
    GrayedCheckbox: TCheckBox;
    procedure NewItemButtonClick(Sender: TObject);
    procedure NewSubitemButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure TextEditChange(Sender: TObject);
    procedure ShowCheckBoxClick(Sender: TObject);
    procedure StateIndexEditExit(Sender: TObject);
    procedure SelectedIndexEditExit(Sender: TObject);
    procedure ImageIndexEditExit(Sender: TObject);
    procedure CheckListBoxClickCheck(Sender: TObject);
    procedure CheckListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckListBoxClick(Sender: TObject);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MoveButtonClick(Sender: TObject);
    procedure TreeViewMouseDown(TreeView: TfcCustomTreeView; Node: TfcTreeNode; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure StateIndexEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringData1EditExit(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringData2EditExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckboxButtonClick(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure GrayedCheckboxClick(Sender: TObject);
    procedure TreeViewToggleCheckbox(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode);
    procedure TreeViewChanging(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode; var AllowChange: Boolean);
    procedure TreeViewChange(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode);
    procedure TreeViewCalcNodeAttributes(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode; State: TfcItemStates);
    procedure Button4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    SuspendCheckboxList: Boolean;
    InRefreshControls: boolean;
    DataModified: boolean;
    OrigTreeView: TfcCustomTreeView;
//    DragFlag: Boolean;
    procedure RefreshControls;
    procedure UpdateNode(UpdateAll: boolean);
    procedure RefreshChecklistBox(Node: TfcTreeNode);
    procedure FillChecklistBox;
    procedure SetCheckboxEnabled(val: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

  {$ifdef fcDelphi6Up}
   TFormDesigner = IDesigner;
  {$else  fcDelphi6Up}
   {$ifdef fcDelphi4Up}
   TFormDesigner = IFormDesigner;
   {$endif}
  {$endif fcDelphi6Up}

  procedure ExecuteTreeNodesEditor(ADesigner: TFormDesigner; ATreeView: TfcTreeView);

var
  fcTreeViewItemsEditor: TfcTreeViewItemsEditor;

implementation

{$R *.DFM}

type TEditorTreeView = class(TfcTreeView);

procedure ExecuteTreeNodesEditor(ADesigner: TFormDesigner; ATreeView: TfcTreeView);
begin
  with TfcTreeViewItemsEditor.Create(Application) do
  begin
    TEditorTreeView(TreeView).NodeClass := TEditorTreeView(ATreeView).NodeClass;
    OrigTreeView:= ATreeView;
    TreeView.Items.Assign(ATreeView.Items);
    TreeView.MultiSelectAttributes.Assign(ATreeView.MultiSelectAttributes);

    TreeView.Font.Assign(ATreeView.Font);

    if ATreeView.Images <> nil then
      TreeView.Images:= ATreeView.Images;
    if ATreeView.StateImages <> nil then
      TreeView.StateImages := ATreeView.StateImages;
    TreeView.Options:= ATreeView.Options - [tvoAutoURL, tvoHideSelection];
    TreeView.Indent:= ATreeView.Indent;
    if ShowModal = mrOK then
    begin
      ATreeView.Items.Assign(TreeView.Items);
      if ADesigner <> nil then ADesigner.Modified else ShowMessage('nil');
    end;
    Free;
  end;
end;

procedure TfcTreeViewItemsEditor.NewItemButtonClick(Sender: TObject);
var ParentOfSelected: TfcTreeNode;
    Node: TfcTreeNode;
begin
//   UpdateNode(False);


   if TreeView.Selected=Nil then ParentOfSelected:= Nil
   else ParentOfSelected:= TreeView.Selected.parent;

   TreeView.selected := TreeView.Items.AddChild(ParentOfSelected, '');

   if parentOfSelected=nil then
      Node := TfcTreeNode(TreeView.Items.GetFirstNode)
   else
      Node := TfcTreeNode(parentOfSelected.GetFirstChild);

   if (Node<>Nil) and (Node.CheckboxType=tvctRadioGroup) then
   begin
      TfcTreeNode(TreeView.selected).CheckboxType:= tvctRadioGroup;
      TfcTreeNode(TreeView.selected).StateIndex:= 1;
   end;

   RefreshControls;
   UpdateNode(False);
   TextEdit.setFocus;

end;

procedure TfcTreeViewItemsEditor.NewSubitemButtonClick(Sender: TObject);
begin
//   UpdateNode;

   if TreeView.selected<>Nil then
   begin
      TreeView.selected:= TreeView.Items.AddChild(TreeView.Selected, '');
      UpdateNode(False);
      TextEdit.setFocus;
   end;
end;

procedure TfcTreeViewItemsEditor.DeleteButtonClick(Sender: TObject);
begin
  if TreeView.selected <> nil then
  begin
    TreeView.Items.Delete(TreeView.Selected);
    RefreshControls;
  end
end;

type TTempTree = class(TfcTreeView);

procedure TfcTreeViewItemsEditor.FillChecklistBox;
var BooleanProps: TStringList;
    i: Integer;
    Node: TfcTreeNode;
begin
  Node := TTempTree(TreeView).NodeClass.Create(TreeView.Items);

  ChecklistBox.Items.Clear;
  BooleanProps := TStringList.Create;
  try
    fcGetBooleanProps(Node, BooleanProps);
    if BooleanProps.count>0 then
    begin
       CheckListbox.enabled:= True;
       TabStop:= True;
    end;
    for i := 0 to BooleanProps.Count - 1 do
      ChecklistBox.Items.Add(BooleanProps[i]);
  finally
    BooleanProps.Free;
    Node.Free;
  end;
end;

procedure TfcTreeViewItemsEditor.RefreshChecklistBox(Node: TfcTreeNode);
var i: Integer;
begin
  SuspendCheckboxList := True;
  for i := 0 to CheckListBox.Items.Count - 1 do
    ChecklistBox.Checked[ChecklistBox.Items.Count - 1] :=
      Boolean(fcGetOrdProp(Node, ChecklistBox.Items[i]));
  SuspendCheckboxList := False;
end;

procedure TfcTreeViewItemsEditor.RefreshControls;
var haveSelection: boolean;
begin
   haveSelection:= TreeView.selected<>Nil;
   InRefreshControls:= True;

   DeleteButton.enabled:= haveSelection;
   NewSubItemButton.enabled:= haveSelection;
   TextEdit.enabled:= haveSelection;
   ImageIndexEdit.enabled:= haveSelection;
   StringData1Edit.enabled:= haveSelection;
   StringData2Edit.enabled:= haveSelection;
   SelectedIndexEdit.enabled:= haveSelection;
   StateIndexEdit.enabled:= haveSelection;
   ShowCheckbox.enabled:= haveSelection;
   CheckListBox.Enabled := haveSelection;
   if ShowCheckBox.enabled then
   begin
       ShowCheckbox.enabled:= haveSelection and
          not TreeView.MultiSelectCheckboxNeeded(TreeView.Selected);
       if not ShowCheckbox.enabled then begin
          ShowCheckbox.checked:= false;
       end
   end;

   if TreeView.selected <> nil then
   begin
      RefreshChecklistBox(TreeView.Selected);
      TextEdit.text:= TreeView.Selected.Text;
      ImageIndexEdit.text:= inttostr(TreeView.Selected.ImageIndex);
      StringData1Edit.text:= TreeView.Selected.StringData;
      StringData2Edit.text:= TreeView.Selected.StringData2;
      SelectedIndexEdit.text:= inttostr(TreeView.Selected.SelectedIndex);
      StateIndexEdit.text:= inttostr(TreeView.Selected.StateIndex);
      ShowCheckbox.checked:= (TreeView.Selected as TfcTreeNode).CheckboxType<>tvctNone;

      If ShowCheckbox.checked then begin
         StateIndexEdit.enabled:= False;
         if (TreeView.Selected as TfcTreeNode).CheckboxType=tvctRadioGroup then
         begin
            CheckboxButton.checked:= False;
            RadioButton.checked:= True;
         end
         else begin
            CheckboxButton.checked:= True;
            RadioButton.checked:= False;
         end;
         GrayedCheckbox.checked:= TreeView.Selected.Grayed;
      end
      else begin
         CheckboxButton.checked:= True;
         RadioButton.checked:= False;
      end;
      SetCheckboxEnabled(ShowCheckbox.checked);
   end;
   InRefreshControls:= False;

end;

procedure TfcTreeViewItemsEditor.SetCheckboxEnabled(val: boolean);
begin
    CheckboxButton.enabled:= val;
    RadioButton.enabled:= val;
    GrayedCheckbox.enabled:= val;
end;

procedure TfcTreeViewItemsEditor.UpdateNode(UpdateAll: boolean);

    procedure SetSiblingsToRadio(Node: TfcTreeNode; RadioGroupFlag: boolean);
    begin
       Node:=  TreeView.GetFirstSibling(Node);
{       parentNode:= TwwTreeNode(TreeView.selected.parent);
       if parentNode=nil then
          Node := TreeView.Items.GetFirstNode as TwwTreeNode
       else
          Node := TwwTreeNode(parentNode.GetFirstChild);
}
       while Node <> nil do
       begin
          if RadioGroupFlag then begin
             Node.CheckboxType:= tvctRadioGroup;
             Node.StateIndex:=strtoint(StateIndexEdit.text);
          end
          else if Node.CheckboxType=tvctRadioGroup then begin
             Node.CheckboxType:= tvctNone;
             Node.StateIndex:=-1;
          end;
          Node := TfcTreeNode(Node.GetNextSibling);
       end;
       TreeView.Invalidate;
    end;

begin
    if TreeView.selected<>nil then begin
       DataModified:= True;
       TreeView.Selected.Text := TextEdit.text;
       if ImageIndexEdit.text<>'' then
          TreeView.Selected.ImageIndex:= strtoint(ImageIndexEdit.text);
       if StringData1Edit.text<>'' then
          TreeView.Selected.StringData:= StringData1Edit.text;
       if StringData2Edit.text<>'' then
          TreeView.Selected.StringData2:= StringData2Edit.text;
       if SelectedIndexEdit.text<>'' then
          TreeView.Selected.SelectedIndex:= strtoint(SelectedIndexEdit.text);
       if StateIndexEdit.text<>'' then
          TreeView.Selected.StateIndex:= strtoint(stateindexedit.text);

       if not UpdateAll then exit;

       if ShowCheckbox.checked then
       begin
          if RadioButton.checked then { Radio group }
             SetSiblingsToRadio(TfcTreeNode(TreeView.selected), True)
          else begin
             SetSiblingsToRadio(TfcTreeNode(TreeView.selected), False);
             if CheckboxButton.checked then
                (TreeView.selected as TfcTreeNode).CheckboxType:= tvctCheckbox
             else
                (TreeView.selected as TfcTreeNode).CheckboxType:= tvctRadioGroup;
             (TreeView.selected as TfcTreeNode).StateIndex:=strtoint(StateIndexEdit.text);
          end;

          TreeView.selected.grayed:=GrayedCheckbox.checked;

       end
       else begin
          if RadioButton.checked then { Radio group }
             SetSiblingsToRadio(TfcTreeNode(TreeView.selected), False)
          else (TreeView.selected as TfcTreeNode).CheckboxType:= tvctNone;
       end

    end;
end;

procedure TfcTreeViewItemsEditor.FormShow(Sender: TObject);
begin
   FillChecklistBox;  { 4/22/99 - Put before refresh controls }
   RefreshControls;
   TreeView.Options:= TreeView.Options - [tvo3StateCheckbox];
//   TreeView.ReadOnly:= True;
end;

procedure TfcTreeViewItemsEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
var answer: integer;
begin
   if ModalResult = mrOK then UpdateNode(True)
   else if (ModalResult = mrCancel) and DataModified then begin
      answer:= MessageDlg('Changes have been made!  Do you wish to save them?',
           mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      if (answer = mrYes) then ModalResult:= mrOK
      else if (answer = mrNo) then ModalResult:= mrCancel
      else Action:= caNone;
   end
end;

procedure TfcTreeViewItemsEditor.Button3Click(Sender: TObject);
begin
   UpdateNode(True);
end;

procedure TfcTreeViewItemsEditor.TextEditChange(Sender: TObject);
begin
   if TextEdit.modified then
   begin
      TreeView.Selected.Text:= TextEdit.Text;
      DataModified:= True;
   end
//   if (Sender as TEdit).Focused then UpdateNode;
//   if TreeView.Selected<>Nil then
//      TreeView.Selected.Text:= (Sender as TEdit).text;
end;

procedure TfcTreeViewItemsEditor.ShowCheckBoxClick(Sender: TObject);
begin
   if InRefreshControls then exit;
   if ShowCheckbox.checked then
   begin
      StateIndexEdit.text:= '1';
      StateIndexEdit.enabled:= False;
      SetCheckboxEnabled(true);
   end
   else begin
      StateIndexEdit.text:= '-1';
      StateIndexEdit.enabled:= True;
      SetCheckboxEnabled(false);
   end;
   UpdateNode(True);
end;

procedure TfcTreeViewItemsEditor.StateIndexEditExit(Sender: TObject);
begin
   if StateIndexEdit.modified then
   begin
      TreeView.Selected.StateIndex:= strtoint(StateIndexEdit.Text);
      TreeView.InvalidateNode(TreeView.Selected);
      DataModified:= True;
   end
end;

procedure TfcTreeViewItemsEditor.SelectedIndexEditExit(Sender: TObject);
begin
   if SelectedIndexEdit.modified then
   begin
      TreeView.Selected.SelectedIndex:= strtoint(SelectedIndexEdit.Text);
      DataModified:= True;
   end
end;

procedure TfcTreeViewItemsEditor.ImageIndexEditExit(Sender: TObject);
begin
   if ImageIndexEdit.modified then
   begin
      TreeView.Selected.ImageIndex:= strtoint(ImageIndexEdit.Text);
      TreeView.InvalidateNode(TreeView.Selected);
      DataModified:= True;
   end
end;

procedure TfcTreeViewItemsEditor.CheckListBoxClickCheck(Sender: TObject);
begin
  if SuspendCheckboxList then Exit;
  if TreeView.Selected <> nil then
    fcSetOrdProp(TreeView.Selected, CheckListBox.Items[CheckListBox.ItemIndex],
      ord(CheckListBox.Checked[CheckListBox.ItemIndex]));
end;

procedure TfcTreeViewItemsEditor.CheckListBoxDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  function ExtrapolateText: string;
  var i: Integer;
  begin
    result := ChecklistBox.Items[Index];
    i := 2;
    while i <= Length(result) do
    begin
      if result[i] in ['A'..'Z'] then
      begin
        Insert(' ', result, i);
        inc(i);
      end;
      inc(i);
    end;
  end;
begin
  Inc(Rect.Left, 2);
  SetBkMode(ChecklistBox.Canvas.Handle, TRANSPARENT);
  SetBkColor(ChecklistBox.Canvas.Handle, 0);
  SetTextColor(ChecklistBox.Canvas.Handle, ColorToRGB(Font.Color));
  DrawText(ChecklistBox.Canvas.Handle, PChar(ExtrapolateText),
    Length(ExtrapolateText), Rect, DT_VCENTER or DT_SINGLELINE);
end;

procedure TfcTreeViewItemsEditor.CheckListBoxClick(Sender: TObject);
begin
//  CheckListBox.Checked[CheckListBox.ItemIndex] := not CheckListBox.Checked[CheckListBox.ItemIndex];
end;

procedure TfcTreeViewItemsEditor.TreeViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var HitTest : TfcHitTests;
    KeyState: TKeyboardState;
begin
  with (Sender as TfcTreeView) do begin
    HitTest := GetHitTestInfoAt(X,Y);
    if (Selected <> nil) and
       ([fchtOnItem, fchtOnButton, fchtOnIndent, fchtOnLabel, fchtOnRight] * HitTest <> []) then
    begin
       if ([fchtOnItem, fchtOnButton, fchtOnIndent, fchtOnLabel, fchtOnRight] * HitTest <> []) then
       begin
          Items.BeginUpdate;
          DataModified:= True;
          GetKeyboardState(KeyState);

          if KeyState[vk_Shift]>=128 then
             Selected.MoveTo(GetNodeAt(X,Y), fcnaAddChild)
          else begin
             if (GetNodeAt(X,Y)=nil) then
                Selected.MoveTo(GetNodeAt(X,Y), fcnaInsertAfter)
             else
                Selected.MoveTo(GetNodeAt(X,Y), fcnaInsert);
          end;
          Items.EndUpdate;
       end
    end
    else if fchtNowhere in HitTest then
    begin
       Selected.MoveTo(DropTarget, fcnaAdd)
    end;

    DropTarget := nil;
    Screen.Cursor := crDefault;
  end
end;

procedure TfcTreeViewItemsEditor.MoveButtonClick(Sender: TObject);
var NextSibling: TfcTreeNode;
    Mode: TfcNodeAttachMode;
begin
  Mode := fcnaInsert;
  if (TreeView.Selected = nil) then Exit;
  if (Sender as TSpeedButton).Tag < 0 then
  begin
    NextSibling := TreeView.Selected.GetNextSibling;
    if NextSibling = nil then Exit;
    NextSibling := NextSibling.GetNextSibling;
    if NextSibling = nil then
    begin
      NextSibling := TreeView.Selected;
      Mode := fcnaAdd;
    end;
  end else NextSibling := TreeView.Selected.GetPrevSibling;
  if NextSibling = nil then Exit;
  TreeView.Items.BeginUpdate;
  TreeView.Selected.MoveTo(NextSibling, Mode);
  TreeView.Items.EndUpdate;
  DataModified := True;
end;

procedure TfcTreeViewItemsEditor.TreeViewMouseDown(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if fchtOnLabel in TreeView.GetHitTestInfoAt(X,Y) then
     TreeView.BeginDrag(False);
end;

procedure TfcTreeViewItemsEditor.TreeViewDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= True;
end;

procedure TfcTreeViewItemsEditor.StateIndexEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then begin
    if ActiveControl = TextEdit then
    begin
       NewItemButton.Click;
    end
    else if (ActiveControl = ImageIndexEdit) or
            (ActiveControl = StringData1Edit) or
            (ActiveControl = StringData2Edit) or
            (ActiveControl = SelectedIndexEdit) or
            (ActiveControl = StateIndexEdit) then
    begin
       TEdit(ActiveControl).OnExit(ActiveControl);
       TEdit(ActiveControl).SelectAll;
    end
  end


end;

procedure TfcTreeViewItemsEditor.StringData1EditExit(Sender: TObject);
begin
   if (Sender as TEdit).modified then
   begin
      TreeView.Selected.StringData:= (Sender as TEdit).Text;
      DataModified:= True;
   end
end;

procedure TfcTreeViewItemsEditor.LoadButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
     TreeView.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TfcTreeViewItemsEditor.SpeedButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
      if MessageDlg(Format('OK to overwrite %s', [SaveDialog1.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
    TreeView.SaveToFile(SaveDialog1.FileName);
  end;

end;

procedure TfcTreeViewItemsEditor.StringData2EditExit(Sender: TObject);
begin
   if (Sender as TEdit).modified then
   begin
      TreeView.Selected.StringData2:= (Sender as TEdit).Text;
      DataModified:= True;
   end
end;

procedure TfcTreeViewItemsEditor.FormResize(Sender: TObject);
begin
  if Width<500 then Width:= 500;
  if Height<325 then Height:= 325;
end;

procedure TfcTreeViewItemsEditor.CheckboxButtonClick(Sender: TObject);
begin
   RadioButton.checked:= False;
   if InRefreshControls then exit;
   UpdateNode(True);
end;

procedure TfcTreeViewItemsEditor.RadioButtonClick(Sender: TObject);
begin
   CheckboxButton.checked:= False;
   if InRefreshControls then exit;
   UpdateNode(True);
end;

procedure TfcTreeViewItemsEditor.GrayedCheckboxClick(Sender: TObject);
begin
   if InRefreshControls then exit;
   UpdateNode(True);
end;

procedure TfcTreeViewItemsEditor.TreeViewToggleCheckbox(
  TreeView: TfcCustomTreeView; Node: TfcTreeNode);
begin
   RefreshControls;
end;

procedure TfcTreeViewItemsEditor.TreeViewChanging(
  TreeView: TfcCustomTreeView; Node: TfcTreeNode;
  var AllowChange: Boolean);
begin
   try
      if ImageIndexEdit.modified or StateIndexEdit.modified or
         SelectedIndexEdit.modified or StringData1Edit.modified or
         StringData2Edit.modified then
         UpdateNode(False);
   except
      AllowChange:= False;
      raise;
   end;
end;

procedure TfcTreeViewItemsEditor.TreeViewChange(
  TreeView: TfcCustomTreeView; Node: TfcTreeNode);
begin
   RefreshControls;
end;

procedure TfcTreeViewItemsEditor.TreeViewCalcNodeAttributes(
  TreeView: TfcCustomTreeView; Node: TfcTreeNode; State: TfcItemStates);
begin
  if (Node.StringData<>'') and (tvoAutoURL in OrigTreeView.Options) then
  begin
      if not (fcisSelected in State) or not TreeView.Focused then
         Treeview.Canvas.Font.Color:= clBlue;
      Treeview.Canvas.Font.Style:=
              Canvas.Font.Style + [fsUnderline];
  end
end;

procedure TfcTreeViewItemsEditor.Button4Click(Sender: TObject);
begin
  fcHelp(Handle, 'TfcTreeView Nodes Editor');
end;

procedure TfcTreeViewItemsEditor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then Button4Click(Button4);
end;

end.
