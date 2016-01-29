unit tablefrm;

interface                                      

uses
  Classes, Forms, Buttons, SysUtils,
  vg_grid, vg_layouts, vg_scene, Controls,
  vg_controls,
  ImgList, vg_actions,
  Grids;

type
  TfrmTableDemo = class(TForm)
    vgScene1: TvgScene;                          
    Root1: TvgBackground;
    Table1: TvgGrid;
    Column1: TvgColumn;
    CheckColumn1: TvgCheckColumn;
    ProgressColumn1: TvgProgressColumn;
    Column2: TvgColumn;
    PopupColumn1: TvgPopupColumn;
    ToolBar1: TvgToolBar;
    ImageColumn1: TvgImageColumn;
    vgImageList1: TvgImageList;
    procedure Table1GetValue(Sender: TObject; const Col, Row: Integer;
      var Value: Variant);
    procedure Table1SetValue(Sender: TObject; const Col, Row: Integer;
      const Value: Variant);
    procedure Table1EdititingDone(Sender: TObject; const Col,
      Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Data: array of array of Variant;
    procedure CreateData;
  end;

var
  frmTableDemo: TfrmTableDemo;

implementation

{$R *.dfm}

{ TfrmTableDemo }

procedure TfrmTableDemo.Table1GetValue(Sender: TObject; const Col, Row: Integer;
  var Value: Variant);
begin
  if Length(Data) = 0 then
  begin
    // Init Data arrays
    CreateData;
  end;
  // we not use Col - because Col return Column - but Column may realigned
  Value := Data[Table1.Columns[Col].Tag][Row];
end;

procedure TfrmTableDemo.Table1SetValue(Sender: TObject; const Col, Row: Integer;
  const Value: Variant);
begin
  // we not use Col - because Col return Column - but Column may realigned
  Data[Table1.Columns[Col].Tag][Row] := Value;
end;

procedure TfrmTableDemo.CreateData;
var
  i: integer;
begin
  // set table row count
  Table1.RowCount := 300;
  // set column Tag - this is real index - because Column may realign
  for i := 0 to Table1.ColumnCount - 1 do
    Table1.Columns[i].Tag := i;
  // create array
  SetLength(Data, Table1.ColumnCount);
  for i := 0 to High(Data) do
  begin
    SetLength(Data[i], Table1.RowCount);
  end;
  // Initialize Data
  // 0 Column - text
  for i := 0 to Table1.RowCount - 1 do
    Data[0][i] := 'text cell ' + IntToStr(i);
  // 1 Column - check
  for i := 0 to Table1.RowCount - 1 do
    Data[1][i] := random(3) = 2;
  // 2 Column - progress
  for i := 0 to Table1.RowCount - 1 do
    Data[2][i] := random(100);
  // 3 Column - text
  for i := 0 to Table1.RowCount - 1 do
    Data[3][i] := 'second text ' + IntToStr(i);
  // 4 Column - popup
  for i := 0 to Table1.RowCount - 1 do
    Data[4][i] := PopupColumn1.Items[random(PopupColumn1.Items.Count)];
  // 5 Column - image
  for i := 0 to Table1.RowCount - 1 do
    Data[5][i] := ObjectToVariant(vgImageList1.Images[random(vgImageList1.Count)]);
end;

procedure TfrmTableDemo.Table1EdititingDone(Sender: TObject; const Col,
  Row: Integer);
begin
  Caption := 'Cell ' + IntToStr(Col) + ':' + IntToStr(Row) + ' was changed';
end;

end.


