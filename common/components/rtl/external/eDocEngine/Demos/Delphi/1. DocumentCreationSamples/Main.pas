// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{$DEFINE gtPro}
// ENABLE THE SWITCH IF YOU ARE USING THE EMAIL FACILITY OF eDocEngine
{ .$DEFINE gtEmail }

unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, TypInfo,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Grids, DBGrids, DB, DBTables, DBCtrls,

  gtWMFEng, gtMetafileEng, gtEMFEng, gtUtils3, gtBMPEng, gtGIFEng, gtJPEGEng,
  gtCstGfxEng, gtSLKEng, gtDIFEng, gtLotusEng, gtQProEng, gtTXTEng, gtCstSpdEng,
  gtCstXLSEng, gtXLSEng, gtXHTMLEng, gtCstHTMLEng, gtHTMLEng, gtRTFEng,
  gtClasses3,
  gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtPDFEng, Buttons, gtCstXLS95Eng,
  gtExXLS95Eng, gtXLS95Eng
{$IFDEF gtPro}
    , gtExXLSEng, gtExHTMLEng, gtExPDFEng, gtSVGEng, gtPNGEng, gtTIFFEng, XPMan

{$ENDIF}
    ;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    Image3: TImage;
    DBImage1: TDBImage;
    DataSource1: TDataSource;
    Table1: TTable;
    Table1SpeciesNo: TFloatField;
    Table1Category: TStringField;
    Table1Common_Name: TStringField;
    Table1SpeciesName: TStringField;
    Table1Lengthcm: TFloatField;
    Table1Length_In: TFloatField;
    Table1Notes: TMemoField;
    Table1Graphic: TGraphicField;
    DBGrid1: TDBGrid;
    Button1: TSpeedButton;
    Button5: TSpeedButton;
    Button3: TSpeedButton;
    Button8: TSpeedButton;
    Button9: TSpeedButton;
    Button2: TSpeedButton;
    Button6: TSpeedButton;
    Button7: TSpeedButton;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button11: TSpeedButton;
    Button10: TSpeedButton;
    Label13: TLabel;
    Label14: TLabel;
    Image13: TImage;
    Image14: TImage;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Image12: TImage;
    Label12: TLabel;
    Button4: TSpeedButton;
    Image15: TImage;
    Label10: TLabel;
    Button12: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure changecolor(Sender: TObject);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button5MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CheckBox1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure CheckBox2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image8Click(Sender: TObject);
    procedure Image8MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button8MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label7MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image9MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label9Click(Sender: TObject);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image11MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button9MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button6MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image5MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label8MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image6MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button3MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image10MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button7MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button4MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label12MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button11MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label13MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image13MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button10MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Image14MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label14MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label6Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Label10MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Label10Click(Sender: TObject);
    procedure Button12MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetEngine;
  public
    { Public declarations }
    FEngine: TgtCustomDocumentEngine;
  end;

var
  Form1: TForm1;
  Old_Button: TLabel;
  New_Button: TLabel;

implementation

{$R *.dfm}

procedure TForm1.GetEngine;
begin
  case ComboBox1.ItemIndex of
    0:
      FEngine := TgtPDFEngine.Create(Self);
    1:
      FEngine := TgtRTFEngine.Create(Self);
    2:
      FEngine := TgtHTMLEngine.Create(Self);
    3:
      FEngine := TgtXHTMLEngine.Create(Self);
    4:
      FEngine := TgtTextEngine.Create(Self);
    5:
      Begin
        FEngine := TgtExcelEngine.Create(Self);
        TgtExcelEngine(FEngine).Preferences.PagesPerWorksheet := 1;
      end;
    6:
      FEngine := TgtQuattroProEngine.Create(Self);
    7:
      FEngine := TgtDIFEngine.Create(Self);
    8:
      FEngine := TgtSYLKEngine.Create(Self);
    9:
      FEngine := TgtLotusEngine.Create(Self);
    10:
      FEngine := TgtBMPEngine.Create(Self);
    11:
      FEngine := TgtJPEGEngine.Create(Self);
    12:
      FEngine := TgtGIFEngine.Create(Self);
    13:
      FEngine := TgtEMFEngine.Create(Self);
    14:
      FEngine := TgtWMFEngine.Create(Self);
    15:
      Begin
        FEngine := TgtXLSEngine.Create(Self);
        TgtXLSEngine(FEngine).Preferences.PagesPerWorksheet := 1;
      end;

