unit DocumentUserTypes_dftAACLeft_UserType;
 {* ����� ����� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAACLeft_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� dftAACLeft }
 dftAACLeftName = 'dftAACLeft';
  {* ��������� ������������� ����������������� ���� "����� ����� ������������ �������" }
 dftAACLeft = TvcmUserType(dftDrugSynchroView + 1);
  {* ����� ����� ������������ ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAACLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAACLeft
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAACLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAACLeft';
end;//Tkw_FormUserType_dftAACLeft.GetWordNameForRegister

function Tkw_FormUserType_dftAACLeft.GetInteger: Integer;
begin
 Result := dftAACLeft;
end;//Tkw_FormUserType_dftAACLeft.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAACLeft.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAACLeft }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
