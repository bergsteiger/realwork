unit FoldersInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Folders"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/FoldersInterfaces.pas"
// Начат: 17.11.2008 18:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Основные прецеденты::Folders::Folders::FoldersInterfaces
//
// Интерфейсы для работы с папками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3TreeInterfaces,
  SimpleListInterfaces,
  FoldersDomainInterfaces,
  ConsultationDomainInterfaces,
  SysUtils,
  vcmInterfaces {a},
  vcmControllers {a}
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
   procedure CanBeOpen(const aNode: Il3SimpleNode); // can raise EdsConsultationInProcess, EdsConsultationSending, EdsOldRefusalConsultationFormat
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
   function pm_GetDsFolders: IdsFolders;
   function pm_GetDsFoldersTree: IdsFoldersTree;
   function pm_GetDsFolderElement: IdsFolderElement;
   property dsFolders: IdsFolders
     read pm_GetDsFolders;
     {* бизнес объект папки }
   property dsFoldersTree: IdsFoldersTree
     read pm_GetDsFoldersTree;
     {* бизнес объект дерево папок }
   property dsFolderElement: IdsFolderElement
     read pm_GetDsFolderElement;
     {* бизнес объект элемент папок }
 end;//IsdsFolders
{$IfEnd} //not Admin AND not Monitorings

implementation

end.