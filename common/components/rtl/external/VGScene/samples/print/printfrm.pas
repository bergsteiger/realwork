unit printfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Printers, vg_controls, vg_scene, vg_objects;

type
  TForm3 = class(TForm)
    vgScene1: TvgScene;
    Root1: TvgBackground;
    Button1: TvgButton;
    PrintDialog1: TPrintDialog;
    PrintArea: TvgRectangle;
    Ellipse1: TvgEllipse;
    Path1: TvgPath;
    RadioButton1: TvgRadioButton;
    RadioButton2: TvgRadioButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  Prn: TvgCanvas;
begin
  if PrintDialog1.Execute then
  begin
    Printer.BeginDoc;
    // create VGScene Printer canvas
    if Assigned(DefaultPrinterCanvasClass) then
    begin
      // create PrinterCanvas
      Prn := DefaultPrinterCanvasClass.CreateFromVCL(Printer.Canvas, Printer.PageWidth, Printer.PageHeight);
      if RadioButton2.IsChecked then
      begin
        // draw on printer canvas using VGScene
        Prn.Fill.Style := vgBrushGradient;
        Prn.FillRect(vgRect(10, 10, 200, 200), 20, 20, AllCorners, 1);
        Prn.StrokeThickness := 3;
        Prn.Stroke.Style := vgBrushSolid;
        Prn.DrawRect(vgRect(10, 10, 200, 200), 20, 20, AllCorners, 1);
      end;
      if RadioButton1.IsChecked then
      begin
        // draw VGScene control - not all controls can be printed - because some control use cliprects - not supported by printer
        PrintArea.PaintTo(Prn, PrintArea.LocalRect);
      end;
      //
      Prn.Free;
    end;
    // end;
    Printer.EndDoc;
  end;
end;

end.
