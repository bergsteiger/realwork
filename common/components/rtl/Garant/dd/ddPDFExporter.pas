unit ddPDFExporter;
 {* Обертка eDocEngine с нашей стороны. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddPDFExporter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddPDFExporter" MUID: (53FF071F01E3)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , Printers
 , l3Canvas
 , l3PrinterInterfaces
 , l3Core
 , l3Units
 , l3InternalInterfaces
 , l3SimpleObject
 , l3Metafile
 , Classes
 , GarantPDFDocument
;

type
 IddPDFDoc = interface
  {* Интерфейс для управления созданием интерфейса. }
  ['{E6E53277-C4AE-498E-8F56-5704832CCA61}']
  procedure NewPage(aOrientation: TPrinterOrientation);
  procedure EndDoc;
 end;//IddPDFDoc

 TddPDFExporter = class;

 TddPDFCanvas = class(Tl3Canvas)
  {* Канвая для экспорта. }
  private
   f_PDFDoc: IddPDFDoc;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FillRectPrim(const R: TRect); override;
   procedure DoFillForeRect(const R: Tl3SRect); override;
   procedure DoStartDrawAAC(aType: TspBlockType); override;
   procedure DoEndDrawAAC(const R: Tl3Rect); override;
   function IsPreview: Boolean; override;
   procedure StartPage; override;
   procedure DoEndPaint; override;
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

procedure TddPDFCanvas.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53FF077501B7_var*
//#UC END# *479731C50290_53FF077501B7_var*
begin
//#UC START# *479731C50290_53FF077501B7_impl*
 f_PDFDoc := nil;
 inherited;
//#UC END# *479731C50290_53FF077501B7_impl*
end;//TddPDFCanvas.Cleanup

procedure TddPDFCanvas.FillRectPrim(const R: TRect);
//#UC START# *47DFCAAF0249_53FF077501B7_var*
//#UC END# *47DFCAAF0249_53FF077501B7_var*
begin
//#UC START# *47DFCAAF0249_53FF077501B7_impl*
 Canvas.FillRect(R);
//#UC END# *47DFCAAF0249_53FF077501B7_impl*
end;//TddPDFCanvas.FillRectPrim

procedure TddPDFCanvas.DoFillForeRect(const R: Tl3SRect);
//#UC START# *47DFCAEE0007_53FF077501B7_var*
const
 D = 8;
 D1 = 3;
//#UC END# *47DFCAEE0007_53FF077501B7_var*
begin
//#UC START# *47DFCAEE0007_53FF077501B7_impl*
 if (R.Bottom - R.Top < D) then
 begin
  if (R.Right - R.Left < D) then
   inherited
  else
  begin
   AddRect(l3SRect(R.Left, R.Top - D1, R.Right, R.Bottom + D1));
   Line(l3SPoint(R.Left, R.Top), l3SPoint(R.Right, R.Top));
  end;//R.Right - R.Left < D
 end//R.Bottom - R.Top < D
 else
 if (R.Right - R.Left < D) then
 begin
  AddRect(l3SRect(R.Left - D1, R.Top, R.Right + D1, R.Bottom));
  Line(l3SPoint(R.Left, R.Top), l3SPoint(R.Left, R.Bottom));
 end//R.Right - R.Left < D
 else
  inherited;
//#UC END# *47DFCAEE0007_53FF077501B7_impl*
end;//TddPDFCanvas.DoFillForeRect

procedure TddPDFCanvas.DoStartDrawAAC(aType: TspBlockType);
//#UC START# *54B4DDF502DD_53FF077501B7_var*
//#UC END# *54B4DDF502DD_53FF077501B7_var*
begin
//#UC START# *54B4DDF502DD_53FF077501B7_impl*
 GDICommentStatAAC(DC, aType);
//#UC END# *54B4DDF502DD_53FF077501B7_impl*
end;//TddPDFCanvas.DoStartDrawAAC

procedure TddPDFCanvas.DoEndDrawAAC(const R: Tl3Rect);
//#UC START# *54B4DE1700CA_53FF077501B7_var*
//#UC END# *54B4DE1700CA_53FF077501B7_var*
begin
//#UC START# *54B4DE1700CA_53FF077501B7_impl*
 GDICommentEndAAC(DC, TRect(WO(R)), BackColor);
//#UC END# *54B4DE1700CA_53FF077501B7_impl*
end;//TddPDFCanvas.DoEndDrawAAC

function TddPDFCanvas.IsPreview: Boolean;
//#UC START# *56B0B9790320_53FF077501B7_var*
//#UC END# *56B0B9790320_53FF077501B7_var*
begin
//#UC START# *56B0B9790320_53FF077501B7_impl*
 Result := True;
//#UC END# *56B0B9790320_53FF077501B7_impl*
end;//TddPDFCanvas.IsPreview

procedure TddPDFCanvas.StartPage;
//#UC START# *56B4B5EF019F_53FF077501B7_var*
var
 l_CR          : Tl3Rect;
 l_WO          : Tl3Point;
 l_Rect        : Tl3Rect;
 l_Canvas      : Il3Canvas;
 l_NeedCorrect : Boolean;
 l_BottomHeight: Integer;
//#UC END# *56B4B5EF019F_53FF077501B7_var*
begin
//#UC START# *56B4B5EF019F_53FF077501B7_impl*
 f_PDFDoc.NewPage(TPrinterOrientation(PageOrientation));
 WindowOrg := l3Point0;
 ClipRect := l3RectBnd(l3Point0,
                       DP2LP(l3SPoint(DeviceCaps(HORZRES),
                                      DeviceCaps(VERTRES))));
 Printed := true;
 l_BottomHeight := pm_GetMargins.Bottom;
 l_WO := WindowOrg;
 WindowOrg := l_WO;
 MoveWindowOrg(l3PointX(-WindowOrg.X));
 l_NeedCorrect := DeviceCaps(PHYSICALOFFSETY) = 0;
 MoveWindowOrg(l3PointY(-l_BottomHeight));
 l_Rect := ClipRect;
 if (l_Rect.Left < 0) then l_Rect.Left := 0;
 if (l_Rect.Top < 0) then l_Rect.Top := 0;
 if l_NeedCorrect then
  l_Rect.BottomRight := l_Rect.BottomRight.Sub(l3PointY(l_BottomHeight));
 ClipRect := l_Rect;
//#UC END# *56B4B5EF019F_53FF077501B7_impl*
end;//TddPDFCanvas.StartPage

procedure TddPDFCanvas.DoEndPaint;
//#UC START# *56B4BDA30301_53FF077501B7_var*
//#UC END# *56B4BDA30301_53FF077501B7_var*
begin
//#UC START# *56B4BDA30301_53FF077501B7_impl*
 inherited;
 SetCanvas(nil, false);
 if not Drawing then
 begin
  f_PDFDoc.EndDoc;
  f_PDFDoc := nil;
 end; // if not Drawing then
//#UC END# *56B4BDA30301_53FF077501B7_impl*
end;//TddPDFCanvas.DoEndPaint

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
