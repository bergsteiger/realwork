unit fillandstroke;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_layouts, vg_objects, vg_controls;

type
  TForm11 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Ellipse1: TvgEllipse;
    Rectangle1: TvgRectangle;
    Path1: TvgPath;
    TrackBar1: TvgTrackBar;
    Label1: TvgLabel;
    PopupBox1: TvgPopupBox;
    PopupBox2: TvgPopupBox;
    Label2: TvgLabel;
    Label3: TvgLabel;
    PopupBox3: TvgPopupBox;
    Label4: TvgLabel;
    Text1: TvgText;
    PopupBox4: TvgPopupBox;
    Label5: TvgLabel;
    ModernStyle: TvgResources;
    VistaStyle: TvgResources;
    Label6: TvgLabel;
    StyleBox: TvgPopupBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure PopupBox1Change(Sender: TObject);
    procedure PopupBox2Change(Sender: TObject);
    procedure PopupBox3Change(Sender: TObject);
    procedure Rectangle1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure PopupBox4Change(Sender: TObject);
    procedure StyleBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses vg_dsgn;

{$R *.dfm}

procedure TForm11.TrackBar1Change(Sender: TObject);
begin
  Ellipse1.StrokeThickness := TrackBar1.Value;
  Rectangle1.StrokeThickness := TrackBar1.Value;
  Path1.StrokeThickness := TrackBar1.Value;
end;

procedure TForm11.PopupBox1Change(Sender: TObject);
begin
  Ellipse1.StrokeCap := TvgStrokeCap(PopupBox1.ItemIndex);
  Rectangle1.StrokeCap := TvgStrokeCap(PopupBox1.ItemIndex);
  Path1.StrokeCap := TvgStrokeCap(PopupBox1.ItemIndex);
end;

procedure TForm11.PopupBox2Change(Sender: TObject);
begin
  Ellipse1.StrokeDash := TvgStrokeDash(PopupBox2.ItemIndex);
  Rectangle1.StrokeDash := TvgStrokeDash(PopupBox2.ItemIndex);
  Path1.StrokeDash := TvgStrokeDash(PopupBox2.ItemIndex);
end;

procedure TForm11.PopupBox3Change(Sender: TObject);
begin
  Ellipse1.StrokeJoin := TvgStrokeJoin(PopupBox3.ItemIndex);
  Rectangle1.StrokeJoin := TvgStrokeJoin(PopupBox3.ItemIndex);
  Path1.StrokeJoin := TvgStrokeJoin(PopupBox3.ItemIndex);
end;

procedure TForm11.Rectangle1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  { }
  SelectInDesign(Rectangle1.Fill, Rectangle1);
end;

procedure TForm11.PopupBox4Change(Sender: TObject);
begin
  Root1.Scale.x := StrToInt(Copy(PopupBox4.Text, 1, Length(PopupBox4.Text) - 1)) / 100;
  Root1.Scale.y := StrToInt(Copy(PopupBox4.Text, 1, Length(PopupBox4.Text) - 1)) / 100;
  vgScene1.RealignRoot;
end;

procedure TForm11.StyleBoxChange(Sender: TObject);
begin
  case StyleBox.ItemIndex of
    0: vgScene1.Style := nil;
    1: vgScene1.Style := ModernStyle;
    2: vgScene1.Style := VistaStyle;
  end;
end;

end.