{$IFDEF gtPro}
    16:
      FEngine := TgtSVGEngine.Create(Self);
    17:
      FEngine := TgtPNGEngine.Create(Self);
    18:
      FEngine := TgtTIFFEngine.Create(Self);
{$ENDIF}

  end;
  with IgtDocumentEngine(FEngine).Preferences do
  begin
    ShowSetupDialog := CheckBox1.Checked;
    OpenAfterCreate := CheckBox2.Checked;
{$IFDEF gtEMail}
    EmailAfterCreate := True;
    FEngine.EmailSettings.Host := '127.0.0.1';
    FEngine.EmailSettings.Body.Add('Gnostice Information Technologies');
    FEngine.EmailSettings.Body.Add('Bangalore');
    FEngine.EmailSettings.Body.Add('India');
    FEngine.EmailSettings.RecipientList.Add('info@gnostice.com');
    FEngine.EmailSettings.RecipientList.Add('support@gnostice.com');
    FEngine.EmailSettings.CCList.Add('you@company.com');
    FEngine.EmailSettings.BCCList.Add('me_too@company.com');
    FEngine.EmailSettings.FromAddress := 'you@company.com';
    FEngine.EmailSettings.FromName := 'YourName';
    FEngine.EmailSettings.AuthenticationRequired := True;
    FEngine.EmailSettings.UserID := 'you@company.com';
    FEngine.EmailSettings.Password := 'password';
    FEngine.EmailSettings.Subject := 'Testing eMail After Create in eDocEngine';
{$ENDIF}
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'BlankDoc';
    Page.PaperSize := A4;
    // ... Set any other document properties as required
    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    // 1st Page: Render text, image and other items here

    NewPage;
    NewPage;
    // 2nd Page: Render text, image and other items here
    // Similarly render any number of pages using NewPage method
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'TextOut';
    Page.PaperSize := A4;
    // ... Set any other document properties as required
    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    Font.Name := 'Arial';
    Font.Size := 18;
    Font.Style := [fsBold, fsUnderline];
    // ... Set any text properties as required
    TextOut(3, 2, 'Simple TextOut Demo');

    Brush.Color := clLtGray;
    Brush.Style := bsSolid;
    Font.Style := [];
    Font.Size := 14;
    Font.Color := clBlue;
    // ... Change settings if necessary
    TextOut(2, 5, 'Gnostice eDocEngine. Visit www.gnostice.com');
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LColumns: TList;
  LS: string;
  I, J: Integer;
  LState1, LState2, LState3, LState4: Integer;
  LGraphic: TGraphic;
begin
  LS := 'Gnostice eDocEngine is a comprehensive, generic, electronic' +
    ' document creation component suite for Borland® Delphi™' +
    ' and Borland® C++Builder™. eDocEngine enables developers to deliver' +
    ' information straight from the applications they develop in over 20' +
    ' popular electronic document formats, including PDF, HTML, RTF, TIFF,' +
    ' XML graphics and many more.';
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'AdvancedFeatures';
    FEngine.MeasurementUnit := muPixels;
    Page.PaperSize := A4;
    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    TextFormatting.Alignment := haCenter;
    TextFormatting.BeforeSpace := 125;
    Font.Name := 'Arial';
    Font.Size := 18;
    Font.Color := clBlue;
    Font.Style := [fsBold];
    BeginPara;
    TextOut('Advanced Drawing Functions');
    EndPara;
    Font.Size := 7;
    Font.Style := [];
    with TableSettings do
    begin
      ColumnWidth := 100;
      RowHeight := 40;
      EnableTitle := True;
      TitleHeight := 10;
      InternalMargin := gtRect(5, 5, 5, 5);
    end;
    ImageSettings.Stretch := True;

    LState1 := SaveEngineState;
    TextFormatting.BeforeSpace := 8;
    TextFormatting.Alignment := haLeft;
    TextFormatting.LeftIndent := 40;
    Font.Size := 12;
    Font.Color := clBlack;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Paragraph Support');
    EndPara;
    LState2 := SaveEngineState;
    Font.Style := [fsBold];
    Font.Size := 8;
    BeginPara;
    TextOut('Align Left');
    EndPara;
    LState4 := SaveEngineState;
    TextFormatting.RightIndent := 75;
    TextFormatting.LeftIndent := 75;
    TextFormatting.BeforeSpace := 5;
    Font.Size := 10;
    Font.Color := clRed;
    Font.Style := [];
    LState3 := SaveEngineState;
    TextFormatting.Alignment := haLeft;
    BeginPara;
    TextOut(LS);
    EndPara;

    RestoreEngineState(LState4);
    BeginPara;
    TextOut('Align Right');
    EndPara;
    RestoreEngineState(LState3);

    TextFormatting.Alignment := haRight;
    BeginPara;
    TextOut(LS);
    EndPara;

    RestoreEngineState(LState4);
    BeginPara;
    TextOut('Center');
    EndPara;
    RestoreEngineState(LState3);

    TextFormatting.Alignment := haCenter;
    BeginPara;
    TextOut(LS);
    EndPara;

    RestoreEngineState(LState4);
    BeginPara;
    TextOut('Justify');
    EndPara;
    RestoreEngineState(LState3);

    TextFormatting.Alignment := haJustify;
    BeginPara;
    TextOut(LS);
    EndPara;

    RestoreEngineState(LState2);

    TextFormatting.BeforeSpace := 40;
    BeginPara;
    TextOut('Table Support');
    EndPara;

    RestoreEngineState(LState1);

    // Pen.Width := 2;
    // Brush.Color := clAqua;
    ImageSettings.Transparent := True;
    LColumns := BeginTable(40, 615, 5);

    for I := 0 to 4 do
    begin
      TgtColumn(LColumns[I]).Width := DBGrid1.Columns[I].Width;
      TgtColumn(LColumns[I]).Title := DBGrid1.Columns[I].Title.Caption;
    end;

    DBGrid1.DataSource.DataSet.Next;
    for J := 0 to 2 do
    begin
      NewRow;
      for I := 0 to 4 do
      begin
        if I <> 2 then
        begin
          // Brush.Style := bsClear;
          TextOut(I, DBGrid1.Fields[I].AsString)
        end
        else
        begin
          Brush.Color := clAqua;
          Brush.Style := bsSolid;
          DBImage1.Refresh;
          LGraphic := DBImage1.Picture.Graphic;
          DrawImage(I, LGraphic.Width, LGraphic.Height, LGraphic);
        end;
      end;
      DBGrid1.DataSource.DataSet.Next;
    end;
    EndTable;
    DBGrid1.DataSource.DataSet.First;

    RestoreEngineState(LState2);

    TextOut(40, 965, 'Textbox Support');

    RestoreEngineState(LState1);
    Font.Size := 8;
{$IFDEF VER140}
    Brush.Color := clCream;
{$ELSE}
    Brush.Color := clWhite;
{$ENDIF}
    Pen.Width := 3;

    Frame.InternalMargin := gtRect(5, 5, 4, 4);
    TextBox(gtRect(40, 990, 300, 1100), LS, haJustify, vaTop);

    Pen.Style := psDash;
    TextBox(gtRect(430, 990, 690, 1100), LS, haJustify, vaTop);

    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'Images';
    FEngine.MeasurementUnit := muPixels;
    Page.PaperSize := A4;
    // ... Set any other document properties as required
    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    TextFormatting.BeforeSpace := 144;
    TextFormatting.Alignment := haCenter;
    Font.Name := 'Arial';
    Font.Style := [fsBold, fsUnderline];
    Font.Size := 20;
    BeginPara;
    TextOut('Image Drawing Demo');
    EndPara;
    ImageSettings.OutputImageFormat := ifJPEG;
    ImageSettings.IsFrame := True;
    ImageSettings.Stretch := True;
    ImageSettings.KeepAspectRatio := True;
    Pen.Width := 2;
    Pen.Color := clBlue;
    Brush.Color := clLtGray;
    // ... Set any image properties through ImageSettings as required

    // Use this method to draw image at a perticular position
    DrawImage(210, 336, Image2.Picture.Graphic);

    // Use this method to specify a rectangle within which to draw the image
    ImageSettings.Stretch := False;
    ImageSettings.KeepAspectRatio := False;
    ImageSettings.Center := True;
    DrawImage(gtRect(200, 192, 600, 307.2), Image3.Picture.Graphic);
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'Shapes';
    Page.PaperSize := A4;
    Page.LeftMargin := 0.5;
    Page.RightMargin := 0.5;
    Page.BottomMargin := 0.5;
    Page.TopMargin := 0.5;
    // ... Set any other document properties as required
    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    TextFormatting.BeforeSpace := 1.5;
    TextFormatting.Alignment := haCenter;
    Font.Name := 'Arial';
    Font.Style := [fsBold, fsUnderline];
    Font.Size := 20;
    BeginPara;
    TextOut('Shape Drawing Demo');
    EndPara;
    Pen.Color := clBlack;
    Brush.Color := clLtGray;
    // ... Set/Change Pen and Brush at any point.
    // Last parameter specifies if the shape needs to be filled with
    // the current brush
    Ellipse(1.5, 2.5, 4, 3.5, False);
    Pen.Style := psDashDot;
    Brush.Style := bsFDiagonal;
    Brush.Color := clGreen;
    RoundRect(6.3, 5.6, 7.3, 7.5, 0.25, 0.15, False);
    Arc(4.2, 2.2, 6, 2.6, 4.5, 6, 4, 4);
    Chord(0.2, 4, 3, 5, 2.3, 3, 4.3, 5, True);
    Pie(4.2, 4, 5, 5, 3, 3, 4.5, 5.2, False);
    Pen.Color := clBlue;
    Brush.Color := clLtGray;
    Line(0.5, 5.5, 1.75, 7.7);
    Rectangle(2, 5.5, 6, 7.8, True);
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  LMetafile: TMetafile;
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'Metafile';
    Page.PaperSize := A4;
    Page.LeftMargin := 0;
    Page.RightMargin := 0;
    Page.BottomMargin := 0;
    Page.TopMargin := 0;

    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    LMetafile := TMetafile.Create;
    LMetafile.Assign(Image1.Picture.Graphic);
    PlayMetafile(LMetafile);
    EndDoc;
  end;
  LMetafile.Free;
  FEngine.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LI: Integer;
  LEngine: TgtPDFEngine;
