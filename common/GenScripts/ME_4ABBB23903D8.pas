unit Navigator_Form;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Navigator_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Navigator" MUID: (4ABBB23903D8)
// ��� ����: "Ten_Navigator"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNavigatorOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Ten_Navigator = {final} class(TPrimNavigatorOptionsForm, NavigatorFormDef)
  {* ���� }
   Entities : TvcmEntities;
 end;//Ten_Navigator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , NavigatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_en_Navigator.SetFactory(Ten_Navigator.Make);
 {* ����������� ������� ����� Navigator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_Navigator);
 {* ����������� Navigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
