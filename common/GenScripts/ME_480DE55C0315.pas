unit afwMultiDocumentPreview;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , afwDocumentPreviewList
 , afwTypes
 , l3Interfaces
 , l3Core
;

type
 TafwMultiDocumentPreview = class(Tl3CacheableBase, IafwDocumentPreview, IafwMultiDocumentPreview)
  function Make: IafwMultiDocumentPreview;
   {* ������� ��������� ������ � ���� ���������� IafwMultiDocumentPreview. }
  function GetDocumentName: IafwCString;
  function DocumentName: IafwCString;
   {* ��� ��������� ��� preview. }
  function InProcess: Boolean;
   {* ���� �������? }
  function InPagesCounting: Boolean;
   {* ������ � �������� �������� �������? }
  function InUpdate: Boolean;
   {* ��������� � �������� ���������� preview? }
  function InPrinting: Boolean;
   {* ��������� � �������� ���������� ������? }
  procedure Update(const aPanel: IafwPreviewPanel);
   {* ���������� preview �� ������ ��� �����������. }
  procedure Print(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager;
   aCopies: Integer;
   const aFileName: AnsiString;
   aCollate: Boolean);
   {* ���������� �� �������. }
  procedure Stop(aWnd: THandle);
   {* ��������� ������� ���������� preview/������. }
  function Stopped: Boolean;
   {* ������� ����������? }
  function CloseRequested: Boolean;
   {* ��� ��������� �������� ��� ������ �� �������� ������ }
  function PreviewResetting: Boolean;
   {* ����� �����������, �� ����� �������������� }
  procedure SetCurrentPage(const aCursor: IUnknown);
   {* ������������� ������ �� ������� ��������. }
  procedure SetCurrentPagePara(aParaID: Integer);
   {* ������������� ������ �� ������� ��������. }
  procedure SetCurrentPageNumber(aPageNumber: Integer);
   {* ������������� ������ �� ������� ��������. }
  function CurrentPage: Integer;
   {* ������� �������� ��� ������. }
  function HasCurrentPage: Boolean;
   {* ����������� �� ������� ��������. }
  function Printer: IafwPrinter;
   {* ������� ��� Preview/������. }
  function HasText: Boolean;
   {* ���� �� ����� ��� ������. }
  procedure AddDocument(const aDocument: IafwDocumentPreview);
   {* ��������� �������� � �����. }
  function DocCount: Integer;
  function PagesInfo: TafwPagesInfo;
 end;//TafwMultiDocumentPreview
 
implementation

uses
 l3ImplUses
 , l3Printer
 , SysUtils
;

end.