begin
  LEngine := TgtPDFEngine.Create(Self);
  with LEngine do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'PDFBookmarks';
    MeasurementUnit := muPixels;
    with Preferences do
    begin
      ShowSetupDialog := CheckBox1.Checked;
      OpenAfterCreate := CheckBox2.Checked;
    end;
    Page.PaperSize := A4;
    Page.LeftMargin := 25;
    Page.RightMargin := 25;
    Page.BottomMargin := 25;
    Page.TopMargin := 25;
    BeginDoc;
    if (EngineStatus <> esStarted) then
      Exit;
    Font.Name := 'Times New Roman';
    Font.Size := 20;
    Font.Color := clBlue;
    TextFormatting.BeforeSpace := 400;
    TextFormatting.Alignment := haCenter;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    Font.Size := 18;
    TextFormatting.BeforeSpace := 50;
    BeginPara;
    TextOut('PDF Bookmarks Demo');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 120;
    TextFormatting.Alignment := haRight;
    Font.Size := 18;
    Font.Color := clBlack;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Introduction');
    EndPara;
    TextFormatting.BeforeSpace := 150;
    Font.Style := [fsBold];
    TextFormatting.Alignment := haLeft;
    Font.Size := 16;
    BeginPara;
    TextOut('1.1. What is eDocEngine?');
    EndPara;
    BeginPara;
    TextOut('1.2. System Requirements');
    EndPara;
    BeginPara;
    TextOut('1.3. Legal Notices');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 120;
    TextFormatting.Alignment := haRight;
    Font.Size := 18;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Using eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 150;
    Font.Style := [fsBold];
    TextFormatting.Alignment := haLeft;
    Font.Size := 16;
    BeginPara;
    TextOut('2.1. Starting eDocEngine');
    EndPara;
    BeginPara;
    TextOut('2.2 Advanced Features');
    EndPara;
    Font.Size := 14;
    BeginPara;
    TextOut('2.2.1. Paragraphs');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 150;
    BeginPara;
    TextOut('2.2.2. Tables');
    EndPara;

    (* Bookmarks *)
    AddTOCItem('PDF Bookmarks Demo', -1, 1, 0);
    LI := AddTOCItem('1. Introduction', -1, 2, 145);
    AddTOCItem('1.1. What is eDocEngine?', LI, 2, 320);
    AddTOCItem('1.2. System Requirements', LI, 2, 495);
    AddTOCItem('1.3. Legal Notices', LI, 2, 670);
    LI := AddTOCItem('2. Using eDocEngine', -1, 3, 145);
    AddTOCItem('2.1. Starting eDocEngine', LI, 3, 320);
    LI := AddTOCItem('2.2. Advanced Features', LI, 3, 495);
    AddTOCItem('2.2.1. Paragraphs', LI, 3, 670);
    AddTOCItem('2.2.2. Tables', LI, 4, 175);
    AddTOCItem('www.gnostice.com', -1, 'http://www.gnostice.com');
    ViewerPreferences.PageMode := pmUseOutlines;
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'HeaderFooter';
    Page.PaperSize := A4;
    Page.HeaderHeight := 2;
    Page.FooterHeight := 2;
    Page.LeftMargin := 0.25;
    Page.RightMargin := 0.25;
    Page.BottomMargin := 0.25;
    Page.TopMargin := 0.25;

    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    BeginHeader;
    with Font do
    begin
      Name := 'Courier New';
      Size := 10;
      Color := clBlue;
    end;
    TextFormatting.Alignment := haRight;
    TextFormatting.BeforeSpace := 1.1;
    BeginPara;
    TextOut('Document Header');
    EndPara;
    ImageSettings.Stretch := True;
    ImageSettings.KeepAspectRatio := True;
    DrawImage(gtRect(0.3, 0.9, 2, 2), Image3.Picture.Graphic);
    EndHeader;
    BeginFooter;
    with Font do
    begin
      Name := 'Verdana';
      Size := 10;
      Color := clRed;
    end;
    TextOut(0.3, 0.9, 'Gnostice Information Technologies Private Limited');
    TextOut(6, 0.9, 'www.gnostice.com');
    EndFooter;

    with Font do
    begin
      Name := 'Times New Roman';
      Size := 20;
      Color := clBlack;
    end;
    TextFormatting.BeforeSpace := 2;
    TextFormatting.Alignment := haCenter;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Header and Footer Demo');
    EndPara;
    BeginPara;
    TextOut('Page 1');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 2;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Header and Footer Demo');
    EndPara;
    BeginPara;
    TextOut('Page 2');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 2;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Header and Footer Demo');
    EndPara;
    BeginPara;
    TextOut('Page 3');
    EndPara;
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  GetEngine;
  with IgtDocumentEngine(FEngine) do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'Watermark';
    Page.PaperSize := A4;
    Page.HeaderHeight := 2;
    Page.FooterHeight := 2;
    Page.LeftMargin := 0.25;
    Page.RightMargin := 0.25;
    Page.BottomMargin := 0.25;
    Page.TopMargin := 0.25;

    BeginDoc;
    if (FEngine.EngineStatus <> esStarted) then
      Exit;
    BeginWaterMark;
    Font.Name := 'Verdana';
    Font.Size := 6;
    Pen.Width := 2;
    Rectangle(1.5, 1.7, 6.35, 3.5, False);
    with Font do
    begin
      Name := 'Verdana';
      Size := 12;
      Color := clBlue;
    end;
    TextFormatting.Alignment := haCenter;
    TextFormatting.BeforeSpace := 2;
    BeginPara;
    TextOut('Gnostice Information Technologies Private Limited');
    EndPara;
    ImageSettings.Stretch := True;
    ImageSettings.KeepAspectRatio := True;
    DrawImage(2.75, 2.3, Image3.Picture.Graphic);
    TextOut(3.5, 3.0, 'Watermark');
    EndWaterMark;
    with Font do
    begin
      Name := 'Times New Roman';
      Size := 20;
      Color := clBlack;
    end;
    TextFormatting.BeforeSpace := 2;
    TextFormatting.Alignment := haCenter;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Watermark Demo');
    EndPara;
    BeginPara;
    TextOut('Page 1');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 2;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Watermark Demo');
    EndPara;
    BeginPara;
    TextOut('Page 2');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 2;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 0.3;
    BeginPara;
    TextOut('Watermark Demo');
    EndPara;
    BeginPara;
    TextOut('Page 3');
    EndPara;
    EndDoc;
  end;
  FEngine.Free;
