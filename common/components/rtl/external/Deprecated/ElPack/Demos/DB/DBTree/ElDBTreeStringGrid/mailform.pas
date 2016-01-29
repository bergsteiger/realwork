unit mailform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, ExtCtrls, DBCtrls, 
  {$ifdef VER150}Variants,{$endif}{$ifdef VER140}Variants,{$endif} 
  ElXPThemedControl, ElTree, ImgList, ElPrinter, ElBtnCtl,
  ElPopBtn, ElTreePrinter, StdCtrls, ElDBTree, ElDBTreeGrids, ElToolbar,
  ElDBCtrls, ElPanel, ElSplit, ElStatBar;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    Panel3: TPanel;
    breeders: TTable;
    ElRelDataSource1: TElRelDataSource;
    Query1: TQuery;
    breederssexx: TIntegerField;
    ImageList1: TImageList;
    breed: TTable;
    DataSource2: TDataSource;
    breedersBreed: TStringField;
    breed_detale: TTable;
    DataSource3: TDataSource;
    breedID: TAutoIncField;
    breedBreed: TStringField;
    breedNotes: TMemoField;
    breedGraphic: TGraphicField;
    Query1breederID: TFloatField;
    Query1Id: TFloatField;
    Query1sex: TStringField;
    Query1dob: TDateField;
    Query1brId: TSmallintField;
    breedersBREEDERID: TFloatField;
    breedersNAME: TStringField;
    breedersDADID: TFloatField;
    breedersMOMID: TFloatField;
    breedersSEX: TStringField;
    breedersDOB: TDateField;
    breedersHEIGHT: TFloatField;
    breedersWEIGHT: TFloatField;
    breedersCHAMP: TFloatField;
    breedersAWARDS: TStringField;
    breedersID: TSmallintField;
    Query1name: TStringField;
    Query1sexx: TIntegerField;
    Query1awards: TStringField;
    Query1height: TFloatField;
    Query1weight: TFloatField;
    ElDBTreeStringGrid1: TElDBTreeStringGrid;
    ElPanel1: TElPanel;
    ElDBNavigator1: TElDBNavigator;
    ElDBNavButton1: TElDBNavButton;
    ElDBNavButton2: TElDBNavButton;
    ElDBNavButton3: TElDBNavButton;
    ElDBNavButton4: TElDBNavButton;
    ElPanel2: TElPanel;
    ElPanel3: TElPanel;
    DBGrid1: TDBGrid;
    ElPanel4: TElPanel;
    ElPanel5: TElPanel;
    DBImage1: TDBImage;
    ElPanel6: TElPanel;
    ElStatusBar1: TElStatusBar;
    ElSplitter1: TElSplitter;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure breedersAfterPost(DataSet: TDataSet);
    procedure breedersAfterDelete(DataSet: TDataSet);
    procedure breedersCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Query1CalcFields(DataSet: TDataSet);
    procedure ElDBTreeStringGrid1AfterSelectionChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  ElDBNavigator1.DataSource := DataSource1;
end;

procedure TForm1.breedersAfterPost(DataSet: TDataSet);
begin
  Query1.Close;
  Query1.ExecSQL;
  Query1.Open;
end;

procedure TForm1.breedersAfterDelete(DataSet: TDataSet);
begin
  Query1.Close;
  Query1.ExecSQL;
  Query1.Open;
end;

procedure TForm1.breedersCalcFields(DataSet: TDataSet);
begin
  if breederssex.asString = 'Male' then
      breederssexx.AsInteger := 0;
  if breederssex.asString = 'Female' then
      breederssexx.AsInteger := 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageList1.ResourceLoad(rtBitmap, 'IMAGES', clSilver);
  ElDBTreeStringGrid1.AutoSizeColumn(0);
end;

procedure TForm1.Query1CalcFields(DataSet: TDataSet);
begin
  if Query1sex.asString = 'Male' then
      Query1sexx.AsInteger := 0;
  if Query1sex.asString = 'Female' then
      Query1sexx.AsInteger := 1;
end;

procedure TForm1.ElDBTreeStringGrid1AfterSelectionChange(Sender: TObject);
begin
  breeders.Locate('breederID',Query1breederID.AsInteger,[]);
end;

end.
