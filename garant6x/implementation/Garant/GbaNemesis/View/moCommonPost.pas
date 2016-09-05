unit moCommonPost;
 {* Файл }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommonPost.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "CommonPost" MUID: (4AA919DA010C)
// Имя типа: "Tmo_CommonPost"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , CommonPost_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_CommonPost = {final} class(TCommonPostModule)
  {* Файл }
 end;//Tmo_CommonPost
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Services
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_CommonPost, 'Файл'));
 TvcmModuleOperationsForRegister.AddOperation(TvcmModuleOperationForRegister_C(Tmo_CommonPost, 'SavePostList', 'Экспортировать все индивидуальные ленты в файл', False, mod_opcode_CommonPostService_SavePostList));
{$IfEnd} // NOT Defined(Admin)

end.