end;

procedure TForm1.Button10Click(Sender: TObject);
{$IFDEF gtPro}
var
  LHTMLEngine: TgtHTMLEngine;
  LI: Integer;
{$ENDIF}
begin
{$IFDEF gtPro}
  LHTMLEngine := TgtHTMLEngine.Create(Self);
  with LHTMLEngine do
  begin
    FileName := ExtractFilePath(Application.ExeName) + 'TableOfContents';
    MeasurementUnit := muPixels;
    with Preferences do
    begin
      ShowSetupDialog := CheckBox1.Checked;
      OpenAfterCreate := CheckBox2.Checked;

    end;
    Page.PaperSize := A4;
    Page.LeftMargin := 25;
    Page.RightMargin := 25;
    Page.BottomMargin := 25;
    Page.TopMargin := 25;
    Preferences.SingleFile := False;
    Navigator.Enabled := True;
    with TOCPageSettings.ItemFont do
    begin
      Name := 'Arial';
      Size := 12;
      Color := clBlue;
    end;
    with TOCPageSettings.TitleFont do
    begin
      Name := 'Verdana';
      Size := 16;
      Color := clRed;
      Style := [fsBold, fsUnderline];
    end;
    TOCPageSettings.Title := 'Table of Contents';
    BeginDoc;
    if (EngineStatus <> esStarted) then
      Exit;
    Font.Name := 'Times New Roman';
    Font.Size := 20;
    Font.Color := clBlue;
    TextFormatting.BeforeSpace := 400;
    TextFormatting.Alignment := haCenter;
    BeginPara;
    TextOut('eDocEngine');
    EndPara;
    Font.Size := 18;
    TextFormatting.BeforeSpace := 50;
    BeginPara;
    TextOut('HTML Table of Contents Demo');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 120;
    TextFormatting.Alignment := haRight;
    Font.Size := 18;
    Font.Color := clBlack;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Introduction');
    EndPara;
    TextFormatting.BeforeSpace := 150;
    Font.Style := [fsBold];
    TextFormatting.Alignment := haLeft;
    Font.Size := 16;
    BeginPara;
    TextOut('1.1. What is eDocEngine?');
    EndPara;
    BeginPara;
    TextOut('1.2. System Requirements');
    EndPara;
    BeginPara;
    TextOut('1.3. Legal Notices');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 120;
    TextFormatting.Alignment := haRight;
    Font.Size := 18;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Using eDocEngine');
    EndPara;
    TextFormatting.BeforeSpace := 150;
    Font.Style := [fsBold];
    TextFormatting.Alignment := haLeft;
    Font.Size := 16;
    BeginPara;
    TextOut('2.1. Starting eDocEngine');
    EndPara;
    BeginPara;
    TextOut('2.2 Advanced Features');
    EndPara;
    Font.Size := 14;
    BeginPara;
    TextOut('2.2.1. Paragraphs');
    EndPara;
    NewPage;
    TextFormatting.BeforeSpace := 150;
    BeginPara;
    TextOut('2.2.2. Tables');
    EndPara;

    (* Table of Contents Page *)
    AddTOCItem('HTML Table of Contents Demo', -1, 1, 0);
    LI := AddTOCItem('1. Introduction', -1, 2, 145);
    AddTOCItem('1.1. What is eDocEngine?', LI, 2, 320);
    AddTOCItem('1.2. System Requirements', LI, 2, 495);
    AddTOCItem('1.3. Legal Notices', LI, 2, 670);
    LI := AddTOCItem('2. Using eDocEngine', -1, 3, 145);
    AddTOCItem('2.1. Starting eDocEngine', LI, 3, 320);
    LI := AddTOCItem('2.2. Advanced Features', LI, 3, 495);
    AddTOCItem('2.2.1. Paragraphs', LI, 3, 670);
    AddTOCItem('2.2.2. Tables', LI, 4, 175);
    AddTOCItem('www.gnostice.com', -1, 'http://www.gnostice.com');

    EndDoc;
  end;
  LHTMLEngine.Free;
{$ENDIF}
end;

