unit PrimCommonDiction_utMedicDiction_UserType;
 {* ������� ����������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utMedicDiction_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimCommonDiction_utTips_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utMedicDiction }
 utMedicDictionName = 'utMedicDiction';
  {* ��������� ������������� ����������������� ���� "������� ����������� ��������" }
 utMedicDiction = TvcmUserType(utTips + 1);
  {* ������� ����������� �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMedicDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMedicDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utMedicDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMedicDiction';
end;//Tkw_FormUserType_utMedicDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMedicDiction.GetInteger: Integer;
begin
 Result := utMedicDiction;
end;//Tkw_FormUserType_utMedicDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMedicDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
