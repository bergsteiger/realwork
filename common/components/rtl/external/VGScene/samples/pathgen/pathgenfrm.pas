unit pathgenfrm;

interface

uses
  {$IFDEF FPC}
  LResources,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vg_scene, vg_controls, vg_listbox, vg_objects, vg_textbox, vg_memo,
  vg_layouts;

type
  TForm16 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    HudButton1: TvgHudButton;
    charMap: TvgHudListBox;
    PathData: TvgHudMemo;
    FontDialog1: TFontDialog;
    labelSample: TvgLabel;
    samplePath: TvgPath;
    HudButton2: TvgHudButton;
    procedure HudButton1Click(Sender: TObject);
    procedure charMapChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HudButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BuildList;
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm} 

procedure TForm16.BuildList;
var
  c: integer;
  ch: WideString;
  item: TvgListBoxItem;
  vgpath: TvgPath;
  i: integer;
begin
  charMap.Clear;
  for c := 33 to 255 do
  begin
    item := TvgListBoxItem.Create(Self);
    item.Parent := charMap;
    vgpath := TvgPath.Create(Self);
    vgpath.Parent := item;
    vgpath.Align := vaClient;
    vgpath.Padding.Rect := vgRect(4,4,4,4);
    vgpath.HitTest := false;
    vgpath.Stroke.Style := vgBrushNone;
    vgpath.WrapMode := vgPathFit;
    item.TagObject := vgpath;
    ch := WideChar(c);

    vgScene1.Canvas.Font.Family:= labelSample.Text;
    vgScene1.Canvas.TextToPath(vgpath.Data, vgRect(0, 0, 64, 64), ch, false, vgTextAlignCenter, vgTextAlignCenter);
    vgpath.Data.Scale(10, 10);
  end;
end;

procedure TForm16.HudButton1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    labelSample.Text := FontDialog1.Font.Name;
    BuildList;
  end;
end;

procedure TForm16.charMapChange(Sender: TObject);
begin
  if charMap.Selected <> nil then
  begin
    PathData.Lines.Text := TvgPath(charMap.Selected.TagObject).Data.Data;
    samplePath.Data.Assign(TvgPath(charMap.Selected.TagObject).Data);
  end;
end;

procedure TForm16.FormCreate(Sender: TObject);
begin
  BuildList;
end;

procedure TForm16.HudButton2Click(Sender: TObject);
begin
  PathData.SelectAll;
  PathData.CopyToClipboard;
end;

end.
