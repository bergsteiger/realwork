unit test1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, jpeg, ExtCtrls, FileCtrl, ComCtrls, Menus, Printers;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Panel3: TPanel;
    DriveComboBox1: TDriveComboBox;
    Scale: TComboBox;
    PixelFormat: TComboBox;
    ColorSpace: TComboBox;
    Performance: TComboBox;
    ProgressiveDisplay: TCheckBox;
    IncrementalDisplay: TCheckBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    PrinterSetup1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    procedure FileListBox1DblClick(Sender: TObject);
    procedure SetJPEGOptions(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProgressUpdate(Sender: TObject; Stage: TProgressStage;
      PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
    procedure Open1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure PrinterSetup1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenFile(const Filename: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.OpenFile(const Filename: string);
begin
  try
    Image1.Picture.LoadFromFile(Filename);
  except
    on EInvalidGraphic do
      Image1.Picture.Graphic := nil;
  end;
  SetJPEGOptions(self);
end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
  OpenFile(FileListbox1.Filename);
end;

procedure TForm1.SetJPEGOptions(Sender: TObject);
var
  Temp: Boolean;
begin
  Temp := Image1.Picture.Graphic is TJPEGImage;
  if Temp then
    with TJPEGImage(Image1.Picture.Graphic) do
    begin
      PixelFormat := TJPEGPixelFormat(Self.PixelFormat.ItemIndex);
      Scale := TJPEGScale(Self.Scale.ItemIndex);
      Grayscale := Boolean(Colorspace.ItemIndex);
      Performance := TJPEGPerformance(Self.Performance.ItemIndex);
      ProgressiveDisplay := Self.ProgressiveDisplay.Checked;
    end;
  Scale.Enabled := Temp;
  PixelFormat.Enabled := Temp;
  Colorspace.Enabled := Temp;
  Performance.Enabled := Temp;
  ProgressiveDisplay.Enabled := Temp
    and TJPEGImage(Image1.Picture.Graphic).ProgressiveEncoding;
  Image1.IncrementalDisplay := IncrementalDisplay.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Scale.ItemIndex := 0;
  PixelFormat.ItemIndex := 0;
  Colorspace.ItemIndex := 0;
  Performance.ItemIndex := 0;
  OpenDialog1.Filter := GraphicFilter(TGraphic);
  FileListbox1.Mask := GraphicFileMask(TGraphic);
  Image1.OnProgress := ProgressUpdate;
end;

procedure TForm1.ProgressUpdate(Sender: TObject; Stage: TProgressStage;
  PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string);
begin
  if Stage = psRunning then
    Caption := Format('%d%%',[PercentDone])
  else
    Caption := 'Form1';
end;


procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    OpenFile(OpenDialog1.FileName);
end;

procedure TForm1.Print1Click(Sender: TObject);
var
  AspectRatio: Single;
  OutputWidth, OutputHeight: Single;
begin
  if not PrintDialog1.Execute then Exit;
  Printer.BeginDoc;
  try
    OutputWidth := Image1.Picture.Width;
    OutputHeight := Image1.Picture.Height;
    AspectRatio := OutputWidth / OutputHeight;
    if (OutputWidth < Printer.PageWidth) and
      (OutputHeight < Printer.PageHeight) then
    begin
      if OutputWidth < OutputHeight then
      begin
        OutputHeight := Printer.PageHeight;
        OutputWidth := OutputHeight * AspectRatio;
      end
      else
      begin
        OutputWidth := Printer.PageWidth;
        OutputHeight := OutputWidth / AspectRatio;
      end
    end;
    if OutputWidth > Printer.PageWidth then
    begin
      OutputWidth := Printer.PageWidth;
      OutputHeight := OutputWidth / AspectRatio;
    end;
    if OutputHeight > Printer.PageHeight then
    begin
      OutputHeight := Printer.PageHeight;
      OutputWidth := OutputHeight * AspectRatio;
    end;
    Printer.Canvas.StretchDraw(Rect(0,0,
      Integer(Trunc(OutputWidth)), Integer(Trunc(OutputHeight))),
      Image1.Picture.Graphic);
  finally
    Printer.EndDoc;
  end;
end;

procedure TForm1.PrinterSetup1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

end.

