unit DocumentUserTypes_dftNone_UserType;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftNone_UserType.pas"
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
 {* ��������� ��� ���� ����� dftNone }
 dftNoneName = 'dftNone';
  {* ��������� ������������� ����������������� ���� "��������" }
 dftNone = TvcmUserType(0);
  {* �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftNone';
end;//Tkw_FormUserType_dftNone.GetWordNameForRegister

function Tkw_FormUserType_dftNone.GetInteger: Integer;
begin
 Result := dftNone;
end;//Tkw_FormUserType_dftNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
