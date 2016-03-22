unit ListUserTypes_lftNone_UserType;
 {* ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftNone_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftNone" MUID: (4BD5879903AE)

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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftNone.GetInteger: Integer;
begin
 Result := lftNone;
end;//Tkw_FormUserType_lftNone.GetInteger

class function Tkw_FormUserType_lftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftNone';
end;//Tkw_FormUserType_lftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
