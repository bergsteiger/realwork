unit eeCustomMemo;

// ������: "w:\common\components\gui\Garant\Everest_Engine\eeCustomMemo.pas"
// ���������: "UtilityPack"
// ������� ������: "eeCustomMemo" MUID: (4AC5D35601BB)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , eeMemo
;

type
 TeeCustomMemo = eeMemo.TeeCustomMemo;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4AC5D35601BBimpl_uses*
 //#UC END# *4AC5D35601BBimpl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeCustomMemo));
 {* ����������� ���� TeeCustomMemo }
{$IfEnd} // NOT Defined(NoScripts)

end.
