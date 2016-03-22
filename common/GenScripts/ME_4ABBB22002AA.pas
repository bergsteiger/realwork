unit CommonDiction_Form;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\CommonDiction_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "CommonDiction" MUID: (4ABBB22002AA)
// ��� ����: "Ten_CommonDiction"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCommonDictionOptions_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_CommonDiction = {final} class(TPrimCommonDictionOptionsForm, CommonDictionFormDef)
  {* ����� ��� }
 end;//Ten_CommonDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , CommonDictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_CommonDiction);
 {* ����������� CommonDiction }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_CommonDiction.SetFactory(Ten_CommonDiction.Make);
 {* ����������� ������� ����� CommonDiction }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
