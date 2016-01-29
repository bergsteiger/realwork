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
  {* Предварительный просмотр печати составного документа. }
  procedure CheckPrinter(aKind: TafwPreviewContentKind);
  procedure CheckContent(aKind: TafwPreviewContentKind);
  procedure SetContent(aKind: TafwPreviewContentKind;
   const aValue: IafwDocumentPreview);
  procedure Create(const aDocument: IafwDocumentPreview;
   const anInfo: IafwDocumentPreview);
  function Make(const aDocument: IafwDocumentPreview;
   const anInfo: IafwDocumentPreview): IafwComplexDocumentPreview;
  procedure ContentChanged;
   {* Содержимое preview изменилось. }
  function DocumentName: IafwCString;
   {* имя документа для preview. }
  function InProcess: Boolean;
   {* идет процесс? }
  function InPagesCounting: Boolean;
   {* сейчас в процессе подсчета страниц? }
  function InUpdate: Boolean;
   {* находимся в процессе построения preview? }
  function InPrinting: Boolean;
   {* находимся в процессе построения печати? }
  procedure Update(const aPanel: IafwPreviewPanel);
   {* установить preview на панель для отображения. }
  procedure Print(anInterval: TafwPagesInterval;
   const aRange: Il3RangeManager;
   aCopies: Integer;
   const aFileName: AnsiString;
   aCollate: Boolean);
   {* напечатать на принтер. }
  procedure Stop(aWnd: THandle);
   {* остановит процесс построение preview/печати. }
  function Stopped: Boolean;
   {* процесс остановлен? }
  function CloseRequested: Boolean;
   {* при остановке процесса был запрос на закрытие превью }
  function PreviewResetting: Boolean;
   {* канва отсутствует, но будет передалываться }
  procedure SetCurrentPage(const aCursor: IUnknown);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPagePara(aParaID: Integer);
   {* устанавливает курсор на текущую страницу. }
  procedure SetCurrentPageNumber(aPageNumber: Integer);
   {* устанавливает курсор на текущую страницу. }
  function CurrentPage: Integer;
   {* текущая страница для печати. }
  function HasCurrentPage: Boolean;
   {* установлена ли текущая страница. }
  function Printer: IafwPrinter;
   {* принтер для Preview/печати. }
  function HasText: Boolean;
   {* есть ли текст для печати. }
  function ContentKind: TafwPreviewContentKind;
   {* Тип отображаемого элемента документа. }
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
