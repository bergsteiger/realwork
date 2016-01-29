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
   {* �������� �� �������� � ������. }
  procedure AddParaOnPage(aParaID: Integer;
   aPageNumber: Integer);
 end;//TnevPages
 
 TafwLastPage = record
 end;//TafwLastPage
 
 TafwPreviewCanvas = class(Tl3Canvas, IafwPreviewCanvas)
  {* ���������� ����� ��� ������. }
  procedure Create(const aPrinter: IafwPrinter;
   aIsPageCounter: Boolean;
   const aPagesInfo: TafwPagesInfo);
  function IsMonochrome: Boolean;
   {* true, ���� ���������� ���������� �� ������������ ����; ����������, ����� ��-��������� �������� ����. }
  function GetPagesCount: Integer;
   {* ����� ��������� � ��������� (���������� ������� "� ������"). }
  function GetPagesWidthCount(aIndex: Integer): Integer;
   {* ������� ������� � ������, ��� �������� ��������. }
  function GetPageByObject(anObjectID: Integer): Integer;
   {* �������� �� �������� � ������. }
  function GetMMPageWidth(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ������ �������� � ��. }
  function GetMMPageHeight(aIndex: Integer;
   aWIndex: Integer): Integer;
   {* ������ (�����) �������� � ��. }
  procedure DrawTo(aIndex: Integer;
   aWIndex: Integer;
   const aRect: TRect;
   aBitmap: VCLBitmap);
   {* ������ �������� � �������������� �� ������� }
  function GetIntervalPages(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager): TafwPrintPagesArray;
   {* �������� ������ �������, �� ���������. }
  procedure Drop;
   {* ���������� �������� �� ����. }
  function IsPagesCounter: Boolean;
   {* ����� ��� �������� ����� �������? }
  function PreviewPage(aIndex: Integer;
   aWIndex: Integer): IafwPreviewPage;
   {* �������� preview. }
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
