unit adveffectsfrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, StdCtrls, vg_ani, vg_effects,
  vg_controls, vg_layouts, vg_listbox, 
  vg_tabcontrol;

type
  TfrmAdvEffects = class(TForm)
    vgScene1: TvgScene;
    VectorImageRoot: TvgBackground;
    vgResources1: TvgResources;
    TabControl1: TvgTabControl;
    TabItem1: TvgTabItem;
    Layout1: TvgLayout;
    TabItem2: TvgTabItem;
    Layout2: TvgLayout;
    ReflectionEffect1: TvgReflectionEffect;
    GlowEffect1: TvgGlowEffect;
    Image2: TvgImage;
    Text1: TvgText;
    Text3: TvgText;
    TabItem3: TvgTabItem;
    Layout3: TvgLayout;
    TabItem4: TvgTabItem;
    Layout4: TvgLayout;
    Image1: TvgImage;
    Image3: TvgImage;
    Image4: TvgImage;
    GlowEffect2: TvgGlowEffect;
    GlowEffect3: TvgGlowEffect;
    Text2: TvgText;
    Text4: TvgText;
    Text5: TvgText;
    CheckBox1: TvgCheckBox;
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdvEffects: TfrmAdvEffects;

implementation

{$R *.dfm}

procedure TfrmAdvEffects.CheckBox1Change(Sender: TObject);
begin
  TabItem2.Enabled := CheckBox1.IsChecked;
end;

end.
