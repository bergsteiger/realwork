unit WebServer;

interface

//Remove the dot (.) below to configure demo for eDocEngine Pro
{.$DEFINE gtPro}

uses
  SysUtils, Classes, HTTPApp, Graphics, gtDocProducer, gtClasses3, gtCstDocEng,
  gtCstPlnEng, gtCstPDFEng, gtPDFEng
  {$IFDEF gtPro}
  , gtExPDFEng
  {$ENDIF}
  ;

type
  TwmdEngineProducer = class(TWebModule)
    gtPDFEngine1: TgtPDFEngine;
    gtDocProducer1: TgtDocProducer;
    procedure gtDocProducer1CreateContent(Sender: TgtDocProducer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wmdEngineProducer: TwmdEngineProducer;

implementation

{$R *.dfm}

procedure TwmdEngineProducer.gtDocProducer1CreateContent(
  Sender: TgtDocProducer);
var
  LS: string;
  LState1, LState2, LState3, LState4: Integer;
begin
	with TgtPDFEngine(Sender.Engine) do
  begin
    BeginDoc;
		LS := 'Gnostice eDocEngine is a comprehensive, generic, electronic' +
      ' document creation component suite for Borland® Delphi™' +
      ' and Borland® C++Builder™. eDocEngine enables developers to deliver' +
      ' information straight from the applications they develop in over 20' +
      ' popular electronic document formats, including PDF, HTML, RTF, TIFF,' +
      ' XML graphics and many more.';
    MeasurementUnit := muPixels;
    Page.PaperSize := A4;
    BeginDoc;
      if (EngineStatus <> esStarted) then Exit;
      TextFormatting.Alignment := haCenter;
      TextFormatting.BeforeSpace := 60;
      Font.Size := 18;
      Font.Color := clBlue;
      Font.Style := [fsBold];
      BeginPara;
        TextOut('Gnostice eDocEngine WebServer Application');
      EndPara;
      TextFormatting.BeforeSpace := 5;
      Font.Size := 14;
      BeginPara;
        TextOut('Simple Page Producer Demo');
      EndPara;
      Font.Size := 8;
      Font.Style := [];
      with TableSettings do
      begin
        ColumnWidth := 100;
        RowHeight := 40;
        EnableTitle := True;
        TitleHeight := 20;
        InternalMargin := gtRect(5,5,5,5);
      end;
      ImageSettings.Stretch := True;

      LState1 := SaveEngineState;
      TextFormatting.BeforeSpace := 25;
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
      Font.Size := 10;
      BeginPara;
	      TextOut('Align Left');
      EndPara;
      LState4 := SaveEngineState;
      TextFormatting.RightIndent := 75;
      TextFormatting.LeftIndent := 75;
      TextFormatting.BeforeSpace := 5;
      Font.Size := 12;
      Font.Color := clMaroon;
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

      BeginPara;
	      TextOut('Textbox Support');
      EndPara;

      LS := 'eDocEngine enables developers to deliver ' +
        'information straight from the applications they develop in over 20 ' +
        'popular electronic document formats. Rich content can be easily ' +
        'formatted to the precise look and feel required and delivered ' +
        'directly to users’ web browsers, sent as email attachments or saved '+
        'to disk. Actionable and navigational elements can be easily added ' +
        'to created documents to provide interactivity and enhance the ' +
        'overall user experience. eDocEngine currently supports the creation ' +
        'of documents in PDF, RTF, HTML, XHTML, EXCEL, TEXT, CSV, Quattro ' +
        'Pro, LOTUS 1-2-3, DIF, SYLK, TIFF, PNG, SVG (XML based vector ' +
        'graphics), JPEG, GIF, BMP, EMF and WMF formats. Metafile, BMP, DIF, ' +
        'SYLK and Text can be directly output to the Windows® Clipboard. ' +
        'eDocEngine does not use any external software or require any DLLs ' +
        'to be deployed for creation of documents in any of the formats. ' +
        'eDocEngine also exports from QuickReport, ReportBuilder, FastReport, ' +
        'Rave Reports, AceReporter, Express Printing System, TRichView, ' +
        'ThtmlViewer, GmPrintSuite and more.';

      RestoreEngineState(LState1);
      {$IFDEF VER140}
      Brush.Color := clCream;
      {$ELSE}
      Brush.Color := clWhite;
      {$ENDIF}

      Pen.Width := 3;

      Frame.InternalMargin := gtRect(5, 5, 4, 4);
      TextBox(gtRect(40, 815, 350, 1075), LS,
        haJustify, vaTop);

      Pen.Style := psDash;
      TextBox(gtRect(430, 815, 740, 1075), LS,
        haJustify, vaTop);

    EndDoc;
  end;
end;

end.
