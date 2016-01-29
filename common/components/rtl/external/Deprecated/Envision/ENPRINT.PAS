{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnPrint
|
| Description: Printer class to print TDibGraphic's.
|
| History: Feb 14, 1999. Michel Brazeau, first version
|          Jun 19, 1999. Michel Brazeau, add LeftMargin, TopMargin,
|                        UsePrintJob properties.
|                        Add GutterLeft, GutterRight fields to TPrintMetrics
|                        record
|          Sep 03, 1999. Michel Brazeau, UsePrintJob did not work when set to
|                        False. The printer metrics must be read before
|                        Printer.BeginDoc otherwise an exception is raised.
|                        The printer metrics are read when the print mode is
|                        changed.
|
|
|
|---------------------------------------------------------------------------}
unit EnPrint;

{$I Envision.Inc}

interface

uses
    EnDiGrph;  { for TDibGraphic }

type

TPrinterMetrics = packed record
    PrintableWidth  : LongInt;
    PrintableHeight : LongInt;
    XPixelsPerInch  : LongInt;
    YPixelsPerInch  : LongInt;
    GutterTop       : LongInt;
    GutterLeft      : LongInt;
    GutterBottom    : LongInt;
    GutterRight     : LongInt;
end;


TEnvisionPrintMode =
    ( pmOriginalSize,
      pmFullPage,
      pmSpecificWidth,
      pmSpecificHeight,
      pmSpecificWidthAndHeight,
      pmStretchToPage );

TDibGraphicPrinter = class(TObject)
protected
    FPrintMode      : TEnvisionPrintMode;
    FWidth          : Double;
    FHeight         : Double;
    FUsePrintJob    : Boolean;

    FPrinterMetrics : TPrinterMetrics;

    FLeftMargin     : Double;
    FTopMargin      : Double;

    FTitle          : String;

    procedure SetPrintMode( const InPrintMode : TEnvisionPrintMode );

public
    constructor Create;

    procedure Print( const Graphic : TDibGraphic );

    property PrintMode : TEnvisionPrintMode read FPrintMode
                                            write SetPrintMode;

    { Dimensions are in inches. Use EnMisc.CmToInches to use metric
      units. }
    property Width  : Double read FWidth write FWidth;
    property Height : Double read FHeight write FHeight;

    { Left and top margins in inches. These properties do not have any
      effect with the pmFullPage and pmStretchToPage print modes. }
    property LeftMargin : Double read FLeftMargin write FLeftMargin;
    property TopMargin  : Double read FTopMargin write FTopMargin;

    { if UsePrintJob is True, each call to Print will create a new
      print job. If False, Printer.BeginDoc followed by Printer.EndDoc or
      Printer.Abort must be called outside of the Print method.
      Default is True. }
    property UsePrintJob : Boolean read FUsePrintJob
                                   write FUsePrintJob;

    { Title that appears in the print manager for a print job. The Title
      property is only applicable when UsePrintJob is True. When
      UsePrintJob is False, the title must be set by the user in the
      printer object itself, before invoking Printer.BeginDoc, for example,

      GraphicPrinter.UsePrintJob := False;
      Printer.Title := 'Document Name';
      Printer.BeginDoc;
      GraphicPrinter.Print(...);
      Printer.EndDoc;  }
    property Title : String read FTitle write FTitle;

end;

{ returns the metrics (dimensions) of the currently selected printer. }
procedure GetPrinterMetrics( var PrinterMetrics : TPrinterMetrics );

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for TRect }
    Printers, { for Printer }
    EnMisc;   { for BeginHourglass, ... }

procedure GetPrinterMetrics( var PrinterMetrics : TPrinterMetrics );
var
    Point : TPoint;
begin
    with PrinterMetrics do
    begin
        YPixelsPerInch  := Windows.GetDeviceCaps( Printer.Handle, LOGPIXELSY );
        XPixelsPerInch  := Windows.GetDeviceCaps( Printer.Handle, LOGPIXELSX );

        PrintableWidth  := Windows.GetDeviceCaps(Printer.Handle, HorzRes);
        PrintableHeight := Windows.GetDeviceCaps(Printer.Handle, VertRes);

        Windows.Escape( Printer.Handle, GETPRINTINGOFFSET, 0, Nil, @Point );
        GutterLeft := Point.X;
        GutterTop  := Point.Y;

        Escape( Printer.Handle, GETPHYSPAGESIZE, 0, Nil, @Point );

        GutterRight  := Point.X - GutterLeft - Printer.PageWidth;
        GutterBottom := Point.Y - GutterTop - Printer.PageHeight;
    end;
end;

{--------------------------------------------------------------------------}

constructor TDibGraphicPrinter.Create;
begin
    PrintMode    := pmFullPage;

    FWidth       := 5;
    FHeight      := 5;

    FLeftMargin  := 0;
    FTopMargin   := 0;

    FUsePrintJob := True;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphicPrinter.Print( const Graphic : TDibGraphic );
