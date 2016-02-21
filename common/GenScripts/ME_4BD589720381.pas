unit ListUserTypes_lftUserCR2_UserType;
 {* ������������� ������� ��������� ���������� 2 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCR2_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftUserCR1_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftUserCR2 }
 lftUserCR2Name = 'lftUserCR2';
  {* ��������� ������������� ����������������� ���� "������������� ������� ��������� ���������� 2" }
 lftUserCR2 = TvcmUserType(lftUserCR1 + 1);
  {* ������������� ������� ��������� ���������� 2 }
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
 Tkw_FormUserType_lftUserCR2 = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftUserCR2 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftUserCR2
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftUserCR2.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftUserCR2';
end;//Tkw_FormUserType_lftUserCR2.GetWordNameForRegister

function Tkw_FormUserType_lftUserCR2.GetInteger: Integer;
begin
 Result := lftUserCR2;
end;//Tkw_FormUserType_lftUserCR2.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCR2.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftUserCR2 }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
