unit mousefrm;

interface

uses
  {$IFNDEF FPC}Windows, {$ELSE}LResources, {$ENDIF} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vg_scene, vg_objects, vg_controls, vg_effects, vg_layouts;

type
  TForm10 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Image1: TvgImage;
    Label1: TvgLabel;
    Layout1: TvgLayout;
    Text1: TvgText;
    ShadowEffect1: TvgShadowEffect;
    Ellipse1: TvgEllipse;
    Text2: TvgText;
    procedure FormCreate(Sender: TObject);
    procedure Layout1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Layout1MouseMove(Sender: TObject; Shift: TShiftState; X, Y,
      Dx, Dy: Single);
    procedure Layout1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Ellipse1MouseEnter(Sender: TObject);
    procedure Ellipse1MouseLeave(Sender: TObject);
  private
    { Private declarations }
    Down: boolean;
    DownPos: TvgPoint;
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.FormCreate(Sender: TObject);
begin
  Layout1.AutoCapture := true; // Set AutoCapture to true - for get mouse events whene mouse not over control
end;

procedure TForm10.Layout1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = mbLeft then
  begin
    DownPos := vgPoint(X, Y);
    Down := true;
  end;
end;

procedure TForm10.Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y, Dx, Dy: Single);
begin
  if Down then
  begin
    TvgVisualObject(Sender).Position.X := TvgVisualObject(Sender).Position.X + (X - DownPos.X);
    TvgVisualObject(Sender).Position.Y := TvgVisualObject(Sender).Position.Y + (Y - DownPos.Y);
  end;
end;

procedure TForm10.Layout1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  Down := false;
end;

procedure TForm10.Ellipse1MouseEnter(Sender: TObject);
begin
  Text2.Text := 'Mouse Enter';
end;

procedure TForm10.Ellipse1MouseLeave(Sender: TObject);
begin
  Text2.Text := 'Mouse Leave';
end;

end.