procedure TForm1.Button11Click(Sender: TObject);
{$IFDEF gtPro}
var
  LPDFEngine: TgtPDFEngine;
  PDFButton: TgtPDFFormPushButton;

  PDFCheckbox: TgtPDFFormCheckBox;

  PDFTextAnnot: TgtPDFTextAnnot;

  PDFRadioGroup: TgtPDFFormRadioButton;
  PDFRadioI1, PDFRadioI2, PDFRadioI3: TgtPDFFormRadioItem;

  PDFComboBox: TgtPDFFormComboBox;

  PDFListBox: TgtPDFFormListBox;

  PDFTextField: TgtPDFFormTextField;
{$ENDIF}
begin
{$IFDEF gtPro}
  LPDFEngine := TgtPDFEngine.Create(Self);
  with LPDFEngine do
  begin

    MeasurementUnit := muPixels;
    with Preferences do
    begin
      ShowSetupDialog := CheckBox1.Checked;
      OpenAfterCreate := CheckBox2.Checked;
    end;
    Page.PaperSize := A4;
    FileName := ExtractFilePath(Application.ExeName) + 'PDFForms';
    BeginDoc;
    if (EngineStatus <> esStarted) then
      Exit;
    Font.Name := 'Verdana';
    Font.Size := 15;
    TextFormatting.Alignment := haCenter;
    TextFormatting.BeforeSpace := 125;
    Font.Size := 20;
    Font.Color := clRed;
    Font.Style := [fsBold];
    BeginPara;
    TextOut('PDF Forms Demo');
    EndPara;
    TextFormatting.BeforeSpace := 15;
    Font.Name := 'Arial';
    Font.Size := 12;
    Font.Color := clBlack;
    Font.Style := [fsBold, fsUnderline];
    BeginPara;
    TextOut('Buttons');
    EndPara;

    (* Push Button with JavaScript Action. *)
    PDFButton := TgtPDFFormPushButton.Create;
    with PDFButton do
    begin
      Rect := gtRect(190, 200, 330, 250);
      Font.Name := 'Comic Sans MS';
      Font.Size := 15;
      FieldName := 'JavaScriptButton';
      NormalCaption := 'JavaScript';
      RolloverCaption := 'Rollover';
      DownCaption := 'Down';
      Action := pbaJavaScript;
      BackgroundColor := clBtnFace;
      JavaScript :=
        'app.alert("Gnostice Information Technologies Private Limited")';
    end;
    AddFormItem(PDFButton);

    (* Push Button with Submit Action. *)
    PDFButton := TgtPDFFormPushButton.Create;
    with PDFButton do
    begin
      Rect := gtRect(350, 200, 470, 250);
      Font.Name := 'Comic Sans MS';
      Font.Size := 15;
      FieldName := 'SubmitButton';
      NormalCaption := 'Submit';
      RolloverCaption := 'Rollover';
      DownCaption := 'Down';
      Action := pbaSubmit;
      BackgroundColor := clBtnFace;
      SubmitURL := 'http://www.gnostice.com';
    end;
    AddFormItem(PDFButton);

    (* Push Button with Reset Action. *)
    PDFButton := TgtPDFFormPushButton.Create;
    with PDFButton do
    begin
      Rect := gtRect(500, 200, 620, 250);
      Font.Name := 'Comic Sans MS';
      Font.Size := 15;
      FieldName := 'ResetButton';
      NormalCaption := 'Reset';
      RolloverCaption := 'Rollover';
      DownCaption := 'Down';
      Action := pbaReset;
      BackgroundColor := clBtnFace;
    end;
    AddFormItem(PDFButton);

    TextFormatting.BeforeSpace := 75;
    BeginPara;
    TextOut('Checkboxes');
    EndPara;
    (* Checkbox 1 *)
    PDFCheckbox := TgtPDFFormCheckBox.Create;
    with PDFCheckbox do
    begin
      Rect := gtRect(340, 295, 365, 320);
      Font.Name := 'Arial';
      Font.Size := 15;
      Font.Color := clRed;
      FieldName := 'Checkbox1';
      Symbol := pfcsStar;
      Checked := False;
    end;
    AddFormItem(PDFCheckbox);

    (* Checkbox 2 *)
    PDFCheckbox := TgtPDFFormCheckBox.Create;
    with PDFCheckbox do
    begin
      Rect := gtRect(390, 295, 415, 320);
      Font.Size := 15;
      Font.Color := clRed;
      FieldName := 'Checkbox2';
      Symbol := pfcsCheck;
      Checked := False;
    end;
    AddFormItem(PDFCheckbox);

    (* Checkbox 3 *)
    PDFCheckbox := TgtPDFFormCheckBox.Create;
    with PDFCheckbox do
    begin
      Rect := gtRect(440, 295, 465, 320);
      Font.Name := 'Arial';
      Font.Size := 15;
      Font.Color := clRed;
      FieldName := 'Checkbox3';
      Symbol := pfcsCross;
      Checked := False;
    end;
    AddFormItem(PDFCheckbox);

    TextFormatting.BeforeSpace := 50;
    BeginPara;
    TextOut('Radio Button Group');
    EndPara;

    (* RadioGroup *)
    PDFRadioGroup := TgtPDFFormRadioButton.Create;
    with PDFRadioGroup do
    begin
      Font.Size := 20;
      Font.Name := 'Arial';
      FieldName := 'RadioGroup';
      Symbol := pfcsDiamond;
      AtleastOneSelectedItem := True;

      PDFRadioI1 := TgtPDFFormRadioItem.Create;
      with PDFRadioI1 do
      begin
        Rect := gtRect(340, 370, 365, 395);
      end;
      AddItem(PDFRadioI1);

      PDFRadioI2 := TgtPDFFormRadioItem.Create;
      with PDFRadioI2 do
      begin
        Rect := gtRect(390, 370, 415, 395);
      end;
      AddItem(PDFRadioI2);

      PDFRadioI3 := TgtPDFFormRadioItem.Create;
      with PDFRadioI3 do
      begin
        Rect := gtRect(440, 370, 465, 395);
      end;
      AddItem(PDFRadioI3);

      SelectedItemIndex := 1;
    end;
    AddFormItem(PDFRadioGroup);

    TextFormatting.BeforeSpace := 60;
    BeginPara;
    TextOut('ComboBox');
    EndPara;

    (* Combobox *)
    PDFComboBox := TgtPDFFormComboBox.Create;
    with PDFComboBox do
    begin
      Rect := gtRect(320, 455, 485, 480);
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Color := clBlue;
      FieldName := 'Combo Box';
      BackgroundColor := clYellow;
      AddItem('TgtExcelEngine');
       AddItem('TgtXLSEngine');
      AddItem('TgtPDFEngine');
      AddItem('TgtRTFEngine');
      AddItem('TgtSVGEngine');
      SelectedItemIndex := 1;
    end;
    AddFormItem(PDFComboBox);

    TextFormatting.BeforeSpace := 65;
    BeginPara;
    TextOut('List Box');
    EndPara;

    (* Listbox *)
    PDFListBox := TgtPDFFormListBox.Create;
    with PDFListBox do
    begin
      Rect := gtRect(335, 535, 465, 575);
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Color := clBlue;
      FieldName := 'ListBox';
      BackgroundColor := clYellow;
      AddItem('TgtExcelEngine');
      AddItem('TgtXLSEngine');
      AddItem('TgtPDFEngine');
      AddItem('TgtRTFEngine');
      AddItem('TgtSVGEngine');
      IsMultiSelect := True;
    end;
    AddFormItem(PDFListBox);

    TextFormatting.BeforeSpace := 75;
    BeginPara;
    TextOut('Single Line Text Field');
    EndPara;

    (* Single line text *)
    PDFTextField := TgtPDFFormTextField.Create;
    with PDFTextField do
    begin
      Rect := gtRect(240, 630, 565, 655);
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Color := clBlack;
      FieldName := 'SingleLineText';
      BackgroundColor := clBlue;
      Value := 'Gnostice eDocEngine';
      MaxLength := 30;
    end;
    AddFormItem(PDFTextField);

    TextFormatting.BeforeSpace := 65;
    BeginPara;
    TextOut('Password Text Field');
    EndPara;

    (* Password *)
    PDFTextField := TgtPDFFormTextField.Create;
    with PDFTextField do
    begin
      Rect := gtRect(240, 705, 565, 730);
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Color := clBlack;
      FieldName := 'PasswordText';
      BackgroundColor := clBlue;
      IsPassword := True;
      MaxLength := 30;
    end;
    AddFormItem(PDFTextField);

    TextFormatting.BeforeSpace := 80;
    BeginPara;
    TextOut('Multiline Text Field');
    EndPara;

    (* Multiline text *)
    PDFTextField := TgtPDFFormTextField.Create;
    with PDFTextField do
    begin
      Rect := gtRect(240, 810, 565, 910);
      Font.Name := 'Arial';
      Font.Size := 10;
      Font.Color := clBlack;
      FieldName := 'MultiLineText';
      BackgroundColor := clBlue;
      Value := 'Gnostice eDocEngine';
      IsMultiline := True;
    end;
    AddFormItem(PDFTextField);

    (* Text Annotation *)
    PDFTextAnnot := TgtPDFTextAnnot.Create;
    with PDFTextAnnot do
    begin
      Rect := gtRect(600, 425, 600, 825);
      Contents := 'Using Gnostice eDocEngine, you can even add notes to ' +
        'the PDF documents created and assist the user in filling up forms.';
      Open := True;
      Name := tnComment;
    end;

    AddAnnotItem(PDFTextAnnot);

    EndDoc;
  end;
  LPDFEngine.Free;
{$ENDIF}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
{$IFDEF gtPro}
  ComboBox1.Items.Add('SVG');
  ComboBox1.Items.Add('PNG');
  ComboBox1.Items.Add('TIFF');
  SetControlsEnabled(GroupBox2, True);
{$ELSE}
  SetControlsEnabled(GroupBox2, False);
{$ENDIF}
  ComboBox1.ItemIndex := 0;
  Old_Button := TLabel.Create(Self);
  Old_Button.Visible := False;
  Old_Button.Color := clActiveCaption;
  Old_Button.Font.Color := clWhite;
  New_Button := TLabel.Create(Self);
  New_Button.Visible := False;
  New_Button.Color := clWhite;
  New_Button.Font.Color := clActiveCaption;
  Table1.Active := True;
