unit NOT_FINISHED_ElXPThemedControl;

// ������: "w:\common\components\gui\Garant\VT\elClone\Source\NOT_FINISHED_ElXPThemedControl.pas"
// ���������: "SimpleClass"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , afwCustomCommonControl
;

type
 TElXPThemedControl = class(TafwCustomCommonControl)
 end;//TElXPThemedControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TElXPThemedControl);
 {* ����������� TElXPThemedControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
