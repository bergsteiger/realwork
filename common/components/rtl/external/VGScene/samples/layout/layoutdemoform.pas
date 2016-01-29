unit layoutdemoform;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_objects, vg_scene, vg_layouts, vg_controls, vg_tabcontrol,
  ExtCtrls;

type
  TfrmLayout = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    TabControl1: TvgTabControl;
    TabItem1: TvgTabItem;
    Layout1: TvgLayout;
    TabItem2: TvgTabItem;
    Layout2: TvgLayout;
    TabControl2: TvgTabControl;
    TabItem3: TvgTabItem;
    Layout3: TvgLayout;
    TabItem4: TvgTabItem;
    Layout4: TvgLayout;
    Rectangle1: TvgRectangle;
    ScaledLayout1: TvgScaledLayout;
    Rectangle2: TvgRectangle;
    TabItem5: TvgTabItem;
    Layout5: TvgLayout;
    Grid1: TvgGridLayout;
    Rectangle3: TvgRectangle;
    Rectangle4: TvgRectangle;
    Rectangle5: TvgRectangle;
    Rectangle6: TvgRectangle;
    Rectangle7: TvgRectangle;
    Rectangle8: TvgRectangle;
    Rectangle9: TvgRectangle;
    Rectangle10: TvgRectangle;
    Rectangle11: TvgRectangle;
    Rectangle12: TvgRectangle;
    Rectangle13: TvgRectangle;
    Rectangle14: TvgRectangle;
    Rectangle15: TvgRectangle;
    Rectangle16: TvgRectangle;
    Rectangle17: TvgRectangle;
    Rectangle18: TvgRectangle;
    Rectangle19: TvgRectangle;
    Rectangle20: TvgRectangle;
    Rectangle21: TvgRectangle;
    Rectangle22: TvgRectangle;
    TabItem6: TvgTabItem;
    Layout6: TvgLayout;
    Rectangle23: TvgRectangle;
    Label1: TvgLabel;
    NonVGLayout1: TvgNonVGLayout;
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLayout: TfrmLayout;

implementation

{$R *.dfm}

end.
