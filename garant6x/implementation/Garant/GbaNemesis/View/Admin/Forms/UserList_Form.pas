unit UserList_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserList_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "UserList" MUID: (4AA8E45C00A8)
// Имя типа: "TefUserList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserListOptions_Form
 , Admin_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TefUserList = {final} class(TPrimUserListOptionsForm, UserListFormDef)
   Entities : TvcmEntities;
 end;//TefUserList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , UserListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_efUserList.SetFactory(TefUserList.Make);
 {* Регистрация фабрики формы UserList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserList);
 {* Регистрация UserList }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
