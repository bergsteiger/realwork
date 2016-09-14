unit eeCustomTreeView;

// ������: "w:\common\components\gui\Garant\Everest_Engine\eeCustomTreeView.pas"
// ���������: "UtilityPack"
// ������� ������: "eeCustomTreeView" MUID: (531F2A0900B9)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeTreeView
;

type
 TeeCustomTreeView = eeTreeView.TeeCustomTreeView;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *531F2A0900B9impl_uses*
 //#UC END# *531F2A0900B9impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCustomTreeView));
 {* ����������� ���� TeeCustomTreeView }
{$IfEnd} // NOT Defined(NoScripts)

end.
