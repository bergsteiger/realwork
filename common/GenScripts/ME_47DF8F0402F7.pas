unit afwComplexDocumentPreview;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , afwPreviewNotifierPtrList
 , afwTypes
 , l3Interfaces
 , l3Core
 , l3IID
;

type
 TafwDocumentPreviewArray = array [TafwPreviewContentKind] of IafwDocumentPreview;
 
 TafwComplexDocumentPreview = class(Tl3CacheableBase, IafwDocumentPreview, IafwPreviewNotifier, IafwComplexDocumentPreview, IafwPreviewNotificationSource)
  {* ��������������� �������� ������ ���������� ���������. }
  procedure CheckPrinter(aKind: TafwPreviewContentKind);
  procedure CheckContent(aKind: TafwPreviewContentKind);
  procedure SetContent(aKind: TafwPreviewContentKind;
   const aValue: IafwDocumentPreview);
  procedure Create(const aDocument: IafwDocumentPreview;
   const anInfo: IafwDocumentPreview);
  function Make(const aDocument: IafwDocumentPreview;
   const anInfo: IafwDocumentPreview): IafwComplexDocumentPreview;
  procedure ContentChanged;
   {* ���������� preview ����������. }
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
  function ContentKind: TafwPreviewContentKind;
   {* ��� ������������� �������� ���������. }
  function Current: IafwDocumentPreview;
  function Document: IafwDocumentPreview;
  procedure SetDocument(const aDocument: IafwDocumentPreview);
  function Selection: IafwDocumentPreview;
  procedure SetSelection(const aSelection: IafwDocumentPreview);
  function Info: IafwDocumentPreview;
  procedure SetInfo(const anInfo: IafwDocumentPreview);
  procedure Subscribe(const aNotifier: IafwPreviewNotifier);
  procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
  function PagesInfo: TafwPagesInfo;
 end;//TafwComplexDocumentPreview
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Printer
 , l3Base
;

end.
