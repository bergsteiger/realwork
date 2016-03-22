unit GarantPDFDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SynPDF"
// Модуль: "w:/common/components/rtl/external/SynPDF/GarantPDFDocument.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::SynPDF::SynPDF::TGarantPDFDocument
//
// Заточенный под наши задачи PDF-класс.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\SynPDF\Synopse.inc}

interface

uses
  Graphics,
  SynPDF
  ;

const
  { PDFConsts }
 cnDefaultPDFDPI = 72;

type
 TGarantPDFDocument = class(TPdfDocument)
  {* Заточенный под наши задачи PDF-класс. }
 private
 // private fields
   f_Scale : Single;
   f_DevFactor : Single;
    {* Задублированная переменная из TpdfCanvas, т.к. "оригинальная" считается внутри RenderMetaFile, когда нужны другие расчеты.}
 protected
 // overridden protected methods
   procedure DoSet4Etalon(aValue: Boolean); override;
 protected
 // protected methods
   procedure InitPrinterPxPerInch(anPPIX: Integer;
     anPPIY: Integer);
 public
 // public methods
   constructor Create(aPPX: Integer;
     aPPY: Integer;
     aForEtalon: Boolean); reintroduce;
   procedure RenderNewPage(aMetaFile: TMetafile;
     anOrientation: Boolean);
     {* Специализированная отрисовка для наших нужд. }
 end;//TGarantPDFDocument

implementation

uses
  Windows
  ;

// start class TGarantPDFDocument

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
 ForEtalon := aForEtalon;
//#UC END# *54632D530392_54632B090390_impl*
end;//TGarantPDFDocument.Create

procedure TGarantPDFDocument.RenderNewPage(aMetaFile: TMetafile;
  anOrientation: Boolean);
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