unit NOT_FINISHED_vtForm;

// ������: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtForm.pas"
// ���������: "UtilityPack"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , l3Forms
;

type
 TvtForm = class(Tl3Form)
 end;//TvtForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtForm);
 {* ����������� TvtForm }
{$IfEnd} // NOT Defined(NoScripts)

end.
