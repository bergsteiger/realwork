unit PrimCommonDiction_utTips_UserType;
 {* ����� ��� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utTips_UserType.pas"
// ���������: "UserType"

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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utTips = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utTips }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utTips
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utTips.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utTips';
end;//Tkw_FormUserType_utTips.GetWordNameForRegister

function Tkw_FormUserType_utTips.GetInteger: Integer;
begin
 Result := utTips;
end;//Tkw_FormUserType_utTips.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utTips.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
