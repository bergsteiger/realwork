unit designform;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_effects, vg_objects, vg_controls, vg_layouts,
  vg_listbox, vg_treeview, vg_inspector;

type
  TfrmDesigner = class(TForm)
    vgSceneDesigner: TvgScene;
    DesignerRoot: TvgBackground;
    vgToolbar: TvgScene;
    Root2: TvgBackground;
    Rectangle1: TvgRectangle;
    Label1: TvgLabel;
    EditorStore: TvgRectangle;
    Ellipse1: TvgEllipse;
    Label2: TvgLabel;
    SpeedButton1: TvgSpeedButton;
    SpeedButton2: TvgSpeedButton;
    SpeedButton3: TvgSpeedButton;
    PopupBox1: TvgPopupBox;
    PopupBox2: TvgPopupBox;
    PopupBox3: TvgPopupBox;
    TrackBar1: TvgTrackBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Image1: TvgImage;
    CheckBox1: TvgCheckBox;
    Line1: TvgLine;
    vgSceneInspector: TvgScene;
    Root1: TvgLayout;
    Inspector1: TvgInspector;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure PopupBox1Change(Sender: TObject);
    procedure PopupBox2Change(Sender: TObject);
    procedure PopupBox3Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    { Private declarations }
    procedure DoChangeSelected(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmDesigner: TfrmDesigner;

implementation

uses vg_dsgn;

{$R *.dfm}

procedure TfrmDesigner.FormCreate(Sender: TObject);
begin
  // Set this property at run-time - enable design feature
  vgSceneDesigner.DesignTime := true;
  vgSceneDesigner.DesignChangeSelection := DoChangeSelected;
end;

procedure TfrmDesigner.SpeedButton3Click(Sender: TObject);
begin
  // Edit selected object Fill and Stroke
  if vgSceneDesigner.Selected is TvgShape then
  begin
    SelectInDesign(TvgShape(vgSceneDesigner.Selected).Fill, vgSceneDesigner.Selected);
  end;
end;

procedure TfrmDesigner.PopupBox1Change(Sender: TObject);
begin
  if not (vgSceneDesigner.Selected is TvgShape) then Exit;
  TvgShape(vgSceneDesigner.Selected).StrokeDash := TvgStrokeDash(PopupBox1.ItemIndex);
end;

procedure TfrmDesigner.PopupBox2Change(Sender: TObject);
begin
  if not (vgSceneDesigner.Selected is TvgShape) then Exit;
  TvgShape(vgSceneDesigner.Selected).StrokeCap := TvgStrokeCap(PopupBox2.ItemIndex);
end;

procedure TfrmDesigner.PopupBox3Change(Sender: TObject);
begin
  if not (vgSceneDesigner.Selected is TvgShape) then Exit;
  TvgShape(vgSceneDesigner.Selected).StrokeJoin := TvgStrokeJoin(PopupBox3.ItemIndex);
end;

procedure TfrmDesigner.TrackBar1Change(Sender: TObject);
begin
  if not (vgSceneDesigner.Selected is TvgShape) then Exit;
  TvgShape(vgSceneDesigner.Selected).StrokeThickness := TrackBar1.Value;
end;

procedure TfrmDesigner.SpeedButton1Click(Sender: TObject);
var
  S: TStream;
begin
  if OpenDialog1.Execute then
  begin
    S := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      EditorStore.DeleteChildren;
      EditorStore.LoadFromStream(S);
    finally
      S.Free;
    end;
  end;
end;

procedure TfrmDesigner.SpeedButton2Click(Sender: TObject);
var
  S: TStream;
begin
  SaveDialog1.FileName := OpenDialog1.FileName;
  if SaveDialog1.Execute then
  begin
    S := TFileStream.Create(SaveDialog1.FileName, fmCreate);
    try
      EditorStore.SaveToStream(S);
    finally
      S.Free;
    end;
  end;
end;

procedure TfrmDesigner.CheckBox1Change(Sender: TObject);
begin
  vgSceneDesigner.DesignPopupEnabled := CheckBox1.IsChecked;
end;

procedure TfrmDesigner.DoChangeSelected(Sender: TObject);
begin
  Inspector1.SelectedObject := vgSceneDesigner.Selected;
end;

end.
