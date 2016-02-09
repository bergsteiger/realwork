unit ddPDFExporter;
 {* Обертка eDocEngine с нашей стороны. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddPDFExporter.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , Printers
 , l3PrinterInterfaces
 , l3SimpleObject
 , l3Metafile
 , Classes
 , GarantPDFDocument
 , l3InternalInterfaces
;

type
 IddPDFDoc = interface
  {* Интерфейс для управления созданием интерфейса. }
  ['{E6E53277-C4AE-498E-8F56-5704832CCA61}']
  procedure NewPage(aOrientation: TPrinterOrientation);
  procedure EndDoc;
 end;//IddPDFDoc

 TddPDFExporter = class;

 TddPDFCanvas = class
  {* Канвая для экспорта. }
  private
   f_PDFDoc: IddPDFDoc;
  public
   constructor Create(const anExpoter: TddPDFExporter;
    const aPrinter: Il3Printer); reintroduce;
 end;//TddPDFCanvas

 TddPDFExporter = class(Tl3SimpleObject, IddPDFDoc)
  {* Класс-обертка над gtPDFEng. }
  private
   f_Metafile: Tl3Metafile;
   f_Stream: TStream;
    {* ссылка на "внешний" поток. }
   f_PDFEngine: TGarantPDFDocument;
   f_Orientation: TPrinterOrientation;
   f_Canvas: TddPDFCanvas;
    {* Поле для свойства Canvas }
  private
   procedure CheckMetaFile;
   procedure ClearMetaFile;
   procedure CreatePDFEngine;
   procedure DeInitPDFEngine;
   procedure CreateCanvas(const aPrinter: Il3Printer);
   procedure DropMetaFile2PDF;
  protected
   function pm_GetCanvas: TddPDFCanvas; virtual;
   procedure NewPage(aOrientation: TPrinterOrientation);
   procedure EndDoc;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFileStream: TStream); reintroduce;
   function GetCanvas(const aPrinter: Il3Printer): Il3Canvas;
  private
   property Canvas: TddPDFCanvas
    read pm_GetCanvas;
 end;//TddPDFExporter

implementation

uses
 l3ImplUses
 , Graphics
 , SysUtils
 , l3Defaults
 , ddPicturePathListner
 , l3Math
 , l3Const
 , Windows
 , SynPDF
;

constructor TddPDFCanvas.Create(const anExpoter: TddPDFExporter;
 const aPrinter: Il3Printer);
//#UC START# *53FF0CB80082_53FF077501B7_var*
//#UC END# *53FF0CB80082_53FF077501B7_var*
begin
//#UC START# *53FF0CB80082_53FF077501B7_impl*
 CreateForPrinting(aPrinter);
 f_PDFDoc := anExpoter;
//#UC END# *53FF0CB80082_53FF077501B7_impl*
end;//TddPDFCanvas.Create

function TddPDFExporter.pm_GetCanvas: TddPDFCanvas;
//#UC START# *53FF0B94012E_53FF07670079get_var*
//#UC END# *53FF0B94012E_53FF07670079get_var*
begin
//#UC START# *53FF0B94012E_53FF07670079get_impl*
 Result := f_Canvas;
//#UC END# *53FF0B94012E_53FF07670079get_impl*
end;//TddPDFExporter.pm_GetCanvas

procedure TddPDFExporter.CheckMetaFile;
//#UC START# *53FF142B018D_53FF07670079_var*

 function lp_Inch2Cm(aInch: LongInt): LongInt;
 begin
  Result := l3MulDiv(aInch, l3mmInInch, l3Inch);
 end;        

//#UC END# *53FF142B018D_53FF07670079_var*
begin
//#UC START# *53FF142B018D_53FF07670079_impl*
 if (f_Metafile = nil) then
 begin
  f_Metafile := Tl3Metafile.Create;
  f_Metafile.MMWidth := lp_Inch2Cm(f_Canvas.SectionExtent.X) * 10;
  f_Metafile.MMHeight := lp_Inch2Cm(f_Canvas.SectionExtent.Y) * 10; 
  f_Canvas.SetCanvas(TMetafileCanvas.Create(f_Metafile, f_Canvas.DC), false);
 end; // if (f_Metafile = nil) then
//#UC END# *53FF142B018D_53FF07670079_impl*
end;//TddPDFExporter.CheckMetaFile

procedure TddPDFExporter.ClearMetaFile;
//#UC START# *53FF145301E1_53FF07670079_var*
{$IFDEF DEBUG_WMF}
var
 l_Ext     : AnsiString;
 l_FileName: AnsiString;
{$ENDIF DEBUG_WMF}
//#UC END# *53FF145301E1_53FF07670079_var*
begin
//#UC START# *53FF145301E1_53FF07670079_impl*
 if (f_PDFEngine <> nil) and (f_Metafile <> nil) then
 begin
{$IFDEF DEBUG_WMF}
  l_Ext := Format('%d_%d%s', [Canvas.PageNumber, Canvas.PageWidthNumber, '.emf']);
  l_FileName := ChangeFileExt(ParamStr(0), l_Ext);
  f_Metafile.SaveToFile(l_FileName);
{$ENDIF DEBUG_WMF}
  FreeAndNil(f_Metafile); // if (f_PDFEngine <> nil) and (f_Metafile <> nil) then
 end;
//#UC END# *53FF145301E1_53FF07670079_impl*
end;//TddPDFExporter.ClearMetaFile

