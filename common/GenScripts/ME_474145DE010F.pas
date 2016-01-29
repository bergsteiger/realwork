unit afwPreviewCanvas;

interface

uses
 l3IntfUses
 , l3Canvas
 , afwInterfaces
 , afwPreviewPageList
 , afwTypes
 , l3Core
 , l3Interfaces
 , l3Units
 , l3BaseWithLargeIDList
 , l3BaseWithID
;

type
 TnevPages = class(Tl3BaseWithLargeIDList)
  function GetPageByObject(anObjectID: Integer): Integer;
   {* страница по смещению с начала. }
  procedure AddParaOnPage(aParaID: Integer;
   aPageNumber: Integer);
 end;//TnevPages
 
 TafwLastPage = record
 end;//TafwLastPage
 
 TafwPreviewCanvas = class(Tl3Canvas, IafwPreviewCanvas)
  {* Реализация канвы для печати. }
  procedure Create(const aPrinter: IafwPrinter;
   aIsPageCounter: Boolean;
   const aPagesInfo: TafwPagesInfo);
  function IsMonochrome: Boolean;
   {* true, если устройство назначения не поддерживает цвет; определяет, будет по-умолчанию подавлен цвет. }
  function GetPagesCount: Integer;
   {* длина документа в страницах (количество страниц "в высоту"). }
  function GetPagesWidthCount(aIndex: Integer): Integer;
   {* сколько страниц в ширину, для заданной страницы. }
  function GetPageByObject(anObjectID: Integer): Integer;
   {* страница по смещению с начала. }
  function GetMMPageWidth(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ширина страницы в мм. }
  function GetMMPageHeight(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* высота (длина) страницы в мм. }
  procedure DrawTo(aIndex: Integer;
   aWIndex: Integer;
   const aRect: TRect;
   aBitmap: VCLBitmap);
   {* рисует страницу в прямоугольнике на битмапе }
  function GetIntervalPages(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager): TafwPrintPagesArray;
   {* получает массив страниц, по диапазону. }
  procedure Drop;
   {* сбрасывает страницы на диск. }
  function IsPagesCounter: Boolean;
   {* канва для подсчета числа страниц? }
  function PreviewPage(aIndex: Integer;
   aWIndex: Integer): IafwPreviewPage;
   {* страница preview. }
  function PagesInfo: TafwPagesInfo;
 end;//TafwPreviewCanvas
 
implementation

uses
 l3ImplUses
 , SysUtils
 , afwFacade
 , afwPreviewPage
;

type
 TnevPage = class(Tl3BaseWithID)
  procedure Create(aParaID: Integer;
   aPageNumber: Integer);
 end;//TnevPage
 
end.