var
    Rect           : TRect;
    XFactor        : Double;
    YFactor        : Double;
    ScaleFactor    : Single;
    XOffset        : LongInt;
    YOffset        : LongInt;
begin
    Rect.Left   := 0;
    Rect.Top    := 0;

    { MB Sep 02, 1999. Only when UsePrintJob is True it's possible to
      automatically set the orientation, otherwise an exception is raised
      as Printer.BeginDoc has already been called. }
    if UsePrintJob then
    begin
        if Graphic.Width > Graphic.Height then
            Printer.Orientation := poLandscape
        else
            Printer.Orientation := poPortrait;
    end;

    case PrintMode of
        pmOriginalSize :
        begin
            XFactor   := (FPrinterMetrics.XPixelsPerInch*1.0)/Graphic.XDotsPerInch;
            YFactor   := (FPrinterMetrics.YPixelsPerInch*1.0)/Graphic.YDotsPerInch;

            Rect.Right  := Trunc(Graphic.Width * XFactor);
            Rect.Bottom := Trunc(Graphic.Height * YFactor);

            ScaleFactor := MinFloat( FPrinterMetrics.PrintableWidth / Rect.Right,
                                     FPrinterMetrics.PrintableHeight / Rect.Bottom );

            { if the image is larger than the printable area, shrink it to
              fit the page. }
            if ScaleFactor < 1.0 then
            begin
                Rect.Right  := Trunc(ScaleFactor * Rect.Right);
                Rect.Bottom := Trunc(ScaleFactor * Rect.Bottom);
            end;
        end;
        pmSpecificWidth :
        begin
            Rect.Right  := Trunc(Self.Width * FPrinterMetrics.XPixelsPerInch);
            XFactor     := Rect.Right / (Graphic.Width*1.0);
            Rect.Bottom := Trunc(XFactor * Graphic.Height);
        end;
        pmSpecificHeight :
        begin
            Rect.Bottom  := Trunc(Self.Height * FPrinterMetrics.YPixelsPerInch);
            YFactor      := Rect.Bottom / (Graphic.Height*1.0);
            Rect.Right   := Trunc(YFactor * Graphic.Width);
        end;
        pmSpecificWidthAndHeight :
        begin
            Rect.Right  := Trunc(Self.Width * FPrinterMetrics.XPixelsPerInch);
            Rect.Bottom := Trunc(Self.Height * FPrinterMetrics.YPixelsPerInch);
        end;
        pmStretchToPage :
        begin
            Rect.Right  := FPrinterMetrics.PrintableWidth-1;
            Rect.Bottom := FPrinterMetrics.PrintableHeight-1;
        end;
        else
        begin
            { use pmFullPage if any other value }

            { try with a full page width }
            Rect.Right  := FPrinterMetrics.PrintableWidth;
            XFactor     := Rect.Right / (Graphic.Width*1.0);
            Rect.Bottom := Trunc(XFactor * Graphic.Height);

            if Rect.Bottom >= FPrinterMetrics.PrintableHeight then
            begin
                Rect.Bottom  := FPrinterMetrics.PrintableHeight;
                YFactor      := Rect.Bottom / (Graphic.Height*1.0);
                Rect.Right   := Trunc(YFactor * Graphic.Width);
            end;
        end;
    end; { case }

    if not (PrintMode in [pmFullPage, pmStretchToPage]) then
    begin
        XOffset     := Trunc(FPrinterMetrics.XPixelsPerInch * FLeftMargin) - FPrinterMetrics.GutterLeft;
        YOffset     := Trunc(FPrinterMetrics.YPixelsPerInch * FTopMargin) - FPrinterMetrics.GutterTop;

        if XOffset < 0 then
            XOffset := 0;

        if YOffset < 0 then
            YOffset := 0;

        Rect.Left   := Rect.Left + XOffset;
        Rect.Right  := Rect.Right + XOffset;

        Rect.Top    := Rect.Top + YOffset;
        Rect.Bottom := Rect.Bottom + YOffset;

    end;

    BeginHourglass;
    try
        if FUsePrintJob then
        begin
            Printer.Title := Self.Title;
            Printer.BeginDoc;
        end;
        try
            Printer.Canvas.StretchDraw(Rect, Graphic);

            if FUsePrintJob then
                Printer.EndDoc;
        except
            if FUsePrintJob then
                Printer.Abort;
            raise;
        end;
    finally
        EndHourglass;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDibGraphicPrinter.SetPrintMode( const InPrintMode : TEnvisionPrintMode );
begin
    { Set the printer orientation to match the graphic characteristics. }
    if PrintMode = pmSpecificWidthAndHeight then
    begin
        if Self.Width > Self.Height then
            Printer.Orientation := poLandscape
        else
            Printer.Orientation := poPortrait;
    end;

    GetPrinterMetrics(FPrinterMetrics);

    { MB Oct 20, 1999. This assignment was inadvertently left out in a
      previous change }
    FPrintMode := InPrintMode;
end;

{--------------------------------------------------------------------------}

end.
