unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, ExtCtrls, Buttons, ComCtrls, FontProcessor,
  TntStdCtrls, GDIPAPI, GDIPOBJ;

type
  TgtGraphics = class(TGPGraphics);

  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Edit1: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    FontDialog1: TFontDialog;
    RadioGroup1: TRadioGroup;
    Label3: TLabel;
    Edit2: TEdit;
    BitBtn2: TBitBtn;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    TntEdit1: TTntEdit;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Edit3: TEdit;
    Edit7: TEdit;
    Image1: TImage;
    RadioGroup2: TRadioGroup;
    Label10: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
      CurX, CurY: Double;
      GraphicsObj: TgtGraphics;
      PenObj: TGPPen;

    { Private declarations }
  public
    procedure DrawCharacter(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
      EvenOddFill: Boolean; ReverseFill: Boolean);
    { Public declarations }
  end;

var
  Form1: TForm1;
  Font1: TFont;


implementation

{$R *.dfm}
var
  lbmp: TBitmap;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Edit1.Text := '';
  if OpenDialog1.Execute then
     Edit1.Text := OpenDialog1.FileName
  else
    exit;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Edit2.Text := '';
  if OpenDialog1.Execute then
     Edit2.Text := OpenDialog1.FileName
  else
    exit;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  LFontStyle: TFontStyles;
begin
  if FontDialog1.Execute then
  begin
  Font1 := TFont.Create;
  Font1.Name :=  FontDialog1.Font.Name;
  Font1.Charset := FontDialog1.Font.Charset;
  Font1.Style :=  FontDialog1.Font.Style;
  Font1.Size :=  FontDialog1.Font.Size;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  LFontProcessor: TgtFontProcessor;
  LErrorCode: ErrorCodes;
begin
  ListBox1.Clear;
  if RadioGroup2.ItemIndex = 0 then
  begin
    if (Edit1.Text = '') then
      Edit1.Text := 'C:\WINDOWS\Fonts\arial.ttf';
    if Edit9.Text = '' then
      Edit9.Text := '1000';
    if Edit10.Text = '' then
      Edit10.Text := '96';
    if Edit11.Text = '' then
      Edit11.Text := '96';
    try
      LFontProcessor := TgtFontProcessor.Create(Edit1.Text, StrToInt(Edit9.Text),
        StrToInt(Edit10.Text), StrToInt(Edit11.Text), LErrorCode);
      //if LErrorCode = Success then
         //LErrorCode := LFontProcessor.InitFace(0);
  if LErrorCode = Success then
  begin
    ListBox1.AddItem('No. of facecounts: ' + IntToStr(LFontProcessor.FaceCount), LFontProcessor);
    ListBox1.AddItem('Family name: ' + LFontProcessor.FamilyName, LFontProcessor);
    ListBox1.AddItem('Postscript name:' + LFontProcessor.PostscriptName, LFontProcessor);
    ListBox1.AddItem('Style name: ' + LFontProcessor.StyleName, LFontProcessor);
    ListBox1.AddItem('Leading: ' + FloatToStr(LFontProcessor.Leading), LFontProcessor);
    ListBox1.AddItem('Ascent :' + FloatToStr(LFontProcessor.Ascent), LFontProcessor);
    ListBox1.AddItem('Descent :' + FloatToStr(LFontProcessor.Descent), LFontProcessor);
    ListBox1.AddItem('UnderScore position :' + FloatToStr(LFontProcessor.UnderscorePosition), LFontProcessor);
    ListBox1.AddItem('UnderscoreSize :' + FloatToStr(LFontProcessor.UnderscoreSize), LFontProcessor);
    ListBox1.AddItem('UnitsPerEm :' + FloatToStr(LFontProcessor.UnitsPerEm), LFontProcessor);
    ListBox1.AddItem('Global BBox :' + FloatToStr(LFontProcessor.GlobalBBox.Left) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Top) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Right) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Bottom), LFontProcessor);
    ListBox1.AddItem('MaxWidth :' + FloatToStr(LFontProcessor.MaxWidth), LFontProcessor);
    ListBox1.AddItem('CapHeight :' + FloatToStr(LFontProcessor.CapHeight), LFontProcessor);
    ListBox1.AddItem('StemV :' + FloatToStr(LFontProcessor.StemV), LFontProcessor);
    ListBox1.AddItem('AvgWidth :' + FloatToStr(LFontProcessor.AvgWidth), LFontProcessor);

