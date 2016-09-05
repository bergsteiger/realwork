unit AdminAppRes;
 {* �������� Admin }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\AdminAppRes.pas"
// ���������: "VCMApplication"
// ������� ������: "AdminApp" MUID: (4AA517B5037A)
// ��� ����: "TAdminAppRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
 , l3StringIDEx
;

const
 {* ������������ ������ AdminTitle }
 str_AdminTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AdminTitle'; rValue : '������ ����');
  {* '������ ����' }

type
 TAdminAppRes = {final} class(TPrimF1Res)
  {* �������� Admin }
  protected
   class procedure DoRun(var theSplash: IUnknown); override;
 end;//TAdminAppRes
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , moAdmin
 , nsStartupSupport
 , PrimAdminMain_Form
 , AdminMain_Form
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AA517B5037Aimpl_uses*
 , Forms
 //#UC END# *4AA517B5037Aimpl_uses*
;

class procedure TAdminAppRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA517B5037A_var*
var
 l_Main : TAdminMainForm;
//#UC END# *4AA7E4DC0047_4AA517B5037A_var*
begin
//#UC START# *4AA7E4DC0047_4AA517B5037A_impl*
 inherited;
 Application.CreateForm(TAdminMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA517B5037A_impl*
end;//TAdminAppRes.DoRun

initialization
 str_AdminTitle.Init;
 {* ������������� str_AdminTitle }
{$IfEnd} // Defined(Admin)

end.