procedure TddPDFExporter.CreatePDFEngine;
//#UC START# *53FF146A00A3_53FF07670079_var*
const
 csCompanyName = 'НПП "Гарант-Сервис"';
 csComment = 'Документ экспортирован из системы ГАРАНТ';
var
 l_ForEtalon: Boolean;
//#UC END# *53FF146A00A3_53FF07670079_var*
begin
//#UC START# *53FF146A00A3_53FF07670079_impl*
 if f_PDFEngine = nil then
 begin
  l_ForEtalon := False;
  {$IFDEF nsTest}
  l_ForEtalon := TddPicturePathListner.Instance.PDF4Etalon;
  {$ENDIF nsTest}
  f_PDFEngine := TGarantPDFDocument.Create(f_Canvas.PixelsPerInchX, f_Canvas.PixelsPerInchY, l_ForEtalon);
  with f_PDFEngine.Info do
  begin
   Author := csCompanyName;
   Creator := csComment;
   {$IFDEF nsTest}
   CreationDate := EncodeDate(2014, 11, 12);
   {$ENDIF nsTest}
  end; // with f_PDFEngine.Info do
 end; // if f_PDFEngine = nil then
//#UC END# *53FF146A00A3_53FF07670079_impl*
end;//TddPDFExporter.CreatePDFEngine

procedure TddPDFExporter.DeInitPDFEngine;
//#UC START# *53FF149700F5_53FF07670079_var*
//#UC END# *53FF149700F5_53FF07670079_var*
begin
//#UC START# *53FF149700F5_53FF07670079_impl*
 FreeAndNil(f_PDFEngine);
 {$IFDEF nsTest}
 TddPicturePathListner.Instance.PDF4Etalon := False;
 {$ENDIF nsTest}
//#UC END# *53FF149700F5_53FF07670079_impl*
end;//TddPDFExporter.DeInitPDFEngine

procedure TddPDFExporter.CreateCanvas(const aPrinter: Il3Printer);
//#UC START# *53FF14F40039_53FF07670079_var*
//#UC END# *53FF14F40039_53FF07670079_var*
begin
//#UC START# *53FF14F40039_53FF07670079_impl*
 if f_Canvas = nil then
  f_Canvas := TddPDFCanvas.Create(Self, aPrinter);
//#UC END# *53FF14F40039_53FF07670079_impl*
end;//TddPDFExporter.CreateCanvas

procedure TddPDFExporter.DropMetaFile2PDF;
//#UC START# *53FF16C2017E_53FF07670079_var*
//#UC END# *53FF16C2017E_53FF07670079_var*
begin
//#UC START# *53FF16C2017E_53FF07670079_impl*
 CreatePDFEngine;
 if (f_Metafile = nil) then
  CheckMetaFile
 else
 begin
  f_PDFEngine.RenderNewPage(f_Metafile, Boolean(f_Orientation));
  ClearMetaFile;
  CheckMetaFile;
 end; // if (f_Metafile <> nil) then
//#UC END# *53FF16C2017E_53FF07670079_impl*
end;//TddPDFExporter.DropMetaFile2PDF

constructor TddPDFExporter.Create(aFileStream: TStream);
//#UC START# *53FF174601A7_53FF07670079_var*
//#UC END# *53FF174601A7_53FF07670079_var*
begin
//#UC START# *53FF174601A7_53FF07670079_impl*
 inherited Create;
 f_Orientation := poPortrait;
 f_Stream := aFileStream;
//#UC END# *53FF174601A7_53FF07670079_impl*
end;//TddPDFExporter.Create

function TddPDFExporter.GetCanvas(const aPrinter: Il3Printer): Il3Canvas;
//#UC START# *53FF2DAF030C_53FF07670079_var*
//#UC END# *53FF2DAF030C_53FF07670079_var*
begin
//#UC START# *53FF2DAF030C_53FF07670079_impl*
 CreateCanvas(aPrinter);
 Result := Canvas;
//#UC END# *53FF2DAF030C_53FF07670079_impl*
end;//TddPDFExporter.GetCanvas

procedure TddPDFExporter.NewPage(aOrientation: TPrinterOrientation);
//#UC START# *53FF090F032F_53FF07670079_var*
//#UC END# *53FF090F032F_53FF07670079_var*
begin
//#UC START# *53FF090F032F_53FF07670079_impl*
 DropMetaFile2PDF;
 f_Orientation := aOrientation;
//#UC END# *53FF090F032F_53FF07670079_impl*
end;//TddPDFExporter.NewPage

procedure TddPDFExporter.EndDoc;
//#UC START# *53FF091B01DF_53FF07670079_var*
//#UC END# *53FF091B01DF_53FF07670079_var*
begin
//#UC START# *53FF091B01DF_53FF07670079_impl*
 if (f_PDFEngine <> nil) then
 begin
  DropMetaFile2PDF;
  f_PDFEngine.SaveToStream(f_Stream
  {$IFDEF nsTest}
  , EncodeDate(2014, 11, 12)
  {$ENDIF nsTest}
  );
  DeInitPDFEngine;
 end; // if f_PDFEngine <> nil then
//#UC END# *53FF091B01DF_53FF07670079_impl*
end;//TddPDFExporter.EndDoc

procedure TddPDFExporter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53FF07670079_var*
//#UC END# *479731C50290_53FF07670079_var*
begin
//#UC START# *479731C50290_53FF07670079_impl*
 f_Stream := nil;
 FreeAndNil(f_Canvas);
 FreeAndNil(f_Metafile);
 DeInitPDFEngine;
 inherited;
//#UC END# *479731C50290_53FF07670079_impl*
end;//TddPDFExporter.Cleanup

end.
