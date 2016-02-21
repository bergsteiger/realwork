unit GarantPDFDocument;
 {* «аточенный под наши задачи PDF-класс. }

// ћодуль: "w:\common\components\rtl\external\SynPDF\GarantPDFDocument.pas"
// —тереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\SynPDF\Synopse.inc}

interface

uses
 l3IntfUses
 , SynPDF
 , Graphics
;

const
 cnDefaultPDFDPI = 72;

type
 TGarantPDFDocument = class(TPdfDocument)
  {* «аточенный под наши задачи PDF-класс. }
  private
   f_Scale: Single;
   f_DevFactor: Single;
    {* «адублированна€ переменна€ из TpdfCanvas, т.к. "оригинальна€" считаетс€ внутри RenderMetaFile, когда нужны другие расчеты. }
  protected
   procedure InitPrinterPxPerInch(anPPIX: Integer;
    anPPIY: Integer);
   procedure DoSet4Etalon(aValue: Boolean); override;
  public
   constructor Create(aPPX: Integer;
    aPPY: Integer;
    aForEtalon: Boolean); reintroduce;
   procedure RenderNewPage(aMetaFile: TMetafile;
    anOrientation: Boolean);
    {* —пециализированна€ отрисовка дл€ наших нужд. }
 end;//TGarantPDFDocument

implementation

uses
 l3ImplUses
 , Windows
;

procedure TGarantPDFDocument.InitPrinterPxPerInch(anPPIX: Integer;
 anPPIY: Integer);
//#UC START# *54632B750318_54632B090390_var*
//#UC END# *54632B750318_54632B090390_var*
begin
//#UC START# *54632B750318_54632B090390_impl*
 FPrinterPxPerInch.X := anPPIX;
 FPrinterPxPerInch.Y := anPPIY;
//#UC END# *54632B750318_54632B090390_impl*
end;//TGarantPDFDocument.InitPrinterPxPerInch

constructor TGarantPDFDocument.Create(aPPX: Integer;
 aPPY: Integer;
 aForEtalon: Boolean);
//#UC START# *54632D530392_54632B090390_var*
//#UC END# *54632D530392_54632B090390_var*
begin
//#UC START# *54632D530392_54632B090390_impl*
 inherited Create(False, RUSSIAN_CHARSET);
 f_Scale := ScreenLogPixels / aPPX;
 f_DevFactor := f_Scale * cnDefaultPDFDPI / ScreenLogPixels;
 InitPrinterPxPerInch(aPPX, aPPY);
 GeneratePDF15File := True;
 UseUniscribe := False;
 if aForEtalon then
 begin
  EmbeddedTTF := False;
  GeneratePDF15File := False;
  CompressionMethod := cmNone;
 end // if aForEtalon then
 else
  EmbeddedTTF := True;
//#UC END# *54632D530392_54632B090390_impl*
end;//TGarantPDFDocument.Create

procedure TGarantPDFDocument.RenderNewPage(aMetaFile: TMetafile;
 anOrientation: Boolean);
 {* —пециализированна€ отрисовка дл€ наших нужд. }
//#UC START# *54632E0400DF_54632B090390_var*
var
 l_Top        : Single;
 l_Page       : TPdfPage;
 l_Right      : Single;
 l_TextWidth  : Single;
 l_TextHeight : Single;
//#UC END# *54632E0400DF_54632B090390_var*
begin
//#UC START# *54632E0400DF_54632B090390_impl*
 l_Page := AddPage;
 l_Page.PageLandscape := anOrientation;
 l_TextWidth := aMetaFile.Width * f_DevFactor;
 l_TextHeight := aMetaFile.Height * f_DevFactor;
 l_Top := (l_Page.PageHeight - l_TextHeight) / 2;
 if l_Top < 0 then l_Top := 0;
 l_Right := (l_Page.PageWidth - l_TextWidth) / 2;
 if l_Right < 0 then l_Right := 0;
 Canvas.RenderMetaFile(aMetaFile, f_Scale, l_Right, l_Top);
//#UC END# *54632E0400DF_54632B090390_impl*
end;//TGarantPDFDocument.RenderNewPage

procedure TGarantPDFDocument.DoSet4Etalon(aValue: Boolean);
//#UC START# *56B471530132_54632B090390_var*
//#UC END# *56B471530132_54632B090390_var*
begin
//#UC START# *56B471530132_54632B090390_impl*
 if aValue then
 begin
  EmbeddedTTF := False;
  GeneratePDF15File := False;
  CompressionMethod := cmNone;
 end // if aForEtalon then
 else
  EmbeddedTTF := True;
//#UC END# *56B471530132_54632B090390_impl*
end;//TGarantPDFDocument.DoSet4Etalon

end.
