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
   {* создает экземпляр класса в виде интерфейса IafwMultiDocumentPreview. }
  function GetDocumentName: IafwCString;
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
  procedure AddDocument(const aDocument: IafwDocumentPreview);
   {* Добавляет документ в пачку. }
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
