unit NOT_FINISHED_evTextSource;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTextSource.pas"
// ���������: "SimpleClass"
// ������� ������: "TevTextSource" MUID: (482D98DE00A9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomTextSource
;

type
 TevTextSource = class(TevCustomTextSource)
 end;//TevTextSource

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *482D98DE00A9impl_uses*
 //#UC END# *482D98DE00A9impl_uses*
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevTextSource);
 {* ����������� TevTextSource }
{$IfEnd} // NOT Defined(NoScripts)

end.
