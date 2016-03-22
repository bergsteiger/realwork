unit PrimCommonDiction_utTips_UserType;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utTips_UserType.pas"
// ���������: "UserType"
// ������� ������: "utTips" MUID: (4BD6F164037F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utTips }
 utTipsName = 'utTips';
  {* ��������� ������������� ����������������� ���� "����� ���" }
 utTips = TvcmUserType(0);
  {* ����� ��� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utTips = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utTips }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utTips
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utTips.GetInteger: Integer;
begin
 Result := utTips;
end;//Tkw_FormUserType_utTips.GetInteger

class function Tkw_FormUserType_utTips.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utTips';
end;//Tkw_FormUserType_utTips.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utTips.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
