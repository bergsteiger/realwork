unit syneditfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_controls, vg_synedit, StdCtrls, SynEditHighlighter,
  SynHighlighterPas, SynEdit, ActnList, vg_layouts, ShellAPI;

type
  TfrmSynEdit = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    ToolBar1: TvgToolBar;
    StatusBar1: TvgStatusBar;
    SynPasSyn1: TSynPasSyn;
    vgResources1: TvgResources;
    ToolButton1: TvgToolButton;
    OpenDialog1: TOpenDialog;
    SynEdit1: TvgSynEdit;
    CheckBox1: TvgCheckBox;
    Label1: TvgLabel;
    TrackBar1: TvgTrackBar;
    procedure ToolButton1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSynEdit: TfrmSynEdit;

implementation

{$R *.dfm}

procedure TfrmSynEdit.ToolButton1Click(Sender: TObject);
begin
  OpenDialog1.Filter := SynPasSyn1.DefaultFilter;
  if OpenDialog1.Execute then
  begin
    SynEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TfrmSynEdit.CheckBox1Change(Sender: TObject);
begin
  SynEdit1.Gutter.ShowLinenumbers := CheckBox1.IsChecked;
end;

procedure TfrmSynEdit.Label1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PAnsiChar('http://mh-nexus.de/en/unisynedit.php'), nil, nil, 1)
end;

procedure TfrmSynEdit.TrackBar1Change(Sender: TObject);
begin
  SynEdit1.Opacity := TrackBar1.Value;
end;

end.
