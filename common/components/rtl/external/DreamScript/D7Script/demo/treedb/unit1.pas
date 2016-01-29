{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit1;

interface
{$I dc.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DcTree, DcDbTree, Db, DBTables, ExtCtrls, ComCtrls, StdCtrls,dcstdctl,dcsystem,
  Grids, DBGrids, DBCtrls, dctsrc, DCGen, dcedit,  Buttons, Menus,
  dctslite, dcpedit, dcDTree, dcdbtreereg {$IFDEF D4} ,imglist  {$ENDIF};

type
  TForm1 = class(TForm)
    SplitterPanel1: TDCSplitPanel;
    DCTreeView1: TDCTreeView;
    DCListView1: TDCListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Table1: TTable;
    DataSource1: TDataSource;
    AddBut: TButton;
    AddChildBut: TButton;
    DeleteBut: TButton;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    RefBut: TButton;
    Table1DirID: TIntegerField;
    Table1ParentID: TIntegerField;
    Table1DirName: TStringField;
    Table1ImageIndex: TSmallintField;
    Table1SelectedIndex: TSmallintField;
    Table1StateIndex: TSmallintField;
    DCSplitter1: TDCSplitter;
    CheckBox1: TCheckBox;
    EdFieldBut: TButton;
    EdColBut: TButton;
    EditBut: TButton;
    Panel3: TPanel;
    DirTableBut: TButton;
    BigTableBut: TButton;
    Table2: TTable;
    Table1id: TIntegerField;
    Table1parent: TIntegerField;
    Table1name: TStringField;
    MoveUpBut: TButton;
    NilBut: TButton;
    DCPropCheckBox1: TDCPropCheckBox;
    DCResViewSource1: TDCResViewSource;
    ResourceBut: TButton;
    MainMenu1: TMainMenu;
    TreeView1: TMenuItem;
    Refresh1: TMenuItem;
    AddItem1: TMenuItem;
    AddSubitem1: TMenuItem;
    EditItem1: TMenuItem;
    DeleteItem1: TMenuItem;
    MoveUpItem1: TMenuItem;
    EditFields1: TMenuItem;
    View1: TMenuItem;
    CheckChild1: TMenuItem;
    ExplorerStyle1: TMenuItem;
    SettoDirectorytable1: TMenuItem;
    Source1: TMenuItem;
    SettoResourceView1: TMenuItem;
    SettoMenuSource1: TMenuItem;
    SettoBigTable1: TMenuItem;
    SetTonil1: TMenuItem;
    DCMenuSource1: TDCMenuSource;
    menubut: TButton;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ImageList1: TImageList;
    DCDataSetSource1: TDCDataSetSource;
    procedure FormCreate(Sender: TObject);
    procedure AddButClick(Sender: TObject);
    procedure AddChildButClick(Sender: TObject);
    procedure DeleteButClick(Sender: TObject);
    procedure RefButClick(Sender: TObject);
    procedure DCListView1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DCTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure EdFieldButClick(Sender: TObject);
    procedure EdColButClick(Sender: TObject);
    procedure EditButClick(Sender: TObject);
    procedure BigTableButClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DirTableButClick(Sender: TObject);
    procedure MoveUpButClick(Sender: TObject);
    procedure NilButClick(Sender: TObject);
    procedure ResourceButClick(Sender: TObject);
    procedure SettoMenuSource1Click(Sender: TObject);
    procedure CheckChild1Click(Sender: TObject);
    procedure ExplorerStyle1Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    firsttime : boolean;
    procedure OpenDirTable;
    procedure SetSources(ASource: TTreeSource);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
{$R *.DCR}

function  FillTable(Table : TTable ; firsttime : boolean ) : integer;
Var
  i, j, k, l, id, parent : Integer;
begin
  if firsttime then
  begin
    Table.CreateTable;
    Table.AddIndex('Dirid', 'Dirid', [ixPrimary, ixUnique]);
    Table.AddIndex('parentId', 'parentId', []);
  end;
  Table.Open;
  if firsttime then
  begin
    Table.DisableControls;
    Screen.Cursor := crHourGlass;
    try
      for i := 0 to 9 do
        for j := 0 to 9 do
          for k := 0 to 9 do
            for l := 0 to 9 do begin
              with Table do
              begin
                Append;
                id := l + k*10 + j* 100 + i * 1000;
                parent := k + j* 10 + i * 100 - 1;
                FieldByName('Dirid').AsInteger := id;
                FieldByName('parentId').AsInteger := parent;
                FieldByName('DirName').AsString := 'TreeNode item No ' + IntToStr(id) + ' parent No ' + IntToStr(Parent);
                Post;
              end;
            end;
    finally
      Table.EnableControls;
      Screen.Cursor := crDefault;
    end;
  end;

  with Table do
  begin
    IndexFieldNames := 'DiriD';
    Last;
    result := FindField('Dirid').AsInteger;
    IndexFieldNames := 'ParentID';
    First;
  end;
end;

procedure TForm1.OpenDirTable;
begin
  with table1 do
  begin
    open;
    last;
    DCDataSetSource1.MaxKeyFieldValue := FieldByName('DirId').Asinteger+1;
    first;
  end;
  if DataSource1.Dataset <> table1 then
    DataSource1.Dataset := table1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  firsttime := true;
  OpenDirTable;
  ImageList1.ResourceLoad(rtBitmap,'IMAGES',clSilver);
  DCResViewSource1.FileName := ParamStr(0);
  Table1.Active:=True;
end;

procedure TForm1.AddButClick(Sender: TObject);
begin
  with DcTreeView1 ,Items do
    Items.Add(Selected,'New Item');
  with DCListView1,Items do
    RefreshList(Root);
end;

procedure TForm1.AddChildButClick(Sender: TObject);
begin
  with DcTreeView1 ,Items do
    if Selected <> nil then
      Items.AddChild(Selected,'New SubItem');
end;

procedure TForm1.DeleteButClick(Sender: TObject);
begin
  DcTreeView1.DeleteSelectedItems;
end;

procedure TForm1.RefButClick(Sender: TObject);
begin
  DcTreeView1.RefreshTree;
end;

procedure TForm1.DCListView1DblClick(Sender: TObject);
begin
  DCListView1.Items.GetNextLevel;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if not CheckBox1.Checked then
  begin
    DcTreeView1.Options := DcTreeView1.Options + [toCanNavigate];
    DcListView1.Options := DcListView1.Options - [loShowSubItems];
  end
  else
  begin
    DcTreeView1.Options := DcTreeView1.Options - [toCanNavigate];
    DcListView1.Options := DcListView1.Options + [loShowSubItems];
  end;
end;

procedure TForm1.DCTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  with DCTreeView1 do
  begin
    SetEnabledControls([AddChildBut, EditBut, DeleteBut],  Selected <> nil);
    MoveUpBut.Enabled := (Selected <> nil)  and (Selected.Parent <> nil);
  end;
end;

procedure TForm1.EdFieldButClick(Sender: TObject);
begin
  EditDatasetFields(Table1);
end;

procedure TForm1.EdColButClick(Sender: TObject);
begin
  CallPropertyEdit(DbGrid1,'Columns');
end;

procedure TForm1.EditButClick(Sender: TObject);
begin
  if DcTreeView1.Selected <> nil then
  begin
    DcTreeView1.SetFocus;
    DcTreeView1.Selected.EditText;
  end;
end;

procedure TForm1.BigTableButClick(Sender: TObject);
begin
  if firsttime then
    if Messagedlg('Create table with 10000 records and show in TreeView?',mtConfirmation,[mbYes,mbNo],0) <> idYes then
      exit;
  SetSources(DCDataSetSource1);
  DCDataSetSource1.MaxKeyFieldValue := FillTable(Table2,firsttime) + 1;
  if DataSource1.Dataset <> Table2  then
    DataSource1.Dataset := Table2;
  firsttime := false;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if not firsttime then
  begin
    Table2.Close;
    Table2.DeleteTable;
  end;
end;

procedure TForm1.DirTableButClick(Sender: TObject);
begin
  SetSources(DCDataSetSource1);
  OpenDirTable;
end;

procedure TForm1.MoveUpButClick(Sender: TObject);
begin
  with DcTreeView1 do
    if (Selected <> nil) and (Selected.Parent <> nil) then
       TDCTreeNode(Selected).MoveTo(Selected.Parent,naAdd);
end;

procedure TForm1.NilButClick(Sender: TObject);
begin
  SetSources(DCDataSetSource1);
  DataSource1.Dataset := nil;
end;

procedure TForm1.SetSources(ASource: TTreeSource);
begin
  DCListView1.Source := ASource;
  DCTreeView1.Source := ASource;
end;

procedure TForm1.ResourceButClick(Sender: TObject);
begin
  SetSources(DCResViewSource1);
  DataSource1.Dataset := nil;
end;

procedure TForm1.SettoMenuSource1Click(Sender: TObject);
begin
  SetSources(DCMenuSource1);
  DataSource1.Dataset := nil;
end;

procedure TForm1.CheckChild1Click(Sender: TObject);
begin
  DCPropCheckBox1.Checked := not DCPropCheckBox1.Checked;
end;

procedure TForm1.ExplorerStyle1Click(Sender: TObject);
begin
  CheckBox1.Checked := not CheckBox1.Checked;
end;

procedure TForm1.Help1Click(Sender: TObject);
begin
  showmessage('DB Tree Demo '#13#10'Copyright (c) 1998 Dream Company');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;


end.
