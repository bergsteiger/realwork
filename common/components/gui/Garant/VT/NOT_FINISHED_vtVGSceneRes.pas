unit NOT_FINISHED_vtVGSceneRes;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtVGSceneRes.pas"
// ���������: "UtilityPack"
// ������� ������: "vtVGSceneRes" MUID: (4D494D090395)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Classes
;

type
 TvtVGSceneResources = class(TDataModule)
 end;//TvtVGSceneResources
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtVGSceneResources);
 {* ����������� TvtVGSceneResources }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene)

end.
