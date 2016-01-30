unit ListUserTypes_lftCorrespondent_UserType;
 {* ������ �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondent_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� lftCorrespondent }
 lftCorrespondentName = 'lftCorrespondent';
  {* ��������� ������������� ����������������� ���� "������ �� ��������" }
 lftCorrespondent = TvcmUserType(lftRespondent + 1);
  {* ������ �� �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondent = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftCorrespondent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftCorrespondent
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftCorrespondent';
end;//Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCorrespondent.GetInteger: Integer;
begin
 Result := lftCorrespondent;
end;//Tkw_FormUserType_lftCorrespondent.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondent.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftCorrespondent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
