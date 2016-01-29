unit Unit1;

interface

uses
  Windows, Messages, SysUtils, {$ifdef VER150}Variants,{$endif}{$ifdef VER140}Variants,{$endif} 
  Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ElXPThemedControl, ElTree, ElDBTree, ElPopBtn,
  ElToolBar, ElDBCtrls, ElPanel, ExtCtrls, ElSplit, ElPgCtl, DB, DBTables,
  ElStatBar, ElDBTreeGrids;

type
  TForm1 = class(TForm)
    ElStatusBar1: TElStatusBar;
    ElPanel1: TElPanel;
    SelfReference: TElRelDataSource;
    TableTree: TTable;
    TableTreeDIRNAME: TStringField;
    TableTreeDIRID: TFloatField;
    TableTreePARENTID: TFloatField;
    TableTreeIMAGEINDEX: TFloatField;
    TableTreeSELECTEDIN: TFloatField;
    TableTreeSTATEINDEX: TFloatField;
    Bevel1: TBevel;
    Filer: TElDBTreeStringGrid;
    procedure FilerResize(Sender: TObject);
    procedure FilerStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FilerDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FilerDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    FDragItem: TElDBTreeItem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TElDragObject = class (TDragControlObject)
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

function TElDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Control is TElTree then
  begin
    if ((Control as TElDBTree).GetItemAtY(Y) <> nil) or (Accepted) then
       Result := (Control as TElDBTree).DragCursor
    else
       Result := crNoDrop;
  end
  else
    Result := inherited GetDragCursor(Accepted,X,Y);
end;

procedure TForm1.FilerResize(Sender: TObject);
begin
  Filer.HeaderSections.Item[1].Width := 50;
  Filer.HeaderSections.Item[0].Width := Filer.Width - 50;
  if Filer.VertScrollBarVisible then
    Filer.HeaderSections.Item[0].Width := Filer.HeaderSections.Item[0].Width - Filer.VertScrollBarStyles.Width;
end;

procedure TForm1.FilerStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragItem := Filer.ItemFocused;
  DragObject := TElDragObject.Create(Filer);
end;

procedure TForm1.FilerDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Temp: TElDBTreeItem;
begin
  Accept := false;
  if Source.ClassType <> TElDragObject then
    exit;
  Temp := Filer.GetItemAtY(Y);
  if Temp = nil then
  begin
    Accept := true;
    exit;
  end;
  TableTree.GotoBookmark(Temp.Bookmark);
  if (TableTree.FieldByName('IMAGEINDEX').AsInteger = 1) then
    Accept := true;
end;

procedure TForm1.FilerDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  Temp: TElDBTreeItem;
  id: integer;
begin
  Temp := Filer.GetItemAtY(Y);
  if ((Temp <> nil) and (not Temp.IsUnder(FDragItem))) then
  begin
    FDragItem.MoveToIns(Temp, Temp.Index + 1);
    TableTree.GotoBookmark(Temp.Bookmark);
    id := TableTree.FieldByName('DIRID').AsInteger;

    TableTree.GotoBookmark(FDragItem.Bookmark);
    TableTree.DisableControls;
    TableTree.Edit;
    TableTree.FieldByName('PARENTID').AsInteger := id;
    TableTree.Post;
    TableTree.EnableControls;
  end;
  Filer.RebuildTree(True);
  FDragItem := nil;
end;

end.
