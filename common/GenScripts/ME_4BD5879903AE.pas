unit ListUserTypes_lftNone_UserType;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftNone_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� lftNone }
 lftNoneName = 'lftNone';
  {* ��������� ������������� ����������������� ���� "������" }
 lftNone = TvcmUserType(0);
  {* ������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftNone';
end;//Tkw_FormUserType_lftNone.GetWordNameForRegister

function Tkw_FormUserType_lftNone.GetInteger: Integer;
begin
 Result := lftNone;
end;//Tkw_FormUserType_lftNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
