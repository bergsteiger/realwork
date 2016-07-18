unit moDocumentListFromFile;
 {* Список документов из файла }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDocumentListFromFile.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "DocumentListFromFile" MUID: (4DA44B030054)
// Имя типа: "Tmo_DocumentListFromFile"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentListFromFile_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_DocumentListFromFile = {final} class(TPrimDocumentListFromFileModule)
  {* Список документов из файла }
 end;//Tmo_DocumentListFromFile

var g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_DocumentListFromFile, 'Список документов из файла'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_DocumentListFromFile, 'OpenDocumentListFromFile', 'Открыть список документов из файла', False, g_module_opcode_DocumentListFromFile_OpenDocumentListFromFile));
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