end;

procedure TForm1.changecolor(Sender: TObject);
var
  I: Integer;
begin
  with Form1 do
  begin
    if (Sender = Button1) or (Sender = Image4) or (Sender = Label2) then
    begin
      Label2.Color := New_Button.Color;
      Label2.Font.Color := New_Button.Font.Color;
      I := 2;
    end
    else if (Sender = Button2) or (Sender = Image8) or (Sender = Label6) then
    begin
      Label6.Color := New_Button.Color;
      Label6.Font.Color := New_Button.Font.Color;
      I := 6;
    end
    else if (Sender = Button8) or (Sender = Image7) or (Sender = Label5) then
    begin
      Label5.Color := New_Button.Color;
      Label5.Font.Color := New_Button.Font.Color;
      I := 5
    end
    else if (Sender = Button5) or (Sender = Image5) or (Sender = Label3) then
    begin
      Label3.Color := New_Button.Color;
      Label3.Font.Color := New_Button.Font.Color;
      I := 3;
    end
    else if (Sender = Button6) or (Sender = Image9) or (Sender = Label7) then
    begin
      Label7.Color := New_Button.Color;
      Label7.Font.Color := New_Button.Font.Color;
      I := 7;
    end
    else if (Sender = Button9) or (Sender = Image11) or (Sender = Label9) then
    begin
      Label9.Color := New_Button.Color;
      Label9.Font.Color := New_Button.Font.Color;
      I := 9;
    end
    else if (Sender = Button3) or (Sender = Image6) or (Sender = Label4) then
    begin
      Label4.Color := clWhite;
      Label4.Font.Color := clActiveCaption;
      I := 4;
    end
    else if (Sender = Button7) or (Sender = Image10) or (Sender = Label8) then
    begin
      Label8.Color := New_Button.Color;
      Label8.Font.Color := New_Button.Font.Color;
      I := 8;
    end
    else if (Sender = Button4) or (Sender = Image12) or (Sender = Label12) then
    begin
      Label12.Color := New_Button.Color;
      Label12.Font.Color := New_Button.Font.Color;
      I := 12;
    end
    else if (Sender = Button11) or (Sender = Image13) or (Sender = Label13) then
    begin
      Label13.Color := New_Button.Color;
      Label13.Font.Color := New_Button.Font.Color;
      I := 13;
    end
    else if (Sender = Button10) or (Sender = Image14) or (Sender = Label14) then
    begin
      Label14.Color := New_Button.Color;
      Label14.Font.Color := New_Button.Font.Color;
      I := 14;
    end
    else if (Sender = Button12) or (Sender = Image15) or (Sender = Label10) then
    begin
      Label10.Color := New_Button.Color;
      Label10.Font.Color := New_Button.Font.Color;
      I := 15;
    end
    else
    begin
      Label2.Color := Old_Button.Color;
      Label2.Font.Color := Old_Button.Font.Color;
      Label6.Color := Old_Button.Color;
      Label6.Font.Color := Old_Button.Font.Color;
      Label5.Color := Old_Button.Color;
      Label5.Font.Color := Old_Button.Font.Color;
      Label3.Color := Old_Button.Color;
      Label3.Font.Color := Old_Button.Font.Color;
      Label7.Color := Old_Button.Color;
      Label7.Font.Color := Old_Button.Font.Color;
      Label9.Color := Old_Button.Color;
      Label9.Font.Color := Old_Button.Font.Color;
      Label4.Color := Old_Button.Color;
      Label4.Font.Color := Old_Button.Font.Color;
      Label8.Font.Color := Old_Button.Font.Color;
      Label8.Color := Old_Button.Color;
      Label12.Font.Color := Old_Button.Font.Color;
      Label12.Color := Old_Button.Color;
      Label13.Font.Color := Old_Button.Font.Color;
      Label13.Color := Old_Button.Color;
      Label14.Font.Color := Old_Button.Font.Color;
      Label14.Color := Old_Button.Color;
      Exit;
    end;
    if I <> 2 then
    begin
      Label2.Color := Old_Button.Color;
      Label2.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 6 then
    begin
      Label6.Color := Old_Button.Color;
      Label6.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 5 then
    begin
      Label5.Color := Old_Button.Color;
      Label5.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 3 then
    begin
      Label3.Color := Old_Button.Color;
      Label3.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 7 then
    begin
      Label7.Color := Old_Button.Color;
      Label7.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 9 then
    begin
      Label9.Color := Old_Button.Color;
      Label9.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 4 then
    begin
      Label4.Color := Old_Button.Color;
      Label4.Font.Color := Old_Button.Font.Color;
    end;
    if I <> 8 then
    begin
      Label8.Font.Color := Old_Button.Font.Color;
      Label8.Color := Old_Button.Color;
    end;
    if I <> 12 then
    begin
      Label12.Font.Color := Old_Button.Font.Color;
      Label12.Color := Old_Button.Color;
    end;
    if I <> 13 then
    begin
      Label13.Font.Color := Old_Button.Font.Color;
      Label13.Color := Old_Button.Color;
    end;
    if I <> 14 then
    begin
      Label14.Font.Color := Old_Button.Font.Color;
      Label14.Color := Old_Button.Color;
    end;
    if I <> 15 then
    begin
      Label10.Font.Color := Old_Button.Font.Color;
      Label10.Color := Old_Button.Color;
    end;
  end;
