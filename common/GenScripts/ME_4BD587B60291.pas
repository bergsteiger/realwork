unit ListUserTypes_lftRespondent_UserType;
 {* ������ �� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondent_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftRespondent" MUID: (4BD587B60291)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftRespondent = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftRespondent }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftRespondent
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftRespondent.GetInteger: Integer;
begin
 Result := lftRespondent;
end;//Tkw_FormUserType_lftRespondent.GetInteger

class function Tkw_FormUserType_lftRespondent.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftRespondent';
end;//Tkw_FormUserType_lftRespondent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondent.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftRespondent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
