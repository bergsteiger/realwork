unit FoldersElementInfo_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersElementInfo_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "FoldersElementInfo" MUID: (4ABCD2AB00C5)
// Имя типа: "TenFoldersElementInfo"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersElementInfoOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenFoldersElementInfo = {final} class(TPrimFoldersElementInfoOptionsForm, FoldersElementInfoFormDef)
   Entities : TvcmEntities;
 end;//TenFoldersElementInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , FoldersElementInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_enFoldersElementInfo.SetFactory(TenFoldersElementInfo.Make);
 {* Регистрация фабрики формы FoldersElementInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenFoldersElementInfo);
 {* Регистрация FoldersElementInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
