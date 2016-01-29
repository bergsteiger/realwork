unit multilangfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_controls, vg_scene, vg_dsgn_lang, vg_layouts,
  vg_listbox, vg_objects, AppEvnts, StdCtrls;

type
  TfrmMultilang = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    vgLang1: TvgLang;
    Button1: TvgButton;
    ToolBar1: TvgToolBar;
    HudButton1: TvgHudButton;
    HudLabel1: TvgHudLabel;
    HudRoundButton1: TvgHudRoundButton;
    Label1: TvgLabel;
    HudCheckBox1: TvgHudCheckBox;
    StringListBox1: TvgStringListBox;
    Label2: TvgLabel;
    Label3: TvgLabel;
    Label4: TvgLabel;
    StringListBox2: TvgStringListBox;
    StatusBar1: TvgStatusBar;
    Label5: TvgLabel;
    ApplicationEvents1: TApplicationEvents;
    procedure Button1Click(Sender: TObject);
    procedure HudRoundButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringListBox1Change(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMultilang: TfrmMultilang;

implementation

{$R *.dfm}

procedure TfrmMultilang.Button1Click(Sender: TObject);
begin
  MessagePopup(Translate('Caption'),
    Translate('This is a message text.'),
    vgMessageInformation,
    [vgButtonOK, vgButtonCancel], vgScene1, Toolbar1);
end;

procedure TfrmMultilang.HudRoundButton1Click(Sender: TObject);
begin
  ShowDsgnLang(vgLang1);
end;

procedure TfrmMultilang.FormCreate(Sender: TObject);
begin
  StringListBox1.Items.Assign(vgLang1.Resources);
  StringListBox1.Items.Insert(0, 'en');
  StringListBox1.ItemIndex := StringListBox1.Items.IndexOf(vgLang1.Lang);
end;

procedure TfrmMultilang.StringListBox1Change(Sender: TObject);
begin
  if StringListBox1.Selected <> nil then
    vgLang1.Lang := StringListBox1.Selected.Text;
end;

procedure TfrmMultilang.ApplicationEvents1Hint(Sender: TObject);
begin
  Label5.Text := Application.Hint;
end;

end.
