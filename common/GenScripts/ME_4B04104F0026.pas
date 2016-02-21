unit DocumentUserTypes_dftDrug_UserType;
 {* �������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrug_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAutoreferat_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftDrug }
 dftDrugName = 'dftDrug';
  {* ��������� ������������� ����������������� ���� "�������� ���������" }
 dftDrug = TvcmUserType(dftAutoreferat + 1);
  {* �������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrug = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDrug }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftDrug
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftDrug.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDrug';
end;//Tkw_FormUserType_dftDrug.GetWordNameForRegister

function Tkw_FormUserType_dftDrug.GetInteger: Integer;
begin
 Result := dftDrug;
end;//Tkw_FormUserType_dftDrug.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrug.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDrug }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
