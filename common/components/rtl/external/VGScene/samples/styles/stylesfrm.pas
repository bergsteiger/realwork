unit stylesfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_textbox, vg_controls, vg_listbox, vg_layouts;

type
  TfrmStyles = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Label1: TvgLabel;
    Button1: TvgButton;
    Resources1: TvgResources;
    SpeedButton1: TvgSpeedButton;
    TextBox1: TvgTextBox;
    ListBox1: TvgListBox;
    ListBoxItem1: TvgListBoxItem;
    ListBoxItem2: TvgListBoxItem;
    ListBoxItem3: TvgListBoxItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStyles: TfrmStyles;

implementation

{$R *.dfm}

end.
