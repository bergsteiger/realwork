unit GroupList_Form;
 {* Группы пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\GroupList_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupListOptions_Form
 , Admin_FormDefinitions_Controls
;

type
 TefGroupList = {final} class(TPrimGroupListOptionsForm, GroupListFormDef)
  {* Группы пользователей }
 end;//TefGroupList
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , GroupListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefGroupList);
 {* Регистрация GroupList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efGroupList.SetFactory(TefGroupList.Make);
 {* Регистрация фабрики формы GroupList }
{$IfEnd} // Defined(Admin)

end.
