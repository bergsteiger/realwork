unit nscImageLabel;

// ������: "w:\common\components\gui\Garant\Nemesis\nscImageLabel.pas"
// ���������: "GuiControl"
// ������� ������: "TnscImageLabel" MUID: (5704F87C02B4)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , vtLabel
;

type
 TnscImageLabel = class(TvtImageLabel)
 end;//TnscImageLabel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscImageLabel);
 {* ����������� TnscImageLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
