unit ListUserTypes_lftCorrespondent_UserType;
 {* ������ �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCorrespondent_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftCorrespondent" MUID: (4BD5880300BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftCorrespondent = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftCorrespondent }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftCorrespondent
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCorrespondent.GetInteger: Integer;
begin
 Result := lftCorrespondent;
end;//Tkw_FormUserType_lftCorrespondent.GetInteger

class function Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftCorrespondent';
end;//Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCorrespondent.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftCorrespondent }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
