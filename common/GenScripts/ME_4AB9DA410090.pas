unit StartupTips_Form;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\StartupTips_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "StartupTips" MUID: (4AB9DA410090)
// ��� ����: "TefStartupTips"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStartupTips_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efStartupTips: TvcmFormDescriptor = (rFormID : (rName : 'efStartupTips'; rID : 0); rFactory : nil);
  {* ������������� ����� TefStartupTips }

type
 TefStartupTips = class;

 StartupTipsFormDef = interface
  {* ������������� ����� StartupTips }
  ['{69581B33-5C00-46C8-8723-A5DE81DDD577}']
 end;//StartupTipsFormDef

 TefStartupTips = {final} class(TPrimStartupTipsForm, StartupTipsFormDef)
  {* ����� ��� }
 end;//TefStartupTips
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , StartupTipsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_StartupTipsLocalConstants }
 str_ut_StartupTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StartupTipsCaption'; rValue : '����� ���');
  {* ��������� ����������������� ���� "����� ���" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefStartupTips);
 {* ����������� StartupTips }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efStartupTips.SetFactory(TefStartupTips.Make);
 {* ����������� ������� ����� StartupTips }
 str_ut_StartupTipsCaption.Init;
 {* ������������� str_ut_StartupTipsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