//    LFontProcessor.Flag;
  end
  else
    ShowMessage('Could not load the font details');
    finally
      LFontProcessor.Free;
    end;
  end
  else
  begin
    if (Edit8.Text = '') then
      Edit8.Text := 'arial.ttf';
    Font1 := TFont.Create;
    Font1.Name := Edit8.Text;
    Font1.Size := 36;
    try
      LFontProcessor := TgtFontProcessor.Create(Font1, LErrorCode);
      //if LErrorCode = Success then
         //LErrorCode := LFontProcessor.InitFace(0);
  if LErrorCode = Success then
  begin
    ListBox1.AddItem('No. of facecounts: ' + IntToStr(LFontProcessor.FaceCount), LFontProcessor);
    ListBox1.AddItem('Family name: ' + LFontProcessor.FamilyName, LFontProcessor);
    ListBox1.AddItem('Postscript name:' + LFontProcessor.PostscriptName, LFontProcessor);
    ListBox1.AddItem('Style name: ' + LFontProcessor.StyleName, LFontProcessor);
    ListBox1.AddItem('Leading: ' + FloatToStr(LFontProcessor.Leading), LFontProcessor);
    ListBox1.AddItem('Ascent :' + FloatToStr(LFontProcessor.Ascent), LFontProcessor);
    ListBox1.AddItem('Descent :' + FloatToStr(LFontProcessor.Descent), LFontProcessor);
    ListBox1.AddItem('UnderScore position :' + FloatToStr(LFontProcessor.UnderscorePosition), LFontProcessor);
    ListBox1.AddItem('UnderscoreSize :' + FloatToStr(LFontProcessor.UnderscoreSize), LFontProcessor);
    ListBox1.AddItem('UnitsPerEm :' + FloatToStr(LFontProcessor.UnitsPerEm), LFontProcessor);
    ListBox1.AddItem('BBox :' + FloatToStr(LFontProcessor.GlobalBBox.Left) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Top) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Right) + ',' +
      FloatToStr(LFontProcessor.GlobalBBox.Bottom), LFontProcessor);
    ListBox1.AddItem(FloatToStr(LFontProcessor.CapHeight), LFontProcessor);
  end
  else
    ShowMessage('Could not load the font details');

    finally
      LFontProcessor.Free;
      Font1.Free;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LFontProcessor: TgtFontProcessor;
  LErrorCode: ErrorCodes;
  ArrayOfInteger: TgtPointsList;
  EOFill, RFill: Boolean;
  LStream: TMemoryStream;
  LText: WideString;
  LSize: Integer;
  LFS: TFontStyles;
  Color: Integer;
  lgpmeta: TGPMetafile;
  LIStream: TStreamAdapter;
begin
  if (Edit5.Text = '') then
    Edit5.Text := '0';
  if Edit6.Text = '' then
    Edit6.Text := '0';
  if (Edit3.Text = '') then
    Edit3.Text := '96';
  if Edit7.Text = '' then
    Edit7.Text := '96';
  Label5.Caption := '';

  if Edit5.Text = '0' then
    Edit5.Text := '50';
  if Edit6.Text = '0' then
    Edit6.Text := '50';
   
  CurX := StrToInt(Edit5.Text);
  CurY := StrToInt(Edit6.Text);

  if (TntEdit1.Text = '') then
    TntEdit1.Text := 'Hello World !';
  LText := TntEdit1.Text;

  if (Edit2.Text = '') then
    Edit2.Text := 'C:\Windows\Fonts\Arial.ttf';
  if (Edit4.Text = '') then
    Edit4.Text := '36';

  LSize := StrToInt(Edit4.Text);

  Image1.Canvas.Brush.Color := clBtnFace;
  Image1.Canvas.Rectangle(0, 0, Image1.Width, Image1.Height);

    if RadioGroup1.ItemIndex = 0 then
    begin
      try
        LStream := TMemoryStream.Create;
        LStream.LoadFromFile(Edit2.Text);
        LFontProcessor := TgtFontProcessor.Create(LStream, LSize,
          StrToInt(Edit3.Text), StrToInt(Edit7.Text), LErrorCode);
        //LFontProcessor.HorzRes := StrToInt(Edit3.Text);
        //LFontProcessor.VertRes := StrToInt(Edit7.Text);
        //LErrorCode := LFontProcessor.InitFace(0);
        if LErrorCode = Success then
        begin
          LErrorCode := LFontProcessor.DecomposeOutlineGlyph(LText, LSize, CurX,
            CurY, CheckBox1.Checked, DrawCharacter, gtCharacterCode);
        end;
      finally
        FreeAndNil(LFontProcessor);
        LStream.Free;
      end;
    end
    else
    begin
      try
        Font1 := TFont.Create;
        if FontDialog1.Execute then
        begin
          Font1.Name :=  FontDialog1.Font.Name;
          Font1.Style :=  FontDialog1.Font.Style;
          Font1.Size :=  FontDialog1.Font.Size;
        end
        else
        begin
          LFS := [fsUnderline];
          Font1.Name := 'arial';
          Font1.Size := 36;
          Font1.Style :=  LFS;
        end;
        LFontProcessor := TgtFontProcessor.Create(Font1, LErrorCode);
        LFontProcessor.HorzRes := StrToInt(Edit3.Text);
        LFontProcessor.VertRes := StrToInt(Edit7.Text);
        LFontProcessor.DecomposeOutlineGlyph(LText, Font1.Size, CurX, CurY,
          CheckBox1.Checked, DrawCharacter, gtCharacterCode);
      finally
        LFontProcessor.Free;
        Font1.Free;
        Image1.Refresh;
      end;
    end;

  if LErrorCode <> Success then
    Label5.Caption := 'Error while drawing!!!'
  else
    Label5.Caption := 'Sucessfully drawn!!!';
  Image1.Canvas.Refresh;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LFontProcessor: TgtFontProcessor;
  LErrorCode: ErrorCodes;
  LFont: TFont;
  LSize: TSize;
  LVal: Double;
