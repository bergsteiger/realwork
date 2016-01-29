unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtExProPDFDoc, gtPDFDoc;

type
  TfrmMain = class(TForm)
    TreeView1: TTreeView;
    btnLoad: TButton;
    edtFilename: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    gtPDFDocument1: TgtPDFDocument;
    edtSearch: TLabeledEdit;
    btnSearch: TButton;
    cbDepth: TComboBox;
    Label1: TLabel;
    procedure btnLoadClick(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnSearchClick(Sender: TObject);
    procedure edtFilenameExit(Sender: TObject);
  private
    { Private declarations }
    FNode: TTreeNode;
    procedure LoadOutlines;
    procedure ClearOutlines;
    procedure BuildOutlineChild(aNode: TTreeNode; aOutline: TgtPDFOutline);
    procedure BuildOutlineNext(aNode: TTreeNode; aOutline: TgtPDFOutline);
    function GetNodeByText(ANode: TTreeNode; AValue: String;
      AVisible: Boolean): TTreeNode;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLoadClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then Exit;
  edtFilename.Text := OpenDialog1.FileName;
  if edtFilename.Text <> '' then
    gtPDFDocument1.LoadFromFile(edtFilename.Text);

  if not gtPDFDocument1.IsLoaded then Exit;
  FNode := nil;
  LoadOutlines;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  LOutline: TgtPDFOutline;
  LDepth: TgtBookmarkTraversalDepth;
begin
  if not Assigned(FNode) then
    FNode := TreeView1.Items[0];
  LOutline := TgtPDFOutline(FNode.Data);
  if Assigned(LOutline) then
  begin
    case cbDepth.ItemIndex of
      0: LDepth := btdFullSubTree;
      1: LDepth := btdChildrenOnly;
      2: LDepth := btdSiblingsOnly;
    end;
   // Search fot title from the selected node
    LOutline := LOutline.GetByTitle(edtSearch.Text, bttDepthFirst,
      LDepth);
    if Assigned(LOutline) then
    begin
      // Found the bookmark
      // Selct the tree node to show the selection
      FNode := GetNodeByText(FNode.GetNext, edtSearch.Text, True);
    end;
  end;
end;

procedure TfrmMain.BuildOutlineChild(aNode: TTreeNode; aOutline: TgtPDFOutline);
var
  LNode: TTreeNode;
begin
// Add aOutline as Child to aNode in the TreeView.
  LNode := TreeView1.Items.AddChildObject(aNode, aOutline.Title, aOutline);

  if aOutline.Child <> nil then
    BuildOutlineChild(LNode, aOutline.Child);
  if aOutline.Next <> nil then
    BuildOutlineNext(LNode, aOutline.Next);
end;

procedure TfrmMain.BuildOutlineNext(aNode: TTreeNode; aOutline: TgtPDFOutline);
var
  LNode: TTreeNode;
begin
// Add aOutline as sibling to aNode in the TreeView.
  LNode := TreeView1.Items.AddObject(aNode, aOutline.Title, aOutline);
  if aOutline.Child <> nil then
    BuildOutlineChild(LNode, aOutline.Child);
  if aOutline.Next <> nil then
    BuildOutlineNext(LNode, aOutline.Next);
end;

procedure TfrmMain.ClearOutlines;
begin
  TreeView1.Items.Clear;
end;

procedure TfrmMain.edtFilenameExit(Sender: TObject);
begin
  if not (gtPDFDocument1.IsLoaded) and (edtFilename.Text <> '') then
    gtPDFDocument1.LoadFromFile(edtFilename.Text);
  if not gtPDFDocument1.IsLoaded then Exit;

  FNode := nil;
  LoadOutlines;
end;

function TfrmMain.GetNodeByText(ANode: TTreeNode; AValue: String;
  AVisible: Boolean): TTreeNode;
var
    Node: TTreeNode;
begin
  Result := nil;
  Node := ANode;
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(AValue) then
    begin
      Result := Node;
      if AVisible then
      begin
        TreeView1.SetFocus;
        Result.Selected := True;
        Break;
      end;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TfrmMain.LoadOutlines;
var
  LOutline, LChild: TgtPDFOutline;
  LNode: TTreeNode;
begin
  ClearOutlines;
  LOutline := gtPDFDocument1.GetBookmarkRoot;
  if Assigned(LOutline) then
  begin
  // Obtain the first child of the root.
    LChild := LOutline.Child;
    if Assigned(LChild) then
    begin
      // Add the Child node to the TreeView, and attach the pointer to it to that node.
      LNode := TreeView1.Items.AddObject(nil, LChild.Title, LChild);
      if LChild.Child <> nil then
        BuildOutlineChild(LNode, LChild.Child);
      if LChild.Next <> nil then
        BuildOutlineNext(LNode, LChild.Next);
    end;
  end;
end;

procedure TfrmMain.TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FNode := TreeView1.GetNodeAt(X, Y);
end;

end.