end;

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.CheckBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.CheckBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  Button1Click(Form1);
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  Button1Click(Form1);
end;

procedure TForm1.Image4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label6MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
  Button2Click(Form1);
end;

procedure TForm1.Image8MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button8MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label7MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image9MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label9Click(Sender: TObject);
begin
  Button9Click(Form1);
end;

procedure TForm1.Label9MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image11MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button9MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button6MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label8MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image6MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button7MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label12MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button11MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  X, Y: Double;
  BiDiModes: TBiDiMode;
  LPDFEngine: TgtPDFEngine;
  LUnicode: TWideStrings;
  I: Integer;
begin
  LPDFEngine := TgtPDFEngine.Create(Self);
  LUnicode := TWideStrings.Create;
  LUnicode.LoadFromFile('UnicodeText.txt');
  with LPDFEngine do
  begin
    Font.Name := 'Calibri';
    Font.Size := -16;
    Page.PaperSize := A3;
    FileName := ExtractFilePath(Application.ExeName) +
      'edocengine_v3_Unicode_Demo3.pdf';
    BeginDoc;
    Y := 0.2;
    // Write text in multiple BiDi modes
    for BiDiModes := Low(TBiDiMode) to High(TBiDiMode) do
    begin
      BiDiMode := BiDiModes;
      TextOut(4, Y, 'BiDimode is ' + GetEnumName(TypeInfo(TBiDiMode),
        Ord(BiDiModes)));
      X := Y + 0.3;
      for I := 0 to LUnicode.Count - 1 do
      begin
        TextOut(4, X, LUnicode[I]);
        X := X + 0.25;
      end;
      Y := Y + 3.5 + 0.6;
    end;
    LUnicode.Free;
    EndDoc;
  end;
