unit OleCtrls;

// ������: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\OleCtrls.pas"
// ���������: "UtilityPack"
// ������� ������: "OleCtrls" MUID: (49EEFA91008E)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
;

type
 TOleControl = class(TWinControl)
 end;//TOleControl
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TOleControl);
 {* ����������� TOleControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
