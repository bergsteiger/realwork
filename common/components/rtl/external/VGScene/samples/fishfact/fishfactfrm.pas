unit fishfactfrm;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_dbctrls, vg_grid, vg_layouts, DB, 
  vg_controls, vg_memo, DBTables;

type

  { TfrmFishFact }

  TfrmFishFact = class(TForm)
    Table1: TTable;
    vgScene1: TvgScene;
    Root1: TvgBackground;
    DataSource1: TDataSource;
    Panel1: TvgPanel;
    DBLabel1: TvgDBLabel;
    DBLabel2: TvgDBLabel;
    Layout1: TvgLayout;
    Label1: TvgLabel;
    CircleButton1: TvgCircleButton;
    Panel2: TvgPanel;
    DBNavigator1: TvgDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFishFact: TfrmFishFact;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

end.
