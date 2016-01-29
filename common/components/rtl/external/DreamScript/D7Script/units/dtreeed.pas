{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dtreeEd;

interface
{$I dc.inc}
uses
  Windows {$IFDEF D4},imglist{$ENDIF},Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,  ExtCtrls, dcstdctl, ComCtrls, Buttons,
  dcpedit,dcedit, dcDTree , dcsystem, dcgen,  dccommon, dcimged , dcconsts;

type
  TDrawEdFrm = class(TForm)
    Panel1: TPanel;
    GrItems: TGroupBox;
    GrProps: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TextEditor: TDCPropEditor;
    ImIndexEditor: TDCPropEditor;
    SelIndexEditor: TDCPropEditor;
    StateIndexEditor: TDCPropEditor;
    ColorEditor: TDCPropEditor;
    BoldEditor: TDCPropCheckBox;
    ItalicEditor: TDCPropCheckBox;
    UnderEditor: TDCPropCheckBox;
    StateEditor: TDCPropEditor;
    GrayedEditor: TDCPropCheckBox;
    RadioEditor: TDCPropCheckBox;
    MsTreeView: TDCMSTreeView;
    ToolPanel: TPanel;
    UpBut: TSpeedButton;
    NewBut: TSpeedButton;
    NewSubButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    Panel2: TPanel;
    OkBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    DCSplitter1: TDCSplitter;
    procedure MsTreeViewSelectionChanged(Sender: TObject; Node: TTreeNode);
    procedure MsTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure MsTreeViewClickCheck(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure NewButClick(Sender: TObject);
    procedure NewSubButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure UpButClick(Sender: TObject);
    procedure MsTreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MsTreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MsTreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure SetEnabledEditors(value : boolean);
    function  AddItem(Sender : TObject ; Child : boolean) : TTreeNode;
  end;

var
  DrawEdFrm: TDrawEdFrm;

procedure EditDrawTree(DrawTree : TCustomDCDrawTreeView);

type
  TMTree = class(TCustomDCDrawTreeView);

implementation

{$R *.DFM}

{------------------------------------------------------------------}

procedure EditDrawTree(DrawTree : TCustomDCDrawTreeView);
begin
  with TDrawEdFrm.Create(nil) do
  try
    Caption := DrawTree.Name + '.Items' ;// don't resource 
    with MsTreeView do
    begin
      CheckBoxes := DrawTree.CheckBoxes;
      AllowGrayed := DrawTree.AllowGrayed;
      Images := TMTree(DrawTree).Images;
      StateImages := TMTree(DrawTree).StateImages;
      Font.Assign(TMTree(DrawTree).Font);
      AssignNodes(TMTree(DrawTree).Items);
      if ShowModal = idOk then
      begin
        TMTree(DrawTree).AssignNodes(Items);
        DesignerModified(DrawTree);
      end;
    end;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.SetEnabledEditors(value : boolean);
begin
  SetEnabledControls([TextEditor, ImIndexEditor, SelIndexEditor, StateIndexEditor,
  ColorEditor, BoldEditor, ItalicEditor, UnderEditor, StateEditor,
  {ParentFontEd, ParentColorEd,} GrayedEditor, RadioEditor], value);
  UpdateEditors(GrProps);
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewSelectionChanged(Sender: TObject;
  Node: TTreeNode);
var
  Lst : TList;
begin
  Lst := MsTreeView.ItemsSelected;
  if Lst.Count > 0 then
    TextEditor.ComponentList := Lst
  else
    TextEditor.Component := nil;
  SetEnabledEditors(Lst.Count > 0);
  DeleteButton.Enabled := Lst.Count > 0;
  UpBut.Enabled := (Node <> nil) and (Node.Parent <> nil)
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  Node.Text := S;
  TextEditor.UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewClickCheck(Sender: TObject;
  Node: TTreeNode);
begin
  StateEditor.UpdateEditorState;
  RadioEditor.UpdateEditorState;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.FormCreate(Sender: TObject);
begin
  SetFlatPropToAll(Self,true);
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
end;

{------------------------------------------------------------------}

function TDrawEdFrm.AddItem(Sender : TObject ; Child : boolean) : TTreeNode;

  {---------------------------------------------------------}

  function InternallAdd(Child : boolean) : TTreeNode;
  begin
    with MsTreeView, Items do
      if Child then
        result := AddChild(Selected, SNewNode)
      else
        result := Add(Selected, SNewNode);
  end;

  {---------------------------------------------------------}

begin
  with MsTreeView, Items do
  begin
    if (GetFirstNode = nil) then
    begin
      BeginUpdate;
      try
        result := InternallAdd(Child);
      finally
        EndUpdate;
      end;
    end
    else
      result := InternallAdd(Child);
    DeselectAllItems;
    Selected := result;
  end;
  if Sender <> nil then
  begin
    TextEditor.SetFocus;
    TextEditor.SelectAll;
  end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.NewButClick(Sender: TObject);
begin
  AddItem(Sender, false);
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.NewSubButtonClick(Sender: TObject);
begin
  AddItem(Sender, true);
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.DeleteButtonClick(Sender: TObject);
begin
  MsTreeView.DeleteSelectedItems;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.UpButClick(Sender: TObject);
var
  Sel : TTreeNode;
begin
  with MSTreeView,Items do
    if Assigned(Selected) and  Assigned(Selected.Parent) then
    begin
      Sel := Selected;
      DeselectAllItems;
      Selected := Sel.Parent;
    end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with MSTreeView do
  begin
    if (not  IsEditing ) then
      case Key of
        VK_DELETE :
          DeleteButtonClick(nil);
        VK_INSERT :
          if (ssCtrl in Shift) then
            NewSubButtonClick(nil)
          else
            NewButClick(nil);
        VK_F2 :
          if Selected <> nil then
            Selected.EditText;
      end;
  end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Node : TTreeNode;
  Next : TTreeNode;
begin
  with MsTreeView do
  begin
    Node := GetNodeAt(X,Y);
    if not ((Node = nil) or (Selected = nil) or (Selected = Node) or Node.HasAsParent(Selected)) then
      if (Node.AbsoluteIndex > Selected.AbsoluteIndex)  then
      begin
        Next := Node.GetNextSibling;
        if Assigned(Next) then
          Selected.MoveTo(Next, naInsert)
        else
          Selected.MoveTo(Node, naAdd)
      end
      else
        Selected.MoveTo(Node, naInsert);
  end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.MsTreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Node : TTreeNode;
begin
  Accept := Sender = Source;
  if not Accept then
    exit;
  with MsTreeView do
  begin
    Node := GetNodeAt(X,Y);
    Accept := (Node <> nil) and (Selected <> nil) and (Selected <> Node) and
           not (Node.HasAsParent(Selected));
  end;
end;

{------------------------------------------------------------------}

procedure TDrawEdFrm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) and not MsTreeView.IsEditing then
    Close;
end;

end.
