unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  {$ifdef VER150}Variants,{$endif}{$ifdef VER140}Variants,{$endif} 
  Dialogs, Grids, DBGrids, DBCtrls, ElPopBtn, ElToolBar, ElDBCtrls,
  ExtCtrls, ElPanel, DB, DBTables;

type
  TfrmMain = class(TForm)
    db: TDatabase;
    tbl: TTable;
    src_tbl: TDataSource;
    ElDBNavigator1: TElDBNavigator;
    ElDBNavButton1: TElDBNavButton;
    ElDBNavButton2: TElDBNavButton;
    ElDBNavButton3: TElDBNavButton;
    ElDBNavButton4: TElDBNavButton;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    ElDBNavButton5: TElDBNavButton;
    ElDBNavButton6: TElDBNavButton;
    ElDBNavButton7: TElDBNavButton;
    ElDBNavButton8: TElDBNavButton;
    ElDBNavButton9: TElDBNavButton;
    ElDBNavButton10: TElDBNavButton;
    ElDBNavButton11: TElDBNavButton;
    ElDBNavButton12: TElDBNavButton;
    ElDBNavButton13: TElDBNavButton;
    ElDBNavButton14: TElDBNavButton;
    ElDBNavButton15: TElDBNavButton;
    ElDBNavButton16: TElDBNavButton;
    ElDBNavButton17: TElDBNavButton;
    ElDBNavButton18: TElDBNavButton;
    ElDBNavButton19: TElDBNavButton;
    ElDBNavButton20: TElDBNavButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

// User defined default hints for Button Role: "nbrFirst"
resourcestring
 rs_ElDBNavButton_First_Hiht = 'go to First Record';

procedure TfrmMain.FormCreate(Sender: TObject);
begin
   if not tbl.Active
     then tbl.Open;
end;

initialization
// Load reference to User hints for Button Role "nbrFirst" into Hints Array:
  ElDBNavButtonsHint[nbrFirst] := @rs_ElDBNavButton_First_Hiht;
end.
