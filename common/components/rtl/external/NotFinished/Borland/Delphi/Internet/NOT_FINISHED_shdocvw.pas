unit NOT_FINISHED_shdocvw;

// ������: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Internet\NOT_FINISHED_shdocvw.pas"
// ���������: "UtilityPack"
// ������� ������: "shdocvw" MUID: (49EC9CF0030B)

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , OleCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TWebBrowser = class(TOleControl)
 end;//TWebBrowser

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWebBrowser);
 {* ����������� TWebBrowser }
{$IfEnd} // NOT Defined(NoScripts)

end.
