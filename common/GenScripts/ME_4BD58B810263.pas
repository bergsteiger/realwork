unit ListUserTypes_lftProducedDrugs_UserType;
 {* ����������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftProducedDrugs_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� lftProducedDrugs }
 lftProducedDrugsName = 'lftProducedDrugs';
  {* ��������� ������������� ����������������� ���� "����������� ���������" }
 lftProducedDrugs = TvcmUserType(lftDrugInternationalNameSynonyms + 1);
  {* ����������� ��������� }
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
 Tkw_FormUserType_lftProducedDrugs = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftProducedDrugs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftProducedDrugs
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftProducedDrugs.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftProducedDrugs';
end;//Tkw_FormUserType_lftProducedDrugs.GetWordNameForRegister

function Tkw_FormUserType_lftProducedDrugs.GetInteger: Integer;
begin
 Result := lftProducedDrugs;
end;//Tkw_FormUserType_lftProducedDrugs.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftProducedDrugs.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftProducedDrugs }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
