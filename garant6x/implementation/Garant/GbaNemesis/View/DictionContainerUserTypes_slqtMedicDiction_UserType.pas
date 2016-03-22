unit DictionContainerUserTypes_slqtMedicDiction_UserType;
 {* ������� ����������� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtMedicDiction_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtMedicDiction" MUID: (4D81EE030156)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionContainerUserTypes_slqtDiction_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� slqtMedicDiction }
 slqtMedicDictionName = 'slqtMedicDiction';
  {* ��������� ������������� ����������������� ���� "������� ����������� ��������" }
 slqtMedicDiction = TvcmUserType(slqtDiction + 1);
  {* ������� ����������� �������� }
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
 Tkw_FormUserType_slqtMedicDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtMedicDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtMedicDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtMedicDiction.GetInteger: Integer;
begin
 Result := slqtMedicDiction;
end;//Tkw_FormUserType_slqtMedicDiction.GetInteger

class function Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtMedicDiction';
end;//Tkw_FormUserType_slqtMedicDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtMedicDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtMedicDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
