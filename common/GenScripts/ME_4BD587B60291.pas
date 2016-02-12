unit ListUserTypes_lftRespondent_UserType;
 {* ������ �� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondent_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� lftRespondent }
 lftRespondentName = 'lftRespondent';
  {* ��������� ������������� ����������������� ���� "������ �� ���������" }
 lftRespondent = TvcmUserType(lftNone + 1);
  {* ������ �� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondent = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftRespondent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftRespondent
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftRespondent.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftRespondent';
end;//Tkw_FormUserType_lftRespondent.GetWordNameForRegister

function Tkw_FormUserType_lftRespondent.GetInteger: Integer;
begin
 Result := lftRespondent;
end;//Tkw_FormUserType_lftRespondent.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondent.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftRespondent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
