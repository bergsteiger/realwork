unit afwPreviewPage;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , l3Metafile
 , afwPreviewPageList
 , l3Canvas
 , l3InternalInterfaces
 , l3Core
 , l3Interfaces
;

type
 TafwPreviewPage = class(Tl3ProtoObject, IafwPreviewPage)
  {* Объект, реализующий страницу preview. }
  procedure Create(aCanvas: Tl3Canvas);
  function Make(aCanvas: Tl3Canvas): IafwPreviewPage;
  procedure Start(aCanvas: Tl3Canvas);
   {* начать генерацию страницы. }
  procedure InitCanvas(aCanvas: Tl3Canvas);
  procedure ReadDCMetrics(const aCanvas: Il3InfoCanvas);
  function PageNumber: Integer;
   {* номер страницы в высоту. }
  function PageWidthNumber: Integer;
   {* номер страницы в ширину. }
  procedure Add(const aPage: IafwPreviewPage);
   {* добавляет страницу в ширину. }
  procedure Drop(aCounter: Boolean);
   {* сбрасывает страницу на диск. }
  procedure Finish(aPageNumber: Integer;
   aPageWidthNumber: Integer;
   anOverallPageNumber: Integer);
   {* завершает построение страницы. }
  function GetMMWidth: Integer;
   {* ширина страницы в мм. }
  function GetMMHeight: Integer;
   {* высота (длина) страницы в мм. }
  procedure DrawTo(const aRect: TRect;
   aBitmap: VCLBitmap);
   {* рисует страницу в прямоугольнике на битмапе }
  function WidthCount: Integer;
   {* количество страниц в ширину. }
  function WidthPage(anIndex: Integer): IafwPreviewPage;
   {* страницы в ширину. }
  function OverallPageNumber: Integer;
 end;//TafwPreviewPage
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3DataCache
 , l3Math
 , l3Const
 , Graphics
 , Windows
 , afwPreviewPageSpy
;

end.
