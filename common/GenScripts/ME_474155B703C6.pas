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
  {* ������, ����������� �������� preview. }
  procedure Create(aCanvas: Tl3Canvas);
  function Make(aCanvas: Tl3Canvas): IafwPreviewPage;
  procedure Start(aCanvas: Tl3Canvas);
   {* ������ ��������� ��������. }
  procedure InitCanvas(aCanvas: Tl3Canvas);
  procedure ReadDCMetrics(const aCanvas: Il3InfoCanvas);
  function PageNumber: Integer;
   {* ����� �������� � ������. }
  function PageWidthNumber: Integer;
   {* ����� �������� � ������. }
  procedure Add(const aPage: IafwPreviewPage);
   {* ��������� �������� � ������. }
  procedure Drop(aCounter: Boolean);
   {* ���������� �������� �� ����. }
  procedure Finish(aPageNumber: Integer;
   aPageWidthNumber: Integer;
   anOverallPageNumber: Integer);
   {* ��������� ���������� ��������. }
  function GetMMWidth: Integer;
   {* ������ �������� � ��. }
  function GetMMHeight: Integer;
   {* ������ (�����) �������� � ��. }
  procedure DrawTo(const aRect: TRect;
   aBitmap: VCLBitmap);
   {* ������ �������� � �������������� �� ������� }
  function WidthCount: Integer;
   {* ���������� ������� � ������. }
  function WidthPage(anIndex: Integer): IafwPreviewPage;
   {* �������� � ������. }
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