end;

procedure TForm1.Button12MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label13MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image13MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Button10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Image14MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label14MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  Button2Click(Form1);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
  Button5Click(Form1);
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
  Button6Click(Form1);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
  Button3Click(Form1);
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
  Button7Click(Form1);
end;

procedure TForm1.Label10Click(Sender: TObject);
begin
  Button12Click(Form1);
end;

procedure TForm1.Label10MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  changecolor(Sender);
end;

procedure TForm1.Label12Click(Sender: TObject);
begin
  Button4Click(Form1);
end;

procedure TForm1.Label13Click(Sender: TObject);
begin
  Button11Click(Form1);
end;

procedure TForm1.Label14Click(Sender: TObject);
begin
  Button10Click(Form1);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  Button8Click(Form1);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  Button8Click(Form1);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  Button5Click(Form1);
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
  Button6Click(Form1);
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  Button9Click(Form1);
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  Button3Click(Form1);
end;

procedure TForm1.Image10Click(Sender: TObject);
begin
  Button7Click(Form1);
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  Button4Click(Form1);
end;

procedure TForm1.Image13Click(Sender: TObject);
begin
  Button11Click(Form1);
end;

procedure TForm1.Image14Click(Sender: TObject);
begin
  Button10Click(Form1);
end;

end.
