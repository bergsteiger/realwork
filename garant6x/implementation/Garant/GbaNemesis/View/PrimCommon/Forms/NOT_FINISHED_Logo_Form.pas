unit NOT_FINISHED_Logo_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\NOT_FINISHED_Logo_Form.pas"
// ���������: "VCMForm"
// ������� ������: "Logo" MUID: (4AA7E32D0252)
// ��� ����: "TLogoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TLogoForm = {final} class(TvcmEntityForm)
 end;//TLogoForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , LogoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ ut_LogoLocalConstants }
 str_ut_LogoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LogoCaption'; rValue : 'Logo');
  {* ��������� ����������������� ���� "Logo" }

initialization
 str_ut_LogoCaption.Init;
 {* ������������� str_ut_LogoCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLogoForm);
 {* ����������� Logo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