begin
  LFont := TFont.Create;
  LFont.Style := [fsBold, fsItalic];
  LFont.Name :=  'Arial';
  LFont.Size := 48;
  //Font1.Charset := ANSI_CHARSET;
  LFontProcessor := TgtFontProcessor.Create(LFont, LErrorCode);
  if LErrorCode = Success then
  begin
    LVal := LFontProcessor.GetTextWidth('Gnostice');
  end;
    ShowMessage(FloatToStr(LVal));
  LFontProcessor.Free;
  LFont.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LFontProcessor: TgtFontProcessor;
  LErrorCode: ErrorCodes;
  LFS: TFontStyles;
begin
  LFS := [fsBold];
  Font1 := TFont.Create;
  Font1.Name :=  'Arial';
  Font1.Size := 18;
  Font1.Style :=  LFS;
  LFontProcessor := TgtFontProcessor.Create(Font1, LErrorCode);
  LFontProcessor.DecomposeOutlineGlyph('ABC', 72, True, DrawCharacter, gtCharacterCode);
  LFontProcessor.Free;
  Font1.Free;
end;

procedure TForm1.DrawCharacter(AGlyphPoints: TgtPointsList;
  AdvanceWidth, AdvanceHeight: Double; EvenOddFill, ReverseFill: Boolean);
var
  LI: Integer;
  StartX, StartY: Double;
  LP1X, LP1Y, LP2X, LP2Y: Double;
  linGrBrush: TGPLinearGradientBrush;
  LColor: Integer;
begin
  LI := 0;
  StartX := 0;
  StartY := 0;
  GraphicsObj := TgtGraphics.Create(Image1.Canvas.Handle);
  GraphicsObj.SetSmoothingMode(SmoothingModeAntiAlias);
  PenObj := TGPPen.Create(MakeColor(255, 0, 0, 0), 1);

  while LI < Length(AGlyphPoints) do
  begin
    case Round(AGlyphPoints[LI]) of
    1:
      begin
        StartX := AGlyphPoints[LI+1];
        StartY := AGlyphPoints[LI+2];
        Inc(LI,3);
      end;
    2:
      begin
        GraphicsObj.DrawLine(PenObj, StartX, StartY, AGlyphPoints[LI+1], AGlyphPoints[LI+2]);
        StartX := AGlyphPoints[LI+1];
        StartY := AGlyphPoints[LI+2];
        Inc(LI,3);
      end;
    3:
      begin
        LP1X := StartX + 2.0 / 3.0 * (AGlyphPoints[LI+1] - StartX);
        LP1Y := StartY + 2.0 / 3.0 * (AGlyphPoints[LI+2] - StartY);
        LP2X := LP1X + (AGlyphPoints[LI+3] - StartX) / 3.0;
        LP2Y := LP1Y + (AGlyphPoints[LI+4] - StartY) / 3.0;

        GraphicsObj.DrawBezier(PenObj, StartX, StartY, LP1X, LP1Y,
          LP2X, LP2Y, AGlyphPoints[LI+3], AGlyphPoints[LI+4]);
        StartX := AGlyphPoints[LI+3];
        StartY := AGlyphPoints[LI+4];
        Inc(LI,5);
      end;
    4:
      begin
         GraphicsObj.DrawBezier(PenObj, StartX, StartY, AGlyphPoints[LI+1], AGlyphPoints[LI+2],
          AGlyphPoints[LI+3], AGlyphPoints[LI+4], AGlyphPoints[LI+5], AGlyphPoints[LI+6]);
        StartX := AGlyphPoints[LI+5];
        StartY := AGlyphPoints[LI+6];
        Inc(LI,7);
      end;
    end;
  end;
  FreeAndNil(GraphicsObj);
  FreeAndNil(PenObj);
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    Edit2.Enabled := True;
    Edit4.Enabled := True;
  end
  else
  begin
    Edit2.Enabled := False;
    Edit4.Enabled := False;
  end;
end;

end.
