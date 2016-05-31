unit NOT_COMPLETED_FoldersInterfaces;
 {* Интерфейсы для работы с папками }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\NOT_COMPLETED_FoldersInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "FoldersInterfaces" MUID: (492192300095)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , l3TreeInterfaces
 , SimpleListInterfaces
 , FoldersDomainInterfaces
 , ConsultationDomainInterfaces
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IdsFolderElement = interface(IvcmViewAreaController)
  {* Элемент папок }
  ['{548ADA55-9255-4D0E-B131-BEF738D30194}']
  function pm_GetSaveObject: IdeSaveObject;
  property SaveObject: IdeSaveObject
   read pm_GetSaveObject;
   {* сохраняемый объект }
 end;//IdsFolderElement

 EdsConsultationInProcess = class(Exception)
  {* консультация находится в процессе обработки }
 end;//EdsConsultationInProcess

 EdsConsultationSending = class(Exception)
  {* консультация отправляется в службу консультаций }
 end;//EdsConsultationSending

 EdsOldRefusalConsultationFormat = class(Exception)
  {* пользователь отказался оплатить консультацию }
 end;//EdsOldRefusalConsultationFormat

 IdsFoldersTree = interface(IvcmViewAreaController)
  {* Дерево папок }
  ['{CC61DE67-AEBA-462A-AF71-619D900AD879}']
  procedure CanBeOpen(const aNode: Il3SimpleNode); { can raise EdsConsultationInProcess, EdsConsultationSending, EdsOldRefusalConsultationFormat }
   {* можно ли открыть элемент.
           Возможные исключения:
             - EdsConsultationInProcess;
             - EdsConsultationSending; }
  function CanBeOpenAsConsultation(const aNode: Il3SimpleNode): Boolean;
   {* определяет возможность открытия объекта без типизации }
  function CanGiveMarkOnConsultation(const aNode: Il3SimpleNode): Boolean;
   {* определяет возможность оценки на консультацию }
  function CanDelete(const aNode: Il3SimpleNode): Boolean;
   {* можено удалить }
  function IsConsultation(const aNode: Il3SimpleNode): Boolean;
   {* узел является консультацией }
  procedure DeleteConsultation(const aNode: Il3SimpleNode);
   {* удалить консультацию }
  function CanImportConsultation(const aNode: Il3SimpleNode): Boolean;
   {* можно ли импортировать консультацию. Возможно только если aNode =
           "Мои консультации" }
  procedure ImportConsultation(const aFileName: Tl3WString);
   {* испортировать консультацию.
           Исключения:
           - EAccessDenied;
           - EInvalidXMLType; }
  function CanExportForIntegration(const aNode: Il3SimpleNode): Boolean;
   {* можно ли экспортировать полученный ответ на консультацию }
  procedure ExportForIntegration(const aNode: Il3SimpleNode);
   {* экспортировать консультацию.
           Исключения:
           - EInvalidEntityType; }
  function CanExportToXML(const aNode: Il3SimpleNode): Boolean;
   {* можно ли экспортировать ноду из папок }
  procedure ExportToXML(const aNode: Il3SimpleNode;
   const aFileName: Tl3WString);
   {* экспортировать ноду из папок.
           Исключения:
           - EAccessDenied;
           - EInvalidEntityType; }
  function CanImportFromXML(const aNode: Il3SimpleNode): Boolean;
   {* можно ли импортировать ноду в папки }
  procedure ImportFromXML(const aNode: Il3SimpleNode;
   const aFileName: Tl3WString);
   {* импортировать ноду в папки.
           Исключения:
           - EAccessDenied;
           - EInvalidEntityType; }
 end;//IdsFoldersTree

 IdsFolders = interface(IvcmViewAreaController)
  {* Папки }
  ['{5ADA9092-6221-45BE-9FD5-6C946A72ED72}']
 end;//IdsFolders

 IsdsFolders = interface(IvcmUseCaseController)
  {* Прецедент папки }
  ['{DF21D078-F373-4C50-A25C-C43CC69116A5}']
  function pm_GetdsFolders: IdsFolders;
  function pm_GetdsFoldersTree: IdsFoldersTree;
  function pm_GetdsFolderElement: IdsFolderElement;
  property dsFolders: IdsFolders
   read pm_GetdsFolders;
   {* бизнес объект папки }
  property dsFoldersTree: IdsFoldersTree
   read pm_GetdsFoldersTree;
   {* бизнес объект дерево папок }
  property dsFolderElement: IdsFolderElement
   read pm_GetdsFolderElement;
   {* бизнес объект элемент папок }
 end;//IsdsFolders
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsConsultationInProcess));
 {* Регистрация типа EdsConsultationInProcess }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsConsultationSending));
 {* Регистрация типа EdsConsultationSending }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdsOldRefusalConsultationFormat));
 {* Регистрация типа EdsOldRefusalConsultationFormat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
