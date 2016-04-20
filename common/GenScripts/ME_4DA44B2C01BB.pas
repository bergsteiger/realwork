unit PrimDocumentListFromFile_Module;
 {* Список документов из файла }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentListFromFile\PrimDocumentListFromFile_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimDocumentListFromFile" MUID: (4DA44B2C01BB)
// Имя типа: "TPrimDocumentListFromFileModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TPrimDocumentListFromFileModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Список документов из файла }
  private
   procedure OpenDocumentListFromFile;
    {* Открыть список документов из файла }
 end;//TPrimDocumentListFromFileModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , kw_DocumentListFromFile_opOpenDocumentListFromFile
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , DynamicDocListUnit
 , SysUtils
 , nsTypes
 , deListSet
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTypesUnit
 , nsOpenDialog
 , bsOpenListInfo
 , PrimPrimListInterfaces
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки Local }
 str_AccessDenied: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AccessDenied'; rValue : 'Нет доступа к файлу');
  {* 'Нет доступа к файлу' }
 str_InvalidType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InvalidType'; rValue : 'Неверный тип файла');
  {* 'Неверный тип файла' }
 str_ImportDocuments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ImportDocuments'; rValue : 'Импортируемых документов');
  {* 'Импортируемых документов' }

procedure TPrimDocumentListFromFileModule.OpenDocumentListFromFile;
 {* Открыть список документов из файла }
//#UC START# *4DA44BDB01D9_4DA44B2C01BB_var*
//#UC END# *4DA44BDB01D9_4DA44B2C01BB_var*
begin
//#UC START# *4DA44BDB01D9_4DA44B2C01BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DA44BDB01D9_4DA44B2C01BB_impl*
end;//TPrimDocumentListFromFileModule.OpenDocumentListFromFile

initialization
 str_AccessDenied.Init;
 {* Инициализация str_AccessDenied }
 str_InvalidType.Init;
 {* Инициализация str_InvalidType }
 str_ImportDocuments.Init;
 {* Инициализация str_ImportDocuments }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
