unit vtComboTree;

// ������: "w:\common\components\gui\Garant\VT\ComboTree\vtComboTree.pas"
// ���������: "SimpleClass"
// ������� ������: "TvtComboTree" MUID: (55B780E60398)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , FakeBox
;

type
 TvtComboTree = class(TFakeBox)
 end;//TvtComboTree

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , vtComboTreeWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , vtComboBoxWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtComboTree);
 {* ����������� TvtComboTree }
{$IfEnd} // NOT Defined(NoScripts)

end.
